-- Loader Bee Hub - Execute ini di Delta
local repoUrl = "https://github.com/chikalgaming213-eng/BeeHub.git"
-- Ganti YOUR_USERNAME dan YOUR_REPO_NAME sesuai repo lu

-- Load config
loadstring(game:HttpGet(repoUrl .. "config.lua"))()
wait(0.5)

-- Load lib
loadstring(game:HttpGet(repoUrl .. "lib.lua"))()
wait(0.5)

-- Load GUI
loadstring(game:HttpGet(repoUrl .. "gui.lua"))()
wait(0.5)

-- Load main
loadstring(game:HttpGet(repoUrl .. "main.lua"))()

print("Bee Hub loaded! Use GUI to toggle features.")
