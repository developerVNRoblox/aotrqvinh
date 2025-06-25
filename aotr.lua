-- AOTR Tekkit-Style GUI - by Trần Quang Vinh 
local plr = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local char = plr.Character or plr.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TekkitAOTR_GUI"

local flags = {
    autoFarm = false,
    autoEscape = false,
    retry = false,
    reload = false,
    teleport = false,
    antiAfk = false,
}

-- Màu chủ đề
local mainColor = Color3.fromRGB(25, 25, 25)
local accent = Color3.fromRGB(80, 80, 255)
local green = Color3.fromRGB(0, 200, 0)
local red = Color3.fromRGB(200, 50, 50)
local gray = Color3.fromRGB(60, 60, 60)

-- Nút nhỏ hiện khi thu nhỏ
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Text = "📌 AOTR Hub"
miniBtn.Size = UDim2.new(0, 140, 0, 36)
miniBtn.Position = UDim2.new(0.02, 0, 0.9, 0)
miniBtn.BackgroundColor3 = accent
miniBtn.TextColor3 = Color3.new(1, 1, 1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextScaled = true
miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 6)

-- Khung chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.BackgroundColor3 = mainColor
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Header
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = accent
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", header)
title.Text = "⭐ AOTR HUB - Trần Quang Vinh"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Nút thu nhỏ
local minimize = Instance.new("TextButton", header)
minimize.Text = "-"
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -65, 0, 5)
minimize.BackgroundColor3 = gray
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.GothamBold
minimize.TextScaled = true
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 6)

minimize.MouseButton1Click:Connect(function()
    frame.Visible = false
    miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    miniBtn.Visible = false
end)

-- Nút đóng
local close = Instance.new("TextButton", header)
close.Text = "X"
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -30, 0, 5)
close.BackgroundColor3 = red
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Scroll chứa nút
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Tạo nút
local function makeBtn(txt, flagKey)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = gray
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Text = txt
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        flags[flagKey] = not flags[flagKey]
        btn.BackgroundColor3 = flags[flagKey] and green or gray
    end)
end

makeBtn("⚔ Auto Farm", "autoFarm")
makeBtn("🚪 Auto Escape", "autoEscape")
makeBtn("🔄 Auto Retry", "retry")
makeBtn("🔫 Auto Reload", "reload")
makeBtn("📍 Teleport Safe", "teleport")
makeBtn("🌀 Anti AFK", "antiAfk")

-- Nút Discord
local discord = Instance.new("TextButton", scroll)
discord.Text = "💬 Join Discord"
discord.Size = UDim2.new(1, -10, 0, 40)
discord.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
discord.TextColor3 = Color3.new(1, 1, 1)
discord.Font = Enum.Font.GothamBold
discord.TextScaled = true
Instance.new("UICorner", discord).CornerRadius = UDim.new(0, 8)
discord.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/KdH2N2Gn")
end)

-- Logic auto
task.spawn(function()
    while wait(1) do
        if flags.antiAfk then
            vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        end
        if flags.teleport and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 50, 0))
        end
        -- Gắn thêm logic farm/reload/escape ở đây
    end
end)