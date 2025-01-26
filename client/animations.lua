-- client/animations.lua
local isChopping = false
local axeProp = nil

-- Danh sách animation chặt cây
local ChopAnimations = {
    {
        dict = "melee@hatchet@streamed_core",
        anim = "plyr_front_takedown",
        flag = 1,
        duration = 3000
    },
    {
        dict = "amb@world_human_hammering@male@base",
        anim = "base",
        flag = 8,
        duration = 2500
    }
}

-- Tạo hiệu ứng vụn gỗ
local function CreateWoodParticles()
    UseParticleFxAssetNextCall("core")
    StartParticleFxLoopedAtCoord("ent_brk_wood_fragments", GetEntityCoords(PlayerPedId()), 0.0, 0.0, 0.0, 1.0, false, false, false, false)
end

-- Animation chính
function StartChoppingAnimation(treeCoords)
    if isChopping then return end
    isChopping = true
    
    local ped = PlayerPedId()
    local anim = ChopAnimations[math.random(#ChopAnimations)]
    
    -- Tải animation
    RequestAnimDict(anim.dict)
    while not HasAnimDictLoaded(anim.dict) do Wait(10) end
    
    -- Tạo rìu
    if not axeProp then
        RequestModel(`prop_axe_hon_01`)
        while not HasModelLoaded(`prop_axe_hon_01`) do Wait(10) end
        axeProp = CreateObject(`prop_axe_hon_01`, GetEntityCoords(ped), true, true, true)
        AttachEntityToEntity(axeProp, ped, GetPedBoneIndex(ped, 57005), 0.09, -0.03, -0.02, -78.0, 13.0, 28.0, true, true, false, true, 1, true)
    end
    
    -- Bắt đầu animation
    CreateThread(function()
        while isChopping do
            TaskPlayAnim(ped, anim.dict, anim.anim, 3.0, 3.0, -1, anim.flag, 0, false, false, false)
            Wait(anim.duration)
            CreateWoodParticles()
            StopAnimTask(ped, anim.dict, anim.anim, 1.0)
        end
        
        -- Dọn dẹp
        DeleteObject(axeProp)
        axeProp = nil
        RemoveAnimDict(anim.dict)
    end)
    
    -- Đồng bộ với mini game
    CreateThread(function()
        while isChopping do
            -- Đảm bảo player hướng về cây
            TaskTurnPedToFaceCoord(ped, treeCoords.x, treeCoords.y, treeCoords.z, 1500)
            Wait(1000)
        end
    end)
end

-- Dừng animation
function StopChoppingAnimation()
    isChopping = false
    ClearPedTasks(PlayerPedId())
end
