---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Skylis",
		Asset = "rbxassetid://17265396700",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 2
		},
		Shatter = false,
		Repair = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {1.5, 20, 1, 5} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 131,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 6,
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 15,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"You died to who you call Skylis...", "He will shoot out fire so make sure you watch your step or you might step on the fire.", "entity suggested by my friend", "lolcat vynixu goat"},
		Cause = "Skylis (or fire)"
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnReachNode", function(node)
	print("Entity has reached node:", node)
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
-- entity:Pause()
-- entity:Resume()
-- entity:IsPaused()
-- entity:Despawn()


local fireShooter = script.Parent -- Assuming the script is directly under the model that will shoot the fire
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local function shootFire()
    while true do
        task.wait(math.random(1, 3)) -- Wait for a random time between 1 to 3 seconds

        local firePart = Instance.new("Part")
        firePart.Size = Vector3.new(10, 10, 10)
        firePart.Shape = Enum.PartType.Ball
        firePart.Transparency = 1
        firePart.Position = fireShooter.Position + Vector3.new(math.random(-50, 50), math.random(20, 50), math.random(-50, 50))
        firePart.Parent = workspace

        local fire = Instance.new("Fire", firePart)
        fire.Size = 10

        local sound = Instance.new("Sound", firePart)
		sound.SoundId = "rbxassetid://9063468624" -- Replace with your sound ID
        sound:Play()

        Debris:AddItem(firePart, 5) -- Remove the fire part after 5 seconds

        firePart.Touched:Connect(function(hit)
            local player = Players:GetPlayerFromCharacter(hit.Parent)
            if player then
                player.Character:BreakJoints() -- Kills the player on touch
            end
        end)
    end
end

shootFire()
