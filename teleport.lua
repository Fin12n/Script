-- Khởi tạo các dịch vụ
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

-- Tạo UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "TeleportUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300) -- Tăng chiều cao lên 300
frame.Position = UDim2.new(0.5, -100, 0.5, -150) -- Điều chỉnh vị trí để cân giữa
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Active = true -- Cho phép kéo thả
frame.Draggable = true -- Kích hoạt kéo thả
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Teleport Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.Parent = frame

local playerDropdown = Instance.new("TextButton")
playerDropdown.Size = UDim2.new(0.9, 0, 0, 30)
playerDropdown.Position = UDim2.new(0.05, 0, 0.15, 0)
playerDropdown.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
playerDropdown.Text = "Select Player"
playerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
playerDropdown.Parent = frame

local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(0.9, 0, 0, 100) -- Giới hạn chiều cao cho 5 player (5 * 20)
dropdownList.Position = UDim2.new(0.05, 0, 0.25, 0)
dropdownList.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
dropdownList.BorderSizePixel = 0
dropdownList.Visible = false
dropdownList.ClipsDescendants = true -- Cho phép cuộn
dropdownList.Parent = frame

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Sẽ cập nhật khi thêm player
scrollingFrame.ScrollBarThickness = 5
scrollingFrame.Parent = dropdownList

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollingFrame
uiListLayout.Padding = UDim.new(0, 2)

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0.9, 0, 0, 30)
tpButton.Position = UDim2.new(0.05, 0, 0.7, 0)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
tpButton.Text = "Teleport"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Parent = frame

-- Thêm TextLabel để hiển thị tọa độ
local coordLabel = Instance.new("TextLabel")
coordLabel.Size = UDim2.new(0.9, 0, 0, 30)
coordLabel.Position = UDim2.new(0.05, 0, 0.85, 0) -- Đặt dưới nút Teleport
coordLabel.BackgroundTransparency = 1
coordLabel.Text = "Coords: N/A"
coordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
coordLabel.Font = Enum.Font.SourceSans
coordLabel.TextSize = 14
coordLabel.Parent = frame

-- Biến trạng thái
local selectedPlayer = nil
local uiVisible = true

-- Cập nhật danh sách người chơi
local function updatePlayerList()
    for _, button in pairs(scrollingFrame:GetChildren()) do
        if button:IsA("TextButton") then
            button:Destroy()
        end
    end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0, 20)
            playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            playerButton.Text = otherPlayer.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Parent = scrollingFrame
            playerButton.MouseButton1Click:Connect(function()
                selectedPlayer = otherPlayer
                playerDropdown.Text = "Selected: " .. otherPlayer.Name
                dropdownList.Visible = false
            end)
        end
    end
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #scrollingFrame:GetChildren() * 22)
end

-- Cập nhật tọa độ
RunService.RenderStepped:Connect(function()
    if humanoidRootPart and uiVisible then
        local pos = humanoidRootPart.Position
        coordLabel.Text = "Coords: X: " .. math.floor(pos.X) .. ", Y: " .. math.floor(pos.Y) .. ", Z: " .. math.floor(pos.Z)
    end
end)

-- Xử lý click dropdown
playerDropdown.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
    updatePlayerList()
end)

-- Xử lý teleport
tpButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") and humanoidRootPart then
        local targetRoot = selectedPlayer.Character.HumanoidRootPart
        humanoidRootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 5, 0)
        print("Teleported to " .. selectedPlayer.Name)
    end
end)

-- Cập nhật danh sách khi có người chơi mới
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Ẩn UI khi click ngoài
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not frame:IsDescendantOf(game.Players.LocalPlayer:WaitForChild("PlayerGui")) then
        dropdownList.Visible = false
    end
end)

-- Toggle UI với phím Y
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.Y and not gameProcessedEvent then
        uiVisible = not uiVisible
        screenGui.Enabled = uiVisible
        if uiVisible then
            print("UI shown")
        else
            print("UI hidden")
        end
    end
end)

-- Thông báo khởi động
print("Teleport script loaded! Press Y to toggle UI.")
