task.spawn(function()
    -- Chờ game và Player load xong
    repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    -- ======================
    -- 1️⃣ Fake Lag
    -- ======================
    _G.ApplyFakeLag = function(min, max)
        min = min or 50      -- giá trị mặc định nếu không truyền
        max = max or 150
        task.wait(math.random(min, max)/1000)
    end

    -- ======================
    -- 2️⃣ Tăng Hitbox cho tất cả người chơi khác
    -- ======================
    task.spawn(function()
        while task.wait(1) do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        local hrp = v.Character.HumanoidRootPart
                        -- Tăng hitbox random
                        local sizeX = math.random(9,11)
                        local sizeY = math.random(9,11)
                        local sizeZ = math.random(9,11)
                        hrp.Size = Vector3.new(sizeX,sizeY,sizeZ)
                        hrp.Transparency = 0.65 + math.random()*0.1
                        hrp.Material = Enum.Material.ForceField
                        hrp.CanCollide = false
                    end)
                end
            end
        end
    end)
end)
