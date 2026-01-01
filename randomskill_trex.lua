-- ================= RANDOM SKILL STANDALONE (ANTI SUS) =================
-- Random skill: Z X C
-- Co fake lag

getgenv().RandomSkillConfig = {
    Enable = true,

    -- delay giua cac lan dung skill
    DelayMin = 0.6,
    DelayMax = 1.8,

    -- fake lag
    FakeLagChance = 30,     -- % co fake lag moi lan
    FakeLagMin = 0.15,      -- giay
    FakeLagMax = 0.45
}

local VIM = game:GetService("VirtualInputManager")

local skills = { "Z", "X", "C"}

math.randomseed(os.clock() * 1000000)

-- fake lag
local function applyFakeLag()
    if math.random(1,100) <= getgenv().RandomSkillConfig.FakeLagChance then
        task.wait(
            math.random(
                getgenv().RandomSkillConfig.FakeLagMin * 1000,
                getgenv().RandomSkillConfig.FakeLagMax * 1000
            ) / 1000
        )
    end
end

local function pressKey(key)
    VIM:SendKeyEvent(true, key, false, game)

    -- hold phim giong nguoi that
    task.wait(math.random(100, 200) / 1000)

    VIM:SendKeyEvent(false, key, false, game)
end

task.spawn(function()
    while task.wait() do
        if not getgenv().RandomSkillConfig.Enable then
            task.wait(0.5)
            continue
        end

        -- fake lag truoc khi bam
        applyFakeLag()

        local skill = skills[math.random(1, #skills)]
        pressKey(skill)

        -- fake lag sau khi bam
        applyFakeLag()

        local delay =
            math.random(
                getgenv().RandomSkillConfig.DelayMin * 1000,
                getgenv().RandomSkillConfig.DelayMax * 1000
            ) / 1000

        task.wait(delay)
    end
end)

