
-- NUNES | PAINEL DE 2 HOMES
-- Para usar como LocalScript no seu próprio jogo Roblox

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local homes = {}
local escala = 1

local gui = Instance.new("ScreenGui")
gui.Name = "NUNES"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(250, 260)
frame.Position = UDim2.new(0.5, -125, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local scale = Instance.new("UIScale")
scale.Scale = escala
scale.Parent = frame

local function criarBotao(nome, texto, y, callback)
    local botao = Instance.new("TextButton")
    botao.Name = nome
    botao.Size = UDim2.new(1, -20, 0, 35)
    botao.Position = UDim2.fromOffset(10, y)
    botao.BackgroundColor3 = Color3.fromRGB(125, 35, 190)
    botao.TextColor3 = Color3.new(1, 1, 1)
    botao.Text = texto
    botao.TextSize = 15
    botao.Font = Enum.Font.GothamBold
    botao.Parent = frame
    Instance.new("UICorner", botao).CornerRadius = UDim.new(0, 8)
    botao.MouseButton1Click:Connect(callback)
end

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 35)
titulo.BackgroundTransparency = 1
titulo.Text = "NUNES HOME"
titulo.TextColor3 = Color3.new(1, 1, 1)
titulo.TextSize = 20
titulo.Font = Enum.Font.GothamBold
titulo.Parent = frame

local function salvarHome(numero)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        homes[numero] = root.CFrame
    end
end

local function teleportarHome(numero)
    local destino = homes[numero]
    local char = player.Character
    if destino and char then
        char:PivotTo(destino * CFrame.new(0, 3, 0))
    end
end

criarBotao("SetHome1", "SALVAR HOME 1", 45, function()
    salvarHome(1)
end)

criarBotao("TeleportHome1", "TELEPORTAR HOME 1", 85, function()
    teleportarHome(1)
end)

criarBotao("SetHome2", "SALVAR HOME 2", 125, function()
    salvarHome(2)
end)

criarBotao("TeleportHome2", "TELEPORTAR HOME 2", 165, function()
    teleportarHome(2)
end)

criarBotao("Aumentar", "AUMENTAR GUI  +", 205, function()
    escala = math.min(escala + 0.1, 1.5)
    scale.Scale = escala
end)

criarBotao("Diminuir", "DIMINUIR GUI  -", 245, function()
    escala = math.max(escala - 0.1, 0.6)
    scale.Scale = escala
end)
