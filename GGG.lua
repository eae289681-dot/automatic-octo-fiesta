-- [[ 1. โหลด UI Library ]]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- [[ 2. สร้างหน้าต่างหลัก ]]
local Window = OrionLib:MakeWindow({
    Name = "NINEKAO HUB 🐱 | Keyboard +1 Level",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NinekaoKeyboard",
    IntroEnabled = true,
    IntroText = "Welcome to Keyboard Autofarm"
})

-- [[ 3. สร้างแท็บเมนู ]]
local FarmTab = Window:MakeTab({
    Name = "ฟาร์มเลเวล / Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
    Name = "ตัวละคร / Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- [[ 4. ระบบ Autofarm เลเวลพุ่ง ]]
local autoFarm = false
FarmTab:AddToggle({
    Name = "⚡ เปิด Autofarm เลเวลพุ่งกระฉูด (Auto Click/Type)",
    Default = false,
    Callback = function(Value)
        autoFarm = Value
        if autoFarm then
            task.spawn(function()
                while autoFarm do
                    -- ส่งคำสั่งกด Virtual Input จำลองการพิมพ์แป้นพิมพ์แบบรัวๆ
                    pcall(function()
                        local VirtualInputManager = game:GetService("VirtualInputManager")
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(0.01)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    end)
                    
                    -- ยิง Event คลิก/พิมพ์ถ้าแมพใช้ Remote
                    pcall(function()
                        for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if v:IsA("RemoteEvent") and (v.Name:lower():find("type") or v.Name:lower():find("click") or v.Name:lower():find("add")) then
                                v:FireServer()
                            end
                        end
                    end)
                    
                    task.wait(0.01) -- ปรับเวลารอ ยิ่งน้อยยิ่งไว
                end
            end)
        end
    end    
})

-- [[ 5. ระบบรีบอร์นอัตโนมัติ ]]
local autoRebirth = false
FarmTab:AddToggle({
    Name = "🔄 รีบอร์นให้อัตโนมัติ (Auto Rebirth)",
    Default = false,
    Callback = function(Value)
        autoRebirth = Value
        if autoRebirth then
            task.spawn(function()
                while autoRebirth do
                    pcall(function()
                        for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if v:IsA("RemoteEvent") and v.Name:lower():find("rebirth") then
                                v:FireServer()
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-- [[ 6. ระบบปรับแต่งความเร็ว ]]
PlayerTab:AddSlider({
    Name = "ความเร็วตัวละคร (WalkSpeed)",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 5,
    ValueName = "Speed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

OrionLib:Init()
