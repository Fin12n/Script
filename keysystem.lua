-- Tạo UI ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo Frame chính
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui

-- Tạo Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0.5, -100, 0.05, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Key Systems | By Finnn"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.Parent = Frame

-- Tạo TextBox để nhập key
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 200, 0, 30)
TextBox.Position = UDim2.new(0.5, -100, 0.3, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Paste key here!"
TextBox.Parent = Frame

-- Tạo nút xác nhận
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 100, 0, 40)
Button.Position = UDim2.new(0.5, -50, 0.6, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "Check keys"
Button.Parent = Frame

-- Tạo label thông báo
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 200, 0, 20)
StatusLabel.Position = UDim2.new(0.5, -100, 0.85, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = ""
StatusLabel.Parent = Frame

-- Key hợp lệ
local validKey = "finnn_Pm9IAHVh23gInMuW7m48qK5Y7T4xNFoY"

-- Hàm chạy script sau khi xác nhận key đúng
local function runMainScript()
    print("Keys successfully! Running Script...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Script/refs/heads/main/emden.lua", true))()
    ScreenGui:Destroy()
    
    -- Script chính
    local part = Instance.new("Part")
    part.Position = Vector3.new(0, 10, 0)
    part.Size = Vector3.new(5, 5, 5)
    part.BrickColor = BrickColor.new("Bright blue")
    part.Parent = game.Workspace
end

-- Xử lý sự kiện khi nhấn nút
Button.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    
    if enteredKey == validKey then
        StatusLabel.Text = "Succesfully..."
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        runMainScript()
    else
        StatusLabel.Text = "Sorry, your key is incorrect!."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextBox.Text = ""
    end
end)
