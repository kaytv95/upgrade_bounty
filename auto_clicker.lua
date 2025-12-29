local VIM = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera

local minDelay = 0.8
local maxDelay = 1.3

-- random chuẩn
local rng = Random.new()

-- ====== TỌA ĐỘ CLICK (CHỈNH Ở ĐÂY) ======
local CLICK_X_RATIO = 0.75
local CLICK_Y_RATIO = 0.68
-- =======================================

task.spawn(function()
    while true do
        local delay = rng:NextNumber(minDelay, maxDelay)
        local vp = cam.ViewportSize

        local x = vp.X * CLICK_X_RATIO
        local y = vp.Y * CLICK_Y_RATIO

        VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
        VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)

        task.wait(delay)
    end
end)

