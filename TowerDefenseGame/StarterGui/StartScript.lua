local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StartGame = ReplicatedStorage:WaitForChild("StartGame")
local GameResult = ReplicatedStorage:WaitForChild("GameResult")
local Start = script.Parent
local StartFrame = Start.Parent

Start.Activated:Connect(function()
	StartGame:FireServer()
end)

GameResult.OnClientEvent:Connect(function(Result)
	if Result == "Playing" then
		StartFrame.Visible = false
	elseif Result == "Menu" then
		StartFrame.Visible = true
	end
end)