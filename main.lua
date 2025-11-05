-- GUI меню для Roblox
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local InfiniteYieldButton = Instance.new("TextButton")
local CtrlTPButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Создание основного GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основной фрейм
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 300, 0, 250)

-- Закругленные углы
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- Заголовок
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "Script Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

-- Кнопка Infinite Yield
InfiniteYieldButton.Name = "InfiniteYieldButton"
InfiniteYieldButton.Parent = Frame
InfiniteYieldButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
InfiniteYieldButton.BorderSizePixel = 0
InfiniteYieldButton.Position = UDim2.new(0.1, 0, 0.25, 0)
InfiniteYieldButton.Size = UDim2.new(0.8, 0, 0, 45)
InfiniteYieldButton.Font = Enum.Font.Gotham
InfiniteYieldButton.Text = "Infinite Yield"
InfiniteYieldButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteYieldButton.TextSize = 16

-- Стиль для кнопки Infinite Yield
local InfiniteYieldCorner = Instance.new("UICorner")
InfiniteYieldCorner.CornerRadius = UDim.new(0, 8)
InfiniteYieldCorner.Parent = InfiniteYieldButton

-- Кнопка Ctrl TP
CtrlTPButton.Name = "CtrlTPButton"
CtrlTPButton.Parent = Frame
CtrlTPButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
CtrlTPButton.BorderSizePixel = 0
CtrlTPButton.Position = UDim2.new(0.1, 0, 0.5, 0)
CtrlTPButton.Size = UDim2.new(0.8, 0, 0, 45)
CtrlTPButton.Font = Enum.Font.Gotham
CtrlTPButton.Text = "Ctrl TP"
CtrlTPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CtrlTPButton.TextSize = 16

-- Стиль для кнопки Ctrl TP
local CtrlTPCorner = Instance.new("UICorner")
CtrlTPCorner.CornerRadius = UDim.new(0, 8)
CtrlTPCorner.Parent = CtrlTPButton

-- Кнопка закрытия
CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.1, 0, 0.75, 0)
CloseButton.Size = UDim2.new(0.8, 0, 0, 35)
CloseButton.Font = Enum.Font.Gotham
CloseButton.Text = "Закрыть"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

-- Стиль для кнопки закрытия
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Функции для анимации кнопок
local function buttonHoverEffect(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = originalColor:Lerp(Color3.fromRGB(255, 255, 255), 0.2)}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = originalColor}
        ):Play()
    end)
end

-- Применяем эффекты ко всем кнопкам
buttonHoverEffect(InfiniteYieldButton)
buttonHoverEffect(CtrlTPButton)
buttonHoverEffect(CloseButton)

-- Функционал кнопок
InfiniteYieldButton.MouseButton1Click:Connect(function()
    InfiniteYieldButton.Text = "Загрузка..."
    wait(0.5)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    InfiniteYieldButton.Text = "Infinite Yield"
end)

CtrlTPButton.MouseButton1Click:Connect(function()
    CtrlTPButton.Text = "Загрузка..."
    wait(0.5)
    loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Click%20Teleport.lua"))()
    CtrlTPButton.Text = "Ctrl TP"
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Делаем фрейм перетаскиваемым
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Уведомление о успешном создании GUI
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Script Menu",
    Text = "GUI успешно загружено!",
    Duration = 3
})
