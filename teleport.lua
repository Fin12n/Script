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
frame.Size = UDim2.new(0, 200, 0, 250) -- Tăng chiều cao từ 150 lên 250
frame.Position = UDim2.new(0.5, -100, 0.5, -125) -- Điều chỉnh vị trí để cân giữa màn hình
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
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
playerDropdown.Position = UDim2.new(0.05, 0, 0.2, 0)
playerDropdown.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
playerDropdown.Text = "Select Player"
playerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
playerDropdown.Parent = frame

local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(0.9, 0, 0, 0)
dropdownList.Position = UDim2.new(0.05, 0, 0.35, 0)
dropdownList.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
dropdownList.BorderSizePixel = 0
dropdownList.Visible = false
dropdownList.Parent = frame

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0.9, 0, 0, 30)
tpButton.Position = UDim2.new(0.05, 0, 0.7, 0)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
tpButton.Text = "Teleport"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Parent = frame

-- Thêm UIListLayout cho dropdown
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = dropdownList
uiListLayout.Padding = UDim.new(0, 2)

-- Biến trạng thái
local selectedPlayer = nil
local uiVisible = true

-- Cập nhật danh sách người chơi
local function updatePlayerList()
    for _, button in pairs(dropdownList:GetChildren()) do
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
            playerButton.Parent = dropdownList
            playerButton.MouseButton1Click:Connect(function()
                selectedPlayer = otherPlayer
                playerDropdown.Text = "Selected: " .. otherPlayer.Name
                dropdownList.Visible = false
            end)
        end
    end
    dropdownList.Size = UDim2.new(0.9, 0, 0, #dropdownList:GetChildren() * 22)
end

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
