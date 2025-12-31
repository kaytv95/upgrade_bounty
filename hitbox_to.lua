-- ================= HITBOX =================

getgenv().Hitbox = true
getgenv().HitboxSize = Vector3.new(10, 10, 10)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while task.wait() do
        if not getgenv().Hitbox then continue end

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                local c = v.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local hrp = c.HumanoidRootPart
                    hrp.Size = getgenv().HitboxSize
                    hrp.Transparency = 0.7
                    hrp.CanCollide = false
                end
            end
        end
    end
end)