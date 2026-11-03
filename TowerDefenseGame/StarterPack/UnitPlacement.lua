local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Tool = script.Parent
local Mouse = Players.LocalPlayer:GetMouse()
local PlaceUnit = ReplicatedStorage:WaitForChild("PlaceUnit")

Tool.Activated:Connect(function()
	PlaceUnit:FireServer(Mouse.Hit.Position, Mouse.Target)
end)
