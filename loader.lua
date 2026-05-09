local repoUrl = "https://raw.githubusercontent.com/chikalgaming213-eng/BeeHub/main/BeeHub/src/"

loadstring(game:HttpGet(repoUrl .. "config.lua"))()
wait(0.5)
loadstring(game:HttpGet(repoUrl .. "lib.lua"))()
wait(0.5)
loadstring(game:HttpGet(repoUrl .. "gui.lua"))()
wait(0.5)
loadstring(game:HttpGet(repoUrl .. "main.lua"))()

print("Bee Hub loaded! Use GUI to toggle features.")
