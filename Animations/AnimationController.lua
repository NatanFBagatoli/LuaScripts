local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local AnimationsFolder = ReplicatedStorage.Animations
local Player = Players.LocalPlayer
local walk

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:WaitForChild("Animator")
    walk = animator:LoadAnimation(AnimationsFolder.Walk)
end
UserInputService.InputBegan:Connect(function(input: InputObject, gp: boolean)
if gp then 
return
end
if input.UserInputType == Enum.UserInputType.W then
if walk then
walk:Play()
end
end
end)

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end