local QBCore = exports['qb-core']:GetCoreObject()
local metal = nil
local isDetecting = false
local showDetectHint = false
local shouldCancelDetecting = false
local lastCancelTime = 0
local isProgressBarRunning = false

-- Animation dictionary and name for detector
local detectorAnimDict = "amb@world_human_stand_impatient@male@no_sign@idle_a"
local detectorAnimName = "idle_a"

-- Function to load and play animation
local function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(5)
	end
end

-- Function to play detector animation
local function playDetectorAnim()
	loadAnimDict(detectorAnimDict)
	TaskPlayAnim(PlayerPedId(), detectorAnimDict, detectorAnimName, 8.0, -8.0, -1, 49, 0, false, false, false)
	RemoveAnimDict(detectorAnimDict)
end

-- Function to stop detector animation
local function stopDetectorAnim()
	ClearPedTasks(PlayerPedId())
end

local allowlist = {1333033863, -1942898710, -1595148316,587194674,509508168, -1286696947,510490462, 1144315879, -461750719, 2128369009, 951832588, -1885547121  }

-- Helper for on-screen text (side of screen)
function ShowDetectHint(text)
	if lib and lib.showTextUI then
		lib.showTextUI(text, {position = 'left-center'})
	else
		-- fallback: DrawText3D or similar if needed
	end
end

function HideDetectHint()
	if lib and lib.hideTextUI then
		lib.hideTextUI()
	end
end

local function resetDetectState()
	isDetecting = false
	shouldCancelDetecting = false
	showDetectHint = false
	HideDetectHint()
	stopDetectorAnim()
end

function metaldetect(done)
	QBCore.Functions.Notify("You found something!")
	PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(1500)
	exports['ps-ui']:Circle(function(success)
		if shouldCancelDetecting or not isDetecting or not metal then
			resetDetectState()
			if done then done() end
			return
		end
		if success then
			TriggerServerEvent('md-metaldetecting:server:giveloot')
			FreezeEntityPosition(PlayerPedId(), false)
		else
			QBCore.Functions.Notify("You failed to find something!")
			FreezeEntityPosition(PlayerPedId(), false)
		end
		resetDetectState()
		if done then done() end
	end, 1, 8)
end

-- Main detection thread with E to start/stop
RegisterNetEvent("md-metaldetect:client:metaldetect")
AddEventHandler("md-metaldetect:client:metaldetect", function() 
	CreateThread(function()
		while metal do
			local inValidArea = false
			for k, v in pairs (allowlist) do
				if GetGroundHash() == v then
					inValidArea = true
					break
				end
			end
			if inValidArea and not isDetecting then
				showDetectHint = true
				ShowDetectHint("Press E to start detecting")
				if IsControlJustReleased(0, 38) and (GetGameTimer() - lastCancelTime > 3000) then -- E key, after cooldown
					isDetecting = true
					shouldCancelDetecting = false
					showDetectHint = false
					HideDetectHint()
					-- Start single detection cycle
					local metalrep = QBCore.Functions.GetPlayerData().metadata["metaldetecting"]
					local waitTime = Config.lvl1Wait
					if metalrep <= Config.lvl1 then waitTime = Config.lvl1Wait
					elseif metalrep <= Config.lvl2 then waitTime = Config.lvl2Wait
					elseif metalrep <= Config.lvl3 then waitTime = Config.lvl3Wait
					elseif metalrep <= Config.lvl4 then waitTime = Config.lvl4Wait
					elseif metalrep <= Config.lvl5 then waitTime = Config.lvl5Wait
					elseif metalrep <= Config.lvl6 then waitTime = Config.lvl6Wait
					elseif metalrep <= Config.lvl7 then waitTime = Config.lvl7Wait
					elseif metalrep <= Config.lvl8 then waitTime = Config.lvl8Wait
					elseif metalrep <= Config.lvl9 then waitTime = Config.lvl9Wait
					elseif metalrep <= Config.lvl10 then waitTime = Config.lvl10Wait end
					local progressTime = waitTime + 1000
					isProgressBarRunning = true
					showDetectHint = true
					ShowDetectHint("Press R to stop detecting")
					CreateThread(function()
						playDetectorAnim()
						while isDetecting and metal and not shouldCancelDetecting do
							if not IsEntityPlayingAnim(PlayerPedId(), detectorAnimDict, detectorAnimName, 3) then
								playDetectorAnim()
							end
							Wait(1000)
						end
					end)
					-- Play metaldetector.ogg 1 second before progress bar finishes
					CreateThread(function()
						Wait(progressTime - 1000)
						if isDetecting and metal and not shouldCancelDetecting then
							TriggerEvent('InteractSound_CL:PlayOnOne', 'metaldetector', 0.5)
						end
					end)
					QBCore.Functions.Progressbar("detecting", "Detecting...", progressTime, false, true, {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
					}, {}, {}, {}, function() -- Done
						isProgressBarRunning = false
						if metal and isDetecting and not shouldCancelDetecting then
							TriggerEvent('InteractSound_CL:PlayOnOne', 'metaldetected', 0.5)
							metaldetect(function()
								resetDetectState()
							end)
						else
							resetDetectState()
						end
					end, function() -- Cancel
						isProgressBarRunning = false
						if shouldCancelDetecting then
							resetDetectState()
						end
					end)
					-- Wait for progress bar to finish or be canceled
					local timer = 0
					while timer < progressTime and isDetecting and metal and not shouldCancelDetecting do
						Wait(100)
						timer = timer + 100
						-- Check if still in valid area
						local stillValid = false
						for k, v in pairs (allowlist) do
							if GetGroundHash() == v then
								stillValid = true
								break
							end
						end
						if not stillValid then
							shouldCancelDetecting = true
							if isProgressBarRunning then TriggerEvent('progressbar:client:cancel') end
							resetDetectState()
							break
						end
					end
				end
			elseif isDetecting then
				showDetectHint = true
				ShowDetectHint("Press R to stop detecting")
			else
				showDetectHint = false
				HideDetectHint()
			end
			Wait(0)
		end
		showDetectHint = false
		HideDetectHint()
	end)
end)

function GetGroundHash()
	local coords = GetEntityCoords(PlayerPedId())
	local num = StartShapeTestCapsule(coords.x,coords.y,coords.z+4,coords.x,coords.y,coords.z-2.0, 1,1,PlayerPedId(),7)
	local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
	return arg5
end

RegisterNetEvent("md-metaldetect:client:startdetecting")
AddEventHandler("md-metaldetect:client:startdetecting", function()
	if metal then
		QBCore.Functions.Notify("Put your detector away")
		DetachEntity(metal, true, true)
		DeleteObject(metal)
		metal = nil
		isDetecting = false
		shouldCancelDetecting = true
		showDetectHint = false
		HideDetectHint()
		stopDetectorAnim()
		ClearPedTasks(PlayerPedId())
		TriggerEvent('progressbar:client:cancel')
	else
		local pos = GetEntityCoords(PlayerPedId(), true)
		RequestModel("bostra_detector")
		while not HasModelLoaded("bostra_detector") do
			Wait(0)
		end
		local object = CreateObject("bostra_detector", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005),  0.8, 0.0, 0.0, 0.0, -90.0, 0.0, true, true, false, true, 1, true)
		metal = object
		TriggerEvent("md-metaldetect:client:metaldetect")
	end
end)

CreateThread(function()
	for k, v in pairs (Config.clumpwash) do
		if Config.OxTarget then
			clumpwash = exports.ox_target:addBoxZone({
			coords = v,
			size = vec(1,1,3),
			rotation = 0,
			debug = false,
			options = {
					{
						name = 'clumpwash',
						icon = "fas fa-sign-in-alt",
						label = "Wash Clumps",
						distance = 5,
						onSelect = function()
							TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
							QBCore.Functions.Progressbar("drink_something", "Washing Clumps", 4000, false, true, {
							disableMovement = false,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
							disableInventory = true,
							}, {}, {}, {}, function()-- Done
							TriggerServerEvent('md-metaldetecting:server:cleanclump')
							ClearPedTasks(PlayerPedId())
							end)
						end,
					},
				},
			})
		else
			exports['qb-target']:AddBoxZone("clumpwash" .. k,v,1.5, 1.75, { -- 963.37, -2122.95, 31.47
			name = "clumpwash" .. k,
			heading = 156.0,
			debugPoly = false,
			minZ = v.z-2,
			maxZ = v.z+2,
		}, {
			options = {
				{
					icon = "fas fa-sign-in-alt",
					label = "Wash Clumps",
					action = function()
						TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
						QBCore.Functions.Progressbar("drink_something", "Washing Clumps", 4000, false, true, {
						disableMovement = true,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
						}, {}, {}, {}, function()-- Done
						TriggerServerEvent('md-metaldetecting:server:cleanclump')
						ClearPedTasks(PlayerPedId())
						end)
					end,
				},
			},
			distance = 2.5
		})
	end
	end

	local metaldetectsales = {}

	for k, v in pairs (Config.LootSell) do 
		metaldetectsales[#metaldetectsales + 1] = {
						   icon = Config.InvWeblink..QBCore.Shared.Items[v.name].image,
							title = v.label,
							event = "md-metaldetecting:client:sellloot",
							args = {
								item = v.name,
								cost = v.price,
							}
						}
		lib.registerContext({id = 'metaldetectsales',title = "Metal Detect Sales", options = metaldetectsales})
	end
		metaldetectingblip = AddBlipForCoord(Config.MetalDetectShop)
		SetBlipSprite(metaldetectingblip, 459)
		SetBlipScale(metaldetectingblip, 1.0)
		SetBlipDisplay(metaldetectingblip, 4)
		SetBlipAsShortRange(metaldetectingblip, true)
		SetBlipColour(metaldetectingblip, 27)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Metal Detecting Shop")
		EndTextCommandSetBlipName(metaldetectingblip)
	
		-- Improved model loading
		local modelHash = GetHashKey("s_m_m_trucker_01")
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Wait(10)
		end
	
		metaldetectsales = CreatePed(0, modelHash, Config.MetalDetectShop.x, Config.MetalDetectShop.y, Config.MetalDetectShop.z-1, 50.0, false, false)
		SetEntityHeading(metaldetectsales, 50.0)
		FreezeEntityPosition(metaldetectsales, true)
		SetEntityInvincible(metaldetectsales, true)
		SetBlockingOfNonTemporaryEvents(metaldetectsales, true)
		SetPedDiesWhenInjured(metaldetectsales, false)
		SetPedCanPlayAmbientAnims(metaldetectsales, true)
		SetPedCanRagdollFromPlayerImpact(metaldetectsales, false)
		SetEntityAsMissionEntity(metaldetectsales, true, true)
	
		exports['qb-target']:AddTargetEntity(metaldetectsales, {
							options = {
								{
									type = "client",
									label = "Buy Metal Detector",
									icon = "fas fa-eye",
									action = function()
										TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
										QBCore.Functions.Progressbar("drink_something", "Buying A Metal Detector", 4000, false, true, {
										disableMovement = true,
										disableCarMovement = false,
										disableMouse = false,
										disableCombat = true,
										disableInventory = true,
										}, {}, {}, {}, function()-- Done
											TriggerServerEvent("md-metaldetecting:server:buydetector")
										ClearPedTasks(PlayerPedId())
										end)
									end	
								},
								{
									type = "client",
									label = "Sell Loot",
									icon = "fas fa-eye",
									action = function()
										lib.showContext('metaldetectsales')
									end
								},
							},
							distance = 2.0
						})
	end)

RegisterNetEvent("md-metaldetecting:client:sellloot", function(data) local dialog
	local price = data.cost 
	local header = "$" .. price .. " each"
	local dialog = exports.ox_lib:inputDialog(QBCore.Shared.Items[data.item].label,   {
		{ type = 'number', label = "Amount to Sell",  description = header, min = 0, max = 50, default = 1 },
	})
		TriggerServerEvent("md-metaldetecting:server:sellloot", dialog[1], data.item, data.cost)
end)

-- Add global R-cancel thread
CreateThread(function()
	while true do
		Wait(0)
		if isDetecting and metal then
			if IsControlJustReleased(0, 45) then -- R key
				shouldCancelDetecting = true
				if isProgressBarRunning then TriggerEvent('progressbar:client:cancel') end
				lastCancelTime = GetGameTimer()
				resetDetectState()
			end
		end
	end
end)
