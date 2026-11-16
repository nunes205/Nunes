
-- SCRIPT NUNES
-- LocalScript para seu proprio jogo no Roblox Studio

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NUNES_GUI")
if old then old:Destroy() end

local homes = {}
local scaleValue = 1
local minimized = false
local nextId = 0

local gui = Instance.new("ScreenGui")
gui.Name = "NUNES_GUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(330, 490)
frame.Position = UDim2.new(0.5, -165, 0.5, -245)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local scale = Instance.new("UIScale")
scale.Scale = scaleValue
scale.Parent = frame

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(37, 37, 48)
header.BorderSizePixel = 0
header.Parent = frame

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -95, 1, 0)
title.Position = UDim2.fromOffset(10, 0)
title.BackgroundTransparency = 1
title.Text = "SCRIPT NUNES"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35, 30)
minimize.Position = UDim2.new(1, -42, 0, 7)
minimize.Text = "-"
minimize.TextSize = 22
minimize.Font = Enum.Font.GothamBold
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(90,90,110)
minimize.Parent = header
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0,7)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -16, 1, -55)
content.Position = UDim2.fromOffset(8, 50)
content.BackgroundTransparency = 1
content.Parent = frame

-- CONTROLES DE QUANTIDADE
local toolbar = Instance.new("Frame")
toolbar.Size = UDim2.new(1, 0, 0, 38)
toolbar.BackgroundTransparency = 1
toolbar.Parent = content

local function makeButton(parent, text, size, position, color)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,7)
    return b
end

local addButton = makeButton(
    toolbar, "+ ADICIONAR HOME",
    UDim2.new(0.58, -4, 1, 0),
    UDim2.new(0, 0, 0, 0),
    Color3.fromRGB(25,145,85)
)

local removeButton = makeButton(
    toolbar, "- REMOVER",
    UDim2.new(0.42, -4, 1, 0),
    UDim2.new(0.58, 8, 0, 0),
    Color3.fromRGB(170,65,65)
)

-- LISTA DE HOMES
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, 0, 1, -85)
list.Position = UDim2.fromOffset(0, 43)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
list.CanvasSize = UDim2.new(0,0,0,0)
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

local function updateSize()
    local height = minimized and 45 or 490
    frame.Size = UDim2.fromOffset(330, height)
end

-- CRIAR HOME
local function createHome()
    nextId += 1
    local id = nextId

    local data = {
        name = "Home " .. id,
        position = nil,
        collapsed = false
    }
    homes[id] = data

    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -5, 0, 112)
    card.BackgroundColor3 = Color3.fromRGB(34,34,45)
    card.BorderSizePixel = 0
    card.LayoutOrder = id
    card.Parent = list
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -105, 0, 32)
    nameLabel.Position = UDim2.fromOffset(9, 3)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = data.name
    nameLabel.TextColor3 = Color3.new(1,1,1)
    nameLabel.TextSize = 15
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = card

    local editButton = makeButton(
        card, "✏️",
        UDim2.fromOffset(32,28),
        UDim2.new(1,-75,0,4),
        Color3.fromRGB(190,120,35)
    )

    local collapseButton = makeButton(
        card, "-",
        UDim2.fromOffset(32,28),
        UDim2.new(1,-38,0,4),
        Color3.fromRGB(85,85,110)
    )

    local saveButton = makeButton(
        card, "SALVAR POSIÇÃO",
        UDim2.new(0.48,-5,0,38),
        UDim2.fromOffset(8,42),
        Color3.fromRGB(25,150,85)
    )

    local tpButton = makeButton(
        card, "TELEPORTAR",
        UDim2.new(0.52,-5,0,38),
        UDim2.new(0.48,0,0,42),
        Color3.fromRGB(45,105,215)
    )

    -- EDITAR NOME
    editButton.MouseButton1Click:Connect(function()
        local editor = Instance.new("TextBox")
        editor.Size = UDim2.new(1,-18,0,30)
        editor.Position = UDim2.fromOffset(9,38)
        editor.BackgroundColor3 = Color3.fromRGB(55,55,70)
        editor.TextColor3 = Color3.new(1,1,1)
        editor.PlaceholderText = "Digite o novo nome"
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
    collapseButton.MouseButton1Click:Connect(function()
        data.collapsed = not data.collapsed
        saveButton.Visible = not data.collapsed
        tpButton.Visible = not data.collapsed
        card.Size = data.collapsed
            and UDim2.new(1,-5,0,38)
            or UDim2.new(1,-5,0,112)
        collapseButton.Text = data.collapsed and "+" or "-"
    end)

    -- SALVAR
    saveButton.MouseButton1Click:Connect(function()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            data.position = root.CFrame
            saveButton.Text = "POSIÇÃO SALVA!"
            task.delay(1.2, function()
                if saveButton.Parent then
                    saveButton.Text = "SALVAR POSIÇÃO"
                end
            end)
        end
    end)

    -- TELEPORTAR
    tpButton.MouseButton1Click:Connect(function()
        local char = player.Character
        if data.position and char then
            char:PivotTo(data.position * CFrame.new(0,3,0))
        else
            tpButton.Text = "SALVE PRIMEIRO!"
            task.delay(1.2, function()
                if tpButton.Parent then
                    tpButton.Text = "TELEPORTAR"
                end
            end)
        end
    end)
end

-- ADICIONAR E REMOVER
addButton.MouseButton1Click:Connect(function()
    createHome()
end)

removeButton.MouseButton1Click:Connect(function()
    if nextId > 1 then
        local last = homes[nextId]
        if last and last.card then
            last.card:Destroy()
        end

        -- Localiza e remove a última Home
        local children = list:GetChildren()
        for i = #children, 1, -1 do
            local child = children[i]
            if child:IsA("Frame") then
                child:Destroy()
                break
            end
        end

        homes[nextId] = nil
        nextId -= 1
    end
end)

-- Registrar cartão para remoção
local originalCreateHome = createHome
-- As Homes são criadas abaixo, uma inicialmente

-- MINIMIZAR PAINEL INTEIRO
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    minimize.Text = minimized and "+" or "-"
    updateSize()
end)

-- TAMANHO
local sizeBar = Instance.new("Frame")
sizeBar.Size = UDim2.new(1,0,0,34)
sizeBar.Position = UDim2.new(0,0,1,-37)
sizeBar.BackgroundTransparency = 1
sizeBar.Parent = content

local bigger = makeButton(
    sizeBar, "AUMENTAR +",
    UDim2.new(0.5,-4,1,0),
    UDim2.new(0,0,0,0),
    Color3.fromRGB(190,110,25)
)

local smaller = makeButton(
    sizeBar, "DIMINUIR -",
    UDim2.new(0.5,-4,1,0),
    UDim2.new(0.5,4,0,0),
    Color3.fromRGB(170,65,65)
)

bigger.MouseButton1Click:Connect(function()
    scaleValue = math.min(1.4, scaleValue + 0.1)
    scale.Scale = scaleValue
end)

smaller.MouseButton1Click:Connect(function()
    scaleValue = math.max(0.6, scaleValue - 0.1)
    scale.Scale = scaleValue
end)

-- ARRASTAR GUI PELO CABEÇALHO
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- COMEÇA COM DUAS HOMES
createHome()
createHome()

print("SCRIPT NUNES V2 CARREGADO!")
