--// Load Luna
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

--// Smooth Blur Setup
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

local function SetBlur(state)
	local goal = {}
	if state then
		goal.Size = 20
	else
		goal.Size = 0
	end
	local tween = TweenService:Create(Blur, TweenInfo.new(0.3), goal)
	tween:Play()
end

--// Window
local Window = Luna:CreateWindow({
	Name = "Opposed Network",
	Subtitle = "--- Survive LAVA for Brainrots!",
	LogoID = "82795327169782",

	LoadingEnabled = true,
	LoadingTitle = "Opposed Network",
	LoadingSubtitle = "Loading Interface...",

	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "OpposedNetwork"
	},

	KeySystem = true,
	KeySettings = {
		Title = "Opposed Network Key",
		Subtitle = "Access System",
		Note = "Join the Discord to get the key.",
		SaveInRoot = false,
		SaveKey = true,
		Key = {"MarchBeta1"},
		SecondAction = {
			Enabled = true,
			Type = "Discord",
			Parameter = "V5FqSpMX"
		}
	}
})

--// HOME TAB
Window:CreateHomeTab({
	SupportedExecutors = {
		"Synapse X","Krnl","Fluxus","Script-Ware",
		"Electron","JJSploit","Delta","Wave","Codex"
	},
	DiscordInvite = "V5FqSpMX",
	Icon = 1
})

--// Welcome Notification
Luna:Notification({
	Title = "Opposed Network",
	Icon = "notifications_active",
	ImageSource = "Material",
	Content = "Welcome to Opposed Network Hub"
})

--------------------------------------------------
-- MAIN TAB
--------------------------------------------------
local MainTab = Window:CreateTab({
	Name = "Main",
	Icon = "widgets",
	ImageSource = "Material",
	ShowTitle = true
})


--------------------------------------------------
-- GAME FEATURES
--------------------------------------------------

MainTab:CreateSection("Game Features")

MainTab:CreateButton({
	Name = "Unlock VIP Doors",
	Description = "Removes all VIP Doors",
	Callback = function()
		local Workspace = game:GetService("Workspace")

		local gameFolder = Workspace:FindFirstChild("GameFolder")
		if gameFolder then
			local vipDoors = gameFolder:FindFirstChild("VIPDoors")
			if vipDoors then
				vipDoors:Destroy()
			end
		end
	end
})

MainTab:CreateButton({
	Name = "Anti Lava",
	Description = "Removes all Lava",
	Callback = function()
		local gameFolder = game:GetService("Workspace"):FindFirstChild("GameFolder")

		if gameFolder then
			local lavas = gameFolder:FindFirstChild("Lavas")
			if lavas then
				lavas:Destroy()
			end
		end
	end
})

--------------------------------------------------
-- AUTO TAB
--------------------------------------------------
local AutoTab = Window:CreateTab({
	Name = "Auto",
	Icon = "bolt",
	ImageSource = "Material",
	ShowTitle = true
})

AutoTab:CreateSection("Automation")

--------------------------------------------------
-- NEW AUTO FEATURES
--------------------------------------------------

_G.AutoUpgradeBase = false
_G.AutoRebirth = false
_G.AutoSpinWheel = false
_G.AutoBuySpeed = false
_G.AutoCarry = false

AutoTab:CreateToggle({
	Name = "Auto Upgrade Base",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoUpgradeBase = Value
		task.spawn(function()
			while _G.AutoUpgradeBase do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Upgrade"):InvokeServer()
				task.wait(1)
			end
		end)
	end
})

AutoTab:CreateToggle({
	Name = "Auto Rebirth",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoRebirth = Value
		task.spawn(function()
			while _G.AutoRebirth do
				local args = {"Rebirth"}
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Rebirth"):InvokeServer(unpack(args))
				task.wait(2)
			end
		end)
	end
})

AutoTab:CreateToggle({
	Name = "Auto Spin Wheel",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoSpinWheel = Value
		task.spawn(function()
			while _G.AutoSpinWheel do
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinWheel"):WaitForChild("RequestSpin"):FireServer()
				task.wait(5)
			end
		end)
	end
})

AutoTab:CreateToggle({
	Name = "Auto Buy Speed (Fast)",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoBuySpeed = Value
		task.spawn(function()
			while _G.AutoBuySpeed do
				local args = {"Speed",1}
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Speed"):InvokeServer(unpack(args))
				task.wait(0.1)
			end
		end)
	end
})

AutoTab:CreateToggle({
	Name = "Auto Upgrade Carry",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoCarry = Value
		task.spawn(function()
			while _G.AutoCarry do
				local args = {"Carry"}
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Carry"):InvokeServer(unpack(args))
				task.wait(1)
			end
		end)
	end
})

--------------------------------------------------
-- MISC TAB
--------------------------------------------------
local MiscTab = Window:CreateTab({
	Name = "Misc",
	Icon = "extension",
	ImageSource = "Material",
	ShowTitle = true
})

MiscTab:CreateSection("Player")

MiscTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16,200},
	Increment = 2,
	CurrentValue = 16,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end
})

MiscTab:CreateSlider({
	Name = "JumpPower",
	Range = {50,200},
	Increment = 5,
	CurrentValue = 50,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end
})

MiscTab:CreateDropdown({
	Name = "Teleport",
	Options = {"Spawn","Shop","Arena"},
	CurrentOption = {"Spawn"},
	MultipleOptions = false,
	Callback = function(Option)
		print("Teleporting to:",Option[1])
	end
})

--------------------------------------------------
-- UI TAB
--------------------------------------------------
local UITab = Window:CreateTab({
	Name = "UI",
	Icon = "palette",
	ImageSource = "Material",
	ShowTitle = true
})

UITab:BuildThemeSection()
UITab:BuildConfigSection()
