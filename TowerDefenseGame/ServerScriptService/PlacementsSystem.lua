local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local PlaceUnit = ReplicatedStorage:WaitForChild("PlaceUnit")

local Defender = ServerStorage.Defenders.BasicDefender
local PlaceTerrain = workspace.MapaDefense.MapaDefensePlate
local Defenders = workspace.MapaDefense.Defenders

PlaceUnit.OnServerEvent:Connect(function(Player, Position, Target)

	if typeof(Position) ~= "Vector3" then return end
	if typeof(Target) ~= "Instance" then return end
	if Target ~= PlaceTerrain then return end

	local UnitClone = Defender:Clone()
	UnitClone:PivotTo(CFrame.new(Position + Vector3.new(0, 3, 0)))
	UnitClone.HumanoidRootPart.Anchored = true
	UnitClone.Parent = Defenders

end)