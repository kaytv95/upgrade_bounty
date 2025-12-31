-- ================= LOW HP COUNT (ENEMY + SELF, STACK WITH BANANA) =================

getgenv().NK_LowHP = {
    Enable = true,

    Enemy = {
        Enable = true,
        LowHealth = 4500,
        MaxCount = 3,
    },

    Self = {
        Enable = true,
        LowHealth = 4500,
        MaxCount = 3,
    },

    Delay = 0.4
}

local enemyCount = 0
local selfCount = 0
local enemyWasLow = false
local selfWasLow = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- lay target cua Banana
local function getBananaTarget()
    return _G.Target
        or getgenv().Target
        or getgenv().SelectedTarget
end

-- clear target de Banana doi nguoi
local function clearBananaTarget()
    if _G.Target then _G.Target = nil end
    if getgenv().Target then getgenv().Target = nil end
    if getgenv().SelectedTarget then getgenv().SelectedTarget = nil end
end

local function getHP(plr)
    if plr
    and plr.Character
    and plr.Character:FindFirstChild("Humanoid") then
        return plr.Character.Humanoid.Health
    end
    return math.huge
end

task.spawn(function()
    while task.wait(getgenv().NK_LowHP.Delay) do
        if not getgenv().NK_LowHP.Enable then
            enemyCount = 0
            selfCount = 0
            enemyWasLow = false
            selfWasLow = false
            continue
        end

        local target = getBananaTarget()

        -- ================= ENEMY LOW HP =================
        if getgenv().NK_LowHP.Enemy.Enable and target then
            local enemyHP = getHP(target)

            if enemyHP <= getgenv().NK_LowHP.Enemy.LowHealth then
                if not enemyWasLow then
                    enemyCount += 1
                    enemyWasLow = true
                end
            else
                enemyWasLow = false
            end

            if enemyCount >= getgenv().NK_LowHP.Enemy.MaxCount then
                clearBananaTarget()
                enemyCount = 0
                enemyWasLow = false
                selfCount = 0
                selfWasLow = false
            end
        end

        -- ================= SELF LOW HP =================
        if getgenv().NK_LowHP.Self.Enable then
            local selfHP = getHP(LocalPlayer)

            if selfHP <= getgenv().NK_LowHP.Self.LowHealth then
                if not selfWasLow then
                    selfCount += 1
                    selfWasLow = true
                end
            else
                selfWasLow = false
            end

            if selfCount >= getgenv().NK_LowHP.Self.MaxCount then
                clearBananaTarget()
                enemyCount = 0
                selfCount = 0
                enemyWasLow = false
                selfWasLow = false
            end
        end
    end
end)
