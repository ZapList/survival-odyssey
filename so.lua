if game.PlaceId == 18629053284 then
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({Name = "Onyx Hub", HidePremium = false, IntroEnabled = false, IntroText = "Welcome to Onyx Hub!", SaveConfig = true, ConfigFolder = "OnyxConfig"})

    _G.autoFarmEnabled = false
    _G.autoFarmGodsEnabled = false
    _G.autoDeleteItemsEnabled = false
    _G.autoTeleportEssenceEnabled = false
    _G.autoPickupEnabled = false
    _G.autoHarvestEnabled = false
    _G.autoRebirthEnabled = false
    _G.selectedPlantType = "Bloodfruit"
    _G.placementRadius = 5
    _G.plantToFarmEnabled = false
    _G.autoDisposeEnabled = false
    _G.autoFarmBossEnabled = false
    _G.autoCraftBags = false
    _G.espEnabled = false
    _G.autoEatEnabled = false
    _G.autoHealEnabled = false
    _G.safetyEnabled = false
    _G.autoPickupAllEnabled = false
    _G.autoVoodooEnabled = false

    _G.autoFarmResources = {
        ["Feather Bush"] = false,
        ["Sun Tree"] = false,
        ["Ancient Tree"] = false,
        ["Gold Node"] = false,
        ["Gold Stone"] = false,
        ["Crystal Lode"] = false,
    }

    _G.autoPickupItems = {
        ["Crystal Chunk"] = false,
        ["Big Crystal Chunk"] = false,
        ["Gold Bar"] = false,
        ["Big Gold Bar"] = false,
        ["Raw Gold"] = false,
        ["Big Raw Gold"] = false,
        ["Essence"] = false,
        ["Big Essence"] = false,
        ["Coin"] = false
    }

    function autoRebirth()
        while _G.autoRebirthEnabled do
            wait(1)
            game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
        end
    end

    function autoEat()
        while wait() do
            if not _G.autoEatEnabled then break end
    
            local foodStatLabel = game.Players.LocalPlayer.PlayerGui.MainGui.Panels.Stats.List.Food.NumberLabel
            local foodValue = tonumber(foodStatLabel.Text)
    
            if foodValue and foodValue <= 75 then
                local rightPanel = game.Players.LocalPlayer.PlayerGui.MainGui.RightPanel.Inventory.List
                for _, slot in pairs(rightPanel:GetChildren()) do
                    if slot:IsA("ImageButton") and slot:FindFirstChild("title") then
                        if slot.title.Text == "Bloodfruit" then
                            local slotId = tonumber(slot.Name)
                            if slotId then
                                while tonumber(foodStatLabel.Text) < 100 and _G.autoEatEnabled do
                                    game.ReplicatedStorage.Events.UseBagItem:FireServer(slotId)
                                    wait(0.1)
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    function autoHeal()
        while wait() do
            if not _G.autoHealEnabled then break end
    
            local healthStatLabel = game.Players.LocalPlayer.PlayerGui.MainGui.Panels.Stats.List.Health.NumberLabel
            local healthValue = tonumber(healthStatLabel.Text)
    
            if healthValue and healthValue <= 75 then
                local rightPanel = game.Players.LocalPlayer.PlayerGui.MainGui.RightPanel.Inventory.List
                for _, slot in pairs(rightPanel:GetChildren()) do
                    if slot:IsA("ImageButton") and slot:FindFirstChild("title") then
                        if slot.title.Text == "Bloodfruit" then
                            local slotId = tonumber(slot.Name)
                            if slotId then
                                while tonumber(healthStatLabel.Text) < 100 and _G.autoHealEnabled do
                                    game.ReplicatedStorage.Events.UseBagItem:FireServer(slotId)
                                    wait(0.1)
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    
    function autoFarmBoss()
        if isAutoFarmBossRunning then return end
        isAutoFarmBossRunning = true
    
        local bossNames = {"Pink Giant", "Emerald Giant", "Queen Ant"}
        
        while _G.autoFarmEnabled and _G.autoFarmBossEnabled do
            local bossesFolder = workspace:FindFirstChild("Important") and workspace.Important:FindFirstChild("Critters")
    
            if not bossesFolder then
                wait(1)
                continue
            end
    
            for _, bossName in ipairs(bossNames) do
                local boss = bossesFolder:FindFirstChild(bossName)
    
                if boss then
    
                    local humanoidRootPart = boss:FindFirstChild("HumanoidRootPart")
                    if not humanoidRootPart then
                        continue
                    end
    
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local targetPosition = humanoidRootPart.Position + Vector3.new(0, 12, 0)
                        character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
    
                        local swingTime = tick()
                        while _G.autoFarmEnabled and _G.autoFarmBossEnabled do
                            boss = bossesFolder:FindFirstChild(bossName)
                            if not boss or not boss.Parent then
                                break
                            end
    
                            if tick() - swingTime >= 0.2 then
                                game.ReplicatedStorage.Events.SwingTool:FireServer({boss}, nil, nil, nil)
                                print("Swinging at boss:", bossName)
                                swingTime = tick()
                            end
    
                            wait(0.1)
                        end
    
                        while bossesFolder:FindFirstChild(bossName) do
                            wait(0.1)
                        end
    
                        wait(1)
                    end
                end
            end
            wait(1)
        end
        isAutoFarmBossRunning = false
    end
    

    function waitForResourceToBeDestroyed(resource)
        while resource and resource.Parent do
            wait(0.5)
        end
    end

    local isAutoFarmRunning = false
    local isAutoFarmGodsRunning = false

    function autoFarmGods()
        if isAutoFarmGodsRunning then return end
        isAutoFarmGodsRunning = true
        
        while _G.autoFarmGodsEnabled do
            wait(1)
        
            local godsFolder = workspace.Map.Resources:FindFirstChild("Gods")
            if godsFolder then
                for _, god in pairs(godsFolder:GetChildren()) do
                    if god:IsA("Model") then
                        local targetPart = god:FindFirstChild("Totem")
                        if targetPart then
                            local character = game.Players.LocalPlayer.Character
                            if character then
                                local targetPosition = targetPart.Position + Vector3.new(0, 3, 0)
                                character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
        
                                while _G.autoFarmGodsEnabled and godsFolder:FindFirstChild(god.Name) do
                                    wait(0.2)
                                    game.ReplicatedStorage.Events.SwingTool:FireServer({god}, nil, nil, nil)
                                end
        
                                while godsFolder:FindFirstChild(god.Name) do
                                    wait(0.1)
                                end
        
                                wait(2)
                            end
                        end
                    end
                end
            end
        
            wait(1)
        end
        
        isAutoFarmGodsRunning = false
    end    
    
    local plantBoxRadius = 5

    function placePlantBoxes()
        local startPosition = game.Players.LocalPlayer.Character.LeftFoot.Position
        local numEvents = 150
        local radius = math.clamp(plantBoxRadius, 5, 25)
        local decrementFactor = 0.2
        
        for i = 1, numEvents do
            if not _G.plantToFarmEnabled then break end
            
            local angle = (i / numEvents) * math.pi * 2
            local offsetX = math.cos(angle) * radius
            local offsetZ = math.sin(angle) * radius
            
            local newPosition = startPosition + Vector3.new(offsetX, 0, offsetZ)
            
            local success, errorMessage = pcall(function()
                game.ReplicatedStorage.Events.PlaceStructure:FireServer("Plant Box", CFrame.new(newPosition), 0)
            end)
            
            if not success then
                print("Failed to place Plant Box:", errorMessage)
            end
            
            wait(0)
            
            if i == numEvents then
                radius = math.max(radius - decrementFactor, 5)
                numEvents = 150
            end
        end
        
        startPosition = startPosition + Vector3.new(0, 0.1, 0)
    end

    function placeGoldenPlantBoxes()
        local startPosition = game.Players.LocalPlayer.Character.LeftFoot.Position
        local numEvents = 150
        local radius = math.clamp(plantBoxRadius, 5, 25)
        local decrementFactor = 0.2
        
        for i = 1, numEvents do
            if not _G.plantToFarmEnabled then break end
            
            local angle = (i / numEvents) * math.pi * 2
            local offsetX = math.cos(angle) * radius
            local offsetZ = math.sin(angle) * radius
            
            local newPosition = startPosition + Vector3.new(offsetX, 0, offsetZ)
            
            local success, errorMessage = pcall(function()
                game.ReplicatedStorage.Events.PlaceStructure:FireServer("Golden Plant Box", CFrame.new(newPosition), 0)
            end)
            
            if not success then
                print("Failed to place Golden Plant Box:", errorMessage)
            end
            
            wait(0)
            
            if i == numEvents then
                radius = math.max(radius - decrementFactor, 5)
                numEvents = 150
            end
        end
        
        startPosition = startPosition + Vector3.new(0, 0.1, 0)
    end
    
    function autoFarm()
        if isAutoFarmRunning then return end
        isAutoFarmRunning = true
    
        local player = game.Players.LocalPlayer
        local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
        if humanoidRootPart then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = humanoidRootPart
        end
    
        while _G.autoFarmEnabled do
            wait(0.7)
    
            for resourceName, enabled in pairs(_G.autoFarmResources) do
                if not _G.autoFarmEnabled then break end
                if enabled then
                    local resourceFolder = workspace.Map.Resources:FindFirstChild(resourceName)
                    if resourceFolder then
                        local resourceModel = resourceFolder:FindFirstChild(resourceName)
                        if resourceModel then
                            local targetPart = nil
                            local yOffset = -5
    
                            if resourceName == "Ancient Tree" then
                                local resourceParts = resourceModel:GetChildren()
                                if #resourceParts > 50 then
                                    continue
                                end
                                targetPart = resourceModel:FindFirstChild("Reference")
                                yOffset = -8
                            elseif resourceName == "Feather Bush" then
                                targetPart = resourceModel:FindFirstChild("Stump")
                            else
                                targetPart = resourceModel:FindFirstChild("Reference")
                            end
    
                            if targetPart and humanoidRootPart then
                                -- Position the player above the target
                                local targetPosition = targetPart.Position + Vector3.new(0, yOffset, 0)
                                humanoidRootPart.CFrame = CFrame.new(targetPosition)
                                local targetToSwing = resourceModel
                                game.ReplicatedStorage.Events.SwingTool:FireServer({targetToSwing}, nil, nil, nil)
                                wait(0.1)
                            end
                        end
                    end
                end
            end
        end
    
        -- Cleanup: Remove BodyVelocity
        if humanoidRootPart then
            local bodyVelocity = humanoidRootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    
        isAutoFarmRunning = false
    end

    local UserInputService = game:GetService("UserInputService")

    function autoVoodoo()
        while _G.autoVoodooEnabled do
            while wait() do
                local input = UserInputService.InputBegan:Wait()
            
                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.V then
                end
            end
        
            wait(0.1)
        end
    end

    function autoPickup()
        while _G.autoPickupEnabled do
            while wait() do
                for _, item in pairs(workspace.Important.Items:GetChildren()) do
                    if _G.autoPickupItems[item.Name] and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - item.Position).Magnitude <= 60 then
                        game:GetService("ReplicatedStorage").Events.Pickup:InvokeServer(item)
                    end
                end
            end
        end
    end

    function autoPickupAll()
        while _G.autoPickupAllEnabled do
            while wait() do
                for _, item in pairs(workspace.Important.Items:GetChildren()) do
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - item.Position).Magnitude <= 60 then
                        game:GetService("ReplicatedStorage").Events.Pickup:InvokeServer(item)
                    end
                end
            end
        end
    end


    local function toggleESP()
        while _G.espEnabled do
            for _, enemy in pairs(workspace.Important.Characters:GetChildren()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                    if not enemy:FindFirstChildOfClass("Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = enemy
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                        highlight.Parent = enemy
                    end
                end
            end
            wait(0.5)
        end
    
        for _, enemy in pairs(workspace.Important.Characters:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                for _, child in pairs(enemy:GetChildren()) do
                    if child:IsA("Highlight") then
                        child:Destroy()
                    end
                end
            end
        end
    end
    
    function autoDeleteItems()
        while _G.autoDeleteItemsEnabled do
            wait(0.5)
            for _, item in pairs(workspace.Important.Items:GetChildren()) do
                if item.Name ~= "Essence" and item.Name ~= "Big Essence" then
                    item:Destroy()
                end
            end
        end
    end

    function safety()
        local blockedUserIds = {
            7564510489,
            3886339185,
            2678331239
        }
        
        local function onPlayerAdded(player)
            if table.find(blockedUserIds, player.UserId) then
                game.Players.LocalPlayer:Kick("Kicked due to moderator joining.")
            end
        end
        game.Players.PlayerAdded:Connect(onPlayerAdded)
    end
    
    function autoTeleportEssence()
        while _G.autoTeleportEssenceEnabled do
            wait(0.1)
            for _, item in pairs(workspace.Important.Items:GetChildren()) do
                if item.Name == "Essence" or item.Name == "Big Essence" then
                    item.CFrame = game.workspace.Important.Characters.ZapList.HumanoidRootPart.CFrame
                end
            end
        end
    end
    
    local FarmingTab = Window:MakeTab({
        Name = "Farming",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    FarmingTab:AddLabel("Main")
    
    FarmingTab:AddToggle({
        Name = "Enable Auto Farm",
        Default = false,
        Callback = function(Value)
            _G.autoFarmEnabled = Value
            if Value then
                autoFarm()
            else
                local teleportPart = Instance.new("Part")
                teleportPart.Size = Vector3.new(15, 2, 15)
                teleportPart.Position = Vector3.new(0, 1000, 0)
                teleportPart.Anchored = true
                teleportPart.CanCollide = true
                teleportPart.Parent = workspace
                
                teleportPart.Color = Color3.fromRGB(57, 55, 57)
                
                local texture = Instance.new("Decal")
                texture.Texture = "rbxassetid://122055231901817"
                texture.Face = Enum.NormalId.Top
                texture.Parent = teleportPart
                
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    local teleportPosition = teleportPart.Position + Vector3.new(0, 3, 0)
                    player.Character:MoveTo(teleportPosition)
                end
    
                isAutoFarmRunning = false
            end
        end
    })    
    
    
    for resourceName, _ in pairs(_G.autoFarmResources) do
        FarmingTab:AddToggle({
            Name = "Auto Farm " .. resourceName,
            Default = false,
            Callback = function(Value)
                _G.autoFarmResources[resourceName] = Value
            end
        })
    end
    
    FarmingTab:AddToggle({
        Name = "Auto Farm Gods",
        Default = false,
        Callback = function(Value)
            _G.autoFarmGodsEnabled = Value
            if Value then
                if _G.autoFarmEnabled == true then
                    autoFarmGods()
                else
                    isAutoFarmGodsRunning = false
                end
            end
        end
    })

    FarmingTab:AddToggle({
        Name = "Auto Farm Boss",
        Default = false,
        Callback = function(Value)
            _G.autoFarmBossEnabled = Value
            if Value then
                autoFarmBoss()
            else
                _G.autoFarmBossEnabled = false
            end
        end
    })

    --FarmingTab:AddToggle({
        --Name = "Auto Voodoo",
        --Default = false,
        --Callback = function(Value)
            --_G.autoVoodooEnabled = Value
            --if Value then
                --autoVoodoo()
            --end
        --end
    --})
    
    FarmingTab:AddToggle({
        Name = "Auto Rebirth",
        Default = false,
        Callback = function(Value)
            _G.autoRebirthEnabled = Value
            if Value then
                autoRebirth()
            end
        end
    })

    FarmingTab:AddLabel("Extra")

        FarmingTab:AddTextbox({
        Name = "Radius (5 to 25)",
        Default = "5",
        TextDisappear = true,
        Callback = function(value)
            local radiusValue = tonumber(value)
            if radiusValue then
                if radiusValue < 5 then
                    plantBoxRadius = 5
                elseif radiusValue > 25 then
                    plantBoxRadius = 25
                else
                    plantBoxRadius = radiusValue
                end
            else
                plantBoxRadius = 5
            end
        end
    })
        
    FarmingTab:AddToggle({
        Name = "Place Plant Boxes",
        Default = false,
        Callback = function(Value)
            _G.plantToFarmEnabled = Value
            if Value then
                placePlantBoxes()
            end
        end
    })

    FarmingTab:AddToggle({
        Name = "Place Golden Plant Boxes",
        Default = false,
        Callback = function(Value)
            _G.plantToFarmEnabled = Value
            if Value then
                placeGoldenPlantBoxes()
            end
        end
    })
    
    FarmingTab:AddDropdown({
        Name = "Select Plant Type",
        Default = _G.selectedPlantType,
        Options = {"Bloodfruit", "Berry", "Jelly", "Apple", "Orange", "Lemon"},
        Callback = function(selectedPlant)
            _G.selectedPlantType = selectedPlant
        end
    })
    
    FarmingTab:AddToggle({
        Name = "Enable Auto Plant",
        Default = false,
        Callback = function(Value)
            _G.plantToFarmEnabled = Value
            if Value then
                local plantLoopRunning = true
                wait(1)
                spawn(function()
                    while _G.plantToFarmEnabled and plantLoopRunning do
                        wait(0.5)
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local playerPosition = character:WaitForChild("HumanoidRootPart").Position
                        local deployables = workspace.Important.Deployables
                        local radius = 25
                        local goldenPlantBoxesInRange = {}
    
                        for _, deployable in pairs(deployables:GetChildren()) do
                            if deployable.Name == "Golden Plant Box" or deployable.Name == "Plant Box" then
                                local distance = (deployable.Reference.Position - playerPosition).Magnitude
                                if distance <= radius then
                                    table.insert(goldenPlantBoxesInRange, deployable)
                                end
                            end
                        end
    
                        local allPlanted = true
                        for _, deployable in pairs(goldenPlantBoxesInRange) do
                            if not deployable:IsA("Model") or deployable.Parent ~= workspace.Important.Deployables then
                                allPlanted = false
                                continue
                            end
    
                            game.ReplicatedStorage.Events.InteractStructure:FireServer(deployable, _G.selectedPlantType)
                        end
    
                        if allPlanted then
                            wait(2)
                        end
                    end
                end)
            else
                _G.plantToFarmEnabled = false
            end
        end
    })

    function autoHarvest()
        while _G.autoHarvestEnabled do
            wait(0.1)
    
            local selectedPlantType = _G.selectedPlantType
    
            local deployables = workspace.Important.Deployables:GetChildren()
            local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    
            for _, deployable in pairs(deployables) do
                if deployable.Name == "Golden Plant Box" or deployable.Name == "Plant Box" then
                    for _, item in pairs(deployable:GetChildren()) do
                        if selectedPlantType == "Jelly" then
                            if item.Name == "Jelly Crop" then
                                local distance = (playerPosition - item.Reference.Position).Magnitude
    
                                if distance <= 60 then
                                    game:GetService("ReplicatedStorage").Events.Pickup:InvokeServer(item)
                                end
                            end
                        else
                            if item.Name == selectedPlantType then
                                local distance = (playerPosition - item.Position).Magnitude
    
                                if distance <= 60 then
                                    game:GetService("ReplicatedStorage").Events.Pickup:InvokeServer(item)
                                end
                            end
                        end
                    end
                end
            end
        end
    end    
    
    FarmingTab:AddToggle({
        Name = "Enable Auto Harvest",
        Default = false,
        Callback = function(Value)
            _G.autoHarvestEnabled = Value
            if Value then
                autoHarvest()
            else
                _G.autoHarvestEnabled = false
            end
        end
    })

    local PickupTab = Window:MakeTab({
        Name = "Pickups",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    PickupTab:AddToggle({
        Name = "Enable Auto Pickup",
        Default = false,
        Callback = function(Value)
            _G.autoPickupEnabled = Value
            if Value then
                autoPickup()
            end
        end
    })

    PickupTab:AddToggle({
        Name = "Enable Auto Pickup All",
        Default = false,
        Callback = function(Value)
            _G.autoPickupAllEnabled = Value
            if Value then
                autoPickupAll()
            end
        end
    })

    for itemName, _ in pairs(_G.autoPickupItems) do
        PickupTab:AddToggle({
            Name = "Auto Pickup " .. itemName,
            Default = false,
            Callback = function(Value)
                _G.autoPickupItems[itemName] = Value
            end
        })
    end

    local CombatTab = Window:MakeTab({
        Name = "Combat",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    CombatTab:AddToggle({
        Name = "ESP",
        Default = false,
        Callback = function(Value)
            _G.espEnabled = Value
            if _G.espEnabled then
                toggleESP()
            else
                for _, enemy in pairs(workspace.Important.Characters:GetChildren()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                        for _, child in pairs(enemy:GetChildren()) do
                            if child:IsA("Highlight") then
                                child:Destroy()
                            end
                        end
                    end
                end
            end
        end
    })
    
    CombatTab:AddToggle({
        Name = "Auto Eat (75 Threshold)",
        Default = false,
        Callback = function(Value)
            _G.autoEatEnabled = Value
            if _G.autoEatEnabled then
                spawn(autoEat)
            end
        end
    })
    
    CombatTab:AddToggle({
        Name = "Auto Heal (75 Threshold)",
        Default = false,
        Callback = function(Value)
            _G.autoHealEnabled = Value
            if _G.autoHealEnabled then
                spawn(autoHeal)
            end
        end
    })

    local MiscTab = Window:MakeTab({
        Name = "Misc",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MiscTab:AddParagraph("Information:","Delete All will delete everything except selected items                      Teleport Essence will teleport all essence drops to you")

    MiscTab:AddToggle({
        Name = "Delete All (Recommended)",
        Default = false,
        Callback = function(Value)
            _G.autoDeleteItemsEnabled = Value
            if Value then
                autoDeleteItems()
            end
        end
    })

    MiscTab:AddToggle({
        Name = "Teleport Essence",
        Default = false,
        Callback = function(Value)
            _G.autoTeleportEssenceEnabled = Value
            if Value then
                autoTeleportEssence()
            end
        end
    })

    function autoDispose()
        local runService = game:GetService("RunService")
        local player = game.Players.LocalPlayer
        local deployablesFolder = workspace.Important.Deployables
        local trackedDeployables = {}
        
        local disposeStick = _G.autoDisposeStick
        local disposeLeaves = _G.autoDisposeLeaves
        
        runService.Heartbeat:Connect(function()
            if _G.autoDisposeEnabled then
                local deployables = deployablesFolder:GetChildren()
                if #deployables ~= #trackedDeployables then
                    trackedDeployables = deployables
                end
                local playerPosition = player.Character.HumanoidRootPart.Position
    
                for _, deployable in pairs(trackedDeployables) do
                    if deployable.Name == "Campfire" then
                        local distance = (deployable.Reference.Position - playerPosition).Magnitude
                        if distance <= 50 then
                            if disposeStick then
                                game.ReplicatedStorage.Events.InteractStructure:FireServer(deployable, "Stick")
                            end
                            if disposeLeaves then
                                game.ReplicatedStorage.Events.InteractStructure:FireServer(deployable, "Leaves")
                            end
                        end
                    end
                end
            end
        end)
    end
    
    MiscTab:AddToggle({
        Name = "Enable Auto Dispose",
        Default = false,
        Callback = function(Value)
            _G.autoDisposeEnabled = Value
            if Value then
                autoDispose()
            end
        end
    })
    
    MiscTab:AddToggle({
        Name = "Dispose Stick",
        Default = false,
        Callback = function(Value)
            _G.autoDisposeStick = Value
        end
    })
    
    MiscTab:AddToggle({
        Name = "Dispose Leaves",
        Default = false,
        Callback = function(Value)
            _G.autoDisposeLeaves = Value
        end
    })

    MiscTab:AddToggle({
        Name = "Auto Craft Bags",
        Default = false,
        Callback = function(Value)
            _G.autoCraftBags = Value
            while _G.autoCraftBags == true do
                game.ReplicatedStorage.Events.CraftItem:FireServer("Leaf Bag")
                wait(0.1)
            end
        end
    })

    MiscTab:AddTextbox({
        Name = "How much gold to use:",
        Default = "1",
        TextDisappear = true,
        Callback = function(value)
            local goldBarCount = tonumber(value)
            if goldBarCount then
                _G.goldBarCount = math.clamp(goldBarCount, 1, 100)
            else
                _G.goldBarCount = 1
            end
        end
    })

    function pressGold()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local playerPosition = character:WaitForChild("HumanoidRootPart").Position
    
        local deployables = workspace.Important.Deployables
        local nearestCoinPress = nil
        local shortestDistance = math.huge
    
        for _, deployable in pairs(deployables:GetChildren()) do
            if deployable.Name == "Coin Press" then
                local distance = (deployable.Reference.Position - playerPosition).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestCoinPress = deployable
                end
            end
        end
    
        if nearestCoinPress then
            local pressesToDo = _G.goldBarCount or 1
            for i = 1, pressesToDo do
                game.ReplicatedStorage.Events.InteractStructure:FireServer(nearestCoinPress, "Gold Bar")
            end
        end
    end
    
    MiscTab:AddButton({
        Name = "Use Coin Press",
        Callback = function()
            pressGold()
        end
    })

    MiscTab:AddButton({
        Name = "Teleport to Void",
        Callback = function()
            local TeleportService = game:GetService("TeleportService")
            local targetGameId = 18629058177
            TeleportService:Teleport(targetGameId, game.Players.LocalPlayer)
        end
    })    

    MiscTab:AddButton({
        Name = "Teleport to Underworld",
        Callback = function()
            local TeleportService = game:GetService("TeleportService")
            local targetGameId = 92039548740735
            TeleportService:Teleport(targetGameId, game.Players.LocalPlayer)
        end
    })
    
    MiscTab:AddToggle({
        Name = "Safety Kick",
        Default = false,
        Callback = function(Value)
            _G.safetyEnabled = Value
            while _G.safetyEnabled == true do
                safety()
                wait(0.1)
            end
        end
    })

    OrionLib:Init()
end