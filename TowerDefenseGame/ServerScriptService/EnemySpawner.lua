local module = {}
local ServerStorage = game:GetService("ServerStorage")
local Enemy = ServerStorage.Enemies.BasicEnemy
local Waypoints = workspace.MapaDefense.Waypoints
local Enemies = workspace.MapaDefense.Enemies
local Base = workspace.MapaDefense.Base
local BaseDamage = 10

function module.SpawnEnemy(Alive)

	local EnemyClone = Enemy:Clone()
	EnemyClone.Parent = Enemies

	local humanoid = EnemyClone.Humanoid

	humanoid.Died:Connect(function()
		EnemyClone:Destroy()
	end)

	local start = Waypoints:WaitForChild("0")
	EnemyClone:PivotTo(start.CFrame * CFrame.new(0, 3, 0))

	for i = 1, #Waypoints:GetChildren() - 1 do

		if not Alive() or humanoid.Health <= 0 then
			EnemyClone:Destroy()
			return
		end

		local Waypoint = Waypoints:WaitForChild(tostring(i))
		local Reached = false

		repeat
			humanoid:MoveTo(Waypoint.Position)
			Reached = humanoid.MoveToFinished:Wait()
		until Reached or humanoid.Health <= 0 or not Alive()

	end

	if Alive() and humanoid.Health > 0 then
		local Health = Base:GetAttribute("Health")
		Base:SetAttribute("Health", math.max(0, Health - BaseDamage))
		print("Vida da base:", Base:GetAttribute("Health"))
	end

	EnemyClone:Destroy()
end

return module