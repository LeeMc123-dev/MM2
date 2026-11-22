if getgenv and getgenv().IdenticalMM2Unload then
    pcall(getgenv().IdenticalMM2Unload
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Config = {
    RoundTimer = true,
    DeathNotifs = true,
    RoleReveals = true,
    AnnounceRoles = false,

    AutoShoot = false,
    SilentAim = false,
    AimPrediction = true,
    PingComp = true,
    SingleShot = false,
    FOVRadius = 160,
    ShowFOV = false,
    AutoEquipGun = true,
    GrabGunAuto = false,
    GunGrabDist = 300,

    KillAura = false,
    AutoKill = false,
    KillMode = "Legit",
    KnifeSilentAim = true,
    AuraRange = 15,
    KillAll = false,
    ShowAuraRing = false,
    AutoEquipKnife = true,
    ProximityKnife = true,
    KnifeProxDist = 18,

    HitboxExpander = false,
    HitboxSize = 10,
    HitboxTransparency = 0.6,

    MurdererAvoid = false,
    SafetyRadius = 40,
    RetreatToLobby = false,
    ProximityAlert = true,
    SprintWhenChased = true,
    FollowMurderer = false,
    FollowDist = 18,

    RoleESP = true,
    ESPBoxes = true,
    ESPNames = true,
    ESPTracers = false,
    ESPDistance = true,
    ESPChams = true,
    ESPDistanceMax = 600,
    GunESP = true,
    CoinESP = true,

    CoinFarm = false,
    FarmSpeed = 28,
    FarmMethod = "Glide",
    SafeCoinFarm = true,
    BagFullStop = true,
    QuickFarm = false,
    CoinBagCap = 40,

    FlingStyle = "Torque",
    FlingPower = 90,

    AutoDrop = false,
    SaveSlot1 = nil,
    SaveSlot2 = nil,

    SpeedEnabled = false,
    SpeedValue = 24,
    JumpEnabled = false,
    JumpValue = 50,
    InfiniteJump = false,
    Noclip = false,
    Fly = false,
    FlySpeed = 35,

    AntiVoid = true,
    AntiFling = true,
    Fullbright = false,
    NoFog = false,
    DisableParticles = false,
    AntiAFK = true,

    AutoPlay = false
}

local DefaultConfig = {}
for k, v in pairs(Config) do
    DefaultConfig[k] = v
end

local CONFIG_FILE = "MurderMystery/mm2_config.json"

local function LoadSavedConfig()
    if isfile and isfile(CONFIG_FILE) then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile(CONFIG_FILE))
        end)
        if ok and type(data) == "table" then
            for k, v in pairs(data) do
                if Config[k] ~= nil then
                    if type(v) == "table" and (k == "SaveSlot1" or k == "SaveSlot2") then
                        Config[k] = CFrame.new(unpack(v))
                    else
                        Config[k] = v
                    end
                end
            end
            return true
        end
    end
    return false
end

local saveDebounce = false
local function AutoSaveConfig()
    if not writefile then return end
    if saveDebounce then return end
    saveDebounce = true
    task.delay(0.25, function()
        saveDebounce = false
        pcall(function()
            if makefolder and not isfolder("MurderMystery") then
                makefolder("MurderMystery")
            end
            local payload = {}
            for k, v in pairs(Config) do
                if typeof(v) == "CFrame" then
                    payload[k] = {v:GetComponents()}
                elseif typeof(v) == "EnumItem" then
                    payload[k] = v.Name
                else
                    payload[k] = v
                end
            end
            writefile(CONFIG_FILE, HttpService:JSONEncode(payload))
        end)
    end)
end

LoadSavedConfig()

local Colors = {
    TextPrimary = Color3.fromRGB(243, 240, 255),
    PurpleAccent = Color3.fromRGB(168, 85, 247),
    AccentGreen = Color3.fromRGB(52, 211, 153),
    AccentRed = Color3.fromRGB(248, 113, 113),
    AccentBlue = Color3.fromRGB(96, 165, 250),
    AccentYellow = Color3.fromRGB(251, 191, 36)
}

local function getSafeUiParent()
    local target = CoreGui
    if gethui then
        pcall(function()
            local h = gethui()
            if h then target = h end
        end)
    end
    return target
end

local espFolder = Instance.new("Folder")
espFolder.Name = "MurderMystery_ESP"
pcall(function() espFolder.Parent = getSafeUiParent() end)
if not espFolder.Parent then espFolder.Parent = CoreGui end

local activeConnections = {}
local trackedESPElements = {}
local trackedTracers = {}
local deadPlayersList = {}
local originalHitboxSizes = {}
local isFlinging = false

local function trackConn(conn)
    if conn then
        table.insert(activeConnections, conn)
    end
    return conn
end

local function fireTouch(part1, part2)
    if firetouchinterest and part1 and part2 then
        local ft = firetouchinterest
        pcall(ft, part1, part2, 0)
        task.wait()
        pcall(ft, part1, part2, 1)
    end
end

local function clearESPCategory(prefix)
    local toRemove = {}
    for id in pairs(trackedESPElements) do
        if string.sub(id, 1, string.len(prefix)) == prefix then
            table.insert(toRemove, id)
        end
    end
    for _, id in ipairs(toRemove) do
        if trackedESPElements[id] then
            pcall(function() trackedESPElements[id]:Destroy() end)
            trackedESPElements[id] = nil
        end
    end
    local tracersToRemove = {}
    for id in pairs(trackedTracers) do
        if string.sub(id, 1, string.len(prefix)) == prefix then
            table.insert(tracersToRemove, id)
        end
    end
    for _, id in ipairs(tracersToRemove) do
        if trackedTracers[id] then
            pcall(function() trackedTracers[id]:Remove() end)
            trackedTracers[id] = nil
        end
    end
    for _, c in ipairs(espFolder:GetChildren()) do
        if string.sub(c.Name, 1, string.len(prefix)) == prefix then
            pcall(function() c:Destroy() end)
        end
    end
end

local function getRootPart(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChildWhichIsA("BasePart")
end

local function getHumanoid(char)
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local function isPlayerAlive(p)
    if not p or not p.Character then return false end
    local hum = getHumanoid(p.Character)
    return hum ~= nil and hum.Health > 0
end

local function getPlayerRole(p)
    if not p then return "Innocent" end
    local bp = p:FindFirstChild("Backpack")
    local char = p.Character
    local knife = (bp and bp:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))
    local gun = (bp and bp:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun"))
    if knife then
        return "Murderer"
    elseif gun then
        return "Sheriff"
    end
    return "Innocent"
end

local function getRolePlayers()
    local murderer = nil
    local sheriff = nil
    local innocents = {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) then
            local r = getPlayerRole(p)
            if r == "Murderer" then
                murderer = p
            elseif r == "Sheriff" then
                sheriff = p
            else
                table.insert(innocents, p)
            end
        end
    end
    return murderer, sheriff, innocents
end

local function getActiveMap()
    for _, c in ipairs(Workspace:GetChildren()) do
        if c:IsA("Model") and not string.find(string.lower(c.Name), "lobby") and not Players:GetPlayerFromCharacter(c) then
            if c:FindFirstChild("Spawns") or c:FindFirstChild("CoinAreas") or c:FindFirstChild("CoinContainer") or c:FindFirstChild("Base") then
                return c
            end
        end
    end
    return nil
end

local function getLobbyModel()
    for _, c in ipairs(Workspace:GetChildren()) do
        if c:IsA("Model") and string.find(string.lower(c.Name), "lobby") then
            return c
        end
    end
    return Workspace:FindFirstChild("SummerLobby") or Workspace:FindFirstChild("Lobby")
end

local function getAllActiveCoins()
    local coins = {}
    local seen = {}

    for _, tag in ipairs({"CoinVisual", "Coin"}) do
        for _, v in ipairs(CollectionService:GetTagged(tag)) do
            if v and v.Parent and not v:GetAttribute("Collected") and not v:GetAttribute("Delete") then
                local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")
                if part and not seen[part] and part.Transparency < 0.95 then
                    seen[part] = true
                    table.insert(coins, part)
                end
            end
        end
    end

    if #coins == 0 then
        local map = getActiveMap()
        if map then
            local container = map:FindFirstChild("CoinAreas") or map:FindFirstChild("CoinContainer") or map:FindFirstChild("Coins")
            if container then
                for _, c in ipairs(container:GetChildren()) do
                    for _, d in ipairs(c:GetDescendants()) do
                        if (d:GetAttribute("CoinID") or string.find(string.lower(d.Name), "coin")) and d:IsA("BasePart") and not seen[d] and d.Transparency < 0.95 then
                            seen[d] = true
                            table.insert(coins, d)
                        end
                    end
                    if (c:GetAttribute("CoinID") or string.find(string.lower(c.Name), "coin")) and c:IsA("BasePart") and not seen[c] and c.Transparency < 0.95 then
                        seen[c] = true
                        table.insert(coins, c)
                    end
                end
            end
        end
    end

    return coins
end

local function getCurrentCoinCount()
    local pgui = LocalPlayer:FindFirstChild("PlayerGui")
    local mg = pgui and pgui:FindFirstChild("MainGUI")
    local gameUi = mg and mg:FindFirstChild("Game")
    local coinBag = gameUi and gameUi:FindFirstChild("CoinBag")
    if coinBag then
        for _, desc in ipairs(coinBag:GetDescendants()) do
            if desc:IsA("TextLabel") and string.find(desc.Text, "/") then
                local current = tonumber(string.match(desc.Text, "(%d+)%s*/"))
                if current then
                    return current
                end
            end
        end
    end
    return 0
end

local function getGunDrop()
    local gd = Workspace:FindFirstChild("GunDrop")
    if gd then return gd end
    local map = getActiveMap()
    if map then
        gd = map:FindFirstChild("GunDrop")
        if gd then return gd end
    end
    for _, c in ipairs(Workspace:GetChildren()) do
        if c.Name == "GunDrop" then
            return c
        end
    end
    return Workspace:FindFirstChild("GunDrop", true)
end

local function getGunDropPart(drop)
    if not drop then return nil end
    if drop:IsA("BasePart") then
        return drop
    end
    if drop:IsA("Model") or drop:IsA("Folder") or drop:IsA("Tool") then
        local p = drop:FindFirstChild("GunDrop") or drop:FindFirstChild("Handle") or drop.PrimaryPart or drop:FindFirstChildWhichIsA("BasePart")
        if p and p:IsA("BasePart") then
            return p
        end
        for _, desc in ipairs(drop:GetDescendants()) do
            if desc:IsA("BasePart") then
                return desc
            end
        end
    end
    return nil
end

local function interactWithGunDrop(gunPart, gunObj)
    if not gunPart then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = getRootPart(char)
    if not root then return end

    local prompt = (gunObj and gunObj:FindFirstChildOfClass("ProximityPrompt"))
        or gunPart:FindFirstChildOfClass("ProximityPrompt")
        or (gunObj and gunObj:FindFirstChildWhichIsA("ProximityPrompt", true))
    if prompt and fireproximityprompt then
        pcall(fireproximityprompt, prompt)
    end

    fireTouch(root, gunPart)
    local rHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
    if rHand then
        fireTouch(rHand, gunPart)
    end
end

-- ==========================================
-- WINDUI LOADER
-- ==========================================
local WindUI = nil
local windUrls = {
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
}

for _, url in ipairs(windUrls) do
    local ok, lib = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if ok and type(lib) == "table" and lib.CreateWindow then
        WindUI = lib
        break
    end
end

local function SendNotification(title, text, duration)
    if WindUI and WindUI.Notify then
        pcall(function()
            WindUI:Notify({
                Title = title or "Murder Mystery",
                Content = text or "",
                Duration = duration or 3
            })
        end)
    else
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = title or "Murder Mystery",
                Text = text or "",
                Duration = duration or 3
            })
        end)
    end
end

if not WindUI then
    SendNotification("Murder Mystery", "No se pudo cargar WindUI en este momento.", 4)
    return
end

local Window = WindUI:CreateWindow({
    Title = "Murder Mystery",
    Icon = "swords",
    Author = "MM2",
    Folder = "MurderMystery-WindUI",
    Size = UDim2.fromOffset(580, 420),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 170,
    HasOutline = true
})

Window:CreateTopbarButton("ToggleUI", "eye", function()
    if Window.Toggle then
        pcall(function() Window:Toggle() end)
    end
end, 999)

local function ShootMurdererAction()
    local murderer = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) and getPlayerRole(p) == "Murderer" then
            murderer = p
            break
        end
    end

    local char = LocalPlayer.Character
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local gun = (bp and bp:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun"))
    if not gun then
        SendNotification("Murder Mystery", "You do not have the Gun!", 2)
        return
    end
    if not murderer or not murderer.Character then
        SendNotification("Murder Mystery", "Murderer not found or deceased!", 2)
        return
    end

    local hum = getHumanoid(char)
    if hum and bp and gun.Parent == bp then
        hum:EquipTool(gun)
        task.wait(0.1)
    end

    local root = getRootPart(char)
    local mRoot = getRootPart(murderer.Character)
    if root and mRoot and gun:FindFirstChild("Shoot") then
        local rayAtt = root:FindFirstChild("GunRaycastAttachment")
        local origin = rayAtt and rayAtt.WorldCFrame or root.CFrame
        local targetCF = CFrame.new(mRoot.Position)
        gun.Shoot:FireServer(origin, targetCF)
        SendNotification("Murder Mystery", "Shot fired at Murderer (" .. murderer.Name .. ")!", 2)
    end
end

local function GrabGunAction()
    local drop = getGunDrop()
    local gunPart = getGunDropPart(drop)
    local char = LocalPlayer.Character
    local root = getRootPart(char)
    if not gunPart then
        SendNotification("Murder Mystery", "No Gun is currently dropped on map!", 2)
        return
    end
    if root then
        root.CFrame = gunPart.CFrame * CFrame.new(0, 1.5, 0)
        task.wait(0.05)
        interactWithGunDrop(gunPart, drop)
        SendNotification("Murder Mystery", "Grabbed dropped gun!", 2)
    end
end

local function AnnounceRolesAction()
    local murderer, sheriff = getRolePlayers()
    local msg = "[Murder Mystery] "
    if murderer then
        msg = msg .. "Murderer: " .. murderer.Name .. " | "
    else
        msg = msg .. "Murderer: Unknown | "
    end
    if sheriff then
        msg = msg .. "Sheriff: " .. sheriff.Name
    else
        msg = msg .. "Sheriff: Unknown"
    end

    local textChannels = TextChatService:FindFirstChild("TextChannels")
    local rbxGeneral = textChannels and textChannels:FindFirstChild("RBXGeneral")
    if rbxGeneral and rbxGeneral.SendAsync then
        rbxGeneral:SendAsync(msg)
    else
        pcall(function()
            local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            local sayReq = events and events:FindFirstChild("SayMessageRequest")
            if sayReq then
                sayReq:FireServer(msg, "All")
            end
        end)
    end
    SendNotification("Murder Mystery", "Roles announced in chat!", 2)
end

local function CopyDeathListAction()
    if #deadPlayersList == 0 then
        SendNotification("Murder Mystery", "No recorded deaths yet this round.", 2)
        return
    end
    local text = "MM2 Dead Players: " .. table.concat(deadPlayersList, ", ")
    if setclipboard then
        setclipboard(text)
        SendNotification("Murder Mystery", "Death list copied to clipboard!", 2)
    else
        SendNotification("Murder Mystery", "Clipboard API not supported.", 2)
    end
end

local function TeleportToMurdererAction()
    local murderer = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) and getPlayerRole(p) == "Murderer" then
            murderer = p
            break
        end
    end
    local root = getRootPart(LocalPlayer.Character)
    if murderer and murderer.Character and root then
        local mRoot = getRootPart(murderer.Character)
        if mRoot then
            root.CFrame = mRoot.CFrame * CFrame.new(0, 0, 4)
            SendNotification("Murder Mystery", "Teleported to Murderer (" .. murderer.Name .. ")", 2)
        end
    else
        SendNotification("Murder Mystery", "Murderer not found or deceased.", 2)
    end
end

local function TeleportToSheriffAction()
    local sheriff = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) and getPlayerRole(p) == "Sheriff" then
            sheriff = p
            break
        end
    end
    local root = getRootPart(LocalPlayer.Character)
    if sheriff and sheriff.Character and root then
        local sRoot = getRootPart(sheriff.Character)
        if sRoot then
            root.CFrame = sRoot.CFrame * CFrame.new(0, 0, 4)
            SendNotification("Murder Mystery", "Teleported to Sheriff (" .. sheriff.Name .. ")", 2)
        end
    else
        SendNotification("Murder Mystery", "Sheriff not found or deceased.", 2)
    end
end

local function TeleportToMapAction()
    local map = getActiveMap()
    local root = getRootPart(LocalPlayer.Character)
    if map and root then
        local spawns = map:FindFirstChild("Spawns")
        if spawns and #spawns:GetChildren() > 0 then
            local sp = spawns:GetChildren()[1]
            root.CFrame = sp.CFrame * CFrame.new(0, 3, 0)
        else
            local p = map:FindFirstChildWhichIsA("BasePart")
            if p then root.CFrame = p.CFrame * CFrame.new(0, 5, 0) end
        end
        SendNotification("Murder Mystery", "Teleported to " .. map.Name, 2)
    else
        SendNotification("Murder Mystery", "No active map currently found.", 2)
    end
end

local function TeleportToLobbyAction()
    local lobby = getLobbyModel()
    local root = getRootPart(LocalPlayer.Character)
    if lobby and root then
        local p = lobby:FindFirstChild("Spawns") or lobby:FindFirstChildWhichIsA("BasePart")
        if p then
            local targetPart = p:IsA("Model") and p:GetChildren()[1] or p
            if targetPart then root.CFrame = targetPart.CFrame * CFrame.new(0, 3, 0) end
        end
        SendNotification("Murder Mystery", "Teleported to Lobby", 2)
    end
end

local function flingCharacter(targetChar)
    if isFlinging then return end
    local char = LocalPlayer.Character
    local root = getRootPart(char)
    local tRoot = getRootPart(targetChar)
    if not root or not tRoot then return end

    local hum = getHumanoid(char)
    local tHum = getHumanoid(targetChar)
    if not hum or hum.Health <= 0 or not tHum or tHum.Health <= 0 then return end

    isFlinging = true
    local oldCF = root.CFrame

    if sethiddenproperty then
        pcall(sethiddenproperty, LocalPlayer, "SimulationRadius", 10000)
        pcall(sethiddenproperty, LocalPlayer, "MaxSimulationRadius", 10000)
    end
    if setsimulationradius then
        pcall(setsimulationradius, 10000)
    end

    for _, obj in ipairs(root:GetChildren()) do
        if obj:IsA("BodyMover") then
            pcall(function() obj:Destroy() end)
        end
    end

    local bAV = Instance.new("BodyAngularVelocity")
    bAV.Name = "FlingTorque"
    bAV.AngularVelocity = Vector3.new(0, 9e9, 0)
    bAV.MaxTorque = Vector3.new(0, 9e9, 0)
    bAV.P = 9e9
    bAV.Parent = root

    local bV = Instance.new("BodyVelocity")
    bV.Name = "FlingVelocity"
    bV.Velocity = Vector3.new(0, 0, 0)
    bV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bV.Parent = root

    local steppedConn = RunService.Stepped:Connect(function()
        if not char or not root or not root.Parent then return end
        for _, child in ipairs(char:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CanCollide = false
            end
        end
    end)

    local startTime = tick()
    local duration = 1.5

    while tick() - startTime < duration do
        if not targetChar or not targetChar.Parent or not tRoot or not tRoot.Parent or tHum.Health <= 0 then
            break
        end
        if not char or not char.Parent or not root or not root.Parent or hum.Health <= 0 then
            break
        end

        local style = Config.FlingStyle
        if style == "Velocity" then
            root.CFrame = CFrame.new(tRoot.Position + Vector3.new(0, 1.2, 0))
            root.AssemblyLinearVelocity = Vector3.new(0, 9e9, 0)
            root.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
        elseif style == "Orbit" then
            local angle = (tick() - startTime) * 20
            local off = Vector3.new(math.cos(angle) * 1.5, 0.5, math.sin(angle) * 1.5)
            root.CFrame = CFrame.new(tRoot.Position + off, tRoot.Position)
            root.AssemblyLinearVelocity = Vector3.new(9e9, 9e9, 9e9)
            root.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
        else
            root.CFrame = tRoot.CFrame
            root.AssemblyLinearVelocity = Vector3.new(9e9, 9e9, 9e9)
            root.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
        end

        RunService.Heartbeat:Wait()
    end

    pcall(function() steppedConn:Disconnect() end)
    pcall(function() bAV:Destroy() end)
    pcall(function() bV:Destroy() end)

    if root and root.Parent then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = oldCF
    end

    task.wait(0.15)
    isFlinging = false
end

local function FlingMurdererAction()
    local murderer = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) and getPlayerRole(p) == "Murderer" then
            murderer = p
            break
        end
    end
    if murderer and murderer.Character then
        SendNotification("Murder Mystery", "Flinging Murderer (" .. murderer.Name .. ")...", 2)
        task.spawn(flingCharacter, murderer.Character)
    else
        SendNotification("Murder Mystery", "Murderer not found or dead.", 2)
    end
end

local function FlingSheriffAction()
    local sheriff = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) and getPlayerRole(p) == "Sheriff" then
            sheriff = p
            break
        end
    end
    if sheriff and sheriff.Character then
        SendNotification("Murder Mystery", "Flinging Sheriff (" .. sheriff.Name .. ")...", 2)
        task.spawn(flingCharacter, sheriff.Character)
    else
        SendNotification("Murder Mystery", "Sheriff not found or dead.", 2)
    end
end

local function queueReinject()
    local qot = (syn and syn.queue_on_teleport) or queue_on_teleport or queueonteleport or (fluxus and fluxus.queue_on_teleport)
    if qot then
        local code = [[
            task.spawn(function()
                repeat task.wait(0.5) until game:IsLoaded() and game:GetService("Players").LocalPlayer
                task.wait(1)
                if isfile and isfile("Identical_MM2.lua") then
                    loadstring(readfile("Identical_MM2.lua"))()
                elseif isfile and isfile("scripts/mm2.luau") then
                    loadstring(readfile("scripts/mm2.luau"))()
                elseif isfile and isfile("Identical.lua") then
                    loadstring(readfile("Identical.lua"))()
                end
            end)
        ]]
        pcall(qot, code)
    end
end

local function RejoinServerAction()
    queueReinject()
    SendNotification("Murder Mystery", "Rejoining server...", 2)
    task.wait(0.1)
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
end

local function ServerHopRandomAction()
    queueReinject()
    SendNotification("Murder Mystery", "Searching for active server...", 2)
    local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&excludeFullGames=true&limit=100"
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and res then
        local data = nil
        pcall(function() data = HttpService:JSONDecode(res) end)
        if data and data.data then
            local validServers = {}
            for _, s in ipairs(data.data) do
                if s.id ~= game.JobId and type(s.playing) == "number" and type(s.maxPlayers) == "number" and s.playing >= 5 and s.playing < s.maxPlayers then
                    table.insert(validServers, s)
                end
            end
            if #validServers == 0 then
                for _, s in ipairs(data.data) do
                    if s.id ~= game.JobId and type(s.playing) == "number" and type(s.maxPlayers) == "number" and s.playing >= 2 and s.playing < s.maxPlayers then
                        table.insert(validServers, s)
                    end
                end
            end
            if #validServers > 0 then
                local chosen = validServers[math.random(1, #validServers)]
                SendNotification("Murder Mystery", "Teleporting (" .. chosen.playing .. "/" .. chosen.maxPlayers .. ")...", 3)
                task.wait(0.1)
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, chosen.id, LocalPlayer)
                end)
                return
            end
        end
    end
    SendNotification("Murder Mystery", "No alternative servers found.", 2)
end

local function ServerHopLowAction()
    queueReinject()
    SendNotification("Murder Mystery", "Searching for low-pop server...", 2)
    local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and res then
        local data = nil
        pcall(function() data = HttpService:JSONDecode(res) end)
        if data and data.data then
            local candidates = {}
            for _, s in ipairs(data.data) do
                if s.id ~= game.JobId and type(s.playing) == "number" and type(s.maxPlayers) == "number" and s.playing >= 2 and s.playing <= 5 then
                    table.insert(candidates, s)
                end
            end
            if #candidates == 0 then
                for _, s in ipairs(data.data) do
                    if s.id ~= game.JobId and type(s.playing) == "number" and type(s.maxPlayers) == "number" and s.playing >= 2 and s.playing < s.maxPlayers then
                        table.insert(candidates, s)
                    end
                end
            end
            if #candidates > 0 then
                local chosen = candidates[1]
                SendNotification("Murder Mystery", "Joining low-pop (" .. chosen.playing .. "/" .. chosen.maxPlayers .. ")...", 3)
                task.wait(0.1)
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, chosen.id, LocalPlayer)
                end)
                return
            end
        end
    end
    SendNotification("Murder Mystery", "No low-population servers found.", 2)
end

-- ==========================================
-- TABS & CONTROLS (WINDUI)
-- ==========================================
local HomeTab = Window:Tab({ Title = "Home", Icon = "home" })
local CombatTab = Window:Tab({ Title = "Combat", Icon = "crosshair" })
local VisualsTab = Window:Tab({ Title = "Visuals", Icon = "eye" })
local FarmTab = Window:Tab({ Title = "Farm", Icon = "coins" })
local SurvivalTab = Window:Tab({ Title = "Survival", Icon = "shield" })
local TeleportsTab = Window:Tab({ Title = "Teleports", Icon = "map-pin" })
local TrollingTab = Window:Tab({ Title = "Trolling", Icon = "zap" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "sliders" })

-- HOME --
HomeTab:Section({ Title = "Quick Actions" })
HomeTab:Button({ Title = "Shoot Murderer", Callback = ShootMurdererAction })
HomeTab:Button({ Title = "Grab Gun", Callback = GrabGunAction })
HomeTab:Button({ Title = "Announce Roles", Callback = AnnounceRolesAction })
HomeTab:Button({ Title = "Copy Death List", Callback = CopyDeathListAction })

HomeTab:Section({ Title = "Configuration Profile" })
HomeTab:Toggle({ Title = "Round Timer", Value = Config.RoundTimer, Callback = function(v) Config.RoundTimer = v; AutoSaveConfig() end })
HomeTab:Toggle({ Title = "Death Notifications", Value = Config.DeathNotifs, Callback = function(v) Config.DeathNotifs = v; AutoSaveConfig() end })
HomeTab:Toggle({ Title = "Role Reveals", Value = Config.RoleReveals, Callback = function(v) Config.RoleReveals = v; AutoSaveConfig() end })
HomeTab:Toggle({ Title = "Announce Roles Auto", Value = Config.AnnounceRoles, Callback = function(v) Config.AnnounceRoles = v; AutoSaveConfig() end })
HomeTab:Button({ Title = "Save Configuration", Callback = function() AutoSaveConfig(); SendNotification("Murder Mystery", "Configuration profile saved to disk!", 2) end })
HomeTab:Button({ Title = "Reload Configuration", Callback = function()
    if LoadSavedConfig() then SendNotification("Murder Mystery", "Configuration profile restored!", 2)
    else SendNotification("Murder Mystery", "No saved profile found.", 2) end
end })
HomeTab:Button({ Title = "Reset Defaults", Callback = function()
    for k, v in pairs(DefaultConfig) do Config[k] = v end
    AutoSaveConfig()
    SendNotification("Murder Mystery", "Settings reset to defaults!", 2)
end })

-- COMBAT --
CombatTab:Section({ Title = "Sheriff & Gun" })
CombatTab:Toggle({ Title = "Auto Shoot Murderer", Value = Config.AutoShoot, Callback = function(v) Config.AutoShoot = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Silent Aim", Value = Config.SilentAim, Callback = function(v) Config.SilentAim = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Aim Prediction", Value = Config.AimPrediction, Callback = function(v) Config.AimPrediction = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Ping Compensation", Value = Config.PingComp, Callback = function(v) Config.PingComp = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Single Shot Lock", Value = Config.SingleShot, Callback = function(v) Config.SingleShot = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Auto Equip Gun", Value = Config.AutoEquipGun, Callback = function(v) Config.AutoEquipGun = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Full Gun Grabber", Value = Config.GrabGunAuto, Callback = function(v) Config.GrabGunAuto = v; AutoSaveConfig() end })
CombatTab:Slider({ Title = "Gun Grab Distance", Min = 20, Max = 500, Default = Config.GunGrabDist, Callback = function(v) Config.GunGrabDist = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Show FOV Circle", Value = Config.ShowFOV, Callback = function(v) Config.ShowFOV = v; AutoSaveConfig() end })
CombatTab:Slider({ Title = "FOV Radius", Min = 50, Max = 700, Default = Config.FOVRadius, Callback = function(v) Config.FOVRadius = v; AutoSaveConfig() end })

CombatTab:Section({ Title = "Murderer & Knife" })
CombatTab:Toggle({ Title = "Kill Aura", Value = Config.KillAura, Callback = function(v) Config.KillAura = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Auto Kill Innocents", Value = Config.AutoKill, Callback = function(v) Config.AutoKill = v; AutoSaveConfig() end })
CombatTab:Dropdown({ Title = "Kill Mode", Values = { "Legit", "Blatant", "Throw" }, Value = Config.KillMode, Callback = function(v) Config.KillMode = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Knife Silent Aim", Value = Config.KnifeSilentAim, Callback = function(v) Config.KnifeSilentAim = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Kill All (No Limit)", Value = Config.KillAll, Callback = function(v) Config.KillAll = v; AutoSaveConfig() end })
CombatTab:Slider({ Title = "Aura Range", Min = 5, Max = 45, Default = Config.AuraRange, Callback = function(v) Config.AuraRange = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Show Aura Ring", Value = Config.ShowAuraRing, Callback = function(v) Config.ShowAuraRing = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Auto Equip Knife", Value = Config.AutoEquipKnife, Callback = function(v) Config.AutoEquipKnife = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Proximity Knife", Value = Config.ProximityKnife, Callback = function(v) Config.ProximityKnife = v; AutoSaveConfig() end })
CombatTab:Slider({ Title = "Proximity Knife Distance", Min = 5, Max = 50, Default = Config.KnifeProxDist, Callback = function(v) Config.KnifeProxDist = v; AutoSaveConfig() end })

CombatTab:Section({ Title = "Hitbox Expansion & Stalker" })
CombatTab:Toggle({ Title = "Hitbox Expander", Value = Config.HitboxExpander, Callback = function(v)
    Config.HitboxExpander = v
    if not v then
        for part, sz in pairs(originalHitboxSizes) do
            if part and part.Parent then part.Size = sz; part.Transparency = 1 end
        end
        originalHitboxSizes = {}
    end
    AutoSaveConfig()
end })
CombatTab:Slider({ Title = "Hitbox Size", Min = 4, Max = 30, Default = Config.HitboxSize, Callback = function(v) Config.HitboxSize = v; AutoSaveConfig() end })
CombatTab:Slider({ Title = "Hitbox Transparency", Min = 0, Max = 1, Default = Config.HitboxTransparency, Callback = function(v) Config.HitboxTransparency = v; AutoSaveConfig() end })
CombatTab:Toggle({ Title = "Murderer Follow", Value = Config.FollowMurderer, Callback = function(v) Config.FollowMurderer = v; AutoSaveConfig() end })
CombatTab:Slider({ Title = "Follow Offset", Min = 8, Max = 40, Default = Config.FollowDist, Callback = function(v) Config.FollowDist = v; AutoSaveConfig() end })

-- VISUALS --
VisualsTab:Section({ Title = "Full Role ESP" })
VisualsTab:Toggle({ Title = "Role ESP Enabled", Value = Config.RoleESP, Callback = function(v) Config.RoleESP = v; if not v then clearESPCategory("mm2_") end; AutoSaveConfig() end })
VisualsTab:Toggle({ Title = "Chams (3D Highlight)", Value = Config.ESPChams, Callback = function(v) Config.ESPChams = v; if not v then clearESPCategory("cham_") end; AutoSaveConfig() end })
VisualsTab:Toggle({ Title = "Player Boxes", Value = Config.ESPBoxes, Callback = function(v) Config.ESPBoxes = v; AutoSaveConfig() end })
VisualsTab:Toggle({ Title = "Role Tags & Names", Value = Config.ESPNames, Callback = function(v) Config.ESPNames = v; AutoSaveConfig() end })
VisualsTab:Toggle({ Title = "Distance Labels", Value = Config.ESPDistance, Callback = function(v) Config.ESPDistance = v; AutoSaveConfig() end })
VisualsTab:Toggle({ Title = "Snapline Tracers", Value = Config.ESPTracers, Callback = function(v)
    Config.ESPTracers = v
    if not v then for _, line in pairs(trackedTracers) do if line then line.Visible = false end end end
    AutoSaveConfig()
end })
VisualsTab:Slider({ Title = "Max ESP Distance", Min = 50, Max = 1000, Default = Config.ESPDistanceMax, Callback = function(v) Config.ESPDistanceMax = v; AutoSaveConfig() end })

VisualsTab:Section({ Title = "Item & World Highlights" })
VisualsTab:Toggle({ Title = "Dropped Gun ESP", Value = Config.GunESP, Callback = function(v) Config.GunESP = v; if not v then clearESPCategory("gun_") end; AutoSaveConfig() end })
VisualsTab:Toggle({ Title = "Coin ESP", Value = Config.CoinESP, Callback = function(v) Config.CoinESP = v; if not v then clearESPCategory("coin_") end; AutoSaveConfig() end })

-- FARM --
FarmTab:Section({ Title = "Coin Farming" })
FarmTab:Toggle({ Title = "Auto Farm Coins", Value = Config.CoinFarm, Callback = function(v) Config.CoinFarm = v; AutoSaveConfig() end })
FarmTab:Dropdown({ Title = "Movement Method", Values = { "Glide", "Tween", "Walk" }, Value = Config.FarmMethod, Callback = function(v) Config.FarmMethod = v; AutoSaveConfig() end })
FarmTab:Slider({ Title = "Farm Speed", Min = 16, Max = 60, Default = Config.FarmSpeed, Callback = function(v) Config.FarmSpeed = v; AutoSaveConfig() end })
FarmTab:Toggle({ Title = "Safe Farming", Value = Config.SafeCoinFarm, Callback = function(v) Config.SafeCoinFarm = v; AutoSaveConfig() end })
FarmTab:Toggle({ Title = "Bag Full Stop", Value = Config.BagFullStop, Callback = function(v) Config.BagFullStop = v; AutoSaveConfig() end })
FarmTab:Slider({ Title = "Coin Bag Cap", Min = 10, Max = 100, Default = Config.CoinBagCap, Callback = function(v) Config.CoinBagCap = v; AutoSaveConfig() end })
FarmTab:Toggle({ Title = "Quick Mode", Value = Config.QuickFarm, Callback = function(v) Config.QuickFarm = v; AutoSaveConfig() end })

-- SURVIVAL --
SurvivalTab:Section({ Title = "Murderer Avoidance & Auto-Play" })
SurvivalTab:Toggle({ Title = "Murderer Avoidance", Value = Config.MurdererAvoid, Callback = function(v) Config.MurdererAvoid = v; AutoSaveConfig() end })
SurvivalTab:Slider({ Title = "Safety Radius", Min = 20, Max = 80, Default = Config.SafetyRadius, Callback = function(v) Config.SafetyRadius = v; AutoSaveConfig() end })
SurvivalTab:Toggle({ Title = "Retreat to Lobby", Value = Config.RetreatToLobby, Callback = function(v) Config.RetreatToLobby = v; AutoSaveConfig() end })
SurvivalTab:Toggle({ Title = "Proximity Alert", Value = Config.ProximityAlert, Callback = function(v) Config.ProximityAlert = v; AutoSaveConfig() end })
SurvivalTab:Toggle({ Title = "Sprint When Chased", Value = Config.SprintWhenChased, Callback = function(v) Config.SprintWhenChased = v; AutoSaveConfig() end })
SurvivalTab:Toggle({ Title = "Role-Based Auto Play", Value = Config.AutoPlay, Callback = function(v) Config.AutoPlay = v; AutoSaveConfig() end })

-- TELEPORTS --
TeleportsTab:Section({ Title = "Map & Role Navigation" })
TeleportsTab:Button({ Title = "Teleport to Murderer", Callback = TeleportToMurdererAction })
TeleportsTab:Button({ Title = "Teleport to Sheriff", Callback = TeleportToSheriffAction })
TeleportsTab:Button({ Title = "Teleport to Active Map", Callback = TeleportToMapAction })
TeleportsTab:Button({ Title = "Teleport to Lobby", Callback = TeleportToLobbyAction })
TeleportsTab:Toggle({ Title = "Auto Drop at Round Start", Value = Config.AutoDrop, Callback = function(v) Config.AutoDrop = v; AutoSaveConfig() end })

TeleportsTab:Section({ Title = "Saved Coordinates" })
TeleportsTab:Button({ Title = "Save Location 1", Callback = function()
    local root = getRootPart(LocalPlayer.Character)
    if root then Config.SaveSlot1 = root.CFrame; AutoSaveConfig(); SendNotification("Murder Mystery", "Saved Slot 1 position to disk.", 2) end
end })
TeleportsTab:Button({ Title = "Teleport Location 1", Callback = function()
    local root = getRootPart(LocalPlayer.Character)
    if root and Config.SaveSlot1 then root.CFrame = Config.SaveSlot1; SendNotification("Murder Mystery", "Teleported to Slot 1.", 2)
    else SendNotification("Murder Mystery", "No location saved in Slot 1.", 2) end
end })
TeleportsTab:Button({ Title = "Save Location 2", Callback = function()
    local root = getRootPart(LocalPlayer.Character)
    if root then Config.SaveSlot2 = root.CFrame; AutoSaveConfig(); SendNotification("Murder Mystery", "Saved Slot 2 position to disk.", 2) end
end })
TeleportsTab:Button({ Title = "Teleport Location 2", Callback = function()
    local root = getRootPart(LocalPlayer.Character)
    if root and Config.SaveSlot2 then root.CFrame = Config.SaveSlot2; SendNotification("Murder Mystery", "Teleported to Slot 2.", 2)
    else SendNotification("Murder Mystery", "No location saved in Slot 2.", 2) end
end })

-- TROLLING --
TrollingTab:Section({ Title = "Fling" })
TrollingTab:Button({ Title = "Fling Murderer", Callback = FlingMurdererAction })
TrollingTab:Button({ Title = "Fling Sheriff", Callback = FlingSheriffAction })
TrollingTab:Dropdown({ Title = "Fling Style", Values = { "Torque", "Velocity", "Orbit" }, Value = Config.FlingStyle, Callback = function(v) Config.FlingStyle = v; AutoSaveConfig() end })
TrollingTab:Slider({ Title = "Fling Power", Min = 10, Max = 200, Default = Config.FlingPower, Callback = function(v) Config.FlingPower = v; AutoSaveConfig() end })

-- MISC --
MiscTab:Section({ Title = "Movement & Character" })
MiscTab:Toggle({ Title = "Speed Boost", Value = Config.SpeedEnabled, Callback = function(v) Config.SpeedEnabled = v; AutoSaveConfig() end })
MiscTab:Slider({ Title = "Walk Speed", Min = 16, Max = 60, Default = Config.SpeedValue, Callback = function(v) Config.SpeedValue = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Safe Jump Boost", Value = Config.JumpEnabled, Callback = function(v) Config.JumpEnabled = v; AutoSaveConfig() end })
MiscTab:Slider({ Title = "Jump Power", Min = 50, Max = 100, Default = Config.JumpValue, Callback = function(v) Config.JumpValue = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Infinite Jump", Value = Config.InfiniteJump, Callback = function(v) Config.InfiniteJump = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Noclip", Value = Config.Noclip, Callback = function(v) Config.Noclip = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Fly", Value = Config.Fly, Callback = function(v) Config.Fly = v; AutoSaveConfig() end })
MiscTab:Slider({ Title = "Fly Speed", Min = 15, Max = 100, Default = Config.FlySpeed, Callback = function(v) Config.FlySpeed = v; AutoSaveConfig() end })

MiscTab:Section({ Title = "Environment & Safety" })
MiscTab:Toggle({ Title = "Fullbright", Value = Config.Fullbright, Callback = function(v)
    Config.Fullbright = v
    if not v then Lighting.Ambient = Color3.fromRGB(128, 128, 128); Lighting.Brightness = 1 end
    AutoSaveConfig()
end })
MiscTab:Toggle({ Title = "Remove Fog", Value = Config.NoFog, Callback = function(v)
    Config.NoFog = v
    if not v then Lighting.FogEnd = 1000 end
    AutoSaveConfig()
end })
MiscTab:Toggle({ Title = "Disable Particles (Anti-Lag)", Value = Config.DisableParticles, Callback = function(v) Config.DisableParticles = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Anti-Fling", Value = Config.AntiFling, Callback = function(v) Config.AntiFling = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Anti-Void", Value = Config.AntiVoid, Callback = function(v) Config.AntiVoid = v; AutoSaveConfig() end })
MiscTab:Toggle({ Title = "Anti-AFK", Value = Config.AntiAFK, Callback = function(v) Config.AntiAFK = v; AutoSaveConfig() end })
MiscTab:Button({ Title = "Reset Character", Callback = function()
    local hum = getHumanoid(LocalPlayer.Character)
    if hum then hum.Health = 0 end
end })

MiscTab:Section({ Title = "Server Tools" })
MiscTab:Button({ Title = "Rejoin Server", Callback = RejoinServerAction })
MiscTab:Button({ Title = "Server Hop (Random)", Callback = ServerHopRandomAction })
MiscTab:Button({ Title = "Server Hop (Low Player)", Callback = ServerHopLowAction })
MiscTab:Button({ Title = "Unload Script", Callback = function()
    if getgenv().IdenticalMM2Unload then getgenv().IdenticalMM2Unload() end
end })

-- ==========================================
-- ESP, HOOKS & RUNTIME LOOPS
-- ==========================================
local function getOrCreateESP(id, adornee, text, color)
    local bb = trackedESPElements[id]
    if not bb or not bb.Parent then
        bb = Instance.new("BillboardGui")
        bb.Name = id
        bb.Size = UDim2.new(0, 140, 0, 40)
        bb.StudsOffset = Vector3.new(0, 2.5, 0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = Config.ESPDistanceMax
        bb.Adornee = adornee
        bb.Parent = espFolder

        local tag = Instance.new("TextLabel")
        tag.Name = "Tag"
        tag.Size = UDim2.new(1, 0, 1, 0)
        tag.BackgroundTransparency = 1
        tag.Font = Enum.Font.GothamBold
        tag.TextSize = 11
        tag.TextColor3 = color
        tag.TextStrokeTransparency = 0.3
        tag.TextStrokeColor3 = Color3.new(0, 0, 0)
        tag.Parent = bb

        trackedESPElements[id] = bb
    end
    bb.Adornee = adornee
    bb.MaxDistance = Config.ESPDistanceMax
    local tag = bb:FindFirstChild("Tag")
    if tag then
        tag.Text = text
        tag.TextColor3 = color
    end
    return bb
end

local function getOrCreateCham(id, targetChar, color)
    local hl = trackedESPElements["cham_" .. id]
    if not hl or not hl.Parent then
        hl = Instance.new("Highlight")
        hl.Name = "cham_" .. id
        hl.FillColor = color
        hl.OutlineColor = Colors.TextPrimary
        hl.FillTransparency = 0.45
        hl.OutlineTransparency = 0.1
        hl.Adornee = targetChar
        hl.Parent = espFolder
        trackedESPElements["cham_" .. id] = hl
    end
    hl.Adornee = targetChar
    hl.FillColor = color
    return hl
end

local function updateTracer(id, targetPos, color)
    if not Drawing or not Drawing.new then return end
    local line = trackedTracers[id]
    if not line then
        pcall(function()
            line = Drawing.new("Line")
            line.Thickness = 1.5
            line.Transparency = 0.8
            line.Color = color
            trackedTracers[id] = line
        end)
        line = trackedTracers[id]
    end
    if not line then return end

    if Config.ESPTracers then
        local targetFeet = targetPos - Vector3.new(0, 2.5, 0)
        local screenPos, onScreen = Camera:WorldToViewportPoint(targetFeet)
        if onScreen then
            local localChar = LocalPlayer.Character
            local localRoot = getRootPart(localChar)
            local fromPos = nil

            if localRoot then
                local feetWorldPos = localRoot.Position - Vector3.new(0, 2.8, 0)
                local myScreenPos, myOnScreen = Camera:WorldToViewportPoint(feetWorldPos)
                if myOnScreen then
                    fromPos = Vector2.new(myScreenPos.X, myScreenPos.Y)
                end
            end

            if not fromPos then
                fromPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            end

            line.From = fromPos
            line.To = Vector2.new(screenPos.X, screenPos.Y)
            line.Color = color
            line.Visible = true
        else
            line.Visible = false
        end
    else
        line.Visible = false
    end
end

local function removeTracer(id)
    if trackedTracers[id] then
        pcall(function() trackedTracers[id]:Remove() end)
        trackedTracers[id] = nil
    end
end

local function getClosestKnifeTarget()
    local char = LocalPlayer.Character
    local root = getRootPart(char)
    if not root then return nil end

    local mousePos = UserInputService:GetMouseLocation()
    local bestTarget = nil
    local bestDist = math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isPlayerAlive(p) and p.Character then
            local tRoot = getRootPart(p.Character)
            if tRoot then
                local screenPos = Camera:WorldToViewportPoint(tRoot.Position)
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if (not Config.ShowFOV or dist <= Config.FOVRadius) and dist < bestDist then
                    bestDist = dist
                    bestTarget = p
                end
            end
        end
    end

    if not bestTarget then
        local minDist = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and isPlayerAlive(p) and p.Character then
                local tRoot = getRootPart(p.Character)
                if tRoot then
                    local d = (root.Position - tRoot.Position).Magnitude
                    if d < minDist then
                        minDist = d
                        bestTarget = p
                    end
                end
            end
        end
    end

    return bestTarget
end

local silentAimHookActive = true
if hookmetamethod and getnamecallmethod then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()

        if silentAimHookActive and not checkcaller() and method == "FireServer" then
            if self.Name == "KnifeThrown" and (Config.KnifeSilentAim or Config.SilentAim) then
                local args = {...}
                local target = getClosestKnifeTarget()
                if target and target.Character then
                    local tRoot = getRootPart(target.Character)
                    if tRoot then
                        local targetPos = tRoot.Position
                        if Config.AimPrediction then
                            local lead = Config.PingComp and 0.16 or 0.12
                            targetPos = targetPos + (tRoot.AssemblyLinearVelocity * lead)
                        end
                        args[2] = CFrame.new(targetPos)
                        if setnamecallmethod then setnamecallmethod("FireServer") end
                        return oldNamecall(self, unpack(args))
                    end
                end
            elseif self.Name == "Shoot" and Config.SilentAim then
                local args = {...}
                local murderer = nil
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and isPlayerAlive(p) and getPlayerRole(p) == "Murderer" then
                        murderer = p
                        break
                    end
                end
                if murderer and murderer.Character then
                    local mRoot = getRootPart(murderer.Character)
                    if mRoot then
                        local targetPos = mRoot.Position
                        if Config.AimPrediction then
                            local lead = Config.PingComp and 0.16 or 0.12
                            targetPos = targetPos + (mRoot.AssemblyLinearVelocity * lead)
                        end
                        args[2] = CFrame.new(targetPos)
                        if setnamecallmethod then setnamecallmethod("FireServer") end
                        return oldNamecall(self, unpack(args))
                    end
                end
            end
        end

        if setnamecallmethod then setnamecallmethod(method) end
        return oldNamecall(self, ...)
    end))
end

local lastFarmTick = 0
local lastShootTick = 0
local lastKnifeTick = 0
local lastSafePosition = nil
local roundStartedFlag = false
local auraRingPart = nil
local auraRingGui = nil
local fovCircle = nil

if Drawing and Drawing.new then
    pcall(function()
        local d = Drawing
        fovCircle = d.new("Circle")
        fovCircle.Thickness = 1.5
        fovCircle.Color = Colors.PurpleAccent
        fovCircle.Filled = false
        fovCircle.Transparency = 0.8
        fovCircle.Visible = false
    end)
end

local function updateAuraRing(root)
    if not Config.ShowAuraRing or not root then
        if auraRingPart then
            auraRingPart.Transparency = 1
            if auraRingGui then auraRingGui.Enabled = false end
        end
        return
    end

    local diameter = Config.AuraRange * 2

    if not auraRingPart or not auraRingPart.Parent then
        auraRingPart = Instance.new("Part")
        auraRingPart.Name = "MurderMystery_AuraRing"
        auraRingPart.Size = Vector3.new(diameter, 0.01, diameter)
        auraRingPart.Anchored = true
        auraRingPart.CanCollide = false
        auraRingPart.CastShadow = false
        auraRingPart.Transparency = 1

        auraRingGui = Instance.new("SurfaceGui")
        auraRingGui.Name = "RingGui"
        auraRingGui.Face = Enum.NormalId.Top
        auraRingGui.AlwaysOnTop = true
        auraRingGui.LightInfluence = 0
        auraRingGui.Adornee = auraRingPart
        auraRingGui.Parent = auraRingPart

        local ringFrame = Instance.new("Frame")
        ringFrame.Name = "Circle"
        ringFrame.Size = UDim2.new(1, 0, 1, 0)
        ringFrame.BackgroundColor3 = Colors.PurpleAccent
        ringFrame.BackgroundTransparency = 0.92
        ringFrame.BorderSizePixel = 0
        ringFrame.Parent = auraRingGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = ringFrame

        local stroke = Instance.new("UIStroke")
        stroke.Color = Colors.PurpleAccent
        stroke.Thickness = 2.5
        stroke.Transparency = 0.1
        stroke.Parent = ringFrame

        auraRingPart.Parent = Workspace
    end

    if auraRingGui then auraRingGui.Enabled = true end
    auraRingPart.Size = Vector3.new(diameter, 0.01, diameter)
    auraRingPart.CFrame = CFrame.new(root.Position.X, root.Position.Y - 2.85, root.Position.Z)
end

local function updateFOVCircle()
    if not fovCircle then return end
    if Config.ShowFOV then
        fovCircle.Visible = true
        fovCircle.Radius = Config.FOVRadius
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        fovCircle.Visible = false
    end
end

trackConn(RunService.Stepped:Connect(function()
    if Config.AntiFling and not isFlinging then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end))

trackConn(RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local root = getRootPart(char)
    local hum = getHumanoid(char)
    local now = tick()

    updateAuraRing(root)
    updateFOVCircle()

    if root and hum then
        local vel = root.AssemblyLinearVelocity
        local angVel = root.AssemblyAngularVelocity
        local velMag = vel.Magnitude
        local angMag = angVel.Magnitude

        if not isFlinging and hum.Health > 0 and hum.FloorMaterial ~= Enum.Material.Air and velMag < 75 and angMag < 35 then
            lastSafePosition = root.CFrame
        end

        if not isFlinging and (Config.AntiFling or Config.AntiVoid) and lastSafePosition then
            if velMag > 120 or angMag > 90 then
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = lastSafePosition
            end

            if Config.AntiVoid and (lastSafePosition.Y - root.Position.Y > 30) then
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = lastSafePosition
            end
        end
    end

    if hum then
        if Config.SpeedEnabled then
            if hum.WalkSpeed ~= Config.SpeedValue then hum.WalkSpeed = Config.SpeedValue end
        else
            if hum.WalkSpeed ~= 16 and not Config.CoinFarm then hum.WalkSpeed = 16 end
        end

        if Config.JumpEnabled then
            if hum.JumpPower ~= Config.JumpValue then hum.JumpPower = Config.JumpValue end
        end
    end

    if Config.Noclip and char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then
                p.CanCollide = false
            end
        end
    end

    if Config.Fullbright then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
    end

    if Config.NoFog then
        Lighting.FogEnd = 1e6
    end

    local rtp = Workspace:FindFirstChild("RoundTimerPart")
    if rtp and rtp:FindFirstChild("SurfaceGui") then
        local sg = rtp.SurfaceGui
        local cr = sg:FindFirstChild("CurrentRound")
        if cr and cr.Text == "Current Round" and not roundStartedFlag then
            roundStartedFlag = true
            if Config.AutoDrop then
                local map = getActiveMap()
                if map and root then
                    local p = map:FindFirstChild("Spawns") or map:FindFirstChildWhichIsA("BasePart")
                    if p then
                        local sp = p:IsA("Model") and p:GetChildren()[1] or p
                        if sp then root.CFrame = sp.CFrame * CFrame.new(0, 4, 0) end
                    end
                end
            end
        elseif cr and cr.Text ~= "Current Round" then
            roundStartedFlag = false
        end
    end

    local murderer, sheriff = getRolePlayers()

    if Config.RoleESP and root then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and isPlayerAlive(p) then
                local pRoot = getRootPart(p.Character)
                if pRoot then
                    local dist = math.floor((root.Position - pRoot.Position).Magnitude)
                    if dist <= Config.ESPDistanceMax then
                        local role = getPlayerRole(p)
                        local col = Colors.AccentGreen
                        if role == "Murderer" then
                            col = Colors.AccentRed
                        elseif role == "Sheriff" then
                            col = Colors.AccentBlue
                        end

                        local text = p.Name
                        if Config.ESPNames then
                            text = "[" .. role .. "] " .. p.Name
                        end
                        if Config.ESPDistance then
                            text = text .. " (" .. dist .. "s)"
                        end

                        getOrCreateESP("mm2_" .. p.UserId, pRoot, text, col)
                        if Config.ESPChams then
                            getOrCreateCham(p.UserId, p.Character, col)
                        end
                        updateTracer("mm2_" .. p.UserId, pRoot.Position, col)
                    end
                end
            else
                if trackedESPElements["mm2_" .. p.UserId] then
                    trackedESPElements["mm2_" .. p.UserId]:Destroy()
                    trackedESPElements["mm2_" .. p.UserId] = nil
                end
                if trackedESPElements["cham_" .. p.UserId] then
                    trackedESPElements["cham_" .. p.UserId]:Destroy()
                    trackedESPElements["cham_" .. p.UserId] = nil
                end
                removeTracer("mm2_" .. p.UserId)
            end
        end
    end

    if Config.GunESP and root then
        local drop = getGunDrop()
        local gunPart = getGunDropPart(drop)
        if gunPart then
            local dist = math.floor((root.Position - gunPart.Position).Magnitude)
            if dist <= Config.ESPDistanceMax then
                getOrCreateESP("gun_drop", gunPart, "[GUN DROP] " .. dist .. "m", Colors.AccentYellow)
            end
        else
            clearESPCategory("gun_")
        end
    end

    if Config.CoinESP and root then
        local coins = getAllActiveCoins()
        for _, coin in ipairs(coins) do
            local dist = math.floor((root.Position - coin.Position).Magnitude)
            if dist <= Config.ESPDistanceMax then
                getOrCreateESP("coin_" .. coin:GetDebugId(), coin, "Coin", Colors.AccentYellow)
            end
        end
    end

    if Config.GrabGunAuto and root then
        local drop = getGunDrop()
        local gunPart = getGunDropPart(drop)
        if gunPart and (root.Position - gunPart.Position).Magnitude <= Config.GunGrabDist then
            interactWithGunDrop(gunPart, drop)
        end
    end

    if Config.AutoShoot and root and (now - lastShootTick >= 0.5) then
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local gun = (bp and bp:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun"))
        if gun and murderer and murderer.Character and isPlayerAlive(murderer) then
            local mRoot = getRootPart(murderer.Character)
            if mRoot then
                if hum and bp and gun.Parent == bp then
                    hum:EquipTool(gun)
                end
                local rayAtt = root:FindFirstChild("GunRaycastAttachment")
                local origin = rayAtt and rayAtt.WorldCFrame or root.CFrame
                local aimPos = mRoot.Position
                if Config.AimPrediction then
                    aimPos = aimPos + (mRoot.AssemblyLinearVelocity * 0.12)
                end
                if gun:FindFirstChild("Shoot") then
                    gun.Shoot:FireServer(origin, CFrame.new(aimPos))
                    lastShootTick = now
                    if Config.SingleShot then Config.AutoShoot = false end
                end
            end
        end
    end

    if (Config.KillAura or Config.AutoKill) and root and (now - lastKnifeTick >= 0.2) then
        local bp = LocalPlayer:FindFirstChild("Backpack")
        local knife = (bp and bp:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))
        if knife then
            if hum and bp and knife.Parent == bp then
                hum:EquipTool(knife)
            end
            local events = knife:FindFirstChild("Events")
            if events then
                if Config.KillMode == "Throw" and events:FindFirstChild("KnifeThrown") and knife:FindFirstChild("Handle") then
                    local target = getClosestKnifeTarget()
                    if target and target.Character then
                        local tRoot = getRootPart(target.Character)
                        if tRoot then
                            local d = (root.Position - tRoot.Position).Magnitude
                            if Config.KillAll or d <= Config.AuraRange then
                                local targetPos = tRoot.Position
                                if Config.AimPrediction then
                                    local lead = Config.PingComp and 0.16 or 0.12
                                    targetPos = targetPos + (tRoot.AssemblyLinearVelocity * lead)
                                end
                                events.KnifeThrown:FireServer(knife.Handle.CFrame, CFrame.new(targetPos))
                                lastKnifeTick = now
                            end
                        end
                    end
                elseif events:FindFirstChild("HandleTouched") then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and isPlayerAlive(p) then
                            local tRoot = getRootPart(p.Character)
                            if tRoot then
                                local d = (root.Position - tRoot.Position).Magnitude
                                if Config.KillAll or d <= Config.AuraRange then
                                    events.HandleTouched:FireServer(tRoot)
                                    if events:FindFirstChild("KnifeStabbed") then
                                        events.KnifeStabbed:FireServer()
                                    end
                                    lastKnifeTick = now
                                    if not Config.KillAll then
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if Config.HitboxExpander then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and isPlayerAlive(p) then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if not originalHitboxSizes[hrp] then
                        originalHitboxSizes[hrp] = hrp.Size
                    end
                    hrp.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                    hrp.Transparency = Config.HitboxTransparency
                    hrp.CanCollide = false
                end
            end
        end
    end

    if Config.MurdererAvoid and root and murderer and murderer.Character and isPlayerAlive(murderer) then
        local mRoot = getRootPart(murderer.Character)
        if mRoot then
            local dist = (root.Position - mRoot.Position).Magnitude
            if dist < Config.SafetyRadius then
                if Config.SprintWhenChased and hum then
                    hum.WalkSpeed = math.max(hum.WalkSpeed, 26)
                end
                if Config.RetreatToLobby then
                    local lobby = getLobbyModel()
                    if lobby then
                        local sp = lobby:FindFirstChildWhichIsA("BasePart")
                        if sp then root.CFrame = sp.CFrame * CFrame.new(0, 3, 0) end
                    end
                else
                    local awayDir = (root.Position - mRoot.Position).Unit
                    root.CFrame = root.CFrame + Vector3.new(awayDir.X * 0.8, 0, awayDir.Z * 0.8)
                end
            end
        end
    end

    if Config.FollowMurderer and root and murderer and murderer.Character and isPlayerAlive(murderer) then
        local mRoot = getRootPart(murderer.Character)
        if mRoot then
            local targetPos = mRoot.Position - (mRoot.CFrame.LookVector * Config.FollowDist)
            root.CFrame = root.CFrame:Lerp(CFrame.new(targetPos, mRoot.Position), 0.15)
        end
    end

    if Config.CoinFarm and root and (now - lastFarmTick >= 0.05) then
        if Config.BagFullStop and getCurrentCoinCount() >= Config.CoinBagCap then
            Config.CoinFarm = false
            SendNotification("Murder Mystery", "Coin bag limit reached! Farming stopped.", 3)
        else
            local coins = getAllActiveCoins()
            local bestCoin = nil
            local bestDist = 1000

            for _, c in ipairs(coins) do
                local d = (root.Position - c.Position).Magnitude
                local isSafe = true
                if Config.SafeCoinFarm and murderer and murderer.Character and isPlayerAlive(murderer) then
                    local mRoot = getRootPart(murderer.Character)
                    if mRoot and (c.Position - mRoot.Position).Magnitude < Config.SafetyRadius then
                        isSafe = false
                    end
                end
                if isSafe and d < bestDist then
                    bestDist = d
                    bestCoin = c
                end
            end

            if bestCoin then
                if hum then
                    hum.WalkSpeed = Config.FarmSpeed
                end
                local targetPos = bestCoin.Position
                local dist = (root.Position - targetPos).Magnitude

                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end

                local speed = Config.QuickFarm and 38 or math.clamp(Config.FarmSpeed, 16, 42)

                if Config.FarmMethod == "Tween" then
                    local travelTime = math.max(dist / speed, 0.05)
                    local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
                    local tw = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos)})
                    tw:Play()
                    if dist < 7 then
                        fireTouch(root, bestCoin)
                        local rHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
                        if rHand then fireTouch(rHand, bestCoin) end
                    end
                elseif Config.FarmMethod == "Glide" or Config.QuickFarm then
                    local dir = (targetPos - root.Position)
                    if dir.Magnitude > 0.3 then
                        root.AssemblyLinearVelocity = dir.Unit * speed
                    else
                        root.AssemblyLinearVelocity = Vector3.zero
                    end
                    if dist < 7 then
                        fireTouch(root, bestCoin)
                        local rHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
                        if rHand then fireTouch(rHand, bestCoin) end
                    end
                else
                    if hum then
                        hum:MoveTo(targetPos)
                        if targetPos.Y > root.Position.Y + 2.0 and hum:GetState() ~= Enum.HumanoidStateType.Jumping then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                    if dist < 7 then
                        fireTouch(root, bestCoin)
                        local rHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
                        if rHand then fireTouch(rHand, bestCoin) end
                    end
                end
                lastFarmTick = now
            end
        end
    end
end))

trackConn(UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.End then
        Config.KillAura = false
        Config.AutoShoot = false
        Config.CoinFarm = false
        Config.AutoKill = false
        SendNotification("Murder Mystery", "EMERGENCY STOP: Features halted.", 2)
    elseif input.KeyCode == Enum.KeyCode.Space and Config.InfiniteJump then
        local hum = getHumanoid(LocalPlayer.Character)
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

local function hookPlayerDeath(p)
    trackConn(p.CharacterAdded:Connect(function(c)
        local h = c:WaitForChild("Humanoid", 5)
        if h then
            trackConn(h.Died:Connect(function()
                table.insert(deadPlayersList, p.Name)
                if Config.DeathNotifs then
                    local r = getPlayerRole(p)
                    SendNotification("Death Alert", p.Name .. " [" .. r .. "] has died!", 3)
                end
            end))
        end
    end))
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        hookPlayerDeath(p)
    end
end

trackConn(Players.PlayerAdded:Connect(function(p)
    hookPlayerDeath(p)
end))

trackConn(LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end
end))

getgenv().IdenticalMM2Unload = function()
    for _, conn in ipairs(activeConnections) do
        pcall(function() conn:Disconnect() end)
    end
    activeConnections = {}
    clearESPCategory("")
    for id in pairs(trackedTracers) do
        pcall(function() trackedTracers[id]:Remove() end)
    end
    trackedTracers = {}
    silentAimHookActive = false
    if auraRingPart then
        auraRingPart:Destroy()
        auraRingPart = nil
    end
    if fovCircle then
        pcall(function() fovCircle:Remove() end)
        fovCircle = nil
    end
    for part, sz in pairs(originalHitboxSizes) do
        if part and part.Parent then
            part.Size = sz
            part.Transparency = 1
        end
    end
    originalHitboxSizes = {}
    if Window and Window.Destroy then
        pcall(function() Window:Destroy() end)
    end
    getgenv().IdenticalMM2Unload = nil
end

SendNotification("Murder Mystery", "Loaded with WindUI!", 3)
