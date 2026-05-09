-- Main logic Bee Hub
print("Starting Bee Hub main...")

if not getgenv().BeeConfig then
    error("Config not loaded. Please load config.lua first")
end
if not getgenv().BeeLib then
    error("Lib not loaded. Please load lib.lua first")
end

task.spawn(function()
    while true do
        getgenv().BeeLib.autoServerHop()
        task.wait(15)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        local cfg = getgenv().BeeConfig
        if (cfg.AutoBounty or cfg.KillAura) and cfg.Setting.FastAttack then
            local target = getgenv().BeeLib.getNearestEnemy()
            if target then
                getgenv().BeeLib.attackTarget(target)
            end
        end
    end
end)

print("Bee Hub fully loaded. Enjoy! - By Kalz")
