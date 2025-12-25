local VIM = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera

local minDelay = 0.5
local maxDelay = 1

task.spawn(function()
    while true do
        local delay = math.random() * (maxDelay - minDelay) + minDelay
        local vp = cam.ViewportSize

        VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, true, game, 0)
        VIM:SendMouseButtonEvent(vp.X/2, vp.Y/2, 0, false, game, 0)

        task.wait(delay)
    end
end)