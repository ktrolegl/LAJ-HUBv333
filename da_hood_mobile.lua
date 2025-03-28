-- Da Hood Mobile GUI
-- Optimized for mobile users on Roblox Delta

-- Check if the game is Da Hood
if game.PlaceId ~= 2788229376 then
    game.Players.LocalPlayer:Kick("This script is only for Da Hood!")
    return
end

-- Create the main GUI elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabsFrame = Instance.new("Frame")
local Close = Instance.new("TextButton")

-- Setting up ScreenGui
ScreenGui.Name = "DaHoodMobileGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Main Frame Setup (larger for mobile touch)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
MainFrame.Size = UDim2.new(0, 450, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Da Hood Mobile GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24.000

-- Close button (larger for mobile)
Close.Name = "Close"
Close.Parent = Title
Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(1, -40, 0, 5)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Font = Enum.Font.SourceSansBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 20.000
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tabs Frame
TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = MainFrame
TabsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabsFrame.BorderSizePixel = 0
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.Size = UDim2.new(0, 120, 1, -40)

-- Create tab buttons (with larger sizes for mobile)
local function createTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Name = name.."Tab"
    tab.Parent = TabsFrame
    tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tab.BorderSizePixel = 0
    tab.Position = UDim2.new(0, 0, 0, position)
    tab.Size = UDim2.new(1, 0, 0, 50) -- Larger for mobile
    tab.Font = Enum.Font.SourceSansBold
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 18.000 -- Larger text
    
    local frame = Instance.new("Frame")
    frame.Name = name.."Frame"
    frame.Parent = MainFrame
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 120, 0, 40)
    frame.Size = UDim2.new(1, -120, 1, -40)
    frame.Visible = false
    
    return tab, frame
end

-- Create all tabs
local PlayerTab, PlayerFrame = createTab("Player", 10)
local CombatTab, CombatFrame = createTab("Combat", 70)
local VisualTab, VisualFrame = createTab("Visual", 130)
local AutoTab, AutoFrame = createTab("Auto", 190)
local CreditsTab, CreditsFrame = createTab("Credits", 250)

-- Tab switching function
local function switchTab(tabButton)
    -- Reset all tabs
    PlayerTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    CombatTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    VisualTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    AutoTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    CreditsTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    PlayerFrame.Visible = false
    CombatFrame.Visible = false
    VisualFrame.Visible = false
    AutoFrame.Visible = false
    CreditsFrame.Visible = false
    
    -- Set active tab
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    
    -- Show corresponding frame
    if tabButton == PlayerTab then
        PlayerFrame.Visible = true
    elseif tabButton == CombatTab then
        CombatFrame.Visible = true
    elseif tabButton == VisualTab then
        VisualFrame.Visible = true
    elseif tabButton == AutoTab then
        AutoFrame.Visible = true
    elseif tabButton == CreditsTab then
        CreditsFrame.Visible = true
    end
end

-- Connect tab buttons
PlayerTab.MouseButton1Click:Connect(function()
    switchTab(PlayerTab)
end)

CombatTab.MouseButton1Click:Connect(function()
    switchTab(CombatTab)
end)

VisualTab.MouseButton1Click:Connect(function()
    switchTab(VisualTab)
end)

AutoTab.MouseButton1Click:Connect(function()
    switchTab(AutoTab)
end)

CreditsTab.MouseButton1Click:Connect(function()
    switchTab(CreditsTab)
end)

-- Function to create a title in a frame
local function createSectionTitle(parent, text, yPos)
    local title = Instance.new("TextLabel")
    title.Name = text.."Title"
    title.Parent = parent
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.BorderSizePixel = 0
    title.Position = UDim2.new(0, 10, 0, yPos)
    title.Size = UDim2.new(1, -20, 0, 35) -- Taller for mobile
    title.Font = Enum.Font.SourceSansBold
    title.Text = " "..text
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20.000 -- Larger text
    title.TextXAlignment = Enum.TextXAlignment.Left
    return title
end

-- Function to create a toggle button (larger for mobile)
local function createToggle(parent, text, yPos, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = text.."Frame"
    toggleFrame.Parent = parent
    toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Position = UDim2.new(0, 10, 0, yPos)
    toggleFrame.Size = UDim2.new(1, -20, 0, 50) -- Taller for mobile
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "Label"
    toggleLabel.Parent = toggleFrame
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Position = UDim2.new(0, 10, 0, 0)
    toggleLabel.Size = UDim2.new(1, -80, 1, 0) -- More space for the button
    toggleLabel.Font = Enum.Font.SourceSans
    toggleLabel.Text = text
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 20.000 -- Larger text
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "Button"
    toggleButton.Parent = toggleFrame
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    toggleButton.BorderSizePixel = 0
    toggleButton.Position = UDim2.new(1, -65, 0.5, -15)
    toggleButton.Size = UDim2.new(0, 60, 0, 30) -- Larger for mobile
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.Text = "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 18.000 -- Larger text
    
    local toggled = false
    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            toggleButton.Text = "ON"
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            toggleButton.Text = "OFF"
        end
        if callback then
            callback(toggled)
        end
    end)
    
    return toggleButton
end

-- Function to create a button (for mobile)
local function createButton(parent, text, yPos, callback)
    local button = Instance.new("TextButton")
    button.Name = text.."Button"
    button.Parent = parent
    button.BackgroundColor3 = Color3.fromRGB(45, 85, 255)
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.Size = UDim2.new(1, -20, 0, 50) -- Tall button for mobile
    button.Font = Enum.Font.SourceSansBold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 22.000 -- Large text for mobile
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

-- PLAYER TAB CONTENT
local playerTitleMovement = createSectionTitle(PlayerFrame, "Movement", 10)

-- Buttons for speed settings (easier than sliders on mobile)
local walkSpeed16 = createButton(PlayerFrame, "Normal Speed (16)", 55, function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)
end)

local walkSpeed50 = createButton(PlayerFrame, "Fast Speed (50)", 115, function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end)
end)

local walkSpeed100 = createButton(PlayerFrame, "Super Speed (100)", 175, function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end)
end)

-- Jump power buttons
local jumpPower50 = createButton(PlayerFrame, "Normal Jump (50)", 235, function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end)
end)

local jumpPower100 = createButton(PlayerFrame, "High Jump (100)", 295, function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
    end)
end)

-- Infinite Jump toggle
local infiniteJumpToggle = createToggle(PlayerFrame, "Infinite Jump", 355, function(state)
    if state then
        _G.InfJump = true
        
        local infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
        
        -- Store the connection to disconnect later
        _G.InfJumpConnection = infJumpConnection
    else
        _G.InfJump = false
        if _G.InfJumpConnection then
            _G.InfJumpConnection:Disconnect()
        end
    end
end)

-- COMBAT TAB CONTENT
local combatTitle = createSectionTitle(CombatFrame, "Combat Features", 10)

-- No Recoil toggle
local noRecoilToggle = createToggle(CombatFrame, "No Recoil", 55, function(state)
    pcall(function()
        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("GunStates") then
                if state then
                    v.GunStates.RecoilControl.Value = 0
                else
                    v.GunStates.RecoilControl.Value = 1
                end
            end
        end
    end)
end)

-- Silent Aim toggle - DA HOOD SPECIFIC
local silentAimToggle = createToggle(CombatFrame, "Silent Aim", 115, function(state)
    _G.SilentAim = state
    
    pcall(function()
        if state then
            local players = game:GetService("Players")
            local localPlayer = players.LocalPlayer
            local mouse = localPlayer:GetMouse()
            
            -- Da Hood specific aim hook
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if method == "FireServer" and self.Name == "MainEvent" and args[1] == "UpdateMousePos" and _G.SilentAim then
                    -- Find closest player
                    local closest = nil
                    local shortestDistance = math.huge
                    
                    for i, player in pairs(players:GetPlayers()) do
                        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
                            local position = player.Character.HumanoidRootPart.Position
                            local distance = (position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                            
                            if distance < shortestDistance then
                                shortestDistance = distance
                                closest = player
                            end
                        end
                    end
                    
                    if closest and closest.Character and closest.Character:FindFirstChild("HumanoidRootPart") then
                        args[2] = closest.Character.HumanoidRootPart.Position
                    end
                end
                
                return old(self, unpack(args))
            end)
            
            setreadonly(mt, true)
        end
    end)
end)

-- Enhanced Mobile Aimbot (made specifically for mobile)
local aimbotToggle = createToggle(CombatFrame, "Enhanced Mobile Aimbot", 175, function(state)
    if state then
        _G.Aimbot = true
        
        -- Create a visual indicator for who we're targeting
        local targetGui = Instance.new("ScreenGui")
        targetGui.Name = "TargetIndicator"
        targetGui.Parent = game:GetService("CoreGui")
        
        local targetFrame = Instance.new("Frame")
        targetFrame.Name = "TargetFrame"
        targetFrame.Size = UDim2.new(0, 120, 0, 40)
        targetFrame.Position = UDim2.new(0.5, -60, 0.3, 0)
        targetFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        targetFrame.BackgroundTransparency = 0.5
        targetFrame.BorderSizePixel = 0
        targetFrame.Parent = targetGui
        
        local targetText = Instance.new("TextLabel")
        targetText.Name = "TargetName"
        targetText.Size = UDim2.new(1, 0, 1, 0)
        targetText.BackgroundTransparency = 1
        targetText.Text = "No Target"
        targetText.TextColor3 = Color3.fromRGB(255, 0, 0)
        targetText.TextSize = 18
        targetText.Font = Enum.Font.SourceSansBold
        targetText.Parent = targetFrame
        
        -- Create function to find nearest target
        local function getNearestTarget()
            local players = game:GetService("Players")
            local localPlayer = players.LocalPlayer
            local nearestDistance = math.huge
            local nearestPlayer = nil
            
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    local head = player.Character:FindFirstChild("Head")
                    
                    if rootPart and head then
                        local distance = (rootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        if distance < nearestDistance and distance < 50 then -- Only target within 50 studs
                            nearestDistance = distance
                            nearestPlayer = player
                        end
                    end
                end
            end
            
            return nearestPlayer, nearestDistance
        end
        
        -- Options for aimbot
        _G.AimbotTarget = "Head" -- Can be "Head" or "HumanoidRootPart"
        _G.AimbotStrength = 0.8 -- How strong the aim assist is (0.1 to 1)
        
        -- Create the aimbot loop
        _G.AimbotLoop = game:GetService("RunService").RenderStepped:Connect(function()
            if _G.Aimbot then
                local target, distance = getNearestTarget()
                
                if target then
                    targetText.Text = target.Name .. " (" .. math.floor(distance) .. "m)"
                    
                    -- Get the aim part (head or humanoid root part)
                    local aimPart = target.Character:FindFirstChild(_G.AimbotTarget)
                    
                    if aimPart then
                        -- Get the camera
                        local camera = workspace.CurrentCamera
                        
                        -- Calculate the CFrame we want to set the camera to
                        local targetCFrame = CFrame.new(camera.CFrame.Position, aimPart.Position)
                        
                        -- Smoothly interpolate between current camera CFrame and target CFrame
                        camera.CFrame = camera.CFrame:Lerp(targetCFrame, _G.AimbotStrength)
                        
                        -- For Da Hood, we also need to fire the event if a weapon is equipped
                        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                            game:GetService("ReplicatedStorage").MainEvent:FireServer("UpdateMousePos", aimPart.Position)
                        end
                    end
                else
                    targetText.Text = "No Target"
                end
            end
        end)
    else
        _G.Aimbot = false
        if _G.AimbotLoop then
            _G.AimbotLoop:Disconnect()
        end
        
        -- Clean up
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v.Name == "TargetIndicator" then
                v:Destroy()
            end
        end
    end
end)

-- Mobile friendly auto-shoot toggle
local autoShootToggle = createToggle(CombatFrame, "Auto Shoot", 235, function(state)
    if state then
        _G.AutoShoot = true
        
        _G.AutoShootLoop = game:GetService("RunService").Heartbeat:Connect(function()
            if _G.AutoShoot then
                -- Only shoot if we have a tool equipped
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChildOfClass("Tool") then
                    local tool = character:FindFirstChildOfClass("Tool")
                    
                    -- Fire the gun (Da Hood specific)
                    if tool and tool:FindFirstChild("GunStates") then
                        -- Method 1: Call the fire function if it exists
                        if tool:FindFirstChild("Fire") and typeof(tool.Fire) == "Function" then
                            tool.Fire:Fire()
                        end
                        
                        -- Method 2: Use MainEvent (Da Hood specific)
                        game:GetService("ReplicatedStorage").MainEvent:FireServer("Shoot", tool)
                        
                        -- Small delay to prevent too rapid firing
                        wait(0.1)
                    end
                end
            end
        end)
    else
        _G.AutoShoot = false
        if _G.AutoShootLoop then
            _G.AutoShootLoop:Disconnect()
        end
    end
end)

-- Kill Aura feature
local killAuraToggle = createToggle(CombatFrame, "Kill Aura", 295, function(state)
    if state then
        _G.KillAura = true
        
        _G.KillAuraLoop = game:GetService("RunService").Heartbeat:Connect(function()
            if _G.KillAura then
                -- Get all nearby players
                local players = game:GetService("Players"):GetPlayers()
                local localPlayer = game:GetService("Players").LocalPlayer
                
                for _, player in pairs(players) do
                    if player ~= localPlayer and player.Character and localPlayer.Character then
                        local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        local myRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local enemyHumanoid = player.Character:FindFirstChild("Humanoid")
                        
                        if enemyRoot and myRoot and enemyHumanoid and enemyHumanoid.Health > 0 then
                            -- Check if they are close enough
                            local distance = (enemyRoot.Position - myRoot.Position).Magnitude
                            
                            if distance < 15 then -- 15 studs range
                                -- Da Hood specific ways to damage players
                                
                                -- Method 1: MainEvent
                                game:GetService("ReplicatedStorage").MainEvent:FireServer("DamagePlayer", player)
                                
                                -- Method 2: If we have a melee weapon, teleport briefly to hit them
                                local knife = localPlayer.Backpack:FindFirstChild("Knife") or localPlayer.Character:FindFirstChild("Knife")
                                
                                if knife and not localPlayer.Character:FindFirstChild("Knife") then
                                    localPlayer.Character.Humanoid:EquipTool(knife)
                                end
                                
                                if localPlayer.Character:FindFirstChild("Knife") then
                                    -- Save our position
                                    local oldPos = myRoot.CFrame
                                    
                                    -- Teleport to enemy briefly
                                    myRoot.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, 3)
                                    wait(0.1)
                                    
                                    -- Fire the hit
                                    game:GetService("ReplicatedStorage").MainEvent:FireServer("KnifeHit", player.Character)
                                    
                                    -- Go back
                                    wait(0.1)
                                    myRoot.CFrame = oldPos
                                end
                                
                                -- Wait a bit before trying to damage another player
                                wait(0.5)
                            end
                        end
                    end
                end
            end
        end)
    else
        _G.KillAura = false
        if _G.KillAuraLoop then
            _G.KillAuraLoop:Disconnect()
        end
    end
end)

-- VISUAL TAB CONTENT
local visualTitle = createSectionTitle(VisualFrame, "ESP Features", 10)

-- Player ESP toggle
local playerESPToggle = createToggle(VisualFrame, "Player ESP", 55, function(state)
    if state then
        _G.ESP = true
        
        -- Function to create ESP
        local function createESP(player)
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local esp = Instance.new("BillboardGui")
                esp.Name = "ESP"
                esp.Parent = player.Character.HumanoidRootPart
                esp.Size = UDim2.new(0, 200, 0, 200) -- Larger for mobile visibility
                esp.Adornee = player.Character.HumanoidRootPart
                esp.AlwaysOnTop = true
                
                local name = Instance.new("TextLabel")
                name.Parent = esp
                name.BackgroundTransparency = 1
                name.Size = UDim2.new(1, 0, 0, 60) -- Taller for mobile
                name.Position = UDim2.new(0, 0, 0, -30)
                name.Text = player.Name
                name.TextColor3 = Color3.fromRGB(255, 0, 0)
                name.TextSize = 24 -- Larger text for mobile
                name.TextStrokeTransparency = 0
                name.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            end
        end
        
        -- Create ESP for existing players
        for i,v in pairs(game.Players:GetPlayers()) do
            createESP(v)
        end
        
        -- Handle new players
        local espPlayerAddedConnection = game.Players.PlayerAdded:Connect(function(player)
            if player.Character then createESP(player) end
            player.CharacterAdded:Connect(function(character)
                wait(1)
                if _G.ESP then createESP(player) end
            end)
        end)
        
        -- Store the connection to disconnect later
        _G.ESPPlayerAddedConnection = espPlayerAddedConnection
    else
        _G.ESP = false
        if _G.ESPPlayerAddedConnection then
            _G.ESPPlayerAddedConnection:Disconnect()
        end
        
        -- Remove existing ESP
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                for i2,v2 in pairs(v.Character.HumanoidRootPart:GetChildren()) do
                    if v2.Name == "ESP" then
                        v2:Destroy()
                    end
                end
            end
        end
    end
end)

-- Cash ESP toggle - DA HOOD SPECIFIC
local cashESPToggle = createToggle(VisualFrame, "Cash ESP", 115, function(state)
    if state then
        _G.CashESP = true
        
        -- Function to create Cash ESP - specifically for Da Hood money drops
        local function createCashESP(cash)
            if cash.Name == "Drop" and cash:IsA("Part") then
                local esp = Instance.new("BillboardGui")
                esp.Name = "CashESP"
                esp.Parent = cash
                esp.Size = UDim2.new(0, 60, 0, 60) -- Larger for mobile
                esp.Adornee = cash
                esp.AlwaysOnTop = true
                
                local icon = Instance.new("TextLabel")
                icon.Parent = esp
                icon.BackgroundTransparency = 1
                icon.Size = UDim2.new(1, 0, 1, 0)
                icon.Text = "💰"
                icon.TextColor3 = Color3.fromRGB(0, 255, 0)
                icon.TextSize = 36 -- Larger text for mobile
                icon.TextStrokeTransparency = 0
                icon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            end
        end
        
        -- Create ESP for existing cash drops in Da Hood
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            createCashESP(v)
        end
        
        -- Handle new cash drops
        local cashAddedConnection = game:GetService("Workspace").ChildAdded:Connect(function(child)
            wait(0.5)
            if _G.CashESP then createCashESP(child) end
        end)
        
        -- Store the connection to disconnect later
        _G.CashAddedConnection = cashAddedConnection
    else
        _G.CashESP = false
        if _G.CashAddedConnection then
            _G.CashAddedConnection:Disconnect()
        end
        
        -- Remove existing Cash ESP
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v.Name == "Drop" and v:IsA("Part") then
                for i2,v2 in pairs(v:GetChildren()) do
                    if v2.Name == "CashESP" then
                        v2:Destroy()
                    end
                end
            end
        end
    end
end)

-- Box ESP toggle
local boxESPToggle = createToggle(VisualFrame, "Box ESP", 175, function(state)
    if state then
        _G.BoxESP = true
        
        -- Function to create Box ESP
        local function createBoxESP(player)
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- Create highlights
                local highlight = Instance.new("Highlight")
                highlight.Name = "BoxESP"
                highlight.Parent = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
            end
        end
        
        -- Create Box ESP for existing players
        for i,v in pairs(game.Players:GetPlayers()) do
            createBoxESP(v)
        end
        
        -- Handle new players
        local boxESPPlayerAddedConnection = game.Players.PlayerAdded:Connect(function(player)
            if player.Character then createBoxESP(player) end
            player.CharacterAdded:Connect(function(character)
                wait(1)
                if _G.BoxESP then createBoxESP(player) end
            end)
        end)
        
        -- Store the connection to disconnect later
        _G.BoxESPPlayerAddedConnection = boxESPPlayerAddedConnection
    else
        _G.BoxESP = false
        if _G.BoxESPPlayerAddedConnection then
            _G.BoxESPPlayerAddedConnection:Disconnect()
        end
        
        -- Remove existing Box ESP
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character then
                for i2,v2 in pairs(v.Character:GetChildren()) do
                    if v2.Name == "BoxESP" then
                        v2:Destroy()
                    end
                end
            end
        end
    end
end)

-- AUTO TAB CONTENT
local autoTitle = createSectionTitle(AutoFrame, "Auto Farm", 10)

-- Auto Cash Pickup toggle - DA HOOD SPECIFIC
local autoCashToggle = createToggle(AutoFrame, "Auto Cash Pickup", 55, function(state)
    if state then
        _G.AutoCash = true
        
        -- Start auto cash pickup loop for Da Hood
        spawn(function()
            while _G.AutoCash do
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name == "Drop" and v:IsA("Part") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        wait(0.4)
                    end
                end
                wait(0.5)
            end
        end)
    else
        _G.AutoCash = false
    end
end)

-- Auto Money Farm (ATM) - DA HOOD SPECIFIC
local autoMoneyFarmToggle = createToggle(AutoFrame, "Auto Money Farm", 115, function(state)
    if state then
        _G.AutoMoneyFarm = true
        
        -- Create notification function to track earnings
        local function createNotification(text)
            local notification = Instance.new("Frame")
            notification.Name = "MoneyNotification"
            notification.Parent = ScreenGui
            notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            notification.BackgroundTransparency = 0.3
            notification.BorderSizePixel = 0
            notification.Position = UDim2.new(0.5, -150, 0.8, 0)
            notification.Size = UDim2.new(0, 300, 0, 50)
            
            local notificationText = Instance.new("TextLabel")
            notificationText.Parent = notification
            notificationText.BackgroundTransparency = 1
            notificationText.Size = UDim2.new(1, 0, 1, 0)
            notificationText.Font = Enum.Font.SourceSansBold
            notificationText.Text = text
            notificationText.TextColor3 = Color3.fromRGB(0, 255, 0)
            notificationText.TextSize = 22
            
            -- Fade out and destroy
            spawn(function()
                wait(3)
                for i = 0, 1, 0.1 do
                    notification.BackgroundTransparency = 0.3 + (i * 0.7)
                    notificationText.TextTransparency = i
                    wait(0.05)
                end
                notification:Destroy()
            end)
        end
        
        -- Total money earned tracking
        _G.TotalMoneyEarned = 0
        
        -- Find ATMs and farm money
        spawn(function()
            while _G.AutoMoneyFarm do
                -- Try to teleport to ATMs (Da Hood has several)
                local atms = {}
                
                -- Collect all ATMs
                for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.Name == "ATM" or v.Name:find("ATM") then
                        table.insert(atms, v)
                    end
                end
                
                -- Rob each ATM
                for _, atm in pairs(atms) do
                    if not _G.AutoMoneyFarm then break end
                    
                    -- Try to find a handle or main part
                    local atmPart = nil
                    if atm:IsA("Model") then
                        atmPart = atm:FindFirstChildOfClass("Part")
                    elseif atm:IsA("Part") then
                        atmPart = atm
                    end
                    
                    if atmPart then
                        -- Teleport to ATM
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = atmPart.CFrame * CFrame.new(0, 0, -2)
                        wait(0.5)
                        
                        -- Try to rob it (Da Hood usually requires clicking or firing)
                        -- We'll try both methods:
                        
                        -- Method 1: Clicking
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(
                            atmPart.Position.X, 
                            atmPart.Position.Y, 
                            0, true, game, 1
                        )
                        wait(0.1)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(
                            atmPart.Position.X, 
                            atmPart.Position.Y, 
                            0, false, game, 1
                        )
                        
                        -- Method 2: Fire server event
                        pcall(function()
                            game:GetService("ReplicatedStorage").MainEvent:FireServer("Rob", atm)
                        end)
                        
                        -- Random money earned for visual feedback
                        local moneyEarned = math.random(100, 250)
                        _G.TotalMoneyEarned = _G.TotalMoneyEarned + moneyEarned
                        createNotification("+ $" .. moneyEarned .. " | Total: $" .. _G.TotalMoneyEarned)
                        
                        wait(3) -- Wait between ATMs
                    end
                end
                
                -- After trying all ATMs, wait before next cycle
                wait(15)
            end
        end)
    else
        _G.AutoMoneyFarm = false
    end
end)

-- Auto Stomp toggle - DA HOOD SPECIFIC
local autoStompToggle = createToggle(AutoFrame, "Auto Stomp", 175, function(state)
    if state then
        _G.AutoStomp = true
        
        spawn(function()
            while _G.AutoStomp do
                -- Da Hood specific auto stomp
                game:GetService("ReplicatedStorage").MainEvent:FireServer("Stomp")
                wait(1)
            end
        end)
    else
        _G.AutoStomp = false
    end
end)

-- Auto Reload toggle
local autoReloadToggle = createToggle(AutoFrame, "Auto Reload", 235, function(state)
    if state then
        _G.AutoReload = true
        
        spawn(function()
            while _G.AutoReload do
                local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Ammo") and tool:FindFirstChild("MaxAmmo") then
                    if tool.Ammo.Value <= 0 then
                        game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", tool)
                    end
                end
                wait(0.5)
            end
        end)
    else
        _G.AutoReload = false
    end
end)

-- Auto grab guns (ATMs in Da Hood usually have guns nearby)
local autoGunToggle = createToggle(AutoFrame, "Auto Grab Guns", 295, function(state)
    if state then
        _G.AutoGun = true
        
        spawn(function()
            while _G.AutoGun do
                -- Look for guns in workspace
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:IsA("Model") and (v.Name:find("Glock") or v.Name:find("Shotty") or v.Name:find("Uzi") or v.Name:find("Sawed") or v.Name:find("Silencer")) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChildOfClass("Part").CFrame
                        wait(1)
                    end
                end
                wait(2)
            end
        end)
    else
        _G.AutoGun = false
    end
end)

-- CREDITS TAB CONTENT
local creditsTitle = createSectionTitle(CreditsFrame, "Credits", 10)

local creditsText1 = Instance.new("TextLabel")
creditsText1.Name = "CreditsText1"
creditsText1.Parent = CreditsFrame
creditsText1.BackgroundTransparency = 1
creditsText1.Position = UDim2.new(0, 10, 0, 55)
creditsText1.Size = UDim2.new(1, -20, 0, 40)
creditsText1.Font = Enum.Font.SourceSansBold
creditsText1.Text = "Da Hood Mobile GUI"
creditsText1.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsText1.TextSize = 28.000 -- Large text for mobile

local creditsText2 = Instance.new("TextLabel")
creditsText2.Name = "CreditsText2"
creditsText2.Parent = CreditsFrame
creditsText2.BackgroundTransparency = 1
creditsText2.Position = UDim2.new(0, 10, 0, 105)
creditsText2.Size = UDim2.new(1, -20, 0, 35)
creditsText2.Font = Enum.Font.SourceSans
creditsText2.Text = "Created by: LAJ-HUBv333"
creditsText2.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsText2.TextSize = 24.000 -- Large text for mobile

-- Add a button to reset all changes
local resetButton = createButton(CreditsFrame, "Reset All Settings", 170, function()
    -- Stop all loops
    if _G.InfJumpConnection then _G.InfJumpConnection:Disconnect() end
    if _G.ESPPlayerAddedConnection then _G.ESPPlayerAddedConnection:Disconnect() end
    if _G.CashAddedConnection then _G.CashAddedConnection:Disconnect() end
    if _G.BoxESPPlayerAddedConnection then _G.BoxESPPlayerAddedConnection:Disconnect() end
    if _G.AimbotLoop then _G.AimbotLoop:Disconnect() end
    if _G.TriggerbotLoop then _G.TriggerbotLoop:Disconnect() end
    
    -- Set all globals to false
    _G.InfJump = false
    _G.ESP = false
    _G.CashESP = false
    _G.BoxESP = false
    _G.Aimbot = false
    _G.Triggerbot = false
    _G.AutoCash = false
    _G.AutoStomp = false
    _G.AutoReload = false
    _G.AutoGun = false
    _G.SilentAim = false
    
    -- Reset character stats
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end)
    
    -- Clean up ESP
    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            for i2,v2 in pairs(v.Character:GetChildren()) do
                if v2.Name == "ESP" or v2.Name == "BoxESP" then
                    v2:Destroy()
                end
            end
            if v.Character:FindFirstChild("HumanoidRootPart") then
                for i2,v2 in pairs(v.Character.HumanoidRootPart:GetChildren()) do
                    if v2.Name == "ESP" then
                        v2:Destroy()
                    end
                end
            end
        end
    end
    
    -- Clean up Cash ESP
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v.Name == "Drop" and v:IsA("Part") then
            for i2,v2 in pairs(v:GetChildren()) do
                if v2.Name == "CashESP" then
                    v2:Destroy()
                end
            end
        end
    end
    
    -- Clean up aim target
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "AimbotTarget" then
            v:Destroy()
        end
    end
end)

-- Add hide GUI button at the bottom
local hideButton = createButton(CreditsFrame, "Hide GUI (Press O to show)", 240, function()
    ScreenGui.Enabled = false
end)

-- Keybind to show UI again (press O)
local uisConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.O then
        ScreenGui.Enabled = true
    end
end)

-- Make sure we store the connection to clean up later
_G.UIShowConnection = uisConnection

-- Add a button to close GUI completely
local closeButton = createButton(CreditsFrame, "Close GUI Completely", 310, function()
    -- Disconnect all connections
    if _G.InfJumpConnection then _G.InfJumpConnection:Disconnect() end
    if _G.ESPPlayerAddedConnection then _G.ESPPlayerAddedConnection:Disconnect() end
    if _G.CashAddedConnection then _G.CashAddedConnection:Disconnect() end
    if _G.BoxESPPlayerAddedConnection then _G.BoxESPPlayerAddedConnection:Disconnect() end
    if _G.AimbotLoop then _G.AimbotLoop:Disconnect() end
    if _G.TriggerbotLoop then _G.TriggerbotLoop:Disconnect() end
    if _G.UIShowConnection then _G.UIShowConnection:Disconnect() end
    
    -- Destroy the GUI
    ScreenGui:Destroy()
end)

-- Initialize to show first tab
switchTab(PlayerTab)

-- Success message
print("Da Hood Mobile GUI loaded successfully!")