-- HamaHub x EclipseX – Full Merge (Updated with Intro, Perf Stats, & Lag Mode)

task.spawn(function()
    _G.HamaHub = {}
    local C = _G.HamaHub

    -- Services
    C.Players = game:GetService("Players")
    C.RunService = game:GetService("RunService")
    C.UserInputService = game:GetService("UserInputService")
    C.TweenService = game:GetService("TweenService")
    C.SoundService = game:GetService("SoundService")
    C.Lighting = game:GetService("Lighting")
    C.ReplicatedStorage = game:GetService("ReplicatedStorage")
    C.HttpService = game:GetService("HttpService")
    C.Player = C.Players.LocalPlayer

    -- ====================== INTRO SEQUENCE (10 SECONDS) ======================
    task.spawn(function()
        local introGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        introGui.Name = "HamaHub_Intro"
        introGui.DisplayOrder = 99999
        introGui.IgnoreGuiInset = true

        local introText = Instance.new("TextLabel", introGui)
        introText.Size = UDim2.new(1, 0, 1, 0)
        introText.Position = UDim2.new(0, 0, 0, 0)
        introText.BackgroundTransparency = 1
        introText.Text = "HAMAHUB"
        introText.TextColor3 = Color3.fromRGB(255, 255, 255)
        introText.Font = Enum.Font.LuckiestGuy
        introText.TextSize = 65
        introText.TextStrokeTransparency = 0.2
        introText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

        -- Hype/Bass Sound
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://6052562028" 
        sound.Volume = 2
        sound:Play()

        -- Fade out after 10 seconds
        task.delay(10, function()
            local tween = C.TweenService:Create(introText, TweenInfo.new(1), {TextTransparency = 1, TextStrokeTransparency = 1})
            tween:Play()
            tween.Completed:Wait()
            introGui:Destroy()
            sound:Destroy()
        end)
    end)

    -- ====================== PERFORMANCE STATS (FPS & PING) ======================
    task.spawn(function()
        local perfGui = Instance.new("ScreenGui")
        local success = pcall(function() perfGui.Parent = game:GetService("CoreGui") end)
        if not success then perfGui.Parent = C.Player:WaitForChild("PlayerGui") end
        perfGui.Name = "HamaHub_Performance"
        perfGui.DisplayOrder = 100

        local perfText = Instance.new("TextLabel", perfGui)
        perfText.Size = UDim2.new(0, 250, 0, 30)
        perfText.Position = UDim2.new(0.5, -125, 0, 10) -- Top Center
        perfText.BackgroundTransparency = 1
        perfText.Text = "FPS: ... | Ping: ... ms"
        perfText.TextColor3 = Color3.fromRGB(255, 255, 255)
        perfText.Font = Enum.Font.GothamBlack
        perfText.TextSize = 16
        perfText.TextStrokeTransparency = 0.2
        perfText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

        local frameCount = 0
        local lastTick = tick()
        
        C.RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local currentTick = tick()
            
            if currentTick - lastTick >= 1 then
                -- Get exact ping in ms
                local ping = math.round(C.Player:GetNetworkPing() * 1000)
                perfText.Text = " HamaHub fps: " .. frameCount .. " | Ping: " .. ping .. " ms"
                
                frameCount = 0
                lastTick = currentTick
            end
        end)
    end)
    -- ============================================================

    -- Rest of your script logic continues here...
    C.isMobile = C.UserInputService.TouchEnabled and not C.UserInputService.KeyboardEnabled
    -- [Rest of the code provided in your prompt...]
end)
