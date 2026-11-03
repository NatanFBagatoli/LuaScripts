local Players = game:GetService("Players")
local Map = workspace:WaitForChild("MapaDefense")
local Defenders = Map:WaitForChild("Defenders")
local Ground = Map:WaitForChild("MapaDefensePlate")
local Mouse = Players.LocalPlayer:GetMouse()

local RangeCircle = Instance.new("Part")
RangeCircle.Name = "RangeCircle"
RangeCircle.Shape = Enum.PartType.Cylinder
RangeCircle.Anchored = true
RangeCircle.CanCollide = false
RangeCircle.CanTouch = false
RangeCircle.CanQuery = false
RangeCircle.Material = Enum.Material.Neon
RangeCircle.Color = Color3.fromRGB(0, 170, 255)
RangeCircle.Transparency = 0.80

local function ShowRange(Unit)

	local Range = Unit:GetAttribute("Range") or 20
	local Position = Unit:GetPivot().Position

	RangeCircle.Size = Vector3.new(0.15, Range * 2, Range * 2)

	local GroundY = Ground.Position.Y + Ground.Size.Y / 2

	RangeCircle.CFrame =
		CFrame.new(Position.X, GroundY + 0.1, Position.Z)
		* CFrame.Angles(0, 0, math.rad(90))

	RangeCircle.Parent = workspace
end

Mouse.Button1Down:Connect(function()

	local Target = Mouse.Target

	while Target and Target.Parent ~= Defenders do
		Target = Target.Parent
	end

	if Target and Target:IsA("Model") then
		ShowRange(Target)
	else
		RangeCircle.Parent = nil
	end

end)