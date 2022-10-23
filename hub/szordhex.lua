local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Szordrin Hub - Boxing Beta", HidePremium = false, SaveConfig = true, IntroEnabled = true, IntroText = "Welcome Szordrin Hub"})

local Tab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


Tab:AddToggle({
	Name = "Punch Cooldown (MEDIUM)",
	Default = false,
	Callback = function(Value)
	    game:GetService("ReplicatedStorage")["PUNCHING_COOLDOWN"].Value = 0.20
	end    
})


Tab:AddToggle({
	Name = "Punch Cooldown (FAST)",
	Default = false,
	Callback = function(Value)
	    game:GetService("ReplicatedStorage")["PUNCHING_COOLDOWN"].Value = 0
	end    
})



Tab:AddButton({
	Name = "Infinite Stamina",
	Callback = function()
		local ow
		_G.go5 = true
		ow = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
			local m = getnamecallmethod()
			local args = {...}
			if not checkcaller() and _G.go5 == true and m == "FireServer" then
				if self.Name == "PlayerDodgeRemote" or self.Name == "PlayerStaminaRemote" then
					if args[1] == false or args[1] == true then
						print(args[1])
					   return 
					end
				end
				print(self,...)
			end 
			return ow(self,...)
		end))
	end   
})

   
	
Tab:AddButton({
	Name = "Auto Dodge",
	Callback = function()
		repeat wait() until game.Players.LocalPlayer ~= nil
repeat wait() until game.ReplicatedStorage:FindFirstChild("ClientTemplates")
repeat wait() until game:IsLoaded()
local HostileAnimations = {}
local HostileNames = {"Jab","Hook","Uppercut","Ultimate"}
for i,v in pairs(game.ReplicatedStorage.ClientTemplates:GetDescendants()) do
if v:IsA("Animation") and not table.find(HostileAnimations, v.AnimationId) then
for x = 1,#HostileNames do
if string.find(v.Name, HostileNames[x]) then
table.insert(HostileAnimations, v.AnimationId)
end
end
end
end
for i,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v ~= game.Players.LocalPlayer then
if v.Character:FindFirstChild("Humanoid") then
v.Character.Humanoid.AnimationPlayed:Connect(function(track)
if table.find(HostileAnimations, track.Animation.AnimationId) and v.Character:FindFirstChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character.Parent == game.Workspace and game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < 20 then
wait()
game:GetService("ReplicatedStorage").RemoteEvents.PlayerDodgeRemote:FireServer(true)
elseif game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < 20 and v.Character.Parent.Parent == game.Players.LocalPlayer.Character.Parent.Parent then
wait()
--if math.random(1,2) == 1 then
game:GetService("ReplicatedStorage").RemoteEvents.PlayerDodgeRemote:FireServer(true)
--end
end
end
end)
end
end
if v ~= game.Players.LocalPlayer then
v.CharacterAdded:Connect(function(char)
repeat wait() until char:FindFirstChild("Humanoid")
if char:FindFirstChild("Humanoid") then
char.Humanoid.AnimationPlayed:Connect(function(track)
if table.find(HostileAnimations, track.Animation.AnimationId) and char:FindFirstChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character.Parent == game.Workspace and game.Players.LocalPlayer:DistanceFromCharacter(char.HumanoidRootPart.Position) < 20 then
wait()
game:GetService("ReplicatedStorage").RemoteEvents.PlayerDodgeRemote:FireServer(true)
elseif game.Players.LocalPlayer:DistanceFromCharacter(char.HumanoidRootPart.Position) < 20 and char.Parent.Parent == game.Players.LocalPlayer.Character.Parent.Parent then
wait()
--if math.random(1,2) == 1 then
game:GetService("ReplicatedStorage").RemoteEvents.PlayerDodgeRemote:FireServer(true)
--end
end
end
end)
end
end)
end
end
end  
})

Tab:AddButton({
	Name = "Fps Booster",
	Callback = function()
		local RemovePlrGuis = false
		local No3DRendering = false
		
		if not game['Loaded'] or not game:GetService('Players')['LocalPlayer'] then
			game['Loaded']:Wait();
			game:WaitForChild(game:GetService('Players'));
			game:GetService('Players'):WaitForChild(game:GetService('Players').LocalPlayer.Name)
		end
		
		local LP = game:GetService('Players').LocalPlayer
		--// Physics Settings
		settings().Physics.PhysicsEnvironmentalThrottle = 0
		settings().Rendering.QualityLevel = 'Level01'
		UserSettings():GetService('UserGameSettings').MasterVolume = 0
		-- Comment line 7 if you want to be able to hear your game, keep it the same if you're using it for bots.
		
		--// Hidden Functions
		setsimulationradius(0, 0)
		setfpscap(1000)
		
		--// Physical/UI Derender
		for _, v in next, game:GetDescendants() do
			if v:IsA('Workspace') then
				sethiddenproperty(v, 'StreamingTargetRadius', 0)
				sethiddenproperty(v, 'StreamingPauseMode', 0)
				sethiddenproperty(v.Terrain, 'Decoration', false)
				v.Terrain.Elasticity = 0
				v.Terrain.WaterWaveSize = 0
				v.Terrain.WaterWaveSpeed = 0
				v.Terrain.WaterReflectance = 0
				v.Terrain.WaterTransparency = 1
			elseif v:IsA('RunService') and No3DRendering then
				v:Set3dRenderingEnabled(false)
				v:setThrottleFramerateEnabled(true)
			elseif v:IsA('NetworkClient') then
				v:SetOutgoingKBPSLimit(100)
			elseif v:IsA('Lighting') then
				sethiddenproperty(v, 'Technology', 2)
				v.GlobalShadows = false
				v.FogEnd = 1/0
				v.Brightness = 0
			elseif v:IsA('Model') then
				sethiddenproperty(v, 'LevelOfDetail', 1)
			elseif LP and v == LP then
				v.ReplicationFocus = nil
			elseif v:IsA('Decal') or v:IsA('Texture') or v:IsA('Beam') then
				v.Transparency = 1
			elseif v:IsA('Fire') or v:IsA('SpotLight') or v:IsA('Smoke') or v:IsA('Sparkles') then
				v.Enabled = false
			elseif v:IsA('SpecialMesh') then
				v.TextureId = ''
				v.MeshId = ''
			elseif v:IsA('ParticleEmitter') or v:IsA('Trail') then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA('BlurEffect') or v:IsA('SunRaysEffect') or v:IsA('ColorCorrectionEffect') or v:IsA('BloomEffect') or v:IsA('DepthOfFieldEffect')  then
				v.Enabled = false
			elseif v:IsA('BasePart') and not v:IsA('MeshPart') then
				v.Reflectance = 0
				v.Material = 'SmoothPlastic'
			elseif v:IsA('Pants') or v:IsA('Shirt') then
				v[v.ClassName..'Template'] = ''
			elseif v:IsA('Explosion') then
				v.BlastPressure = 0
				v.BlastRadius = 0
				v.Visible = false
				v.Position = Vector3.new(0, 0, 0)
			elseif v:IsA('ForceField') then
				v.Visible = false
			elseif v:IsA('ShirtGraphic') then
				v.Graphic = ''
			elseif v:IsA('MeshPart') then
				v.MeshId = ''
				v.TextureID = ''
				v.Reflectance = 0
				v.Material = 'SmoothPlastic'
			elseif v:IsA('CharacterMesh') then
				v.BaseTextureId = ''
				v.MeshId = ''
				v.OverlayTextureId = ''
			elseif v:IsA('Sound') then
				v.SoundId = ''
				v.Volume = 0
			elseif v:IsA('PlayerGui') and RemovePlrGuis then
				v:ClearAllChildren()
			end
		end
		
		local WorkspaceChildAdded;WorkspaceChildAdded = workspace.DescendantAdded:Connect(function(v)
			wait()
			if v:IsA('Model') then
				sethiddenproperty(v, 'LevelOfDetail', 1)
			elseif LP and v == LP then
				v.ReplicationFocus = nil
			elseif v:IsA('Decal') or v:IsA('Texture') or v:IsA('Beam') then
				v.Transparency = 1
			elseif v:IsA('Fire') or v:IsA('SpotLight') or v:IsA('Smoke') or v:IsA('Sparkles') then
				v.Enabled = false
			elseif v:IsA('SpecialMesh') then
				v.TextureId = ''
				v.MeshId = ''
			elseif v:IsA('ParticleEmitter') or v:IsA('Trail') then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA('BlurEffect') or v:IsA('SunRaysEffect') or v:IsA('ColorCorrectionEffect') or v:IsA('BloomEffect') or v:IsA('DepthOfFieldEffect')  then
				v.Enabled = false
			elseif v:IsA('BasePart') and not v:IsA('MeshPart') then
				v.Reflectance = 0
				v.Material = 'SmoothPlastic'
			elseif v:IsA('Pants') or v:IsA('Shirt') then
				v[v.ClassName..'Template'] = ''
			elseif v:IsA('Explosion') then
				v.BlastPressure = 0
				v.BlastRadius = 0
				v.Visible = false
				v.Position = Vector3.new(0, 0, 0)
			elseif v:IsA('ForceField') then
				v.Visible = false
			elseif v:IsA('ShirtGraphic') then
				v.Graphic = ''
			elseif v:IsA('MeshPart') then
				v.MeshId = ''
				v.TextureID = ''
				v.Reflectance = 0
				v.Material = 'SmoothPlastic'
			elseif v:IsA('CharacterMesh') then
				v.BaseTextureId = ''
				v.MeshId = ''
				v.OverlayTextureId = ''
			elseif v:IsA('Sound') then
				v.SoundId = ''
				v.Volume = 0
			end
		end)
	end
}) 

local Tab = Window:MakeTab({
	Name = "Rage",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


Tab:AddButton({
	Name = "Server Lag",
	Callback = function()
while wait(0.6) do --// don't change it's the best
	game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
	local function getmaxvalue(val)
	   local mainvalueifonetable = 499999
	   if type(val) ~= "number" then
		   return nil
	   end
	   local calculateperfectval = (mainvalueifonetable/(val+2))
	   return calculateperfectval
	end
	
	local function bomb(tableincrease, tries)
	local maintable = {}
	local spammedtable = {}
	
	table.insert(spammedtable, {})
	z = spammedtable[1]
	
	for i = 1, tableincrease do
		local tableins = {}
		table.insert(z, tableins)
		z = tableins
	end
	
	local calculatemax = getmaxvalue(tableincrease)
	local maximum
	
	if calculatemax then
		 maximum = calculatemax
		 else
		 maximum = 999999
	end
	
	for i = 1, maximum do
		 table.insert(maintable, spammedtable)
	end
	
	for i = 1, tries do
		 game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
	end
	end
	
	bomb(250, 2) --// change values if client crashes
	end
	end
})


Tab:AddSlider({
	Name = "Changes Walkspeed",
	Min = 0,
	Max = 500,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(v)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
	end    
})

Tab:AddSlider({
	Name = "Changes JumpPower",
	Min = 0,
	Max = 500,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(v)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
		game.Players.LocalPlayer.Character.Humanoid.JumpHeight = v
	end    
})
