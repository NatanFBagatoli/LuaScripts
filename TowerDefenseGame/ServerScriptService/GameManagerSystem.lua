local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local StartGame = ReplicatedStorage:WaitForChild("StartGame")
local GameResult = ReplicatedStorage:WaitForChild("GameResult")
local RepeatGame = ReplicatedStorage:WaitForChild("RepeatGame")
local BaseDestroyed = ServerScriptService:WaitForChild("BaseDestroyed")
local WaveSystem = require(ServerScriptService:WaitForChild("WaveSystem"))
local Map = workspace.MapaDefense
local Base = Map.Base
local GameStarted = false
local GameRunning = false
local WaveId = 0

local function EndGame(Result)
	if not GameRunning then return end

	GameRunning = false
	GameResult:FireAllClients(Result)
end

StartGame.OnServerEvent:Connect(function(Player)

	if GameStarted then return end

	GameStarted = true
	GameRunning = true
	WaveId += 1

	local CurrentWave = WaveId

	Base:SetAttribute("Health", 100)
	GameResult:FireAllClients("Playing")

	task.spawn(function()
		local Completed = WaveSystem.Start(function()
			return GameRunning and WaveId == CurrentWave
		end)

		if Completed and WaveId == CurrentWave then
			EndGame("Victory")
		end
	end)
end)

BaseDestroyed.Event:Connect(function()
	EndGame("Defeat")
end)

RepeatGame.OnServerEvent:Connect(function()
	if not GameStarted or GameRunning then return end

	WaveId += 1
	GameStarted = false
	Map.Enemies:ClearAllChildren()
	Map.Defenders:ClearAllChildren()
	Base:SetAttribute("Health", 100)
	GameResult:FireAllClients("Menu")
end)
