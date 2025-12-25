-- invisible floor anti water (blox fruits stable)

local plr = game.Players.LocalPlayer
local rs = game:GetService("RunService")

local floor = Instance.new("Part")
floor.Name = "AntiWaterFloor"
floor.Size = Vector3.new(70, 1, 70)
floor.Anchored = true
floor.CanCollide = true
floor.Transparency = 1
floor.Parent = workspace

local char, hrp

local function loadChar(c)
    char = c
    hrp = c:WaitForChild("HumanoidRootPart")
end

if plr.Character then
    loadChar(plr.Character)
end
plr.CharacterAdded:Connect(loadChar)

rs.Heartbeat:Connect(function()
    if not hrp then return end

    if hrp.Position.Y < 6 then
        floor.Position = hrp.Position - Vector3.new(0, 3, 0)
    else
        floor.Position = Vector3.new(0, -1000, 0)
    end
end)
