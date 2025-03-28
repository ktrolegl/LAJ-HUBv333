-- Da Hood/Da Strike Basic GUI
-- Simple version that should work on Roblox Delta

-- Load DrRay UI Library with error handling - direct version
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

-- Create main window
local window = DrRayLibrary:Load("Da Hood Basic", "Default")

-- COMBAT TAB
local combatTab = window:Tab("Combat", "")

-- Gun mods
combatTab:Section("Gun Modifications")

combatTab:Toggle("No Recoil", "Removes gun recoil", false, function(state)
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

combatTab:Toggle("Infinite Ammo", "Never run out of bullets", false, function(state)
    pcall(function()
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        if state then
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if method == "FireServer" and self.Name == "MainEvent" and args[1] == "UpdateAmmo" then
                    args[2] = math.huge
                    return old(self, unpack(args))
                end
                
                return old(self, ...)
            end)
        else
            mt.__namecall = old
        end
        
        setreadonly(mt, true)
    end)
end)

combatTab:Toggle("Silent Aim", "Auto-aims at nearest player", false, function(state)
    _G.SilentAim = state
    
    pcall(function()
        if state then
            local players = game:GetService("Players")
            local localPlayer = players.LocalPlayer
            local mouse = localPlayer:GetMouse()
            local camera = game:GetService("Workspace").CurrentCamera
            
            local function getClosestPlayerToCursor()
                local closestPlayer = nil
                local shortestDistance = math.huge
                
                for i, player in pairs(players:GetPlayers()) do
                    if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
                        local pos = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                        local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                        
                        if magnitude < shortestDistance then
                            closestPlayer = player
                            shortestDistance = magnitude
                        end
                    end
                end
                
                return closestPlayer
            end
            
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if method == "FireServer" and self.Name == "MainEvent" and args[1] == "UpdateMousePos" and _G.SilentAim then
                    local closest = getClosestPlayerToCursor()
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

-- PLAYER TAB
local playerTab = window:Tab("Player", "")

playerTab:Section("Character Modifications")

-- Speed control
playerTab:Slider("WalkSpeed", "Change how fast you walk", 16, 150, 16, function(value)
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end)
end)

-- Jump power
playerTab:Slider("JumpPower", "Change how high you jump", 50, 250, 50, function(value)
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end)
end)

-- Flight
playerTab:Toggle("Flight", "Fly around the map", false, function(state)
    pcall(function()
        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        
        if state then
            _G.Flying = true
            local bodyvelocity = Instance.new("BodyVelocity", plr.Character.HumanoidRootPart)
            bodyvelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyvelocity.Velocity = Vector3.new(0, 0.1, 0)
            bodyvelocity.Name = "Flight"
            
            while _G.Flying do
                local speed = 50
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                    bodyvelocity.Velocity = plr.Character.HumanoidRootPart.CFrame.lookVector * speed
                elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                    bodyvelocity.Velocity = plr.Character.HumanoidRootPart.CFrame.lookVector * -speed
                else
                    bodyvelocity.Velocity = Vector3.new(0, 0.1, 0)
                end
                wait()
            end
        else
            _G.Flying = false
            for i,v in pairs(plr.Character.HumanoidRootPart:GetChildren()) do
                if v.Name == "Flight" then
                    v:Destroy()
                end
            end
        end
    end)
end)

-- Noclip
playerTab:Toggle("NoClip", "Walk through walls", false, function(state)
    pcall(function()
        local plr = game.Players.LocalPlayer
        
        if state then
            _G.NoClip = true
            
            game:GetService("RunService").Stepped:Connect(function()
                if _G.NoClip then
                    for i,v in pairs(plr.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide == true then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        else
            _G.NoClip = false
        end
    end)
end)

-- ESP/VISUALS TAB
local visualsTab = window:Tab("Visuals", "")

visualsTab:Section("ESP Features")

visualsTab:Toggle("Player ESP", "See players through walls", false, function(state)
    pcall(function()
        if state then
            _G.ESP = true
            
            local function createESP(player)
                local esp = Instance.new("BillboardGui", player.Character.HumanoidRootPart)
                esp.Name = "ESP"
                esp.Size = UDim2.new(0, 100, 0, 150)
                esp.Adornee = player.Character.HumanoidRootPart
                esp.AlwaysOnTop = true
                
                local name = Instance.new("TextLabel", esp)
                name.Text = player.Name
                name.Size = UDim2.new(1, 0, 0, 50)
                name.BackgroundTransparency = 1
                name.TextColor3 = Color3.fromRGB(255, 0, 0)
                name.TextSize = 20
                name.TextStrokeTransparency = 0
                name.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            end
            
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    createESP(v)
                end
            end
            
            game.Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    wait(1)
                    if _G.ESP and character:FindFirstChild("HumanoidRootPart") then
                        createESP(player)
                    end
                end)
            end)
        else
            _G.ESP = false
            
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
end)

visualsTab:Toggle("Cash ESP", "See cash drops through walls", false, function(state)
    pcall(function()
        if state then
            _G.CashESP = true
            
            local function createCashESP(cash)
                local esp = Instance.new("BillboardGui", cash)
                esp.Name = "CashESP"
                esp.Size = UDim2.new(0, 50, 0, 50)
                esp.Adornee = cash
                esp.AlwaysOnTop = true
                
                local icon = Instance.new("ImageLabel", esp)
                icon.Image = "rbxassetid://3354143408" -- Money icon
                icon.Size = UDim2.new(1, 0, 1, 0)
                icon.BackgroundTransparency = 1
                icon.ImageColor3 = Color3.fromRGB(0, 255, 0)
            end
            
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v.Name == "Drop" and v:IsA("Part") then
                    createCashESP(v)
                end
            end
            
            game:GetService("Workspace").ChildAdded:Connect(function(child)
                wait(0.5)
                if _G.CashESP and child.Name == "Drop" and child:IsA("Part") then
                    createCashESP(child)
                end
            end)
        else
            _G.CashESP = false
            
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
end)

-- Auto-farm tab
local autoFarmTab = window:Tab("Auto Farm", "")

autoFarmTab:Section("Automated Money Making")

autoFarmTab:Toggle("Auto Cash Pickup", "Automatically collect dropped cash", false, function(state)
    pcall(function()
        if state then
            _G.AutoCash = true
            
            while _G.AutoCash do
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name == "Drop" and v:IsA("Part") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        wait(0.4)
                    end
                end
                wait(0.5)
            end
        else
            _G.AutoCash = false
        end
    end)
end)

-- PROTECTION TAB
local protectionTab = window:Tab("Protection", "")

protectionTab:Section("Anti-Ban & Security")

protectionTab:Toggle("Anti-Kick", "Prevent automatic kicks", false, function(state)
    pcall(function()
        if state then
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if method == "Kick" then
                    return
                end
                return old(self, ...)
            end)
            setreadonly(mt, true)
        end
    end)
end)

protectionTab:Toggle("Anti-Fling", "Prevent being flung by others", false, function(state)
    pcall(function()
        if state then
            _G.AntiFling = true
            
            game:GetService("RunService").Stepped:Connect(function()
                if _G.AntiFling then
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            v.Character.HumanoidRootPart.CanCollide = false
                            v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                            v.Character.HumanoidRootPart.Transparency = 1
                        end
                    end
                end
            end)
        else
            _G.AntiFling = false
        end
    end)
end)

-- SETTINGS TAB
local settingsTab = window:Tab("Settings", "")

-- UI Settings
settingsTab:Section("UI Settings")

-- UI color theme setting
settingsTab:Dropdown("Theme", "Change UI appearance", {"Default", "Dark", "Light", "Mocha"}, function(selected)
    pcall(function()
        DrRayLibrary:ChangeTheme(selected)
    end)
end)

-- Keybind setting for toggling the UI visibility
settingsTab:Keybind("Toggle UI", "Show/Hide the interface", Enum.KeyCode.RightShift, function()
    pcall(function()
        window:Toggle()
    end)
end)

-- Credits section
local creditsTab = window:Tab("Credits", "")
creditsTab:Label("Created by: Ultimate Da Hood GUI")
creditsTab:Label("UI Library: DrRay UI Library")
creditsTab:Label("Game: Da Hood/Da Strike")

-- Add a button to destroy/close the UI
creditsTab:Button("Destroy UI", "Close the interface completely", function()
    window:Destroy()
end)

-- Print success message
print("Da Hood/Da Strike Ultimate GUI loaded successfully!")

