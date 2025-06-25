-- AOTR HUB - By Trần Quang Vinh
local plr = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local char = plr.Character or plr.CharacterAdded:Wait()

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AOTRHub"

-- MiniBtn khi thu nhỏ
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Text = "📌 AOTR Hub"
miniBtn.Size = UDim2.new(0, 140, 0, 35)
miniBtn.Position = UDim2.new(0.02, 0, 0.9, 0)
miniBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextScaled = true
miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 8)

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 380)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Header
local title = Instance.new("TextLabel", frame)
title.Text = "🌟 AOTR Hub"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Nút X
local close = Instance.new("TextButton", frame)
close.Text = "X"
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Nút thu nhỏ
local minimize = Instance.new("TextButton", frame)
minimize.Text = "-"
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -70, 0, 5)
minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimize.TextColor3 = Color3.new(1,1,1)
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

-- Scroll
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Flags
local flags = {
	autoFarm = false,
	autoEscape = false,
	retry = false,
	reload = false,
	tele = false,
	antiAfk = false,
}

-- Tạo nút
local function createBtn(txt, flag)
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0.5, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Text = txt
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		flags[flag] = not flags[flag]
		btn.BackgroundColor3 = flags[flag] and Color3.fromRGB(0,180,0) or Color3.fromRGB(60,60,60)
	end)
end

createBtn("⚔ Auto Farm", "autoFarm")
createBtn("🚪 Auto Escape", "autoEscape")
createBtn("🔄 Auto Retry", "retry")
createBtn("🔫 Auto Reload", "reload")
createBtn("📍 Tele to Safe Zone", "tele")
createBtn("🌀 Anti AFK", "antiAfk")

-- Nút Join Discord
local discord = Instance.new("TextButton", scroll)
discord.Text = "💬 Join Discord"
discord.Size = UDim2.new(1, -20, 0, 40)
discord.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
discord.TextColor3 = Color3.new(1,1,1)
discord.Font = Enum.Font.GothamBold
discord.TextScaled = true
Instance.new("UICorner", discord).CornerRadius = UDim.new(0, 6)

discord.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/KdH2N2Gn")
end)

-- Logic
task.spawn(function()
	while wait(1) do
		if flags.antiAfk then
			vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		end
		if flags.tele and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 50, 0))
		end
		-- Gắn thêm các logic tùy theo game cụ thể
	end
end)