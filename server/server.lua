-- -- client
-- QBCore.Functions.TriggerCallback('enty-callems:EMSOnline', function(EMSOnline, hasEnoughMoney)
-- end)

-- local some, values, returned = TriggerServerCallback('awesome:script', foo, bar)
-- -- this is a synchronous function!

-- -- server
-- RegisterServerCallback('awesome:script', function(source, some, data)
--     -- some awesome code
--     return some, response
-- end)


-- lib.callback.register('enty-suicide:GetVehiclePedIsIn', function(source)
--     local src = source


--     local inventory = target and Inventory(target) or Inventory(source)
--     return (inventory and Inventory.GetItem(inventory, item, metadata, true)) or 0
-- end)


-- GetVehiclePedIsIn(
-- 		ped --[[ Ped ]],
-- 		lastVehicle --[[ boolean ]]
-- 	)

-- lib.addCommand('sui', {
--     help = 'Gives an item to a player',
--     restricted = 'group.admin'
-- }, function(source)
--     TriggerClientEvent("suicide", source)
--     -- local item = Items(args.item)

--     -- if item then
--     --     Inventory.AddItem(args.target, item.name, args.count or 1, args.metatype)
--     -- end
-- end)


RegisterServerEvent("enty-suicide:ShootAtCoord", function(PlayerPed)
    local src = source
    PlayerPed = GetPlayerPed(src)
TaskShootAtCoord(PlayerPed, 0.0, 0.0, 0.0, 2000, "FIRING_PATTERN_DELAY_FIRE_BY_ONE_SEC") --https://docs.fivem.net/natives/?_0x601C22E3
-- https://pastebin.com/Px036isB
end)