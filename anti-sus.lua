-- anti load trung
if _G.BANANA_HELPER_LOADED then return end
_G.BANANA_HELPER_LOADED = true

task.spawn(function()

    repeat task.wait() until game:IsLoaded()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local VIM = game:GetService("VirtualInputManager")

    local lp = Players.LocalPlayer
    repeat task.wait() until lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")

    local hrp = lp.Character.HumanoidRootPart

    -- ================= CONFIG =================
    local SKILLS = {"Z","X","C","V","F"}
    local DASH_KEYS = {"W","A","S","D"}

    local ATTACK_RANGE = 30
    local PREDICT_FACTOR_MIN = 0.12
    local PREDICT_FACTOR_MAX = 0.18

    local lastAction = 0

    -- ================= FAKE LAG =================
    local function FakeLag(min, max)
        task.wait(math.random(min, max) / 1000)
    end

    -- ================= RANDOM SKILL =================
    local function RandomSkill()
        local k = SKILLS[math.random(#SKILLS)]
        VIM:SendKeyEvent(true, k, false, game)
        FakeLag(120, 260)
        VIM:SendKeyEvent(false, k, false, game)
    end

    -- ================= SMART DASH =================
    local function SmartDash()
        local d = DASH_KEYS[math.random(#DASH_KEYS)]
        VIM:SendKeyEvent(true, d, false, game)
        FakeLag(60, 150)
        VIM:SendKeyEvent(false, d, false, game)
    end

    -- ================= PREDICTION NHE (KHONG TARGET) =================
    local function GetNearestPredictedEnemy()
        local bestDist = math.huge
        local found = false

        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local thrp = plr.Character.HumanoidRootPart
                local factor = math.random() * (PREDICT_FACTOR_MAX - PREDICT_FACTOR_MIN) + PREDICT_FACTOR_MIN
                local predictPos = thrp.Position + thrp.Velocity * factor
                local dist = (hrp.Position - predictPos).Magnitude

                if dist < bestDist and dist < ATTACK_RANGE then
                    bestDist = dist
                    found = true
                end
            end
        end

        return found
    end

    -- ================= MAIN LOOP =================
    RunService.Heartbeat:Connect(function()
        local now = tick()
        if now - lastAction < 0.25 then return end -- tranh spam

        if GetNearestPredictedEnemy() then
            if math.random() < 0.6 then
                SmartDash()
            end
            RandomSkill()
            lastAction = now
        end
    end)

end)
