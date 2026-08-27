--[[
    FlazeHub — Unified Sniper Arena & Rivals Script
    UI Framework: Rayfield Interface Suite
]]

local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("FlazeHub: Failed to load Rayfield UI library.")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "FlazeHub",
    LoadingTitle = "FlazeHub Loading...",
    LoadingSubtitle = "by Flaze",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "FlazeHubConfig",
        FileName = "FlazeHubSettings"
    },
    KeySystem = false
})

local Settings = {
    Aimbot = false,
    AimbotSmooth = 35,
    FOV = 120,
    Prediction = 50,
    TargetPart = "Head",
    ShowFOV = true,
    TeamCheck = true,
    TriggerBot = false,
    Hitbox = false,
    HitboxSize = 2,
    ESP_Box = false,
    ESP_Filled = false,
    ESP_Skeleton = false,
    ESP_Line = false,
    ESP_Distance = false,
    ESP_Name = true,
    VisCheck = false,
    NoReload = false,
    Speed = false,
    SpeedVal = 0.05,
    SafeFly = false,
    FlySpeed = 25,
    Jump = false,
    JumpVal = 50,
    AutoStrafe = false,
    InfiniteJump = false,
    Noclip = false
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PGui = LocalPlayer:WaitForChild("PlayerGui")

-- Tabs Creation
local CombatTab = Window:CreateTab("🎯 COMBAT", 4483363048)
local VisualsTab = Window:CreateTab("👁️ VISUALS", 4483362458)
local WeaponTab = Window:CreateTab("🔫 WEAPON", 4483362458)
local MovementTab = Window:CreateTab("🏃 MOVEMENT", 4483362458)
local ConfigTab = Window:CreateTab("⚙️ CONFIG", 4483362458)

-- Combat Elements
CombatTab:CreateToggle({
    Name = "Aimbot (Advanced Mouse Track)",
    CurrentValue = Settings.Aimbot,
    Flag = "AimbotFlag",
    Callback = function(Value) Settings.Aimbot = Value end
})

CombatTab:CreateSlider({
    Name = "Aimbot Smoothness",
    Range = {1, 99},
    Increment = 1,
    CurrentValue = Settings.AimbotSmooth,
    Flag = "AimbotSmoothFlag",
    Callback = function(Value) Settings.AimbotSmooth = Value end
})

CombatTab:CreateSlider({
    Name = "FOV Radius",
    Range = {20, 400},
    Increment = 5,
    CurrentValue = Settings.FOV,
    Flag = "FOVFlag",
    Callback = function(Value) Settings.FOV = Value end
})

CombatTab:CreateSlider({
    Name = "Prediction Value",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = Settings.Prediction,
    Flag = "PredictionFlag",
    Callback = function(Value) Settings.Prediction = Value end
})

CombatTab:CreateDropdown({
    Name = "Target Bone",
    Options = {"Head", "HumanoidRootPart", "UpperTorso"},
    CurrentOption = Settings.TargetPart,
    Flag = "TargetBoneFlag",
    Callback = function(Option) Settings.TargetPart = Option end
})

CombatTab:CreateToggle({
    Name = "Show FOV Circle",
    CurrentValue = Settings.ShowFOV,
    Flag = "ShowFOVFlag",
    Callback = function(Value) Settings.ShowFOV = Value end
})

CombatTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = Settings.TeamCheck,
    Flag = "TeamCheckFlag",
    Callback = function(Value) Settings.TeamCheck = Value end
})

CombatTab:CreateToggle({
    Name = "Trigger Assist (Auto Fire)",
    CurrentValue = Settings.TriggerBot,
    Flag = "TriggerBotFlag",
    Callback = function(Value) Settings.TriggerBot = Value end
})

CombatTab:CreateToggle({
    Name = "Hitbox Expand",
    CurrentValue = Settings.Hitbox,
    Flag = "HitboxFlag",
    Callback = function(Value) Settings.Hitbox = Value end
})

CombatTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = Settings.HitboxSize,
    Flag = "HitboxSizeFlag",
    Callback = function(Value) Settings.HitboxSize = Value end
})

-- Visuals Elements
VisualsTab:CreateToggle({
    Name = "ESP Highlight Box",
    CurrentValue = Settings.ESP_Box,
    Flag = "ESPBoxFlag",
    Callback = function(Value) Settings.ESP_Box = Value end
})

VisualsTab:CreateToggle({
    Name = "ESP Box Filled",
    CurrentValue = Settings.ESP_Filled,
    Flag = "ESPFilledFlag",
    Callback = function(Value) Settings.ESP_Filled = Value end
})

VisualsTab:CreateToggle({
    Name = "Skeleton ESP",
    CurrentValue = Settings.ESP_Skeleton,
    Flag = "ESPSkeletonFlag",
    Callback = function(Value) Settings.ESP_Skeleton = Value end
})

VisualsTab:CreateToggle({
    Name = "Tracer ESP (Lines)",
    CurrentValue = Settings.ESP_Line,
    Flag = "ESPLineFlag",
    Callback = function(Value) Settings.ESP_Line = Value end
})

VisualsTab:CreateToggle({
    Name = "Name & Distance Tags",
    CurrentValue = Settings.ESP_Name,
    Flag = "ESPNameFlag",
    Callback = function(Value) Settings.ESP_Name = Value; Settings.ESP_Distance = Value end
})

VisualsTab:CreateToggle({
    Name = "Visible Check (Raycast)",
    CurrentValue = Settings.VisCheck,
    Flag = "VisCheckFlag",
    Callback = function(Value) Settings.VisCheck = Value end
})

-- Weapon Elements
WeaponTab:CreateToggle({
    Name = "Instant No Reload",
    CurrentValue = Settings.NoReload,
    Flag = "NoReloadFlag",
    Callback = function(Value) Settings.NoReload = Value end
})

-- Movement Elements
MovementTab:CreateLabel("⚠️ Speed Limit: Max 0.1 (CFrame)")
MovementTab:CreateToggle({
    Name = "CFrame Speed",
    CurrentValue = Settings.Speed,
    Flag = "SpeedFlag",
    Callback = function(Value) Settings.Speed = Value end
})

MovementTab:CreateSlider({
    Name = "Speed Value",
    Range = {0.01, 0.1},
    Increment = 0.01,
    CurrentValue = Settings.SpeedVal,
    Flag = "SpeedValFlag",
    Callback = function(Value) Settings.SpeedVal = Value end
})

MovementTab:CreateToggle({
    Name = "Safe Fly",
    CurrentValue = Settings.SafeFly,
    Flag = "SafeFlyFlag",
    Callback = function(Value) Settings.SafeFly = Value end
})

MovementTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 100},
    Increment = 1,
    CurrentValue = Settings.FlySpeed,
    Flag = "FlySpeedFlag",
    Callback = function(Value) Settings.FlySpeed = Value end
})

MovementTab:CreateToggle({
    Name = "Jump Boost",
    CurrentValue = Settings.Jump,
    Flag = "JumpFlag",
    Callback = function(Value) Settings.Jump = Value end
})

MovementTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 100},
    Increment = 1,
    CurrentValue = Settings.JumpVal,
    Flag = "JumpValFlag",
    Callback = function(Value) Settings.JumpVal = Value end
})

MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = Settings.InfiniteJump,
    Flag = "InfiniteJumpFlag",
    Callback = function(Value) Settings.InfiniteJump = Value end
})

MovementTab:CreateToggle({
    Name = "Auto Strafe",
    CurrentValue = Settings.AutoStrafe,
    Flag = "AutoStrafeFlag",
    Callback = function(Value) Settings.AutoStrafe = Value end
})

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = Settings.Noclip,
    Flag = "NoclipFlag",
    Callback = function(Value) Settings.Noclip = Value end
})

-- Config Elements
local configFileName = "FlazeHub_CustomConfig.json"

ConfigTab:CreateButton({
    Name = "Save Configuration File",
    Callback = function()
        if writefile then
            local success, err = pcall(function()
                writefile(configFileName, HttpService:JSONEncode(Settings))
            end)
            if success then
                Rayfield:Notify({Title = "Config Saved", Content = "Successfully saved settings to workspace!", Duration = 3, Image = 4483362850})
            else
                Rayfield:Notify({Title = "Error", Content = "Failed to write config: " .. tostring(err), Duration = 3, Image = 4483362850})
            end
        else
            Rayfield:Notify({Title = "Unsupported", Content = "Your executor does not support writefile.", Duration = 3, Image = 4483362850})
        end
    end
})

ConfigTab:CreateButton({
    Name = "Load Configuration File",
    Callback = function()
        if readfile and isfile and isfile(configFileName) then
            local success, decoded = pcall(function()
                return HttpService:JSONDecode(readfile(configFileName))
            end)
            if success and type(decoded) == "table" then
                for k, v in pairs(decoded) do
                    if Settings[k] ~= nil then
                        Settings[k] = v
                    end
                end
                Rayfield:Notify({Title = "Config Loaded", Content = "Successfully loaded settings!", Duration = 4, Image = 4483362850})
            else
                Rayfield:Notify({Title = "Error", Content = "Failed to parse config file.", Duration = 3, Image = 4483362850})
            end
        else
            Rayfield:Notify({Title = "Not Found", Content = "No saved configuration file exists yet.", Duration = 3, Image = 4483362850})
        end
    end
})

-- Utility Drawings / UI Elements
local fovGui = Instance.new("ScreenGui")
fovGui.Name = "FlazeFOV"
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.Parent = PGui

local fovFrame = Instance.new("Frame")
fovFrame.BackgroundTransparency = 1
fovFrame.BorderSizePixel = 0
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Parent = fovGui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovFrame

local fovStroke = Instance.new("UIStroke")
fovStroke.Transparency = 0.25
fovStroke.Thickness = 1.5
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Parent = fovFrame

local function CreateLine(from, to, color)
    local line = Drawing.new("Line")
    line.Visible = true
    line.Color = color or Color3.fromRGB(255, 255, 255)
    line.Thickness = 1
    line.From = from
    line.To = to
    return line
end

local function IsEnemy(p)
    if not Settings.TeamCheck then return true end
    if not LocalPlayer.Team or not p.Team then return true end
    return p.Team ~= LocalPlayer.Team
end

local function GetClosestTarget()
    local target, bestDist = nil, math.huge
    local center = UserInputService:GetMouseLocation()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsEnemy(player) and player.Character then
            local char = player.Character
            local part = char:FindFirstChild(Settings.TargetPart) or char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if part and hum and hum.Health > 0 then
                if Settings.VisCheck then
                    local parts = Camera:GetPartsObscuringTarget({part.Position}, {LocalPlayer.Character, char})
                    if #parts > 0 then continue end
                end
                
                local aimPos = part.Position
                local vel = part.AssemblyLinearVelocity
                if vel.Magnitude > 0.5 then
                    local dist3D = (Camera.CFrame.Position - aimPos).Magnitude
                    aimPos = aimPos + vel * ((dist3D / 500) * (Settings.Prediction / 100))
                end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(aimPos)
                if onScreen then
                    local magnitude = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if magnitude < Settings.FOV and magnitude < bestDist then
                        bestDist = magnitude
                        target = part
                    end
                end
            end
        end
    end
    return target
end

-- Robust Global Garbage Collection Table Hook for No Reload
local function HookNoReload()
    if not Settings.NoReload then return end
    pcall(function()
        for _, obj in pairs(getgc(true)) do
            if typeof(obj) == "table" then
                if rawget(obj, "ReloadTime") or rawget(obj, "Ammo") or rawget(obj, "MaxAmmo") then
                    if rawget(obj, "ReloadTime") then obj.ReloadTime = 0 end
                    if rawget(obj, "Ammo") and rawget(obj, "MaxAmmo") then obj.Ammo = obj.MaxAmmo end
                end
            end
        end
    end)
end

-- Infinite Jump Core Hook
local jumpConn = UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local activeDrawings = {}
local espObjects = {}

local function RemoveESP(p)
    if espObjects[p] then
        if espObjects[p].hl then espObjects[p].hl:Destroy() end
        if espObjects[p].bb then espObjects[p].bb:Destroy() end
        espObjects[p] = nil
    end
end

RunService.RenderStepped:Connect(function()
    -- FOV Update
    if Settings.ShowFOV and Settings.Aimbot then
        fovGui.Enabled = true
        fovFrame.Size = UDim2.fromOffset(Settings.FOV * 2, Settings.FOV * 2)
        local m = UserInputService:GetMouseLocation()
        fovFrame.Position = UDim2.fromOffset(m.X, m.Y)
    else
        fovGui.Enabled = false
    end

    -- Clear Dynamic Line Drawings
    for _, drawing in pairs(activeDrawings) do drawing:Remove() end
    activeDrawings = {}

    -- Noclip Loop
    if Settings.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- Movement modifications
    if Settings.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * Settings.SpeedVal)
        end
    end

    -- Safe Fly Loop
    if Settings.SafeFly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local hum = LocalPlayer.Character.Humanoid
        hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            hrp.Velocity = Vector3.new(moveDir.X * Settings.FlySpeed, hrp.Velocity.Y, moveDir.Z * Settings.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, Settings.FlySpeed, hrp.Velocity.Z)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, -Settings.FlySpeed, hrp.Velocity.Z)
        end
    end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if Settings.Jump then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpVal
        end
        if Settings.AutoStrafe and LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
            local velocity = LocalPlayer.Character.HumanoidRootPart.Velocity
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(velocity.X * 1.01, velocity.Y, velocity.Z * 1.01)
        end
    end

    -- Render Loop for Entities
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if char and hrp and head and hum and hum.Health > 0 and IsEnemy(player) then
                -- Highlights & Box ESP
                local d = espObjects[player] or {}
                espObjects[player] = d
                
                if Settings.ESP_Box or Settings.ESP_Filled then
                    if not d.hl or not d.hl.Parent then
                        local h = Instance.new("Highlight")
                        h.Adornee = char
                        h.Parent = char
                        d.hl = h
                    end
                    d.hl.Enabled = true
                    d.hl.OutlineColor = player.Team and player.Team.TeamColor.Color or Color3.fromRGB(255, 60, 60)
                    d.hl.FillColor = d.hl.OutlineColor
                    d.hl.OutlineTransparency = Settings.ESP_Box and 0 or 1
                    d.hl.FillTransparency = Settings.ESP_Filled and 0.55 or 1
                elseif d.hl then
                    d.hl:Destroy()
                    d.hl = nil
                end

                -- Billboard GUI (Name & Distance)
                if Settings.ESP_Name or Settings.ESP_Distance then
                    if not d.bb or not d.bb.Parent then
                        local bb = Instance.new("BillboardGui")
                        bb.AlwaysOnTop = true
                        bb.Size = UDim2.fromOffset(130, 44)
                        bb.StudsOffset = Vector3.new(0, 3.5, 0)
                        bb.Adornee = hrp
                        bb.Parent = hrp
                        
                        local ul = Instance.new("UIListLayout")
                        ul.HorizontalAlignment = Enum.HorizontalAlignment.Center
                        ul.Parent = bb
                        
                        local nl = Instance.new("TextLabel")
                        nl.Name = "NL"
                        nl.BackgroundTransparency = 1
                        nl.Size = UDim2.new(1, 0, 0, 18)
                        nl.Font = Enum.Font.GothamBold
                        nl.TextSize = 13
                        nl.TextStrokeTransparency = 0.4
                        nl.Parent = bb
                        
                        local dl = Instance.new("TextLabel")
                        dl.Name = "DL"
                        dl.BackgroundTransparency = 1
                        dl.Size = UDim2.new(1, 0, 0, 16)
                        dl.Font = Enum.Font.Gotham
                        dl.TextSize = 11
                        dl.TextStrokeTransparency = 0.4
                        dl.Parent = bb
                        
                        d.bb = bb
                    end
                    d.bb.Enabled = true
                    local nl = d.bb:FindFirstChild("NL")
                    local dl = d.bb:FindFirstChild("DL")
                    if nl then nl.Text = player.DisplayName; nl.Visible = Settings.ESP_Name end
                    if dl and Camera then 
                        dl.Text = math.floor((Camera.CFrame.Position - hrp.Position).Magnitude) .. " studs"
                        dl.Visible = Settings.ESP_Distance 
                    end
                elseif d.bb then
                    d.bb:Destroy()
                    d.bb = nil
                end

                -- Skeleton ESP
                if Settings.ESP_Skeleton then
                    local function drawBone(p1, p2)
                        if p1 and p2 then
                            local pos1, on1 = Camera:WorldToViewportPoint(p1.Position)
                            local pos2, on2 = Camera:WorldToViewportPoint(p2.Position)
                            if on1 and on2 then
                                table.insert(activeDrawings, CreateLine(Vector2.new(pos1.X, pos1.Y), Vector2.new(pos2.X, pos2.Y)))
                            end
                        end
                    end
                    drawBone(head, char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"))
                    drawBone(char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"), char:FindFirstChild("LowerTorso"))
                end

                -- Tracer Lines
                if Settings.ESP_Line then
                    local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        table.insert(activeDrawings, CreateLine(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y), Vector2.new(pos.X, pos.Y), Color3.fromRGB(255, 60, 60)))
                    end
                end

                -- Hitbox Expansion
                if Settings.Hitbox then
                    head.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    head.Transparency = 0.5
                    head.CanCollide = false
                end
            else
                RemoveESP(player)
            end
        end
    end

    -- Advanced Aimbot Execution
    if Settings.Aimbot then
        local targetPart = GetClosestTarget()
        if targetPart then
            local aimPos = targetPart.Position
            local vel = targetPart.AssemblyLinearVelocity
            if vel.Magnitude > 0.5 then
                local dist3D = (Camera.CFrame.Position - aimPos).Magnitude
                aimPos = aimPos + vel * ((dist3D / 500) * (Settings.Prediction / 100))
            end
            
            local smooth = math.clamp(Settings.AimbotSmooth / 100, 0.01, 0.99)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, aimPos), 1 - smooth)
        end
    end

    -- TriggerBot
    if Settings.TriggerBot then
        local target = Mouse.Target
        if target and target.Parent and target.Parent:FindFirstChild("Humanoid") then
            mouse1click()
        end
    end

    if Settings.NoReload then
        HookNoReload()
    end
end)

Players.PlayerRemoving:Connect(RemoveESP)

Rayfield:Notify({
    Title = "FlazeHub Loaded",
    Content = "Successfully injected unified cheat menu!",
    Duration = 5,
    Image = 4483362850
})
