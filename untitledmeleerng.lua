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
	Subtitle = "--- Untitled Melee RNG",
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
		Key = {"2026"},
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

--// Notification
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

MainTab:CreateSection("Basic Features")

MainTab:CreateButton({
	Name = "Rejoin Server",
	Description = "Reconnect to the current server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
	end
})

--------------------------------------------------
-- COMBAT SECTION
--------------------------------------------------
MainTab:CreateSection("Combat")

_G.HitboxEnabled = false

task.spawn(function()
	while true do
		if _G.HitboxEnabled then
			for _, mob in pairs(workspace.Mobs:GetChildren()) do
				local hrp = mob:FindFirstChild("HumanoidRootPart")

				if hrp then
					hrp.Size = Vector3.new(1000,1000,1000)
					hrp.Transparency = 1
					hrp.CanCollide = false
					hrp.Massless = true
				end
			end
		end
		task.wait(0.2)
	end
end)

MainTab:CreateToggle({
	Name = "Hitbox Expander (Hide mobs breaks this)",
	CurrentValue = false,
	Callback = function(Value)
		_G.HitboxEnabled = Value
	end
})

--------------------------------------------------
-- AUTO ASCEND
--------------------------------------------------

_G.AutoAscend = false

MainTab:CreateToggle({
	Name = "Auto Ascend",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoAscend = Value

		task.spawn(function()
			while _G.AutoAscend do

				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("ConfirmAscend")
					:InvokeServer()

				task.wait(2)

			end
		end)
	end
})

--------------------------------------------------
-- AUTO RAID UNLOCK
--------------------------------------------------

_G.AutoRaidUnlock = false

MainTab:CreateToggle({
	Name = "Unlock Auto Raid",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoRaidUnlock = Value

		task.spawn(function()
			local player = game.Players.LocalPlayer

			while _G.AutoRaidUnlock do
				local gui = player:WaitForChild("PlayerGui")

				for _, v in pairs(gui:GetDescendants()) do
					if v.Name == "AutoRaidBtn" then
						v.Visible = true
					end
				end

				task.wait(0.5)
			end
		end)
	end
})

--------------------------------------------------
-- WEAPON DAMAGE
--------------------------------------------------

_G.WeaponDamage = 500
_G.DamageEnabled = false

MainTab:CreateSlider({
	Name = "Weapon Damage",
	Range = {500,50000},
	Increment = 500,
	CurrentValue = 500,
	Callback = function(Value)
		_G.WeaponDamage = Value
	end
})

MainTab:CreateToggle({
	Name = "Enable Custom Damage",
	CurrentValue = false,
	Callback = function(Value)
		_G.DamageEnabled = Value

		task.spawn(function()
			while _G.DamageEnabled do

				local player = game.Players.LocalPlayer
				local character = workspace:FindFirstChild(player.Name)

				if character then
					for _, obj in pairs(character:GetChildren()) do
						if obj:GetAttribute("Damage") ~= nil then
							obj:SetAttribute("Damage", _G.WeaponDamage)
						end
					end
				end

				task.wait(0.2)
			end
		end)
	end
})

--------------------------------------------------
-- TELEPORT SECTION
--------------------------------------------------
MainTab:CreateSection("Teleports")

local function teleportToArea(areaName)

	local player = game.Players.LocalPlayer
	local character = workspace:FindFirstChild(player.Name)

	if character then
		local hrp = character:FindFirstChild("HumanoidRootPart")
		local area = workspace.Areas:FindFirstChild(areaName)

		if hrp and area then
			local part = area:FindFirstChildWhichIsA("BasePart", true)

			if part then
				hrp.CFrame = part.CFrame + Vector3.new(0,5,0)
			end
		end
	end

end

MainTab:CreateButton({
	Name = "Grassland",
	Callback = function()
		teleportToArea("Grassland")
	end
})

MainTab:CreateButton({
	Name = "Desert Biome",
	Callback = function()
		teleportToArea("Desert Biome")
	end
})

MainTab:CreateButton({
	Name = "Jungle Biome",
	Callback = function()
		teleportToArea("Jungle Biome")
	end
})

MainTab:CreateButton({
	Name = "Snow Biome",
	Callback = function()
		teleportToArea("Snow Biome")
	end
})

MainTab:CreateButton({
	Name = "Volcano Island",
	Callback = function()
		teleportToArea("Volcano Island")
	end
})

MainTab:CreateButton({
	Name = "Shadow Realm",
	Callback = function()
		teleportToArea("Shadow Realm")
	end
})

MainTab:CreateButton({
	Name = "Shadow Dungeon",
	Callback = function()

		local player = game.Players.LocalPlayer
		local character = workspace:FindFirstChild(player.Name)

		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart")
			local area = workspace.Areas:FindFirstChild("Shadow Dungeon")

			if hrp and area then
				local part = area:FindFirstChildWhichIsA("BasePart", true)

				if part then
					hrp.CFrame = part.CFrame - (part.CFrame.LookVector * 20) + Vector3.new(0,5,0)
				end
			end
		end

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
