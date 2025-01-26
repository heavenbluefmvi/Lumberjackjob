-- qb-lumberjack/client/main.lua
local isWorking = false

-- Tạo NPC và shop
CreateThread(function()
    local npc = Config.JobStart
    RequestModel(`s_m_m_gentransport`)
    while not HasModelLoaded(`s_m_m_gentransport`) do Wait(10) end
    
    local ped = CreatePed(0, `s_m_m_gentransport`, npc.x, npc.y, npc.z-1.0, npc.w, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    
    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                type = "client",
                event = "qb-menu:lumberjackMenu",
                icon = "fas fa-tree",
                label = "Nói chuyện",
                job = 'lumberjack'
            }
        },
        distance = 2.5
    })
end)

-- Menu chính
RegisterNetEvent('qb-menu:lumberjackMenu', function()
    local ShopItems = {}
    for k,v in pairs(Config.ShopItems) do
        ShopItems[#ShopItems+1] = {
            header = v.label,
            txt = "Giá: $"..v.price,
            params = {
                event = "qb-lumberjack:client:buyAxe"
            }
        }
    end

    ShopItems[#ShopItems+1] = {
        header = "Nghỉ việc",
        txt = "Ngừng công việc hiện tại",
        params = {
            event = "qb-lumberjack:client:offDuty"
        }
    }

    exports['qb-menu']:openMenu(ShopItems)
end)

-- Mini game chặt cây
local function StartChopping()
    if isWorking then return end
    if not HasWeaponEquipped('weapon_battleaxe') then
        QBCore.Functions.Notify('Bạn cần cầm rìu!', 'error')
        return
    end
    
    isWorking = true
    if Config.MinigameType == 'circle' then
        exports['qb-lock']:StartLockPickCircle(3, 10, function(success)
            if success then
                TriggerServerEvent('qb-lumberjack:server:giveWood')
            end
            isWorking = false
        end)
    else
        exports['qb-lock']:StartLockPickSkill(3, 10, function(success)
            if success then
                TriggerServerEvent('qb-lumberjack:server:giveWood')
            end
            isWorking = false
        end)
    end
end

-- Tương tác với cây
CreateThread(function()
    for _, model in pairs(Config.TreeModels) do
        exports['qb-target']:AddTargetModel(model, {
            options = {
                {
                    type = "client",
                    action = StartChopping,
                    icon = "fas fa-tree",
                    label = "Chặt cây",
                    job = 'lumberjack',
                    canInteract = function(entity)
                        return not isWorking
                    end
                }
            },
            distance = 2.5
        })
    end
end)
