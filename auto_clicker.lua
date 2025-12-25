local VIM = game:GetService("VirtualInputManager")
local plr = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

local minDelay = 0.3
local maxDelay = 0.6

local char

local function loadChar(c)
    char = c
end

if plr.Character then
    loadChar(plr.Character)
end
plr.CharacterAdded:Connect(loadChar)

local function isInCombat()
    if not char then return false end

    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BoolValue") and v.Value == true then
            return true
        end
        if v:IsA("NumberValue") and v.Value > 0 then
            return true
        end
    end

    for _, v in pairs(char:GetAttributes()) do
        if type(v) == "boolean" and v == true then
            return true
        end
        if type(v) == "number" and v > 0 then
            return true
        end
    end

    return false
end

task.spawn(function()
    while true do
        if isInCombat() then
            local delay = math.random() * (maxDelay - minDelay) + minDelay
            local vp = cam.ViewportSize

            VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, true, game, 0)
            VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 0)

            task.wait(delay)
        else
            task.wait(0.2)
        end
    end
end)

