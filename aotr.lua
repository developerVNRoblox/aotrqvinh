- Tekkit Remix GUI by Trần Quang Vinh
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TekkitHubRemix"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 360)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Text = "🟣 Tekkit Remix - Trần Quang Vinh"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Layout
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.Position = UDim2.new(0, 0, 0, 40)
scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Tạo toggle đơn giản
local flags = {}

function createToggle(text, key, callback)
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Position = UDim2.new(0.05, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.Text = "🔘 " .. text
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	flags[key] = false
	btn.MouseButton1Click:Connect(function()
		flags[key] = not flags[key]
		btn.Text = (flags[key] and "✅ " or "🔘 ") .. text
		callback(flags[key])
	end)
end

-- Nút chức năng
createToggle("Auto Farm", "farm", function(on)
	while on and task.wait(1) do
		-- Thêm lệnh farm vô đây
	end
end)

createToggle("Safe Farm", "safe", function(on) end)
createToggle("Auto Reload", "reload", function(on) end)
createToggle("Auto Retry", "retry", function(on) end)
createToggle("Auto Escape", "escape", function(on)
	if on then
		plr.Character:BreakJoints()
	end
end)

createToggle("Return to Lobby", "lobby", function(on)
	if on then
		game:GetService("TeleportService"):Teleport(game.PlaceId)
	end
end)

createToggle("Hide UI", "hide", function(on)
	frame.Visible = not on
end)

-- Nút Discord
local discordBtn = Instance.new("TextButton", scroll)
discordBtn.Size = UDim2.new(0.9, 0, 0, 35)
discordBtn.Position = UDim2.new(0.05, 0, 0, 0)
discordBtn.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
discordBtn.TextColor3 = Color3.new(1, 1, 1)
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextScaled = true
discordBtn.Text = "💬 Join Discord"
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 6)

discordBtn.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/KdH2N2Gn")
end)