local module = {}
local ServerScriptService = game:GetService("ServerScriptService")
local EnemyModule = require(ServerScriptService:WaitForChild("EnemySpawner"))
local Enemies = workspace.MapaDefense.Enemies

local Waves = {
	{ enemies = 5,  intervalo = 1 }, 
	{ enemies = 10, intervalo = 1 },  
	{ enemies = 15, intervalo = 1 },  
	{ enemies = 20, intervalo = 1 }, 
	{ enemies = 25, intervalo = 1 },  
}

function module.Start(Alive)

	for Wave, config in ipairs(Waves) do
		if not Alive() then return false end
		print("Wave ".. Wave)

		for i = 1, config.enemies do
			if not Alive() then return false end
			task.spawn(EnemyModule.SpawnEnemy, Alive)
			task.wait(config.intervalo)		

		end
		while #Enemies:GetChildren() > 0 do
			if not Alive() then return false end
			task.wait(0.5)
		end
		if not Alive() then return false end
		print("Wave " .. Wave .. " concluída!")
		task.wait(3)
	end
	if not Alive() then return false end
	return true
end
return module
