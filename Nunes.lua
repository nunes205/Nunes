
-- SCRIPT NUNES
-- LocalScript para seu proprio jogo no Roblox Studio

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local homes = {}
local minimized = false
local scaleValue = 1

local old = playerGui:FindFirstChild("NUNES_GUI")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "NUNES_GUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(310, 390)
frame.Position = UDim2.new(0.5, -155, 0.5, -195)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local scale = Instance.new("UIScale")
scale.Scale = scaleValue
scale.Parent = frame

-- BARRA SUPERIOR
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
header.BorderSizePixel = 0
header.Parent = frame

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -55, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "SCRIPT NUNES"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(38, 32)
minimize.Position = UDim2.new(1, -44, 0, 8)
minimize.BackgroundColor3 = Color3.fromRGB(90, 90, 110)
minimize.Text = "-"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 22
minimize.Font = Enum.Font.GothamBold
minimize.Parent = header

Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)

-- AREA DOS BOTOES
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -58)
content.Position = UDim2.fromOffset(10, 53)
content.BackgroundTransparency = 1
content.Parent = frame

local function label(text, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 25)
    l.Position = UDim2.fromOffset(0, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(220, 220, 230)
    l.TextSize = 14
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = content
end

local function button(text, y, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 38)
    b.Position = UDim2.fromOffset(0, y)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 15
    b.Font = Enum.Font.GothamBold
    b.Parent = content

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function saveHome(n)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if root then
        homes[n] = root.CFrame
        print("HOME " .. n .. " SALVA!")
    end
end

local function teleportHome(n)
    local destination = homes[n]
    local char = player.Character

    if destination and char then
        char:PivotTo(destination * CFrame.new(0, 3, 0))
    else
        warn("HOME " .. n .. " ainda nao foi salva!")
    end
end

-- SALVAR HOMES
label("SALVAR POSICOES", 0)

button("SALVAR HOME 1", 29,
    Color3.fromRGB(30, 160, 90),
    function() saveHome(1) end)

button("SALVAR HOME 2", 73,
    Color3.fromRGB(20, 125, 115),
    function() saveHome(2) end)

-- TELEPORTAR
label("TELEPORTAR", 121)

button("TELEPORTAR HOME 1", 150,
    Color3.fromRGB(40, 110, 220),
    function() teleportHome(1) end)

button("TELEPORTAR HOME 2", 194,
    Color3.fromRGB(105, 65, 210),
    function() teleportHome(2) end)

-- TAMANHO
label("TAMANHO DO GUI", 242)

button("AUMENTAR GUI  +", 271,
    Color3.fromRGB(190, 110, 25),
    function()
        scaleValue = math.min(scaleValue + 0.1, 1.5)
        scale.Scale = scaleValue
    end)

button("DIMINUIR GUI  -", 315,
    Color3.fromRGB(170, 65, 65),
    function()
        scaleValue = math.max(scaleValue - 0.1, 0.6)
        scale.Scale = scaleValue
    end)

-- MINIMIZAR E ABRIR
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized

    if minimized then
        frame.Size = UDim2.fromOffset(310, 48)
        minimize.Text = "+"
    else
        frame.Size = UDim2.fromOffset(310, 390)
        minimize.Text = "-"
    end
end)

-- ARRASTAR PELA TELA (MOUSE E CELULAR)
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("SCRIPT NUNES CARREGADO!")
