local QBCore = exports['qb-core']:GetCoreObject()
local metal = nil

local allowlist = {1333033863, -1942898710, -1595148316,587194674,509508168, -1286696947,510490462, 1144315879, -461750719, 2128369009, 951832588, -1885547121  }
RegisterNetEvent("md-metaldetect:client:metaldetect")
AddEventHandler("md-metaldetect:client:metaldetect", function() 
CreateThread(function()
while metal do
	local metalrep = QBCore.Functions.GetPlayerData().metadata["metaldetecting"]
	for k, v in pairs (allowlist) do
		if GetGroundHash() == v then	
			if metalrep <= Config.lvl1 then
				Wait(Config.lvl1Wait)
				metaldetect()
			elseif metalrep <= Config.lvl2 then
				Wait(Config.lvl2Wait)
				metaldetect()
			elseif metalrep <= Config.lvl3 then
				Wait(Config.lvl3Wait)
				metaldetect()
			elseif metalrep <= Config.lvl4 then
				Wait(Config.lvl4Wait)
				metaldetect()
			elseif metalrep <= Config.lvl5 then
				Wait(Config.lvl5Wait)
				metaldetect()
			elseif metalrep <= Config.lvl6 then
				Wait(Config.lvl6Wait)
				metaldetect()
			elseif metalrep <= Config.lvl7 then
				Wait(Config.lvl7Wait)
				metaldetect()
			elseif metalrep <= Config.lvl8 then
				Wait(Config.lvl8Wait)
				metaldetect()
			elseif metalrep <= Config.lvl9 then
				Wait(Config.lvl9Wait)
				metaldetect()
			elseif metalrep <= Config.lvl10 then
				Wait(Config.lvl10Wait)
				metaldetect()
			end
		else
		Wait(100)
		end
	end
end
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
		QBCore.Functions.Notify("You Put Your Pole Away")
		DetachEntity(metal, true, true)
		DeleteObject(metal)
		metal = nil
		ClearPedTasks(PlayerPedId())
	else
		local pos = GetEntityCoords(PlayerPedId(), true)
		RequestModel("bostra_detector")
		while not HasModelLoaded("bostra_detector") do
			Wait(0)
		end
		local object = CreateObject("bostra_detector", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005),  0.8, 0.06, 0.1, 5.0, -99.0, 56.0, true, true, false, true, 1, true)
		metal = object
		TriggerEvent("md-metaldetect:client:metaldetect")
	end
end)


function metaldetect()
	QBCore.Functions.Notify("You found something!")
	PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(1500)
exports['ps-ui']:Circle(function(success)
if success then
	TriggerServerEvent('md-metaldetecting:server:giveloot')
	FreezeEntityPosition(PlayerPedId(), false)
else
	QBCore.Functions.Notify("You failed to find something!")
	FreezeEntityPosition(PlayerPedId(), false)
end
end, 1, 8) -- NumberOfCircles, 
end

CreateThread(function()
for k, v in pairs (Config.clumpwash) do
	if Config.OxTarget then
		clumpwash = exports.ox_target:addBoxZone({
		coords = v,
		size = vec(1,1,3),
		rotation = 0,
		debug = true,
		options = {
				{
					name = 'clumpwash',
					icon = "fas fa-sign-in-alt",
					label = "Wash Clumps",
					distance = 5,
					onSelect = function()
						exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
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
					exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
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
				   icon = " "..Config.InvWeblink..QBCore.Shared.Items[v.name].image,
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
	lib.requestModel("s_m_m_trucker_01", 500)
	local current = "s_m_m_trucker_01"
    metaldetectsales = CreatePed(0, current,Config.MetalDetectShop.x,Config.MetalDetectShop.y,Config.MetalDetectShop.z-1, false, false)
	SetEntityHeading(metaldetectsales, 50.0)
    FreezeEntityPosition(metaldetectsales, true)
    SetEntityInvincible(metaldetectsales, true)
	exports['qb-target']:AddTargetEntity(metaldetectsales, {
                options = {
                    {
                        type = "client",
                        label = "Buy Metal Detector",
                        icon = "fas fa-eye",
                        action = function()
							exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
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
