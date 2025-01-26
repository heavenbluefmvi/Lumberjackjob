-- qb-lumberjack/config.lua
Config = {
    TreeModels = {
        "prop_tree_cedar_s_01",
        "prop_tree_cedar_s_02",
        "prop_tree_fallen_02"
    },
    JobStart = vector3(1960.17, 5179.22, 47.98), -- Vị trí NPC
    ShopItems = {
        [1] = { name = "weapon_battleaxe", price = 250, label = "Rìu chặt cây" }
    },
    WoodItem = "wood",
    ChanceMultiWood = 20, -- 20% cơ hội
    MaxWood = 4,
    MinigameType = "circle" -- circle/skillbar
}
