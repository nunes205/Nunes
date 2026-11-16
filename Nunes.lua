
-- SCRIPT NUNES
-- LocalScript para seu proprio jogo no Roblox Studio

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NUNES_GUI")
if old then old:Destroy() end

local homes = {}
local nextId = 0
local scaleValue = 1
local minimized = false

local PURPLE = Color3.fromRGB(135, 55, 220)
local DARK = Color3.fromRGB(18, 17, 27)
local CARD = Color3.fromRGB(35, 32, 49)
local GREEN = Color3.fromRGB(25, 165, 100)
local RED = Color3.fromRGB(195, 55, 65)
local BLUE = Color3.fromRGB(48, 110, 225)
local WHITE = Color3.fromRGB(245, 243, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "NUNES_GUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(340, 500)
frame.Position = UDim2.new(0.5, -170, 0.5, -250)
frame.BackgroundColor3 = DARK
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = PURPLE
frameStroke.Thickness = 2
frameStroke.Transparency = 0.2
frameStroke.Parent = frame

local scale = Instance.new("UIScale")
scale.Scale = scaleValue
scale.Parent = frame

-- CABECALHO
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(48, 32, 72)
header.BorderSizePixel = 0
header.Parent = frame

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -125, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "SCRIPT NUNES"
title.TextColor3 = WHITE
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Active = true
title.Parent = header

local function makeButton(parent, text, size, position, color, textSize)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = WHITE
    b.TextSize = textSize or 13
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = true
    b.BorderSizePixel = 0
    b.Parent = parent

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)

    return b
end

-- CONTROLES PEQUENOS NO CABECALHO
local decrease = makeButton(
    header, "-", UDim2.fromOffset(27, 28),
    UDim2.new(1, -108, 0, 10), RED, 19
)

local increase = makeButton(
    header, "+", UDim2.fromOffset(27, 28),
    UDim2.new(1, -76, 0, 10), GREEN, 19
)

local minimizeButton = makeButton(
    header, "-", UDim2.fromOffset(27, 28),
    UDim2.new(1, -44, 0, 10),
    Color3.fromRGB(95, 85, 115), 19
)

decrease.MouseButton1Click:Connect(function()
    scaleValue = math.max(0.65, scaleValue - 0.1)
    scale.Scale = scaleValue
end)

increase.MouseButton1Click:Connect(function()
    scaleValue = math.min(1.4, scaleValue + 0.1)
    scale.Scale = scaleValue
end)

-- CONTEUDO
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -18, 1, -58)
content.Position = UDim2.fromOffset(9, 53)
content.BackgroundTransparency = 1
content.Parent = frame

-- BARRA DE ADICIONAR E REMOVER
local toolbar = Instance.new("Frame")
toolbar.Size = UDim2.new(1, 0, 0, 38)
toolbar.BackgroundTransparency = 1
toolbar.Parent = content

local addButton = makeButton(
    toolbar, "+ ADICIONAR HOME",
    UDim2.new(0.58, -4, 1, 0),
    UDim2.new(0, 0, 0, 0),
    GREEN, 12
)

local removeButton = makeButton(
    toolbar, "- REMOVER HOME",
    UDim2.new(0.42, -4, 1, 0),
    UDim2.new(0.58, 8, 0, 0),
    RED, 12
)

-- LISTA COM ROLAGEM
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, 0, 1, -43)
list.Position = UDim2.fromOffset(0, 43)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
list.ScrollBarImageColor3 = PURPLE
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(
        0, 0, 0, layout.AbsoluteContentSize.Y + 12
    )
end)

-- CRIAR HOME
local function createHome()
    nextId += 1
    local id = nextId

    local data = {
        name = "Home " .. id,
        position = nil,
        collapsed = false
    }

    local card = Instance.new("Frame")
    card.Name = "HomeCard_" .. id
    card.Size = UDim2.new(1, -5, 0, 112)
    card.BackgroundColor3 = CARD
    card.BorderSizePixel = 0
    card.LayoutOrder = id
    card.Parent = list
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 13)

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(80, 65, 110)
    cardStroke.Thickness = 1
    cardStroke.Transparency = 0.45
    cardStroke.Parent = card

    data.card = card
    table.insert(homes, data)

    -- NOME DA HOME
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -105, 0, 34)
    nameLabel.Position = UDim2.fromOffset(12, 2)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = data.name
    nameLabel.TextColor3 = WHITE
    nameLabel.TextSize = 17
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = card

    -- EDITAR NOME
    local editButton = makeButton(
        card, "✏️",
        UDim2.fromOffset(32, 29),
        UDim2.new(1, -76, 0, 4),
        Color3.fromRGB(190, 120, 35), 16
    )

    editButton.MouseButton1Click:Connect(function()
        local editor = Instance.new("TextBox")
        editor.Size = UDim2.new(1, -20, 0, 30)
        editor.Position = UDim2.fromOffset(10, 38)
        editor.BackgroundColor3 = Color3.fromRGB(55, 48, 72)
        editor.TextColor3 = WHITE
        editor.PlaceholderText = "Novo nome da Home"
        editor.Text = data.name
        editor.ClearTextOnFocus = false
        editor.TextSize = 14
        editor.Font = Enum.Font.Gotham
        editor.Parent = card
        editor:CaptureFocus()

        editor.FocusLost:Connect(function()
            local newName = editor.Text:match("^%s*(.-)%s*$")
            if newName and newName ~= "" then
                data.name = newName
                nameLabel.Text = newName
            end
            editor:Destroy()
        end)
    end)

    -- MINIMIZAR HOME INDIVIDUAL
    local collapseButton = makeButton(
        card, "-",
        UDim2.fromOffset(32, 29),
        UDim2.new(1, -39, 0, 4),
        Color3.fromRGB(90, 80, 115), 18
    )

    -- SALVAR POSICAO
    local saveButton = makeButton(
        card, "SALVAR POSIÇÃO",
        UDim2.new(0.49, -9, 0, 40),
        UDim2.fromOffset(8, 45),
        GREEN, 13
    )

    -- TELEPORTAR
    local teleportButton = makeButton(
        card, "TELEPORTAR",
        UDim2.new(0.51, -9, 0, 40),
        UDim2.new(0.49, 1, 0, 45),
        BLUE, 13
    )

    collapseButton.MouseButton1Click:Connect(function()
        data.collapsed = not data.collapsed
        saveButton.Visible = not data.collapsed
        teleportButton.Visible = not data.collapsed

        card.Size = data.collapsed
            and UDim2.new(1, -5, 0, 38)
            or UDim2.new(1, -5, 0, 112)

        collapseButton.Text = data.collapsed and "+" or "-"
    end)

    saveButton.MouseButton1Click:Connect(function()
        local character = player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if root then
            data.position = root.CFrame
            saveButton.Text = "SALVO!"
            task.delay(1, function()
                if saveButton.Parent then
                    saveButton.Text = "SALVAR POSIÇÃO"
                end
            end)
        end
    end)

    teleportButton.MouseButton1Click:Connect(function()
        local character = player.Character

        if data.position and character then
            character:PivotTo(data.position * CFrame.new(0, 3, 0))
        else
            teleportButton.Text = "SALVE PRIMEIRO!"
            task.delay(1, function()
                if teleportButton.Parent then
                    teleportButton.Text = "TELEPORTAR"
                end
            end)
        end
    end)
end

-- ADICIONAR HOME
addButton.MouseButton1Click:Connect(function()
    createHome()
end)

-- REMOVER ULTIMA HOME
removeButton.MouseButton1Click:Connect(function()
    if #homes > 0 then
        local lastHome = table.remove(homes)
        lastHome.card:Destroy()
    end
end)

-- MINIMIZAR PAINEL INTEIRO
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    minimizeButton.Text = minimized and "+" or "-"

    frame.Size = minimized
        and UDim2.fromOffset(340, 48)
        or UDim2.fromOffset(340, 500)
end)

-- ARRASTAR PELO TITULO
local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
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

-- COMECA COM DUAS HOMES
createHome()
createHome()

print("SCRIPT NUNES V3 CARREGADO!")
