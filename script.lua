local Players = game:GetService("Players")
local player = Players.LocalPlayer

pcall(function()
    game:GetService("CoreGui"):FindFirstChild("OhickUpdate"):Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "OhickUpdate"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1, 1)
bg.Position = UDim2.fromScale(0, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BorderSizePixel = 0
bg.Parent = gui

local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.Position = UDim2.new(0.5, 0, 0.42, 0)
title.Size = UDim2.new(0.8, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.Text = "SCRIPT DESATUALIZADO"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Parent = bg

local sub = Instance.new("TextLabel")
sub.AnchorPoint = Vector2.new(0.5, 0.5)
sub.Position = UDim2.new(0.5, 0, 0.50, 0)
sub.Size = UDim2.new(0.8, 0, 0.05, 0)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.Gotham
sub.Text = "Adquira a versão mais recente."
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.TextScaled = true
sub.Parent = bg

local button = Instance.new("TextButton")
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.Position = UDim2.new(0.5, 0, 0.62, 0)
button.Size = UDim2.new(0, 300, 0, 60)
button.BackgroundColor3 = Color3.fromRGB(255,255,255)
button.TextColor3 = Color3.fromRGB(0,0,0)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Text = "ADQUIRIR SCRIPT ATUALIZADO"
button.Parent = bg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

button.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard("https://discord.gg/nWqUsBYXBu")
    end)

    button.Text = "LINK COPIADO!"
end)