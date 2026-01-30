local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Brainrot Hub - EDITABLE", "BloodTheme")

local Player = game.Players.LocalPlayer
local Flags = {
    SpeedValue = 16,
    InfJump = false,
    SpinBot = false,
    KillAura = false
}

local Main = Window:NewTab("Contrôles")
local Section = Main:NewSection("Vitesse & Combat")

-- BOOST DE VITESSE (RÉPARÉ)
Section:NewSlider("Vitesse Boost", "De 0 à 100", 100, 0, function(s)
    Flags.SpeedValue = s
end)

Section:NewKeybind("Touche Boost", "Active la vitesse choisie", Enum.KeyCode.V, function()
    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.WalkSpeed <= 16 then
            hum.WalkSpeed = Flags.SpeedValue
        else
            hum.WalkSpeed = 16
        end
    end
end)

-- INFINITE JUMP
Section:NewToggle("Infinite Jump", "Saute sans limite", function(state)
    Flags.InfJump = state
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Flags.InfJump and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.Velocity = Vector3.new(Player.Character.HumanoidRootPart.Velocity.X, 50, Player.Character.HumanoidRootPart.Velocity.Z)
    end
end)

-- AUTO ATTACK
Section:NewToggle("Kill Aura", "Frappe automatique", function(state)
    Flags.KillAura = state
    task.spawn(function()
        while Flags.KillAura do
            local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
            task.wait(0.1)
        end
    end)
end)

-- AUTO SPIN
Section:NewToggle("Auto Spin", "Tourner vite", function(state)
    Flags.SpinBot = state
    task.spawn(function()
        while Flags.SpinBot do
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(60), 0)
            end
            task.wait(0.01)
        end
    end)
end)

local Settings = Window:NewTab("Settings")
Settings:NewSection("Menu"):NewKeybind("Afficher/Cacher", "Ctrl de Droite", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)