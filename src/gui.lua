-- GUI Bee Hub
local CoreGui = game:GetService("CoreGui")
local currentTarget = nil
local autoBountyRunning = false
local killAuraRunning = false

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BeeHubGUI"
    screenGui.Parent = CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(255, 170, 0)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    title.Text = "Bee Hub - Bounty Hunter"
    title.TextColor3 = Color3.fromRGB(0, 0, 0)
    title.Font = Enum.Font.Bold
    title.TextSize = 20
    title.Parent = mainFrame

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -50)
    scroll.Position = UDim2.new(0, 5, 0, 45)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.CanvasSize = UDim2.new(0, 0, 0, 300)
    scroll.Parent = mainFrame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 5)
    list.Parent = scroll

    local function addToggle(text, getter, setter)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 0, 30)
        frame.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
        frame.BorderSizePixel = 0
        frame.Parent = scroll

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = frame

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 60, 0, 25)
        btn.Position = UDim2.new(1, -65, 0, 2.5)
        btn.Text = getter() and "ON" or "OFF"
        btn.BackgroundColor3 = getter() and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Parent = frame

        btn.MouseButton1Click:Connect(function()
            local newVal = not getter()
            setter(newVal)
            btn.Text = newVal and "ON" or "OFF"
            btn.BackgroundColor3 = newVal and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        end)
    end

    addToggle("Auto Bounty", function() return getgenv().BeeConfig.AutoBounty end, function(v)
        getgenv().BeeConfig.AutoBounty = v
        if v then
            if not autoBountyRunning then
                autoBountyRunning = true
                task.spawn(function()
                    while autoBountyRunning do
                        if not getgenv().BeeLib.isSafeHealth() then task.wait(1) goto cont end
                        local enemy = getgenv().BeeLib.getNearestEnemy()
                        if enemy then getgenv().BeeLib.attackTarget(enemy) end
                        ::cont::
                        task.wait(getgenv().BeeConfig.FarmDelay)
                    end
                end)
            end
        else
            autoBountyRunning = false
        end
    end)

    addToggle("Kill Aura", function() return getgenv().BeeConfig.KillAura end, function(v)
        getgenv().BeeConfig.KillAura = v
        if v then
            killAuraRunning = true
            task.spawn(function()
                while killAuraRunning do
                    local enemy = getgenv().BeeLib.getNearestEnemy()
                    if enemy then getgenv().BeeLib.attackTarget(enemy) end
                    task.wait(0.1)
                end
            end)
        else
            killAuraRunning = false
        end
    end)

    addToggle("Lock Target", function() return getgenv().BeeConfig.LockTarget end, function(v)
        getgenv().BeeConfig.LockTarget = v
        if v then
            task.spawn(function()
                while getgenv().BeeConfig.LockTarget do
                    local target = getgenv().BeeLib.getNearestEnemy()
                    if target and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, hrp.Position)
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)

    addToggle("AimBot", function() return getgenv().BeeConfig.AimBot.Enabled end, function(v)
        getgenv().BeeConfig.AimBot.Enabled = v
    end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
end

createGUI()
print("GUI loaded")
