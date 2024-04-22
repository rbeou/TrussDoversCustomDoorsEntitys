---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Slower",
		Asset = "rbxassetid://17258001013",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 3
		},
		Shatter = false,
		Repair = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {0.05, 0.5, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 1,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 1,
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 5,
		Amount = 90
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = false
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"You have died to the Slowest Doors Entity ever!", "I have no idea how he appeared so I guess you can just open the next doors and continue or hide.", "He doesn't kill you instantly he takes alot of your health.", "He barley flickers the lights so I guess you have to pay attention to the lights he shows off!", "Better luck next time!", "lolcat_f and vynixu goat"},
		Cause = "Slower"
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
