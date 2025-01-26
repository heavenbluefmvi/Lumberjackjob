-- qb-lumberjack/server/main.lua
QBCore = exports['qb-core']:GetCoreObject()

-- Tạo NPC nhận việc
RegisterNetEvent('qb-lumberjack:server:startJob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.PlayerData.job.name == 'unemployed' then
        Player.Functions.SetJob('lumberjack', 0)
        TriggerClientEvent('QBCore:Notify', src, 'Bạn đã nhận việc đốn gỗ!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Bạn đang có công việc khác!', 'error')
    end
end)

-- Hệ thống shop
RegisterNetEvent('qb-lumberjack:server:buyAxe', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.ShopItems[1]
    
    if Player.Functions.RemoveMoney('cash', item.price) then
        Player.Functions.AddItem(item.name, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Không đủ tiền!', 'error')
    end
end)

-- Xử lý phần thưởng
RegisterNetEvent('qb-lumberjack:server:giveWood', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = 1
    
    if math.random(1, 100) <= Config.ChanceMultiWood then
        amount = math.random(2, Config.MaxWood)
    end
    
    Player.Functions.AddItem(Config.WoodItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WoodItem], 'add')
end)
