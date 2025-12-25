-- =================== ULTRA REDUCE LAG CLIENT-ONLY ===================
local plr = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local rs = game:GetService("RunService")
local cam = workspace.CurrentCamera

-- ====== Ẩn / giảm tất cả Part, Mesh, Union, Terrain ======
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
        if not obj:FindFirstAncestorWhichIsA("Tool") and not obj:FindFirstAncestorWhichIsA("Model") then
            obj.Transparency = 1
            obj.CanCollide = false
        end
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Light") then
        obj.Enabled = false
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj.Transparency = 1
    end
end

-- ====== Tắt hầu hết animation của NPC (client-only) ======
for _, npc in pairs(workspace:GetDescendants()) do
    if npc:IsA("Humanoid") then
        for _, track in pairs(npc:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end
end

-- ====== Lighting cực đơn giản ======
lighting.GlobalShadows = false
lighting.FogEnd = 9e9
lighting.Brightness = 1
lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
lighting.ClockTime = 14
lighting.Ambient = Color3.fromRGB(127,127,127)
lighting.FogColor = Color3.fromRGB(0,0,0)

-- ====== Ẩn GUI không cần thiết ======
if plr:FindFirstChild("PlayerGui") then
    for _, gui in pairs(plr.PlayerGui:GetDescendants()) do
        if gui:IsA("Frame") or gui:IsA("ImageLabel") or gui:IsA("TextLabel") then
            gui.Visible = false
        end
    end
end

-- ====== Reduce Camera / DrawDistance (tùy chọn) ======
cam.FieldOfView = 70
if cam:FindFirstChild("CameraSubject") then
    cam.CameraType = Enum.CameraType.Scriptable
end

-- ====== Chú ý ======
-- Client-only, không xóa NPC, tool, HRP → auto bounty BananaCat vẫn chạy bình thường