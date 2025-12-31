-- ================= LOW HP COUNT (NON RESET, STACK WITH BANANA) =================

getgenv().NK_LowHP = {
    Enable = true,
    LowHealth = 5000,
    MaxCount = 3,
    Delay = 0.4
}

local count = 0
local wasLow = false

local function getBananaTarget()
    return _G.Target
        or getgenv().Target
        or getgenv().SelectedTarget
end

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
            count = 0
            wasLow = false
            continue
        end

        local target = getBananaTarget()
        if not target then
            count = 0
            wasLow = false
            continue
        end

        local hp = getHP(target)

        if hp <= getgenv().NK_LowHP.LowHealth then
            if not wasLow then
                count += 1
                wasLow = true
            end
        else
            wasLow = false
        end

        if count >= getgenv().NK_LowHP.MaxCount then
            clearBananaTarget()
            count = 0
            wasLow = false
        end
    end
end)
