local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

local FIREBASE_URL = "https://keysohick-default-rtdb.firebaseio.com/ohick_keys.json"

-- ==================== GUI PRINCIPAL ====================
local Gui = Instance.new("ScreenGui")
Gui.Name = "OHICK MENU"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Background.Parent = Gui

-- ==================== ESTRELAS NO FUNDO ====================
local StarContainer = Instance.new("Frame")
StarContainer.Size = UDim2.fromScale(1, 1)
StarContainer.BackgroundTransparency = 1
StarContainer.Parent = Background

local maxStars = 60
local stars = {}

for i = 1, maxStars do
	local star = Instance.new("Frame")
	local size = math.random(1, 3)
	star.Size = UDim2.fromOffset(size, size)
	star.Position = UDim2.fromScale(math.random(), math.random())
	star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	star.BorderSizePixel = 0
	star.BackgroundTransparency = math.random(3, 8) / 10
	star.Parent = StarContainer
	
	if size > 1 then
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = star
	end
	
	table.insert(stars, {
		instance = star,
		speed = math.random(1, 5) / 1000,
		twinkleSpeed = math.random(2, 5)
	})
end

RunService.RenderStepped:Connect(function()
	local clock = os.clock()
	for _, starData in ipairs(stars) do
		local star = starData.instance
		local newX = star.Position.X.Scale - starData.speed
		local newY = star.Position.Y.Scale - (starData.speed * 0.3)
		
		if newX < 0 then newX = 1 end
		if newY < 0 then newY = 1 end
		
		star.Position = UDim2.fromScale(newX, newY)
		star.BackgroundTransparency = 0.4 + math.sin(clock * starData.twinkleSpeed) * 0.4
	end
end)

-- ==================== JANELA PRINCIPAL ====================
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(0, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.Parent = Background

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = Main

-- Borda Branca Forte
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2.5
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Transparency = 0.6
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Parent = Main

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Position = UDim2.fromOffset(0, 10)
Title.BackgroundTransparency = 1
Title.Text = "BEM VINDO AO OHICK MENU"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Main

-- Input Key com Hint
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.85, 0, 0, 48)
KeyBox.Position = UDim2.fromScale(0.075, 0.32)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Insira a key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyBox.Text = ""
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Main

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyBox

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 1
KeyStroke.Color = Color3.fromRGB(40, 40, 40)
KeyStroke.Parent = KeyBox

-- Botão Validar
local Login = Instance.new("TextButton")
Login.Size = UDim2.new(0.85, 0, 0, 48)
Login.Position = UDim2.fromScale(0.075, 0.55)
Login.Text = "VALIDAR ACESSO"
Login.Font = Enum.Font.GothamBold
Login.TextSize = 14
Login.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Login.TextColor3 = Color3.fromRGB(0, 0, 0)
Login.AutoButtonColor = false
Login.Parent = Main

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0, 10)
LoginCorner.Parent = Login

-- Botão Discord
local Discord = Instance.new("TextButton")
Discord.Size = UDim2.new(0.85, 0, 0, 40)
Discord.Position = UDim2.fromScale(0.075, 0.78)
Discord.Text = "ENTRAR NO DISCORD"
Discord.Font = Enum.Font.GothamMedium
Discord.TextSize = 12
Discord.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Discord.TextColor3 = Color3.fromRGB(200, 200, 200)
Discord.AutoButtonColor = false
Discord.Parent = Main

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 10)
DiscordCorner.Parent = Discord

local DiscordStroke = Instance.new("UIStroke")
DiscordStroke.Thickness = 1
DiscordStroke.Color = Color3.fromRGB(40, 40, 40)
DiscordStroke.Parent = Discord

-- ==================== ANIMAÇÕES ====================
TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(440, 310)}):Play()

-- Animação da borda branca
task.spawn(function()
	while true do
		for i = 0, 1, 0.015 do
			local sineValue = math.abs(math.sin(i * math.pi * 2))
			Stroke.Transparency = 0.4 + sineValue * 0.3
			task.wait(0.025)
		end
	end
end)

-- Hover Effects
local function SetupHover(Button, PropertiesIn, PropertiesOut)
	Button.MouseEnter:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.25, Enum.EasingStyle.Quad), PropertiesIn):Play()
	end)
	Button.MouseLeave:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.25, Enum.EasingStyle.Quad), PropertiesOut):Play()
	end)
end

SetupHover(Login, 
	{BackgroundColor3 = Color3.fromRGB(220, 220, 220), Size = UDim2.new(0.87, 0, 0, 50), Position = UDim2.fromScale(0.065, 0.545)},
	{BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0.85, 0, 0, 48), Position = UDim2.fromScale(0.075, 0.55)}
)

SetupHover(Discord, 
	{BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.fromRGB(255, 255, 255)},
	{BackgroundColor3 = Color3.fromRGB(15, 15, 15), TextColor3 = Color3.fromRGB(200, 200, 200)}
)

-- Foco na KeyBox
KeyBox.Focused:Connect(function()
	TweenService:Create(KeyStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(200, 200, 200)}):Play()
end)
KeyBox.FocusLost:Connect(function()
	TweenService:Create(KeyStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(40, 40, 40)}):Play()
end)

-- ==================== FUNCIONALIDADES ====================
local function ShowStatus(text, color)
	local status = Instance.new("TextLabel")
	status.Size = UDim2.new(0.85, 0, 0, 28)
	status.Position = UDim2.fromScale(0.075, 0.90)
	status.BackgroundTransparency = 1
	status.Text = text
	status.TextColor3 = color
	status.TextScaled = true
	status.Font = Enum.Font.Gotham
	status.Parent = Main
	
	TweenService:Create(status, TweenInfo.new(3.5, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
	game.Debris:AddItem(status, 4)
end

-- Discord
Discord.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/nWqUsBYXBu")
	local old = Discord.Text
	Discord.Text = "✅ LINK COPIADO!"
	task.wait(2)
	Discord.Text = old
end)

-- Verificar Key
local function CheckKey(key)
	if key == "" or key == nil then
		ShowStatus("DIGITE UMA KEY!", Color3.fromRGB(255, 80, 80))
		return
	end

	Login.Text = "VERIFICANDO..."
	
	local success, response = pcall(function()
		return game:HttpGet(FIREBASE_URL)
	end)

	if not success then
		ShowStatus("ERRO DE CONEXÃO", Color3.fromRGB(255, 80, 80))
		Login.Text = "VALIDAR ACESSO"
		return
	end

	local data
	pcall(function()
		data = HttpService:JSONDecode(response)
	end)

	for _, info in pairs(data or {}) do
		if info.key and string.upper(info.key) == string.upper(key) then
			if info.status == "ativa" then
				ShowStatus("KEY VÁLIDA ✓", Color3.fromRGB(0, 255, 120))
				task.wait(1.2)
				
				local loadSuccess = pcall(function()
					loadstring(game:HttpGet("https://pastefy.app/h6tsuSEj/raw"))()
				end)
				
				if loadSuccess then
					ShowStatus("CARREGANDO SCRIPT...", Color3.fromRGB(0, 255, 120))
					task.wait(1)
					Gui:Destroy()
				else
					ShowStatus("ERRO AO CARREGAR SCRIPT", Color3.fromRGB(255, 80, 80))
				end
				return
			else
				ShowStatus("KEY INATIVA / EXPIRADA", Color3.fromRGB(255, 160, 0))
				Login.Text = "VALIDAR ACESSO"
				return
			end
		end
	end

	ShowStatus("KEY INVÁLIDA ✗", Color3.fromRGB(255, 80, 80))
	Login.Text = "VALIDAR ACESSO"
end

Login.MouseButton1Click:Connect(function()
	CheckKey(KeyBox.Text)
end)

KeyBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		CheckKey(KeyBox.Text)
	end
end)

ShowStatus("BEM-VINDO AO OHICK MENU", Color3.fromRGB(180, 180, 180))