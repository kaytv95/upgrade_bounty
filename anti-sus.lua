task.spawn(function()
    repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

    local RunService = game:GetService("RunService")
    local VIM = game:GetService("VirtualInputManager")
    local player = game.Players.LocalPlayer

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    -- fake lag
    _G.ApplyFakeLag = function(50, 150)
        task.wait(math.random(50, 150) / 1000)
    end

    -- smart dash
    _G.SmartDash = function()
        local dirs = {"W","A","S","D"}
        local d = dirs[math.random(#dirs)]
        VIM:SendKeyEvent(true, d, false, game)
        _G.ApplyFakeLag(50,150)
        VIM:SendKeyEvent(false, d, false, game)
    end

    -- main loop: chỉ dash
    RunService.Heartbeat:Connect(function()
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        _G.SmartDash()
    end)
end)
