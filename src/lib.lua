-- Library fungsi utility
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function isSafeHealth()
    local char = LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return false end
    local cfg = getgenv().BeeConfig
    return not (cfg.SafeHealth.Health > 0 and hum.Health < cfg.SafeHealth.Health)
end

local function getNearestEnemy()
    local nearest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local myTeam = getgenv().BeeConfig.Team
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team then
            local teamName = plr.Team.Name
            if (myTeam == "Pirates" and teamName == "Marines") or (myTeam == "Marines" and teamName == "Pirates") then
                local plrChar = plr.Character
                if plrChar and plrChar:FindFirstChild("HumanoidRootPart") and plrChar.Humanoid.Health > 0 then
                    local dist = (root.Position - plrChar.HumanoidRootPart.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearest = plr
                    end
                end
            end
        end
    end
    return nearest
end

local VirtualInputManager = syn and syn.input or nil
local function attackTarget(target)
    if not target or not target.Character then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return end
    if VirtualInputManager then
        VirtualInputManager:PressMouseButton(0)
        task.wait(0.05)
        VirtualInputManager:ReleaseMouseButton(0)
    end
end

local function autoServerHop()
    local cfg = getgenv().BeeConfig
    if not cfg.Setting.AutoServerHop then return end
    local enemies = 0
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team then
            local myTeam = cfg.Team
            local teamName = plr.Team.Name
            if (myTeam == "Pirates" and teamName == "Marines") or (myTeam == "Marines" and teamName == "Pirates") then
                enemies = enemies + 1
            end
        end
    end
    if enemies == 0 then
        game:GetService("TeleportService"):Teleport(game.PlaceId)
        task.wait(5)
    end
end

getgenv().BeeLib = {
    isSafeHealth = isSafeHealth,
    getNearestEnemy = getNearestEnemy,
    attackTarget = attackTarget,
    autoServerHop = autoServerHop
}
print("Lib loaded")
