local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RepeatGame = ReplicatedStorage:WaitForChild("RepeatGame")
local GameResult = ReplicatedStorage:WaitForChild("GameResult")
local RepeatButton = script.Parent
local ResultFrame = RepeatButton.Parent
local ResultUI = ResultFrame.Parent
local ResultTitle = ResultFrame:WaitForChild("ResultTitle")

ResultUI.Enabled = false

GameResult.OnClientEvent:Connect(function(Result)

	if Result == "Victory" then
		ResultTitle.Text = "Você ganhou!"
		ResultUI.Enabled = true

	elseif Result == "Defeat" then
		ResultTitle.Text = "Você perdeu"
		ResultUI.Enabled = true

	elseif Result == "Menu" or Result == "Playing" then
		ResultUI.Enabled = false
	end

end)

RepeatButton.Activated:Connect(function()
	RepeatGame:FireServer()
end)