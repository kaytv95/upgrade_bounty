task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    -- =====================
    -- ⚙️ SETTINGS
    -- =====================
    local MIN_LAG = 30    -- ms
    local MAX_LAG = 120   -- ms

    local HITBOX_MIN = 9
    local HITBOX_MAX = 11

    -- =====================
    -- 🐌 FAKE LAG FUNCTION
    -- =====================
    local function ApplyFakeLag()
        task.wait(math.random(MIN_LAG, MAX_LAG) / 1000)
    end

    -- =====================
    -- 📦 HITBOX + AUTO FAKE LAG
    -- =====================
    task.spawn(function()
        while task.wait(0.8) do
            local foundPlayer = false

            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= player
                    and v.Character
                    and v.Character:FindFirstChild("HumanoidRootPart")
                then
                    foundPlayer = true

                    pcall(function()
                        local hrp = v.Character.HumanoidRootPart
                        local size = math.random(HITBOX_MIN, HITBOX_MAX)

                        hrp.Size = Vector3.new(size, size, size)
                        hrp.Transparency = 0.65 + math.random() * 0.1
                        hrp.Material = Enum.Material.ForceField
                        hrp.CanCollide = false
                    end)
                end
            end

            -- 👉 Chỉ fake lag khi có player khác
            if foundPlayer then
                ApplyFakeLag()
                task.wait(math.random(0.05, 0.25)) -- nghỉ nhẹ cho tự nhiên
            end
        end
    end)
end)
