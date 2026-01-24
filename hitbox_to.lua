task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    -- =====================
    -- ⚙️ SETTINGS
    -- =====================
    local HITBOX_MIN = 9
    local HITBOX_MAX = 11

    -- =====================
    -- 📦 HITBOX
    -- =====================
    task.spawn(function()
        while task.wait(0.8) do
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= player
                    and v.Character
                    and v.Character:FindFirstChild("HumanoidRootPart")
                then
                    pcall(function()
                        local hrp = v.Character.HumanoidRootPart
                        local size = math.random(HITBOX_MIN, HITBOX_MAX)

                        hrp.Size = Vector3.new(size, size, size)
                        hrp.Transparency = 0.7
                        hrp.Material = Enum.Material.ForceField
                        hrp.CanCollide = false
                    end)
                end
            end
        end
    end)
end)
