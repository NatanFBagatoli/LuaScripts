local Enemies = workspace.MapaDefense.Enemies
local Defenders = workspace.MapaDefense.Defenders
local Base = workspace.MapaDefense.Base
local Damage = 10
local Range = 20
local Cd = 1

local BaseDestroyed = game.ServerScriptService:WaitForChild("BaseDestroyed")
Base:GetAttributeChangedSignal("Health"):Connect(function()
	if Base:GetAttribute("Health") <= 0 then
		BaseDestroyed:Fire()
	end
end)

local function FindEnemies(Unit)
	local UnitPosition = Unit:GetPivot().Position
	for _, Enemy in Enemies:GetChildren() do
		local humanoid = Enemy:FindFirstChild("Humanoid")
		 
		if humanoid and humanoid.Health > 0 then
			local Distance = (Enemy:GetPivot().Position - UnitPosition).Magnitude
			
			if Distance <= Range then
				return humanoid
			end
		end
	end
	
	return nil
end

local function BaseHP()
	local BaseHealth = Base:GetAttribute("Health")
	
end
local function StartCombat(Unit)
	while Unit.Parent do
		local Target = FindEnemies(Unit)
		if Target then
			Target:TakeDamage(Damage)
			task.wait(Cd)
		else
			task.wait(1)
		end
	end
end

Defenders.ChildAdded:Connect(StartCombat)