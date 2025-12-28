-- chong load trung
if _G.CORE_LOADED then return end
_G.CORE_LOADED = true

task.spawn(function()

    repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local VIM = game:GetService("VirtualInputManager")

    local player = Players.LocalPlayer

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    local currentTarget = nil
    local lowHpCount = 0

    -- fake lag
    _G.ApplyFakeLag = function(min, max)
        task.wait(math.random(min, max) / 1000)
    end

    -- random skill
    _G.RandomSkill = function()
        local skills = {"Z","X","C","V","F"}
        local k = skills[math.random(#skills)]
        VIM:SendKeyEvent(true, k, false, game)
        _G.ApplyFakeLag(100,300)
        VIM:SendKeyEvent(false, k, false, game)
    end

    -- get closest enemy
    _G.GetClosestEnemy = function()
        local best, dist = nil, math.huge
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local d = (v.Character.HumanoidRootPart.Position -
                           player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    best = v
                end
            end
        end
        return best
    end

    -- smart dash
    _G.SmartDash = function()
        local dirs = {"W","A","S","D"}
        local d = dirs[math.random(#dirs)]
        VIM:SendKeyEvent(true, d, false, game)
        _G.ApplyFakeLag(50,150)
        VIM:SendKeyEvent(false, d, false, game)
    end

    -- combat logic
    _G.SmartCombat = function()
        local t = _G.GetClosestEnemy()
        if not t then return end

        local dist = (player.Character.HumanoidRootPart.Position -
                      t.Character.HumanoidRootPart.Position).Magnitude
        if dist < 30 then
            _G.SmartDash()
            _G.RandomSkill()
        end
    end

    -- main loop
    RunService.Heartbeat:Connect(function()
        local char = player.Character
        if not char or not char:FindFirstChild("Humanoid") then return end

        local hum = char.Humanoid
        if hum.Health < 5000 then
            lowHpCount += 1
            if lowHpCount >= 3 then
                currentTarget = _G.GetClosestEnemy()
                lowHpCount = 0
            end
        end

        if currentTarget then
            _G.SmartCombat()
        else
            currentTarget = _G.GetClosestEnemy()
        end
    end)

end)