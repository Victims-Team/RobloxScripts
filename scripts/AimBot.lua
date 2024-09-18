local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local isEnabled = false

local function getNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            
            if player.Team ~= LocalPlayer.Team and distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = player
            end
        end
    end

    return nearestEnemy
end

local function focusCameraOnNearestEnemy()
    if isEnabled then
        local nearestEnemy = getNearestEnemy()
        if nearestEnemy and nearestEnemy.Character and nearestEnemy.Character:FindFirstChild("Head") then
            local targetPosition = nearestEnemy.Character.Head.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
        end
    end
end

local function onKeyPress(input)
    if input.KeyCode == Enum.KeyCode.T then
        isEnabled = not isEnabled
        if isEnabled then
            print("Camera focus enabled")
        else
            print("Camera focus disabled")
        end
    end
end

UserInputService.InputBegan:Connect(onKeyPress)
RunService.RenderStepped:Connect(focusCameraOnNearestEnemy)
