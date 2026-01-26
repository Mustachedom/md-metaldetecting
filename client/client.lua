local detecting = false
local metalDetector = nil
local allowlist = {1288448767,1333033863, -1942898710, -1595148316,587194674,509508168, -1286696947,510490462, 1144315879, -461750719, 2128369009, 951832588, -1885547121  }
local search, displayed = '', ''

local function requestModel(model, timeout)
	local modelHash =  GetHashKey(model) or model
	if not IsModelValid(modelHash) then return false end
	local timeout = timeout or 10000
	RequestModel(modelHash)
	local start = GetGameTimer()
	while not HasModelLoaded(modelHash) do
		Wait(10)
		if GetGameTimer() - start >= timeout then
			return false
		end
	end
	return true
end

local function GetGroundHash()
	local coords = GetEntityCoords(PlayerPedId())
	local num = StartShapeTestCapsule(coords.x,coords.y,coords.z+4,coords.x,coords.y,coords.z-2.0, 1,1,PlayerPedId(),7)
	local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
	return arg5
end

local function createDetector()
	local pos = GetEntityCoords(PlayerPedId(), true)
	requestModel("bostra_detector")
	metalDetector = CreateObject("bostra_detector", pos.x, pos.y, pos.z, true, true, true)
	AttachEntityToEntity(metalDetector, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005),  0.8, 0.06, 0.1, 5.0, -99.0, 56.0, true, true, false, true, 1, true)
	detecting = true
end

local function allowedGround()
	local ground = GetGroundHash()
	return Bridge.Tables.TableContains(allowlist, ground) or false, ground
end

local function hideText()
	Bridge.HelpText.HideHelpText()
	displayed = ''
	search = ''
end

local function stopDetecting()
	DetachEntity(metalDetector, true, true)
	DeleteObject(metalDetector)
	detecting = false
	metalDetector = nil
	ClearPedTasks(PlayerPedId())
	TriggerServerEvent('md-metaldetecting:server:stopDetecting')
	hideText()
end

local function find(ground)
	Bridge.HelpText.HideHelpText()
	if not minigame() then
		hideText()
		return false
	end
	SetEntityVisible(metalDetector, false, 0)

	if not progressbar(Bridge.Language.Locale('Progress.dig'), 11000, "WORLD_HUMAN_GARDENER_PLANT") then
		hideText()
		SetEntityVisible(metalDetector, true, 0)
		return false
	end
	SetEntityVisible(metalDetector, true, 0)
	TriggerServerEvent('md-metaldetecting:server:giveloot', ground)
	hideText()
	return true
end

local function searchText(ground)
	if not Config.ShowDrawText then return end 
	if ground then
		search = Bridge.Language.Locale('DrawText.success')
	else
		search = Bridge.Language.Locale('DrawText.fail')
	end
	if search ~= displayed then
		displayed = search
		Bridge.HelpText.ShowHelpText(displayed)
	end
end

RegisterNetEvent("md-metaldetect:client:startDetecting",function(time)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		Bridge.Notify.SendNotify(Bridge.Language.Locale('Fails.inVehicle'), 'error')
		TriggerServerEvent('md-fishing:server:stopFishing')
		return
	end
	if detecting then
		Bridge.Notify.SendNotify(Bridge.Language.Locale('Fails.alreadyDetecting'), 'error')
		return
	end
	detecting = true
	createDetector()
	repeat
		local timer = time
		local groundBool, ground
		repeat
			groundBool, ground = allowedGround()
			searchText(groundBool)
			Wait(1000)
			timer = timer - 1
		until timer == 0 or not detecting or not DoesEntityExist(metalDetector) or IsPedInAnyVehicle(PlayerPedId(), false) or not groundBool
		if not detecting then
			stopDetecting()
			return
		end
		if not DoesEntityExist(metalDetector) then
			stopDetecting()
			return
		end
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			Bridge.Notify.SendNotify(Bridge.Language.Locale('Fails.inVehicle'), 'error')
			stopDetecting()
			return
		end
		if not groundBool then
			searchText(groundBool)
			goto continue
		end
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
		Bridge.Notify.SendNotify(Bridge.Language.Locale('Success.foundSomething'), 'success')
		Wait(1000)
		if not find(ground) then
			goto continue
		end
		::continue::
	until not detecting
end)

RegisterNetEvent("md-metaldetect:client:stopDetecting",function()
	detecting = false
	stopDetecting()
end)

local function initZones()
	local locations = Bridge.Callback.Trigger('md-metaldetecting:server:getLocs')
	for k, v in pairs (locations.shop) do
		if v.blipData and v.blipData.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
			SetBlipSprite (blip, v.blipData.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipData.scale)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, v.blipData.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipData.name)
			EndTextCommandSetBlipName(blip)
		end
		requestModel(v.ped)
		local ped = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z - 1.0, v.loc.w, false, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
		Bridge.Target.AddLocalEntity(ped, {
			{
				label = Bridge.Language.Locale('Targets.shops.targ1.label', Config.Pricefordetector),
				icon = Bridge.Language.Locale('Targets.shops.targ1.icon'),
				action = function()
					local type = Bridge.Input.Open(Bridge.Language.Locale('Targets.shops.targ1.input.header'), {
						{type = 'select', options = {{label = Bridge.Language.Locale('Info.cash'), value = 'cash'}, {label = Bridge.Language.Locale('Info.bank'), value = 'bank'}}, title = Bridge.Language.Locale('Targets.shops.targ1.input.title'), required = true},
					})
					if not type then return end
					if type and not type[1] then
						return
					end
					TriggerServerEvent('md-metaldetecting:server:buyDetector', k, type[1])
				end
			},
			{
				label = Bridge.Language.Locale('Targets.shops.targ2.label'),
				icon = Bridge.Language.Locale('Targets.shops.targ2.icon'),
				action = function()
					local loot = Bridge.Callback.Trigger('md-metaldetecting:server:getLoot', k)
					if not loot then
						return
					end
					local menu = {}
					menu[#menu+1] = {
						title = Bridge.Language.Locale('Targets.shops.targ2.sellAll'),
						onSelect = function()
							TriggerServerEvent('md-metaldetecting:server:sellLoot', k, 'all')
						end
					}
					for item, price in pairs(loot) do
						if Bridge.Inventory.HasItem(item) then
							local itemInfo = Bridge.Inventory.GetItemInfo(item)
							menu[#menu+1] = {
								title = itemInfo.label,
								description = Bridge.Language.Locale('Targets.shops.targ2.menuDescription', price),
								icon = itemInfo.image,
								onSelect = function()
									TriggerServerEvent('md-metaldetecting:server:sellLoot', k, item)
								end
							}
						end
					end
					Bridge.Menu.Open({
						id = 'md_metaldetecting_sellLoot',
						title = Bridge.Language.Locale('Targets.shops.targ2.menuTitle'),
						options = menu
					})
				end
			}
		})
	end

	for k, v in pairs (locations.wash) do
		if v.blipData and v.blipData.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
			SetBlipSprite (blip, v.blipData.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipData.scale)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, v.blipData.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipData.name)
			EndTextCommandSetBlipName(blip)
		end
		Bridge.Target.AddBoxZone('metalWash'..k, v.loc, vector3(1.0, 1.0, 2.0), v.loc.w or 0.0,  {
			{
				label = Bridge.Language.Locale('Targets.wash.label'),
				icon = Bridge.Language.Locale('Targets.wash.icon'),
				action = function()
					if not minigame() then
						return
					end
					if not progressbar(Bridge.Language.Locale('Progress.wash'), 1000, {dict = "mp_arresting", clip = 'a_uncuff', flag = 49}) then
						return
					end
					TriggerServerEvent('md-metaldetecting:server:washClump',k)
				end
			}
		})
	end
end

initZones()

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end
	if DoesEntityExist(metalDetector) then
		DeleteEntity(metalDetector)
	end
end)