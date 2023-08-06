local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Entry Point Loud GUI", "Sentinel")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Have fun, made by Providence.")
local countingvalue = 0
local esp = false
local highlightColor = Color3.new(1, 0, 0)  -- Default color is red
local highlightObjects = {}

local function updateHighlightColor()
    for _, highlight in ipairs(highlightObjects) do
        highlight.Color3 = highlightColor
    end
end

Section:NewToggle("ESP", "See your enemies.", function(state)
    esp = state
    updateHighlightColor()
end)

game.Workspace.Level.Actors.ChildAdded:Connect(function(child)
    local char = child:WaitForChild('Character')
    local hp = char:WaitForChild('Humanoid')
    local obj = char:WaitForChild('Interact'):WaitForChild('ObjectName').Value
    local primary = child:WaitForChild("Status"):WaitForChild("Primary")
    local swatSniper = child:WaitForChild("Status"):WaitForChild("Weapons"):WaitForChild("SwatSniper")
    if (obj == "SWAT" or obj == "ETF" or obj == "SC Soldier" or obj == "TRU" or obj == "Halcyon Operative") and primary.Value ~= swatSniper then
        countingvalue = countingvalue + 1
    end
    if obj == "SWAT" or obj == "ETF" or obj == "SC Soldier" or obj == "TRU" or obj == "Halcyon Operative" then
        hp.HealthChanged:Connect(function(health)
            if health == 0 and primary.Value ~= swatSniper then
                countingvalue = countingvalue - 1
            end
        end)
    end
    local chams = Instance.new('Highlight')
    chams.Parent = child
    chams.Color3 = highlightColor
    table.insert(highlightObjects, chams)
end)

local hitboxExpanderSection = Tab:NewSection("Hitbox Expander (NPCs)")
hitboxExpanderSection:NewButton("Expand Hitboxes", "Expands hitboxes of NPCs", function()
    while wait(5) do
        for _, npc in pairs(game:GetService("Workspace").Level.Actors:GetChildren()) do
            pcall(function()
                local char = npc:FindFirstChild('Character')
                if char then
                    local head = char:FindFirstChild('Head')
                    if head then
                        head.CanCollide = false
                        head.Size = Vector3.new(3, 3, 3)
                        head.Transparency = 0.4
                    end
                end
            end)
        end
    end
end)

game.Workspace.Level.Actors.ChildAdded:Connect(function(npc)
    pcall(function()
        local char = npc:FindFirstChild('Character')
        if char then
            local head = char:FindFirstChild('Head')
            if head then
                head.CanCollide = false
                head.Size = Vector3.new(3, 3, 3)
                head.Transparency = 0.4
            end
        end
    end)
end)

Section:NewKeybind("Toggle GUI", "Toggle GUI", Enum.KeyCode.K, function()
    Library:ToggleUI()
end)
