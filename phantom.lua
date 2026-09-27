-- =========================================================================
-- [ PASTEHUB - FULL BUILD | RAINBOW CUBE + TRACERS + GRENADE ESP + WEAPON ESP ]
-- [ BloxStrike Edition ]
-- =========================================================================

if _G.__PASTEHUB_FULLBUILD_INJECTED__ then
    local oldUnload = _G.__PASTEHUB_FULLBUILD_UNLOAD__
    if oldUnload then
        pcall(oldUnload)
    else
        return
    end
end
_G.__PASTEHUB_FULLBUILD_INJECTED__ = true

do
-- ============================================================
-- 🎬 GAMESENSE FUNK EDIT — БЕЗ LOADING В КОНЦЕ
-- ============================================================
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local MUSIC_ID = 126400067778923
local START_AT = 60
local DURATION = 15
local VOLUME = 3
local BEAT = 0.5

local BANNER_TOP = "game"
local BANNER_BOT = "sense"
local TAG_TOP = "[ FUNK EDIT ]"
local AUTHOR = "produced by volne.xyz"

local C = {
    bg = Color3.fromRGB(3, 3, 5),
    wht = Color3.fromRGB(255, 255, 255),
    green = Color3.fromRGB(118, 212, 0),
    greenHi = Color3.fromRGB(220, 255, 120),
    red = Color3.fromRGB(255, 20, 70),
    blue = Color3.fromRGB(0, 200, 255),
    gry = Color3.fromRGB(70, 70, 78),
}

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://" .. MUSIC_ID
sound.Volume = VOLUME
sound.Looped = false
sound.Parent = SoundService
sound.Loaded:Connect(function() sound.TimePosition = START_AT end)
sound:Play()

-- ТРЯСКА КАМЕРЫ
local shakeIntensity = 0
local shakeEnabled = true
task.spawn(function()
    RunService.RenderStepped:Connect(function(dt)
        if not shakeEnabled or shakeIntensity <= 0 then return end
        if not Camera then return end
        local sx = (math.random() - 0.5) * shakeIntensity
        local sy = (math.random() - 0.5) * shakeIntensity
        local sr = (math.random() - 0.5) * shakeIntensity * 0.5
        Camera.CFrame = Camera.CFrame * CFrame.new(sx, sy, 0) * CFrame.Angles(0, 0, math.rad(sr))
        shakeIntensity = shakeIntensity * 0.85
        if shakeIntensity < 0.02 then shakeIntensity = 0 end
    end)
end)
local function doCameraShake(intensity)
    shakeIntensity = math.max(shakeIntensity, intensity)
end

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "FunkEditClean"
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.IgnoreGuiInset = true
pcall(function() sg.Parent = game:GetService("CoreGui") end)
if not sg.Parent then sg.Parent = LP:WaitForChild("PlayerGui") end

local function TW(o, p, t, st, dir)
    local tw = TweenService:Create(o, TweenInfo.new(t or 0.2, st or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), p)
    tw:Play()
    return tw
end

local shake = Instance.new("Frame", sg)
shake.Size = UDim2.new(1, 0, 1, 0)
shake.BackgroundTransparency = 1
shake.ZIndex = 2

-- ФОН
local dim = Instance.new("Frame", shake)
dim.Size = UDim2.new(1, 0, 1, 0)
dim.BackgroundColor3 = Color3.new(0, 0, 0)
dim.BackgroundTransparency = 1
dim.BorderSizePixel = 0
dim.ZIndex = 1
TW(dim, {BackgroundTransparency = 0.4}, 0.3)

-- СЕТКА
local gridHolder = Instance.new("Frame", shake)
gridHolder.Size = UDim2.new(1, 0, 1, 0)
gridHolder.BackgroundTransparency = 1
gridHolder.ZIndex = 2
for i = 0, 40 do
    local vline = Instance.new("Frame", gridHolder)
    vline.Size = UDim2.new(0, 1, 1, 0)
    vline.Position = UDim2.new(i / 40, 0, 0, 0)
    vline.BackgroundColor3 = C.green
    vline.BackgroundTransparency = 0.92
    vline.BorderSizePixel = 0
    vline.ZIndex = 2
end
for i = 0, 25 do
    local hline = Instance.new("Frame", gridHolder)
    hline.Size = UDim2.new(1, 0, 0, 1)
    hline.Position = UDim2.new(0, 0, i / 25, 0)
    hline.BackgroundColor3 = C.green
    hline.BackgroundTransparency = 0.92
    hline.BorderSizePixel = 0
    hline.ZIndex = 2
end

-- ВИНЬЕТКА
local vignette = Instance.new("ImageLabel", shake)
vignette.Size = UDim2.new(1, 0, 1, 0)
vignette.BackgroundTransparency = 1
vignette.Image = "rbxassetid://8992230677"
vignette.ImageColor3 = Color3.new(0, 0, 0)
vignette.ImageTransparency = 1
vignette.ScaleType = Enum.ScaleType.Stretch
vignette.ZIndex = 3
TW(vignette, {ImageTransparency = 0.25}, 0.5)

-- ШУМ
local noise = Instance.new("ImageLabel", shake)
noise.Size = UDim2.new(1, 0, 1, 0)
noise.BackgroundTransparency = 1
noise.Image = "rbxassetid://5028857472"
noise.ImageColor3 = Color3.new(1, 1, 1)
noise.ImageTransparency = 1
noise.ScaleType = Enum.ScaleType.Tile
noise.TileSize = UDim2.new(0, 200, 0, 200)
noise.ZIndex = 4
TW(noise, {ImageTransparency = 0.85}, 0.5)
task.spawn(function()
    while sg.Parent do
        noise.Position = UDim2.new(math.random(-20, 20) / 100, 0, math.random(-20, 20) / 100, 0)
        task.wait(0.05)
    end
end)

-- СКАНЛАЙНЫ
local scanHolder = Instance.new("Frame", shake)
scanHolder.Size = UDim2.new(1, 0, 1, 0)
scanHolder.BackgroundTransparency = 1
scanHolder.ZIndex = 5
for y = 0, 130 do
    local line = Instance.new("Frame", scanHolder)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, y / 130, 0)
    line.BackgroundColor3 = Color3.new(0, 0, 0)
    line.BackgroundTransparency = 0.88
    line.BorderSizePixel = 0
    line.ZIndex = 5
end

-- ЛОГО
local logoHolder = Instance.new("Frame", shake)
logoHolder.Size = UDim2.new(0, 900, 0, 200)
logoHolder.Position = UDim2.new(0.5, -450, 0.5, -100)
logoHolder.BackgroundTransparency = 1
logoHolder.ZIndex = 10

local gameLbl = Instance.new("TextLabel", logoHolder)
gameLbl.Size = UDim2.new(0.5, 0, 1, 0)
gameLbl.BackgroundTransparency = 1
gameLbl.Text = BANNER_TOP
gameLbl.TextColor3 = C.wht
gameLbl.Font = Enum.Font.GothamBlack
gameLbl.TextSize = 130
gameLbl.TextXAlignment = Enum.TextXAlignment.Right
gameLbl.ZIndex = 20
gameLbl.TextTransparency = 1

local senseLbl = Instance.new("TextLabel", logoHolder)
senseLbl.Size = UDim2.new(0.5, 0, 1, 0)
senseLbl.Position = UDim2.new(0.5, 0, 0, 0)
senseLbl.BackgroundTransparency = 1
senseLbl.Text = BANNER_BOT
senseLbl.TextColor3 = C.green
senseLbl.Font = Enum.Font.GothamBlack
senseLbl.TextSize = 130
senseLbl.TextXAlignment = Enum.TextXAlignment.Left
senseLbl.ZIndex = 20
senseLbl.TextTransparency = 1

for depth = 5, 1, -1 do
    local g3d = gameLbl:Clone()
    g3d.TextColor3 = Color3.new(0, 0, 0)
    g3d.Position = UDim2.new(0, depth, 0, depth)
    g3d.ZIndex = 19
    g3d.TextTransparency = 1
    g3d.Name = "Depth" .. depth
    g3d.Parent = logoHolder
    local s3d = senseLbl:Clone()
    s3d.TextColor3 = Color3.new(0, 0, 0)
    s3d.Position = UDim2.new(0.5, depth, 0, depth)
    s3d.ZIndex = 19
    s3d.TextTransparency = 1
    s3d.Name = "Depth" .. depth
    s3d.Parent = logoHolder
end

local gameRed = gameLbl:Clone(); gameRed.TextColor3 = C.red;  gameRed.ZIndex = 18; gameRed.Parent = logoHolder
local gameBlue = gameLbl:Clone(); gameBlue.TextColor3 = C.blue; gameBlue.ZIndex = 18; gameBlue.Parent = logoHolder
local senseRed = senseLbl:Clone(); senseRed.TextColor3 = C.red;  senseRed.ZIndex = 18; senseRed.Parent = logoHolder
local senseBlue = senseLbl:Clone(); senseBlue.TextColor3 = C.blue; senseBlue.ZIndex = 18; senseBlue.Parent = logoHolder

local underline = Instance.new("Frame", logoHolder)
underline.Size = UDim2.new(0, 0, 0, 3)
underline.Position = UDim2.new(0.5, 0, 1, -15)
underline.AnchorPoint = Vector2.new(0.5, 0.5)
underline.BackgroundColor3 = C.green
underline.BorderSizePixel = 0
underline.ZIndex = 21

local tagLbl = Instance.new("TextLabel", shake)
tagLbl.Size = UDim2.new(1, 0, 0, 24)
tagLbl.Position = UDim2.new(0.5, 0, 0.5, 125)
tagLbl.AnchorPoint = Vector2.new(0.5, 0.5)
tagLbl.BackgroundTransparency = 1
tagLbl.Text = TAG_TOP
tagLbl.TextColor3 = C.gry
tagLbl.Font = Enum.Font.Code
tagLbl.TextSize = 18
tagLbl.ZIndex = 10
tagLbl.TextTransparency = 1

local authLbl = Instance.new("TextLabel", shake)
authLbl.Size = UDim2.new(0, 400, 0, 20)
authLbl.Position = UDim2.new(0.5, 0, 0.5, 155)
authLbl.AnchorPoint = Vector2.new(0.5, 0.5)
authLbl.BackgroundTransparency = 1
authLbl.Text = AUTHOR
authLbl.TextColor3 = C.green
authLbl.Font = Enum.Font.Code
authLbl.TextSize = 13
authLbl.ZIndex = 10
authLbl.TextTransparency = 1

local flash = Instance.new("Frame", shake)
flash.Size = UDim2.new(1, 0, 1, 0)
flash.BackgroundColor3 = C.green
flash.BackgroundTransparency = 1
flash.BorderSizePixel = 0
flash.ZIndex = 100

-- ЧАСТИЦЫ
local particleHolder = Instance.new("Frame", shake)
particleHolder.Size = UDim2.new(1, 0, 1, 0)
particleHolder.BackgroundTransparency = 1
particleHolder.ZIndex = 8

local particles = {}
for i = 1, 15 do
    local p = Instance.new("Frame", particleHolder)
    p.Size = UDim2.new(0, 4, 0, 4)
    p.Position = UDim2.new(0.5, 0, 0.5, 0)
    p.AnchorPoint = Vector2.new(0.5, 0.5)
    p.BackgroundColor3 = i % 2 == 0 and C.green or C.greenHi
    p.BorderSizePixel = 0
    p.BackgroundTransparency = 1
    p.ZIndex = 8
    local c = Instance.new("UICorner", p)
    c.CornerRadius = UDim.new(1, 0)
    particles[i] = p
end

local function burstParticles(count)
    count = count or 10
    for i = 1, count do
        local p = particles[i]
        if not p then continue end
        local angle = math.random() * math.pi * 2
        local dist = 120 + math.random() * 150
        p.Position = UDim2.new(0.5, 0, 0.5, 0)
        p.BackgroundTransparency = 0
        local sz = math.random(3, 6)
        p.Size = UDim2.new(0, sz, 0, sz)
        TW(p, {
            Position = UDim2.new(0.5, math.cos(angle) * dist, 0.5, math.sin(angle) * dist),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 1, 0, 1)
        }, 0.6, Enum.EasingStyle.Quint)
    end
end

-- ПОЯВЛЕНИЕ
task.spawn(function()
    task.wait(0.1)
    gameLbl.Position = UDim2.new(0, -120, 0, 0)
    senseLbl.Position = UDim2.new(0.5, 120, 0, 0)
    TW(gameLbl, {Position = UDim2.new(0, 0, 0, 0), TextTransparency = 0}, 0.45, Enum.EasingStyle.Back)
    TW(senseLbl, {Position = UDim2.new(0.5, 0, 0, 0), TextTransparency = 0}, 0.45, Enum.EasingStyle.Back)
    for _, ch in ipairs(logoHolder:GetChildren()) do
        if ch.Name:sub(1, 5) == "Depth" then
            TW(ch, {TextTransparency = 0}, 0.45, Enum.EasingStyle.Back)
        end
    end
    doCameraShake(3)
    task.wait(0.3)
    flash.BackgroundTransparency = 0.3
    TW(flash, {BackgroundTransparency = 1}, 0.35)
    task.wait(0.2)
    TW(underline, {Size = UDim2.new(0.7, 0, 0, 3)}, 0.45, Enum.EasingStyle.Quint)
    TW(tagLbl, {TextTransparency = 0}, 0.3)
    TW(authLbl, {TextTransparency = 0.3}, 0.3)
end)

-- БИТ-УДАРЫ
task.spawn(function()
    task.wait(0.9)
    while sg.Parent do
        gameRed.Position = UDim2.new(0, 22, 0, -5)
        gameBlue.Position = UDim2.new(0, -22, 0, 5)
        senseRed.Position = UDim2.new(0.5, 22, 0, -5)
        senseBlue.Position = UDim2.new(0.5, -22, 0, 5)
        gameRed.TextTransparency = 0.1
        gameBlue.TextTransparency = 0.1
        senseRed.TextTransparency = 0.1
        senseBlue.TextTransparency = 0.1
        logoHolder.Position = UDim2.new(0.5, -450 + math.random(-10, 10), 0.5, -100 + math.random(-6, 6))
        gameLbl.TextSize = 148
        senseLbl.TextSize = 148
        flash.BackgroundTransparency = 0.82
        flash.BackgroundColor3 = (math.random() > 0.5) and C.green or C.greenHi
        burstParticles(10)
        doCameraShake(3)
        task.wait(0.06)
        TW(gameRed, {Position = UDim2.new(0, 10, 0, -2), TextTransparency = 0.5}, 0.15)
        TW(gameBlue, {Position = UDim2.new(0, -10, 0, 2), TextTransparency = 0.5}, 0.15)
        TW(senseRed, {Position = UDim2.new(0.5, 10, 0, -2), TextTransparency = 0.5}, 0.15)
        TW(senseBlue, {Position = UDim2.new(0.5, -10, 0, 2), TextTransparency = 0.5}, 0.15)
        TW(logoHolder, {Position = UDim2.new(0.5, -450, 0.5, -100)}, 0.15, Enum.EasingStyle.Back)
        TW(gameLbl, {TextSize = 130}, 0.15, Enum.EasingStyle.Back)
        TW(senseLbl, {TextSize = 130}, 0.15, Enum.EasingStyle.Back)
        TW(flash, {BackgroundTransparency = 1}, 0.15)
        task.wait(BEAT - 0.06)
    end
end)

task.spawn(function()
    while sg.Parent do
        TW(underline, {BackgroundColor3 = C.greenHi}, 0.25)
        task.wait(0.25)
        TW(underline, {BackgroundColor3 = C.green}, 0.25)
        task.wait(0.25)
    end
end)

task.spawn(function()
    task.wait(1)
    while sg.Parent do
        TW(gameLbl, {Position = UDim2.new(0, 0, 0, -4)}, 0.35, Enum.EasingStyle.Sine)
        TW(senseLbl, {Position = UDim2.new(0.5, 0, 0, 4)}, 0.35, Enum.EasingStyle.Sine)
        task.wait(0.35)
        TW(gameLbl, {Position = UDim2.new(0, 0, 0, 4)}, 0.35, Enum.EasingStyle.Sine)
        TW(senseLbl, {Position = UDim2.new(0.5, 0, 0, -4)}, 0.35, Enum.EasingStyle.Sine)
        task.wait(0.35)
    end
end)

-- ФИНАЛ — просто взрыв и исчезновение (без loading)
task.spawn(function()
    task.wait(DURATION - 1.5)

    -- Финальный взрыв
    flash.BackgroundTransparency = 0.15
    flash.BackgroundColor3 = C.greenHi
    TW(flash, {BackgroundTransparency = 1}, 0.7)
    gameLbl.TextSize = 200
    senseLbl.TextSize = 200
    doCameraShake(15)
    burstParticles(15)

    task.wait(0.25)

    -- Разлёт + затухание
    TW(gameLbl, {Position = UDim2.new(0, -300, 0, 0), TextTransparency = 1, TextSize = 130}, 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TW(senseLbl, {Position = UDim2.new(0.5, 300, 0, 0), TextTransparency = 1, TextSize = 130}, 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TW(gameRed, {Position = UDim2.new(0, -320, 0, 0), TextTransparency = 1}, 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TW(gameBlue, {Position = UDim2.new(0, -280, 0, 0), TextTransparency = 1}, 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TW(senseRed, {Position = UDim2.new(0.5, 280, 0, 0), TextTransparency = 1}, 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TW(senseBlue, {Position = UDim2.new(0.5, 320, 0, 0), TextTransparency = 1}, 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    for _, ch in ipairs(logoHolder:GetChildren()) do
        if ch.Name:sub(1, 5) == "Depth" then
            TW(ch, {TextTransparency = 1}, 0.6)
        end
    end
    TW(underline, {Size = UDim2.new(0, 0, 0, 3)}, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TW(tagLbl, {TextTransparency = 1}, 0.4)
    TW(authLbl, {TextTransparency = 1}, 0.4)
    TW(noise, {ImageTransparency = 1}, 0.6)
    TW(vignette, {ImageTransparency = 1}, 0.7)
    TW(dim, {BackgroundTransparency = 1}, 0.7)

    task.wait(0.9)
    shakeEnabled = false
    sg:Destroy()

end)

task.delay(DURATION, function()
    sound:Stop()
    sound:Destroy()
    shakeEnabled = false
end)
end
local MaterialLimits = {
    [Enum.Material.Asphalt] = 0.25,
    [Enum.Material.Basalt] = 0.25,
    [Enum.Material.Brick] = 0.25,
    [Enum.Material.Cobblestone] = 0.25,
    [Enum.Material.Concrete] = 0.25,
    [Enum.Material.CrackedLava] = 0.25,
    [Enum.Material.DiamondPlate] = 0.25,
    [Enum.Material.Foil] = 0.25,
    [Enum.Material.Glacier] = 0.25,
    [Enum.Material.Granite] = 0.25,
    [Enum.Material.Grass] = 0.25,
    [Enum.Material.Ground] = 0.25,
    [Enum.Material.Ice] = 0.25,
    [Enum.Material.LeafyGrass] = 0.25,
    [Enum.Material.Limestone] = 0.25,
    [Enum.Material.Marble] = 0.25,
    [Enum.Material.Metal] = 0.25,
    [Enum.Material.Mud] = 0.25,
    [Enum.Material.Pavement] = 0.25,
    [Enum.Material.Rock] = 0.25,
    [Enum.Material.Salt] = 0.25,
    [Enum.Material.Sand] = 0.25,
    [Enum.Material.Sandstone] = 0.25,
    [Enum.Material.Slate] = 0.25,
    [Enum.Material.Snow] = 0.25,
    [Enum.Material.ForceField] = 0.25,
    [Enum.Material.Neon] = 0.25,
    [Enum.Material.CorrodedMetal] = 0.25,
    [Enum.Material.Pebble] = 0.25,
    [Enum.Material.CeramicTiles] = 0.25,
    [Enum.Material.Plaster] = 0.25,
    [Enum.Material.Plastic] = 7,
    [Enum.Material.SmoothPlastic] = 7,
    [Enum.Material.Wood] = 7,
    [Enum.Material.WoodPlanks] = 7,
    [Enum.Material.Cardboard] = 7,
    [Enum.Material.Glass] = 100,
    [Enum.Material.Fabric] = 100
}

local MaterialVariantLimits = {
    ["IndoorWall"] = 0.25,
    ["Sandy Brick"] = 0.25
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- =========================================================================
-- [ PENETRATION SYSTEM ]
-- =========================================================================

local function GetPenetrationStats(origin, direction, maxPen, ignoreList, targetRoot)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.CollisionGroup = "Bullet"
    local filter = ignoreList or {LP.Character, Camera}
    params.FilterDescendantsInstances = filter
    local currentOrigin = origin
    local currentDir = direction
    local accMat = {}
    local accVar = {}
    local stats = {
        TotalThickness = 0,
        MaterialStats = {},
        Success = false,
        FailReason = "Max Steps",
        EndPos = Vector3.zero
    }

    local backParams = RaycastParams.new()
    backParams.FilterType = Enum.RaycastFilterType.Include
    backParams.CollisionGroup = "Bullet"

    for i = 1, 100 do
        if not currentOrigin or not currentDir then break end
        local result = Workspace:Raycast(currentOrigin, currentDir * 1000, params)
        if not result then
            if not targetRoot then
                stats.Success = true
                stats.EndPos = currentOrigin + (currentDir * 1000)
            else
                stats.FailReason = "Void (Missed)"
            end
            break
        end
        if not result.Instance or not result.Instance.Parent then
            stats.FailReason = "Destroyed Instance"
            break
        end
        if targetRoot and result.Instance:IsDescendantOf(targetRoot) then
            stats.Success = true
            stats.EndPos = result.Position
            stats.FailReason = "Hit"
            return stats
        end
        table.insert(filter, result.Instance)
        params.FilterDescendantsInstances = filter
        local enterPos = result.Position
        local fakeEnd = enterPos + (currentDir * 1000)
        backParams.FilterDescendantsInstances = {result.Instance}
        local backRes = Workspace:Raycast(fakeEnd, enterPos - fakeEnd, backParams)
        local thickness = 0.5
        local limit = 0.25
        local matName = result.Instance.Material.Name
        if not backRes then
            thickness = 5
            stats.FailReason = "Infinite/Block"
        else
            thickness = (enterPos - backRes.Position).Magnitude
            local variant = backRes.Instance.MaterialVariant
            if variant ~= "" and MaterialVariantLimits[variant] then
                matName = variant
                limit = MaterialVariantLimits[variant]
                accVar[variant] = (accVar[variant] or 0) + thickness
                if accVar[variant] > limit + maxPen then
                    stats.FailReason = string.format("Var: %s (%.1f > %.1f)", variant, accVar[variant], limit + maxPen)
                    stats.MaterialStats = {Type = "Variant", Name = variant, Thickness = accVar[variant], Limit = limit + maxPen}
                    return stats
                end
            else
                local mat = backRes.Material
                matName = mat.Name
                limit = MaterialLimits[mat] or 0.25
                accMat[mat] = (accMat[mat] or 0) + thickness
                if accMat[mat] > limit + maxPen then
                    stats.FailReason = string.format("%s (%.1f / %.1f)", matName, accMat[mat], limit + maxPen)
                    stats.MaterialStats = {Type = "Material", Name = matName, Thickness = accMat[mat], Limit = limit + maxPen}
                    return stats
                end
            end
            currentOrigin = backRes.Position
        end
        stats.TotalThickness = stats.TotalThickness + thickness
    end
    return stats
end

-- =========================================================================
-- [ MATH & BHOP HELPERS ]
-- =========================================================================

local function GetMoveDirection()
    local Direction = Vector3.zero
    local LookVector = Camera.CFrame.LookVector
    local RightVector = Camera.CFrame.RightVector
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += RightVector end
    return Vector3.new(Direction.X, 0, Direction.Z).Unit
end

local charfolder = Workspace:WaitForChild("Characters", 10)

local function get_player_team(player)
    if not player then return nil end
    if player.Team then return player.Team.Name end
    return nil
end

local function IsValidTarget(character, teamCheckEnabled)
    if not character or not character:FindFirstChild("HumanoidRootPart") then return false end
    local targetPlayer = Players:GetPlayerFromCharacter(character)
    if not targetPlayer or targetPlayer == LP then return false end
    if teamCheckEnabled then
        if LP.Team and targetPlayer.Team then
            if LP.Team == targetPlayer.Team then return false end
        end
        if LP.Character and LP.Character.Parent and character.Parent then
            if LP.Character.Parent == character.Parent and character.Parent.Name ~= "Characters" then
                return false
            end
        end
    end
    return true
end

-- =========================================================================
-- [ GAMESENSE GUI + OBSIDIAN SHIM ]
-- =========================================================================

local Options = {}
local Toggles = {}
local Library = { Options = Options, Toggles = Toggles, Font = Enum.Font.Code }
local Window = {}
local Tabs = {}
local SettingsGroup
local SaveManager = {}
local ThemeManager = {}
local HttpService = game:GetService("HttpService")

do
    local GSConfig = {
        menu_key = 0x2D,
        MenuColor = { 190, 190, 190, 255 },
    }

    local MenuCol = function()
        return Color3.fromRGB(GSConfig.MenuColor[1], GSConfig.MenuColor[2], GSConfig.MenuColor[3])
    end

    local function RGBtoHSV(r, g, b)
        r, g, b = r / 255, g / 255, b / 255
        local mx = math.max(r, g, b)
        local mn = math.min(r, g, b)
        local h, s, v = 0, 0, mx
        if mx ~= mn then
            local d = mx - mn
            s = mx == 0 and 0 or (d / mx)
            if mx == r then
                h = (g - b) / d
            elseif mx == g then
                h = 2 + (b - r) / d
            else
                h = 4 + (r - g) / d
            end
            h = h * 60
            if h < 0 then h = h + 360 end
            h = h / 360
        end
        return h, s, v
    end

    local function HSVtoRGB(h, s, v)
        h = math.clamp(h, 0, 1)
        s = math.clamp(s, 0, 1)
        v = math.clamp(v, 0, 1)
        local hh = (h == 1) and 0 or (h * 6)
        local f = hh - math.floor(hh)
        local p = v * (1 - s)
        local q = v * (1 - s * f)
        local t = v * (1 - s * (1 - f))
        local r, g, b
        if hh < 1 then r, g, b = v, t, p
        elseif hh < 2 then r, g, b = q, v, p
        elseif hh < 3 then r, g, b = p, v, t
        elseif hh < 4 then r, g, b = p, q, v
        elseif hh < 5 then r, g, b = t, p, v
        else r, g, b = v, p, q end
        return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
    end

    local unloaded = false
    local menuOpen = { v = true }
    local prevCamType = nil
    local Connections = {}
    local function Track(conn)
        Connections[#Connections + 1] = conn
        return conn
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "gamesense"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 100

    local function AttachGui()
        local ok, cg = pcall(function() return game:GetService("CoreGui") end)
        if ok and cg then
            local ok2 = pcall(function() ScreenGui.Parent = cg end)
            if ok2 and ScreenGui.Parent then return end
        end
        local ok3, pg = pcall(function() return LP:WaitForChild("PlayerGui", 5) end)
        if ok3 and pg then
            pcall(function() ScreenGui.Parent = pg end)
        end
    end
    pcall(AttachGui)
    DropdownContainer = ScreenGui

    local MainFrame = Instance.new("CanvasGroup")
    MainFrame.Name = "Main"
    MainFrame.Size = UDim2.new(0, 660, 0, 560)
    MainFrame.Position = UDim2.new(0.5, -330, 0.5, -280)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = false
    MainFrame.Parent = ScreenGui

    local dragState = { on = false, ox = 0, oy = 0 }
    Track(UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        if not ScreenGui.Parent or not MainFrame.Parent or MainFrame.GroupTransparency > 0.5 then return end
        local m = input.Position
        if m.X >= MainFrame.AbsolutePosition.X and m.X <= MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X
            and m.Y >= MainFrame.AbsolutePosition.Y and m.Y <= MainFrame.AbsolutePosition.Y + 18 then
            dragState.on = true
            dragState.ox = m.X - MainFrame.AbsolutePosition.X
            dragState.oy = m.Y - MainFrame.AbsolutePosition.Y
        end
    end))
    Track(UserInputService.InputChanged:Connect(function(input)
        if not dragState.on or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        local m = input.Position
        MainFrame.Position = UDim2.new(0, m.X - dragState.ox, 0, m.Y - dragState.oy)
    end))
    Track(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragState.on = false end
    end))

    for _, c in ipairs({ 12, 61, 43, 43, 43, 61 }) do
        local o = Instance.new("UIStroke")
        o.Color = Color3.fromRGB(c, c, c)
        o.Thickness = 1
        o.Parent = MainFrame
    end

    local AB = Instance.new("Frame")
    AB.Size = UDim2.new(1, 0, 0, 2)
    AB.Position = UDim2.new(0, 7, 0, 7)
    AB.BorderSizePixel = 0
    AB.BackgroundTransparency = 1
    AB.Parent = MainFrame

    local AL = Instance.new("Frame")
    AL.Size = UDim2.new(0.5, 0, 0, 2)
    AL.BorderSizePixel = 0
    AL.Parent = AB
    local ALG = Instance.new("UIGradient")
    ALG.Color = ColorSequence.new(Color3.fromRGB(76, 204, 112), Color3.fromRGB(204, 227, 53))
    ALG.Parent = AL

    local AR = Instance.new("Frame")
    AR.Size = UDim2.new(0.5, 0, 0, 2)
    AR.Position = UDim2.new(0.5, 0, 0, 0)
    AR.BorderSizePixel = 0
    AR.Parent = AB
    local ARG = Instance.new("UIGradient")
    ARG.Color = ColorSequence.new(Color3.fromRGB(204, 227, 53), Color3.fromRGB(153, 0, 153))
    ARG.Parent = AR

    local BL = Instance.new("Frame")
    BL.Size = UDim2.new(1, -14, 0, 1)
    BL.Position = UDim2.new(0, 7, 0, 8)
    BL.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BL.BackgroundTransparency = 1 - 119 / 255
    BL.BorderSizePixel = 0
    BL.Parent = MainFrame

    local DL = Instance.new("Frame")
    DL.Size = UDim2.new(1, -14, 0, 1)
    DL.Position = UDim2.new(0, 7, 0, 9)
    DL.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
    DL.BorderSizePixel = 0
    DL.Parent = MainFrame

    local GUN_ID = "rbxassetid://8547236654"

    local TabIconArt = {
        "rbxassetid://8547236654", -- 0 RAGE
        "custom",                   -- 1 ANTI-AIM (перечёркнутый пистолет)
        "rbxassetid://8547249956",  -- 2 LEGIT
        "rbxassetid://8547254518",  -- 3 VISUALS
        "rbxassetid://8547256547",  -- 4 MISC
        "rbxassetid://8547258459",  -- 5 SKINS
        "floppy",                   -- 6 CONFIG
    }

    local TabNames = { "rage", "aa", "legit", "vfx", "misc", "skins", "cfg" }
    local TabButtons = {}
    local TabFrames = {}
    local TabIconPx = {}
    local CurTab = { v = 0 }
    local DDStates = {}
    local KeyPickers = {}
    local KeyBindActive = nil
    local ChildAccents = {}

    local TabTip = Instance.new("TextLabel")
    TabTip.Name = "TabTip"
    TabTip.Size = UDim2.new(0, 0, 0, 20)
    TabTip.ZIndex = 100
    TabTip.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TabTip.BorderSizePixel = 0
    TabTip.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabTip.Font = Enum.Font.Code
    TabTip.TextSize = 12
    TabTip.TextXAlignment = Enum.TextXAlignment.Left
    TabTip.Visible = false
    TabTip.Parent = ScreenGui
    local TabTipStroke = Instance.new("UIStroke")
    TabTipStroke.Color = Color3.fromRGB(10, 10, 10)
    TabTipStroke.Thickness = 1
    TabTipStroke.Parent = TabTip

    local function CloseAllDDs()
        for _, state in ipairs(DDStates) do
            pcall(state.CloseDD)
        end
    end

    local ActivePickerClose = nil
    local function CloseAllPickers()
        if ActivePickerClose then
            pcall(ActivePickerClose)
        end
        ActivePickerClose = nil
    end

    local function BuildTabIcon(parent, art, cell, color)
        if art == "floppy" then
            local holder = Instance.new("Frame")
            holder.Name = "FloppyIcon"
            holder.Size = UDim2.new(0, 48, 0, 48)
            holder.Position = UDim2.new(0.5, 0, 0.5, 0)
            holder.AnchorPoint = Vector2.new(0.5, 0.5)
            holder.BackgroundTransparency = 1
            holder.BorderSizePixel = 0
            holder.ZIndex = 4
            holder.Parent = parent

            local body = Instance.new("Frame", holder)
            body.Size = UDim2.new(0.72, 0, 0.72, 0)
            body.Position = UDim2.new(0.5, 0, 0.5, 0)
            body.AnchorPoint = Vector2.new(0.5, 0.5)
            body.BackgroundTransparency = 1
            body.BorderSizePixel = 0
            body.ZIndex = 4
            local bodyC = Instance.new("UICorner", body)
            bodyC.CornerRadius = UDim.new(0, 2)
            local bodyS = Instance.new("UIStroke", body)
            bodyS.Color = color
            bodyS.Thickness = 1.4
            bodyS.Transparency = 0

            local slider = Instance.new("Frame", body)
            slider.Size = UDim2.new(0.45, 0, 0.30, 0)
            slider.Position = UDim2.new(0.5, 0, 0.0, 0)
            slider.AnchorPoint = Vector2.new(0.5, 0)
            slider.BackgroundTransparency = 1
            slider.BorderSizePixel = 0
            slider.ZIndex = 5
            local sliderS = Instance.new("UIStroke", slider)
            sliderS.Color = color
            sliderS.Thickness = 1.2
            sliderS.Transparency = 0

            local slot = Instance.new("Frame", slider)
            slot.Size = UDim2.new(0.10, 0, 0.55, 0)
            slot.Position = UDim2.new(0.75, 0, 0.22, 0)
            slot.BackgroundColor3 = color
            slot.BorderSizePixel = 0
            slot.ZIndex = 6

            local label = Instance.new("Frame", body)
            label.Size = UDim2.new(0.70, 0, 0.50, 0)
            label.Position = UDim2.new(0.5, 0, 0.50, 0)
            label.AnchorPoint = Vector2.new(0.5, 0)
            label.BackgroundTransparency = 1
            label.BorderSizePixel = 0
            label.ZIndex = 5
            local labelS = Instance.new("UIStroke", label)
            labelS.Color = color
            labelS.Thickness = 1.2
            labelS.Transparency = 0

            return { bodyS, sliderS, slot, labelS }
        end
        if art == "custom" then
            local holder = Instance.new("Frame")
            holder.Name = "CrossedIcon"
            holder.Size = UDim2.new(0, 52, 0, 52)
            holder.Position = UDim2.new(0.5, 0, 0.5, 0)
            holder.AnchorPoint = Vector2.new(0.5, 0.5)
            holder.BackgroundTransparency = 1
            holder.BorderSizePixel = 0
            holder.ZIndex = 4
            holder.Parent = parent

            local circle = Instance.new("Frame", holder)
            circle.Name = "Circle"
            circle.Size = UDim2.new(0, 36, 0, 36)
            circle.Position = UDim2.new(0.5, 0, 0.5, 0)
            circle.AnchorPoint = Vector2.new(0.5, 0.5)
            circle.BackgroundTransparency = 1
            circle.BorderSizePixel = 0
            circle.ZIndex = 4
            local cc = Instance.new("UICorner", circle)
            cc.CornerRadius = UDim.new(1, 0)
            local cs = Instance.new("UIStroke", circle)
            cs.Color = color
            cs.Thickness = 1
            cs.Transparency = 0.15

            local gun = Instance.new("ImageLabel", holder)
            gun.Name = "Gun"
            gun.Size = UDim2.new(0, 39, 0, 39)
            gun.Position = UDim2.new(0.5, 0, 0.5, 0)
            gun.AnchorPoint = Vector2.new(0.5, 0.5)
            gun.BackgroundTransparency = 1
            gun.Image = GUN_ID
            gun.ImageColor3 = color
            gun.ScaleType = Enum.ScaleType.Fit
            gun.ZIndex = 5

            local slash = Instance.new("Frame", holder)
            slash.Name = "Slash"
            slash.Size = UDim2.new(0, 44, 0, 2.2)
            slash.Position = UDim2.new(0.5, 0, 0.5, 0)
            slash.AnchorPoint = Vector2.new(0.5, 0.5)
            slash.BackgroundColor3 = color
            slash.BorderSizePixel = 0
            slash.Rotation = -45
            slash.ZIndex = 6

            return { circle, gun, slash }
        end
        if type(art) == "string" and art:find("rbxassetid://") then
            local img = Instance.new("ImageLabel")
            img.Size = UDim2.new(0, 52, 0, 52)
            img.Position = UDim2.new(0.5, 0, 0.5, 0)
            img.AnchorPoint = Vector2.new(0.5, 0.5)
            img.BackgroundTransparency = 1
            img.BorderSizePixel = 0
            img.Image = art
            img.ImageColor3 = color
            img.ScaleType = Enum.ScaleType.Fit
            img.ZIndex = 4
            img.Parent = parent
            return { img }
        end
        if type(art) ~= "table" then
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = art
            lbl.TextColor3 = color
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 34
            lbl.ZIndex = 4
            lbl.Parent = parent
            return { lbl }
        end
        local rows = #art
        local cols = rows > 0 and #art[1] or 12
        local w, h = cell * cols, cell * rows
        local anchor = Instance.new("Frame")
        anchor.Name = "Icon"
        anchor.Size = UDim2.new(0, w, 0, h)
        anchor.Position = UDim2.new(0.5, -w / 2, 0.5, -h / 2)
        anchor.BackgroundTransparency = 1
        anchor.BorderSizePixel = 0
        anchor.ZIndex = 4
        anchor.Parent = parent
        local pxls = {}
        for y = 1, rows do
            local line = art[y] or ""
            for x = 1, cols do
                local ch = line:sub(x, x)
                if ch == "#" or ch == "1" then
                    local pxl = Instance.new("Frame")
                    pxl.Size = UDim2.new(0, cell, 0, cell)
                    pxl.Position = UDim2.new(0, (x - 1) * cell, 0, (y - 1) * cell)
                    pxl.BackgroundColor3 = color
                    pxl.BorderSizePixel = 0
                    pxl.ZIndex = 4
                    pxl.Parent = anchor
                    pxls[#pxls + 1] = pxl
                end
            end
        end
        return pxls
    end

    local TAB_W, TAB_H, TAB_STEP = 72, 72, 74
    local IconCell = 3
    local IconIdle = Color3.fromRGB(90, 90, 90)
    local IconHover = Color3.fromRGB(160, 160, 160)
    local TabDisplay = {
        ["rage"] = "RAGE", ["aa"] = "ANTI-AIM", ["legit"] = "LEGIT",
        ["vfx"] = "VISUALS", ["misc"] = "MISC", ["skins"] = "SKINS",
        ["cfg"] = "CONFIG",
    }

    for i = 1, #TabNames do
        local num = i - 1
        local ti = i
        local btn = Instance.new("TextButton")
        btn.Name = "Tab_" .. TabNames[i]
        btn.Size = UDim2.new(0, TAB_W, 0, TAB_H)
        btn.Position = UDim2.new(0, 8, 0, 16 + TAB_STEP * num)
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.ZIndex = 3
        btn.Parent = MainFrame

        local iconPx = BuildTabIcon(btn, TabIconArt[i], IconCell, (num == 0) and Color3.new(1, 1, 1) or IconIdle)

        local fill = Instance.new("Frame")
        fill.Name = "BgFill"
        fill.Size = UDim2.new(1, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        fill.BorderSizePixel = 0
        fill.Visible = (num ~= 0)
        fill.ZIndex = 1
        fill.Parent = btn

        local rb = Instance.new("Frame")
        rb.Name = "RB"
        rb.Size = UDim2.new(0, 1, 1, 0)
        rb.Position = UDim2.new(1, 0, 0, 0)
        rb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        rb.BorderSizePixel = 0
        rb.Visible = (num ~= 0)
        rb.ZIndex = 4
        rb.Parent = btn

        local frame = Instance.new("Frame")
        frame.Name = "Content_" .. TabNames[i]
        frame.Size = UDim2.new(0, 558, 0, 508)
        frame.Position = UDim2.new(0, 88, 0, 30)
        frame.BackgroundTransparency = 0
        frame.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        frame.Visible = (num == 0)
        frame.Parent = MainFrame

        TabButtons[i] = btn
        TabFrames[i] = frame
        TabIconPx[i] = iconPx

        local function SetTab(idx, active)
            local b2 = TabButtons[idx]
            local col = active and Color3.new(1, 1, 1) or IconIdle
            local pxs = TabIconPx[idx]
            if pxs then
                for _, p in ipairs(pxs) do
                    if p:IsA("ImageLabel") then
                        p.ImageColor3 = col
                    elseif p:IsA("TextLabel") then
                        p.TextColor3 = col
                    elseif p:IsA("UIStroke") then
                        p.Color = col
                    else
                        p.BackgroundColor3 = col
                    end
                end
            end
            local f2 = b2:FindFirstChild("BgFill")
            if f2 then f2.Visible = not active end
            local rbA = b2:FindFirstChild("RB")
            if rbA then rbA.Visible = not active end
        end

        btn.MouseEnter:Connect(function()
            if CurTab.v ~= num then
                for _, p in ipairs(iconPx) do
                    if p:IsA("ImageLabel") then
                        p.ImageColor3 = IconHover
                    elseif p:IsA("TextLabel") then
                        p.TextColor3 = IconHover
                    elseif p:IsA("UIStroke") then
                        p.Color = IconHover
                    else
                        p.BackgroundColor3 = IconHover
                    end
                end
            end
            local tval = TabDisplay[TabNames[i]]
            if tval then
                TabTip.Text = tval
                TabTip.Size = UDim2.new(0, tval:len() * 9 + 10, 0, 20)
                local pa, ba = ScreenGui.AbsolutePosition, btn.AbsolutePosition
                TabTip.Position = UDim2.new(0, ba.X - pa.X + TAB_W + 8, 0, ba.Y - pa.Y + math.floor(TAB_H / 2) - 10)
                TabTip.Visible = true
            end
        end)
        btn.MouseLeave:Connect(function()
            TabTip.Visible = false
            SetTab(ti, CurTab.v == num)
        end)
        btn.MouseButton1Click:Connect(function()
            CurTab.v = num
            pcall(CloseAllDDs)
            pcall(CloseAllPickers)
            for j = 1, #TabButtons do
                TabFrames[j].Visible = (j == ti)
                SetTab(j, j == ti)
            end
        end)
    end

    local TabCols = {}
    local function MakeColsPair(parent)
        local left = Instance.new("ScrollingFrame")
        left.Name = "LeftCol"
        left.Size = UDim2.new(0.5, -6, 1, 0)
        left.Position = UDim2.new(0, 0, 0, 0)
        left.BackgroundTransparency = 1
        left.BorderSizePixel = 0
        left.ScrollBarThickness = 4
        left.ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65)
        left.AutomaticCanvasSize = Enum.AutomaticSize.Y
        left.CanvasSize = UDim2.new(0, 0, 0, 0)
        left.Active = true
        left.Parent = parent
        local ll = Instance.new("UIListLayout")
        ll.Padding = UDim.new(0, 8)
        ll.SortOrder = Enum.SortOrder.LayoutOrder
        ll.Parent = left

        local right = Instance.new("ScrollingFrame")
        right.Name = "RightCol"
        right.Size = UDim2.new(0.5, -6, 1, 0)
        right.Position = UDim2.new(0.5, 6, 0, 0)
        right.BackgroundTransparency = 1
        right.BorderSizePixel = 0
        right.ScrollBarThickness = 4
        right.ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65)
        right.AutomaticCanvasSize = Enum.AutomaticSize.Y
        right.CanvasSize = UDim2.new(0, 0, 0, 0)
        right.Active = true
        right.Parent = parent
        local rl = Instance.new("UIListLayout")
        rl.Padding = UDim.new(0, 8)
        rl.SortOrder = Enum.SortOrder.LayoutOrder
        rl.Parent = right

        return { left = left, right = right, leftN = 0, rightN = 0 }
    end

    local function EnsureTabCols(idx)
        if TabCols[idx] then return TabCols[idx] end
        local frame = TabFrames[idx]
        TabCols[idx] = MakeColsPair(frame)
        return TabCols[idx]
    end

    local function FireCtrl(ctrl, value)
        if ctrl._cb then pcall(ctrl._cb, value) end
        for _, fn in ipairs(ctrl._changed) do pcall(fn, value) end
    end

    local function MakeColorPickerUI(parent, order, id, opts)
        opts = opts or {}
        local row = opts._reuseRow
        if not row then
            row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 24)
            row.BackgroundTransparency = 1
            row.LayoutOrder = order or 0
            row.ZIndex = 2
            row.Parent = parent

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(0.7, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = opts.Title or id
            lbl.TextColor3 = Color3.fromRGB(205, 205, 205)
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.ZIndex = 3
            lbl.Parent = row
        end

        local default = opts.Default
        if typeof(default) ~= "Color3" then default = Color3.new(1, 1, 1) end

        local swatch = Instance.new("TextButton")
        swatch.Size = UDim2.new(0, 28, 0, 14)
        swatch.Position = UDim2.new(1, -28, 0.5, -7)
        swatch.BackgroundColor3 = default
        swatch.BorderSizePixel = 0
        swatch.Text = ""
        swatch.ZIndex = 3
        swatch.Parent = row
        local ss = Instance.new("UIStroke")
        ss.Color = Color3.fromRGB(12, 12, 12)
        ss.Thickness = 1
        ss.Parent = swatch
        local sc = Instance.new("UICorner")
        sc.CornerRadius = UDim.new(0, 2)
        sc.Parent = swatch

        local popup = Instance.new("Frame")
        popup.Size = UDim2.new(0, 180, 0, 165)
        popup.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        popup.BorderSizePixel = 0
        popup.ZIndex = 92
        popup.Visible = false
        popup.Parent = ScreenGui
        local ps = Instance.new("UIStroke")
        ps.Color = Color3.fromRGB(12, 12, 12)
        ps.Thickness = 1
        ps.Parent = popup

        local h, s, v = RGBtoHSV(default.R, default.G, default.B)

        local svArea = Instance.new("Frame")
        svArea.Size = UDim2.new(0, 150, 0, 120)
        svArea.Position = UDim2.new(0, 5, 0, 5)
        svArea.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        svArea.BorderSizePixel = 0
        svArea.ZIndex = 31
        svArea.Parent = popup
        local svTop = Instance.new("UIGradient")
        svTop.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1))
        svTop.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
        svTop.Rotation = 0
        svTop.Parent = svArea
        local svBottom = Instance.new("Frame")
        svBottom.Size = UDim2.new(1, 0, 1, 0)
        svBottom.BackgroundColor3 = Color3.new(0, 0, 0)
        svBottom.BackgroundTransparency = 0
        svBottom.BorderSizePixel = 0
        svBottom.ZIndex = 32
        svBottom.Parent = svArea
        local svBg = Instance.new("UIGradient")
        svBg.Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0, 0, 0))
        svBg.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
        svBg.Rotation = 90
        svBg.Parent = svBottom
        local svInput = Instance.new("TextButton")
        svInput.Size = UDim2.new(1, 0, 1, 0)
        svInput.BackgroundTransparency = 1
        svInput.Text = ""
        svInput.ZIndex = 33
        svInput.Parent = svArea

        local hueBar = Instance.new("Frame")
        hueBar.Size = UDim2.new(0, 14, 0, 120)
        hueBar.Position = UDim2.new(0, 160, 0, 5)
        hueBar.BorderSizePixel = 0
        hueBar.ZIndex = 31
        hueBar.Parent = popup
        local hg = Instance.new("UIGradient")
        hg.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
            ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17, 1, 1)),
            ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
            ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67, 1, 1)),
            ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1)),
        })
        hg.Rotation = 90
        hg.Parent = hueBar
        local hueInput = Instance.new("TextButton")
        hueInput.Size = UDim2.new(1, 0, 1, 0)
        hueInput.BackgroundTransparency = 1
        hueInput.Text = ""
        hueInput.ZIndex = 32
        hueInput.Parent = hueBar

        local preview = Instance.new("Frame")
        preview.Size = UDim2.new(0, 170, 0, 22)
        preview.Position = UDim2.new(0, 5, 0, 132)
        preview.BackgroundColor3 = default
        preview.BorderSizePixel = 0
        preview.ZIndex = 31
        preview.Parent = popup
        local pvS = Instance.new("UIStroke")
        pvS.Color = Color3.fromRGB(12, 12, 12)
        pvS.Thickness = 1
        pvS.Parent = preview

        local ctrl = {
            Value = default,
            _changed = {},
            _cb = opts.Callback,
        }

        local function applyVisual()
            local col = Color3.fromHSV(h, s, v)
            ctrl.Value = col
            swatch.BackgroundColor3 = col
            preview.BackgroundColor3 = col
            svArea.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        end

        function ctrl:OnChanged(fn)
            table.insert(self._changed, fn)
            return self
        end

        function ctrl:SetValue(c)
            if typeof(c) ~= "Color3" then return end
            self.Value = c
            h, s, v = RGBtoHSV(c.R, c.G, c.B)
            applyVisual()
            FireCtrl(self, c)
        end

        local function Close()
            popup.Visible = false
            ActivePickerClose = nil
        end

        local held = false
        local function HandleSV(x, y)
            local ax, ay = svArea.AbsolutePosition.X, svArea.AbsolutePosition.Y
            local aw, ah = svArea.AbsoluteSize.X, svArea.AbsoluteSize.Y
            if aw <= 0 or ah <= 0 then return end
            s = math.clamp((x - ax) / aw, 0, 1)
            v = 1 - math.clamp((y - ay) / ah, 0, 1)
            applyVisual()
        end
        local function HandleHue(x, y)
            local ax, ay = hueBar.AbsolutePosition.X, hueBar.AbsolutePosition.Y
            local aw, ah = hueBar.AbsoluteSize.X, hueBar.AbsoluteSize.Y
            if aw <= 0 or ah <= 0 then return end
            h = math.clamp((y - ay) / ah, 0, 1)
            applyVisual()
        end

        local function commit()
            applyVisual()
            FireCtrl(ctrl, ctrl.Value)
        end

        swatch.MouseButton1Click:Connect(function()
            if popup.Visible then
                Close()
                return
            end
            pcall(CloseAllDDs)
            pcall(CloseAllPickers)
            local p = swatch.AbsolutePosition
            popup.Position = UDim2.new(0, p.X - ScreenGui.AbsolutePosition.X, 0, p.Y - ScreenGui.AbsolutePosition.Y + 18)
            popup.Visible = true
            ActivePickerClose = Close
        end)

        svInput.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                held = true
                HandleSV(i.Position.X, i.Position.Y)
            end
        end)
        hueInput.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                held = true
                HandleHue(i.Position.X, i.Position.Y)
            end
        end)

        Track(UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                if held then
                    held = false
                    commit()
                end
            end
        end))
        Track(UserInputService.InputChanged:Connect(function(i, gp)
            if gp or not held or not popup.Visible then return end
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                local ok, mloc = pcall(function() return UserInputService:GetMouseLocation() end)
                if ok and mloc then
                    if hueBar:IsDescendantOf(game) then
                        local hx = mloc.X
                        local hy = mloc.Y
                        local inHue = hx >= hueBar.AbsolutePosition.X and hx <= hueBar.AbsolutePosition.X + hueBar.AbsoluteSize.X
                        local inSV = hx >= svArea.AbsolutePosition.X and hx <= svArea.AbsolutePosition.X + svArea.AbsoluteSize.X
                        if inHue then
                            HandleHue(mloc.X, mloc.Y)
                        elseif inSV then
                            HandleSV(mloc.X, mloc.Y)
                        end
                    end
                end
            end
        end))
        Track(RunService.RenderStepped:Connect(function()
            if unloaded or not ScreenGui.Parent then return end
            if open and held then
                local ok, mloc = pcall(function() return UserInputService:GetMouseLocation() end)
                if ok and mloc then
                    local inHue = mloc.X >= hueBar.AbsolutePosition.X and mloc.X <= hueBar.AbsolutePosition.X + hueBar.AbsoluteSize.X
                    local inSV = mloc.X >= svArea.AbsolutePosition.X and mloc.X <= svArea.AbsolutePosition.X + svArea.AbsoluteSize.X
                    if inHue then
                        HandleHue(mloc.X, mloc.Y)
                    elseif inSV then
                        HandleSV(mloc.X, mloc.Y)
                    end
                end
            end
        end))
        local open = false
        local origVisible = popup:GetPropertyChangedSignal("Visible")
        Track(origVisible:Connect(function()
            open = popup.Visible
            if not open then held = false end
        end))
        open = popup.Visible

        Track(UserInputService.InputBegan:Connect(function(i, gp)
            if gp or not popup.Visible then return end
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                local mx, my = i.Position.X, i.Position.Y
                local function inF(f)
                    if not f or not f.Parent then return false end
                    return mx >= f.AbsolutePosition.X and mx <= f.AbsolutePosition.X + f.AbsoluteSize.X
                        and my >= f.AbsolutePosition.Y and my <= f.AbsolutePosition.Y + f.AbsoluteSize.Y
                end
                if not inF(popup) and not inF(swatch) then
                    Close()
                end
            end
        end))

        applyVisual()
        return ctrl, row
    end

    local function MakeKeyPickerUI(parent, order, id, opts)
        opts = opts or {}
        local row = opts._reuseRow
        if not row then
            row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 24)
            row.BackgroundTransparency = 1
            row.LayoutOrder = order or 0
            row.ZIndex = 2
            row.Parent = parent

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(0.55, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = opts.Text or id
            lbl.TextColor3 = Color3.fromRGB(205, 205, 205)
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.ZIndex = 3
            lbl.Parent = row
        end

        local bb = Instance.new("TextButton")
        bb.Size = UDim2.new(0.45, 0, 1, 0)
        bb.Position = UDim2.new(0.55, 0, 0, 0)
        bb.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        bb.BorderSizePixel = 0
        bb.Text = ""
        bb.TextColor3 = Color3.fromRGB(180, 180, 180)
        bb.Font = Enum.Font.Code
        bb.TextSize = 13
        bb.ZIndex = 3
        bb.Parent = row
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 2)
        bc.Parent = bb
        local bs = Instance.new("UIStroke")
        bs.Color = Color3.fromRGB(12, 12, 12)
        bs.Thickness = 1
        bs.Parent = bb

        local modePopup = Instance.new("Frame")
        modePopup.Size = UDim2.new(0, 100, 0, 60)
        modePopup.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        modePopup.BorderSizePixel = 0
        modePopup.ZIndex = 30
        modePopup.Visible = false
        modePopup.Parent = ScreenGui
        local mps = Instance.new("UIStroke")
        mps.Color = Color3.fromRGB(12, 12, 12)
        mps.Thickness = 1
        mps.Parent = modePopup

        local modes = { "Always", "Toggle", "Hold" }

        local function mouseKeyName(ut)
            if ut == Enum.UserInputType.MouseButton1 then return "Mouse1" end
            if ut == Enum.UserInputType.MouseButton2 then return "Mouse2" end
            if ut == Enum.UserInputType.MouseButton3 then return "Mouse3" end
            return nil
        end

        local ctrl = {
            Value = opts.Default or "None",
            Mode = opts.Mode or "Toggle",
            _label = opts.Text or id,
            _changed = {},
            _cb = opts.Callback,
            _toggled = false,
            _editing = false,
            _lastMouse1Bind = 0,
        }

        local function refreshText()
            if ctrl._editing then
                bb.Text = "..."
                bb.TextColor3 = Color3.fromRGB(255, 0, 0)
                return
            end
            bb.Text = tostring(ctrl.Value) .. " [" .. tostring(ctrl.Mode) .. "]"
            bb.TextColor3 = Color3.fromRGB(114, 114, 114)
        end

        function ctrl:OnChanged(fn)
            table.insert(self._changed, fn)
            return self
        end

        function ctrl:SetValue(keyName)
            self.Value = keyName or "None"
            refreshText()
            FireCtrl(self, self.Value)
        end

        function ctrl:GetState()
            local mode = self.Mode or "Toggle"
            if self.Value == "Always" or mode == "Always" then return true end
            if self.Value == "None" or self.Value == "" then return false end
            if mode == "Toggle" then return self._toggled end
            local mouseMap = {
                Mouse1 = Enum.UserInputType.MouseButton1,
                Mouse2 = Enum.UserInputType.MouseButton2,
                Mouse3 = Enum.UserInputType.MouseButton3,
            }
            if mouseMap[self.Value] then
                local ok, down = pcall(function() return UserInputService:IsMouseButtonPressed(mouseMap[self.Value]) end)
                if ok then return down end
            end
            local code = Enum.KeyCode[self.Value]
            if code then
                local ok, down = pcall(function() return UserInputService:IsKeyDown(code) end)
                if ok then return down end
            end
            return false
        end

        bb.MouseButton1Click:Connect(function()
            modePopup.Visible = false
        end)

        bb.MouseButton2Click:Connect(function()
            if ctrl._editing then return end
            modePopup.Visible = not modePopup.Visible
            if modePopup.Visible then
                pcall(CloseAllDDs)
                pcall(CloseAllPickers)
                for k, c in ipairs(modePopup:GetChildren()) do
                    if c:IsA("TextButton") then
                        local m = modes[k]
                        c.BackgroundColor3 = (ctrl.Mode == m) and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(35, 35, 35)
                        c.TextColor3 = (ctrl.Mode == m) and MenuCol() or Color3.fromRGB(205, 205, 205)
                    end
                end
                local p = bb.AbsolutePosition
                modePopup.Position = UDim2.new(0, p.X - ScreenGui.AbsolutePosition.X, 0, p.Y - ScreenGui.AbsolutePosition.Y + 26)
            end
        end)

        for i = 1, #modes do
            local mi = i
            local ob = Instance.new("TextButton")
            ob.Size = UDim2.new(1, 0, 0, 20)
            ob.Position = UDim2.new(0, 0, 0, (i - 1) * 20)
            ob.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ob.BorderSizePixel = 0
            ob.Text = "  " .. modes[i]
            ob.TextColor3 = Color3.fromRGB(205, 205, 205)
            ob.Font = Enum.Font.Code
            ob.TextSize = 12
            ob.TextXAlignment = Enum.TextXAlignment.Left
            ob.ZIndex = 31
            ob.Parent = modePopup
            ob.MouseButton1Click:Connect(function()
                ctrl.Mode = modes[mi]
                modePopup.Visible = false
                refreshText()
                FireCtrl(ctrl, ctrl.Value)
            end)
        end

        Track(UserInputService.InputBegan:Connect(function(i, gp)
            local function mouseOverBB()
                local mx, my = i.Position.X, i.Position.Y
                return mx >= bb.AbsolutePosition.X and mx <= bb.AbsolutePosition.X + bb.AbsoluteSize.X
                    and my >= bb.AbsolutePosition.Y and my <= bb.AbsolutePosition.Y + bb.AbsoluteSize.Y
            end
            if ctrl._editing then
                local mn = mouseKeyName(i.UserInputType)
                if mn then
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then
                        if not mouseOverBB() then return end
                        if os.clock() - ctrl._lastMouse1Bind < 0.5 then return end
                        ctrl._lastMouse1Bind = os.clock()
                    end
                    if ctrl.Value == mn then
                        ctrl.Value = "None"
                    else
                        ctrl.Value = mn
                    end
                    ctrl._editing = false
                    KeyBindActive = nil
                    refreshText()
                    return
                end
                local kc = i.KeyCode
                if kc ~= Enum.KeyCode.Unknown then
                    local kname = tostring(kc):gsub("^Enum%.KeyCode%.", "")
                    local isMenuKey = (kc == Enum.KeyCode.RightShift or kc.Value == GSConfig.menu_key)
                    if kc == Enum.KeyCode.Escape then
                        ctrl.Value = "None"
                    elseif not isMenuKey then
                        ctrl.Value = kname
                    end
                    ctrl._editing = false
                    KeyBindActive = nil
                    refreshText()
                    if not isMenuKey then return end
                else
                    return
                end
            end
            if modePopup.Visible and i.UserInputType == Enum.UserInputType.MouseButton1 then
                local mx, my = i.Position.X, i.Position.Y
                local inM = mx >= modePopup.AbsolutePosition.X and mx <= modePopup.AbsolutePosition.X + modePopup.AbsoluteSize.X
                    and my >= modePopup.AbsolutePosition.Y and my <= modePopup.AbsolutePosition.Y + modePopup.AbsoluteSize.Y
                local inB = mx >= bb.AbsolutePosition.X and mx <= bb.AbsolutePosition.X + bb.AbsoluteSize.X
                    and my >= bb.AbsolutePosition.Y and my <= bb.AbsolutePosition.Y + bb.AbsoluteSize.Y
                if not inM and not inB then modePopup.Visible = false end
            end
            local mn = mouseKeyName(i.UserInputType)
            if mn then
                if mouseOverBB() then
                    ctrl._editing = true
                    ctrl._lastMouse1Bind = os.clock()
                    KeyBindActive = ctrl
                    refreshText()
                    task.delay(6, function()
                        if KeyBindActive == ctrl then
                            ctrl._editing = false
                            KeyBindActive = nil
                            refreshText()
                        end
                    end)
                    return
                end
                if ctrl.Value ~= mn then return end
                if ctrl.Mode == "Toggle" then
                    ctrl._toggled = not ctrl._toggled
                    FireCtrl(ctrl, ctrl._toggled)
                elseif ctrl.Mode == "Hold" then
                    FireCtrl(ctrl, true)
                end
                return
            end
            if i.KeyCode == Enum.KeyCode.Unknown then return end
            local keyName = tostring(i.KeyCode):gsub("^Enum%.KeyCode%.", "")
            if ctrl.Value ~= keyName then return end
            if ctrl.Mode == "Toggle" then
                ctrl._toggled = not ctrl._toggled
                FireCtrl(ctrl, ctrl._toggled)
            elseif ctrl.Mode == "Hold" then
                FireCtrl(ctrl, true)
            end
        end))

        Track(UserInputService.InputEnded:Connect(function(i)
            local mn = mouseKeyName(i.UserInputType)
            if mn then
                if ctrl.Mode ~= "Hold" then return end
                if ctrl.Value == mn then
                    FireCtrl(ctrl, false)
                end
                return
            end
            if i.KeyCode == Enum.KeyCode.Unknown then return end
            if ctrl.Mode ~= "Hold" then return end
            local keyName = tostring(i.KeyCode):gsub("^Enum%.KeyCode%.", "")
            if ctrl.Value == keyName then
                FireCtrl(ctrl, false)
            end
        end))

        KeyPickers[#KeyPickers + 1] = ctrl
        refreshText()
        return ctrl, row
    end

    local function MakeInputUI(parent, order, id, opts)
        opts = opts or {}
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 26)
        row.BackgroundTransparency = 1
        row.LayoutOrder = order or 0
        row.ZIndex = 2
        row.Parent = parent

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.35, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = opts.Text or id
        lbl.TextColor3 = Color3.fromRGB(205, 205, 205)
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 3
        lbl.Parent = row

        local inp = Instance.new("TextBox")
        inp.Size = UDim2.new(0.65, -4, 1, 0)
        inp.Position = UDim2.new(0.35, 4, 0, 0)
        inp.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        inp.BorderSizePixel = 0
        inp.Text = opts.Default or ""
        inp.PlaceholderText = opts.Placeholder or ""
        inp.TextColor3 = Color3.fromRGB(205, 205, 205)
        inp.Font = Enum.Font.Code
        inp.TextSize = 13
        inp.ClearTextOnFocus = false
        inp.ZIndex = 3
        inp.Parent = row
        for _, c in ipairs({ 12, 50, 16 }) do
            local s = Instance.new("UIStroke")
            s.Color = Color3.fromRGB(c, c, c)
            s.Thickness = 1
            s.Parent = inp
        end

        local ctrl = {
            Value = opts.Default or "",
            _changed = {},
            _cb = opts.Callback,
        }
        function ctrl:OnChanged(fn)
            table.insert(self._changed, fn)
            return self
        end
        function ctrl:SetValue(v)
            self.Value = v or ""
            inp.Text = self.Value
            FireCtrl(self, self.Value)
        end
        inp.FocusLost:Connect(function()
            ctrl.Value = inp.Text
            FireCtrl(ctrl, ctrl.Value)
        end)
        inp:GetPropertyChangedSignal("Text"):Connect(function()
            if inp:IsFocused() then
                ctrl.Value = inp.Text
            end
        end)
        return ctrl, row
    end

    local function MakeDividerUI(parent, order)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 8)
        row.BackgroundTransparency = 1
        row.LayoutOrder = order or 0
        row.ZIndex = 2
        row.Parent = parent
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Position = UDim2.new(0, 0, 0.5, 0)
        line.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        line.BorderSizePixel = 0
        line.ZIndex = 3
        line.Parent = row
        return row
    end

    local function BindContainer(frame)
        local n = 0
        local function nextOrder()
            n = n + 1
            return n
        end

        local api = {}

        function api:AddToggle(id, opts)
            opts = opts or {}
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 24)
            row.BackgroundTransparency = 1
            row.LayoutOrder = nextOrder()
            row.ZIndex = 2
            row.Parent = frame

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.ZIndex = 3
            btn.Parent = row

            local boxGrad = Instance.new("Frame")
            boxGrad.Size = UDim2.new(0, 14, 0, 14)
            boxGrad.Position = UDim2.new(0, 2, 0.5, -7)
            boxGrad.BorderSizePixel = 0
            boxGrad.ZIndex = 3
            boxGrad.Parent = row

            local gi = Instance.new("UIGradient")
            gi.Name = "Grad"
            gi.Rotation = 90
            gi.Parent = boxGrad

            local boxCheck = Instance.new("TextLabel")
            boxCheck.Size = UDim2.new(1, 0, 1, 0)
            boxCheck.BackgroundTransparency = 1
            boxCheck.Text = "X"
            boxCheck.TextColor3 = Color3.fromRGB(10, 10, 10)
            boxCheck.Font = Enum.Font.Code
            boxCheck.TextSize = 11
            boxCheck.Visible = false
            boxCheck.ZIndex = 4
            boxCheck.Parent = boxGrad

            local boxStroke = Instance.new("UIStroke")
            boxStroke.Color = Color3.fromRGB(12, 12, 12)
            boxStroke.Thickness = 1
            boxStroke.Parent = boxGrad
            local cc = Instance.new("UICorner")
            cc.CornerRadius = UDim.new(0, 1)
            cc.Parent = boxGrad
            local rs = Instance.new("UIStroke")
            rs.Color = Color3.fromRGB(12, 12, 12)
            rs.Thickness = 1
            rs.Parent = row
            local rc = Instance.new("UICorner")
            rc.CornerRadius = UDim.new(0, 1)
            rc.Parent = row

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -30, 1, 0)
            lbl.Position = UDim2.new(0, 28, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = opts.Text or id
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.ZIndex = 3
            lbl.Parent = row

            local tip
            if opts.Disabled then
                tip = Instance.new("TextLabel")
                tip.Size = UDim2.new(0, 220, 0, 32)
                tip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                tip.BorderSizePixel = 0
                tip.Text = opts.DisabledTooltip or "Disabled"
                tip.TextColor3 = Color3.fromRGB(255, 200, 80)
                tip.Font = Enum.Font.Code
                tip.TextSize = 12
                tip.TextWrapped = true
                tip.ZIndex = 80
                tip.Visible = false
                tip.Parent = ScreenGui
                btn.MouseEnter:Connect(function()
                    local p = row.AbsolutePosition
                    tip.Position = UDim2.new(0, p.X - ScreenGui.AbsolutePosition.X, 0, p.Y - ScreenGui.AbsolutePosition.Y + 24)
                    tip.Visible = true
                end)
                btn.MouseLeave:Connect(function()
                    tip.Visible = false
                end)
            end

            local ctrl = {
                Value = opts.Default and true or false,
                _changed = {},
                _cb = opts.Callback,
                _disabled = opts.Disabled and true or false,
            }

            local function sync()
                if ctrl.Value then
                    gi.Color = ColorSequence.new(MenuCol(), MenuCol())
                    lbl.TextColor3 = Color3.fromRGB(225, 225, 225)
                    boxCheck.Visible = true
                else
                    gi.Color = ColorSequence.new(Color3.fromRGB(66, 66, 66), Color3.fromRGB(40, 40, 40))
                    lbl.TextColor3 = ctrl._disabled and Color3.fromRGB(120, 120, 120) or Color3.fromRGB(175, 175, 175)
                    boxCheck.Visible = false
                end
            end

            function ctrl:OnChanged(fn)
                table.insert(self._changed, fn)
                return self
            end

            function ctrl:SetValue(v, skipCb)
                v = v and true or false
                if self.Value == v then return end
                self.Value = v
                sync()
                if not skipCb then
                    FireCtrl(self, v)
                end
            end

            function ctrl:AddColorPicker(pid, popts)
                return api:AddColorPicker(pid, popts)
            end

            function ctrl:AddKeyPicker(pid, popts)
                return api:AddKeyPicker(pid, popts)
            end

            btn.MouseButton1Click:Connect(function()
                if ctrl._disabled then return end
                ctrl:SetValue(not ctrl.Value)
            end)

            sync()
            Toggles[id] = ctrl
            return ctrl
        end

        function api:AddSlider(id, opts)
            opts = opts or {}
            local minV = opts.Min or 0
            local maxV = opts.Max or 100
            if maxV <= minV then maxV = minV + 1 end
            local rounding = opts.Rounding or 0
            local suffix = opts.Suffix
            local def = opts.Default
            if type(def) ~= "number" then def = minV end
            local m = 10 ^ rounding
            def = math.floor(math.clamp(def, minV, maxV) * m + 0.5) / m

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 34)
            row.BackgroundTransparency = 1
            row.LayoutOrder = nextOrder()
            row.ZIndex = 2
            row.Parent = frame

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 16)
            lbl.BackgroundTransparency = 1
            lbl.Text = opts.Text or id
            lbl.TextColor3 = Color3.fromRGB(205, 205, 205)
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.ZIndex = 3
            lbl.Parent = row

            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, 0, 0, 8)
            bar.Position = UDim2.new(0, 0, 0, 20)
            bar.BorderSizePixel = 0
            bar.ZIndex = 3
            bar.Parent = row

            local bg = Instance.new("UIGradient")
            bg.Color = ColorSequence.new(Color3.fromRGB(52, 52, 52), Color3.fromRGB(72, 72, 72))
            bg.Rotation = 90
            bg.Parent = bar
            local bs = Instance.new("UIStroke")
            bs.Color = Color3.fromRGB(12, 12, 12)
            bs.Thickness = 1
            bs.Parent = bar

            local fill = Instance.new("Frame")
            fill.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            fill.BorderSizePixel = 0
            fill.ZIndex = 4
            fill.Parent = bar

            local val = Instance.new("TextLabel")
            val.Size = UDim2.new(0, 70, 0, 14)
            val.BackgroundTransparency = 1
            val.TextColor3 = Color3.fromRGB(255, 255, 255)
            val.Font = Enum.Font.Code
            val.TextSize = 13
            val.TextStrokeTransparency = 0.5
            val.ZIndex = 6
            val.Parent = bar

            local sliderHit = Instance.new("TextButton")
            sliderHit.Size = UDim2.new(1, 0, 1, 0)
            sliderHit.BackgroundTransparency = 1
            sliderHit.BorderSizePixel = 0
            sliderHit.Text = ""
            sliderHit.ZIndex = 8
            sliderHit.Parent = bar

            local ctrl = {
                Value = def,
                _changed = {},
                _cb = opts.Callback,
            }

            local function fmt(v)
                local t = string.format("%." .. tostring(rounding) .. "f", v)
                if suffix and suffix ~= "" then
                    t = t .. " " .. suffix
                end
                return t
            end

            local function snap(v)
                v = math.clamp(v, minV, maxV)
                local mm = 10 ^ rounding
                return math.floor(v * mm + 0.5) / mm
            end

            local function sync()
                local p = math.clamp((ctrl.Value - minV) / (maxV - minV), 0, 1)
                fill.Size = UDim2.new(p, 0, 1, 0)
                val.Text = fmt(ctrl.Value)
                val.Position = UDim2.new(p, -35, 0, -3)
            end

            local function setFromX(x, fire)
                local p = math.clamp((x - bar.AbsolutePosition.X) / math.max(1, bar.AbsoluteSize.X), 0, 1)
                local nv = snap(minV + (maxV - minV) * p)
                if nv == ctrl.Value then
                    sync()
                    return
                end
                ctrl.Value = nv
                sync()
                if fire then FireCtrl(ctrl, nv) end
            end

            function ctrl:OnChanged(fn)
                table.insert(self._changed, fn)
                return self
            end

            function ctrl:SetValue(v)
                local nv = snap(tonumber(v) or minV)
                if self.Value == nv then
                    sync()
                    return
                end
                self.Value = nv
                sync()
                FireCtrl(self, nv)
            end

            local dragging = false
            sliderHit.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    pcall(function() setFromX(i.Position.X, true) end)
                end
            end)
            Track(UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    if dragging then
                        dragging = false
                        local ok, mloc = pcall(function() return UserInputService:GetMouseLocation() end)
                        if ok and mloc then setFromX(mloc.X, true) end
                    end
                end
            end))
            Track(RunService.RenderStepped:Connect(function()
                if unloaded or not ScreenGui.Parent then return end
                if dragging then
                    local ok, mloc = pcall(function() return UserInputService:GetMouseLocation() end)
                    if ok and mloc then setFromX(mloc.X, false) end
                end
                sync()
            end))

            sync()
            Options[id] = ctrl
            return ctrl
        end

        function api:AddDropdown(id, opts)
            opts = opts or {}
            local values = opts.Values or {}
            local default = opts.Default
            if type(default) == "number" then
                default = values[default]
            end
            if default == nil then default = values[1] end

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 26)
            row.BackgroundTransparency = 1
            row.LayoutOrder = nextOrder()
            row.ZIndex = 2
            row.Parent = frame

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(0.45, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = opts.Text or id
            lbl.TextColor3 = Color3.fromRGB(205, 205, 205)
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.ZIndex = 3
            lbl.Parent = row

            local dropBtn = Instance.new("TextButton")
            dropBtn.Size = UDim2.new(0.55, 0, 1, 0)
            dropBtn.Position = UDim2.new(0.45, 0, 0, 0)
            dropBtn.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            dropBtn.BorderSizePixel = 0
            dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropBtn.Font = Enum.Font.Code
            dropBtn.TextSize = 13
            dropBtn.ZIndex = 3
            dropBtn.Parent = row
            local bg = Instance.new("UIGradient")
            bg.Color = ColorSequence.new(Color3.fromRGB(31, 31, 31), Color3.fromRGB(36, 36, 36))
            bg.Rotation = 90
            bg.Parent = dropBtn
            local dc = Instance.new("UICorner")
            dc.CornerRadius = UDim.new(0, 2)
            dc.Parent = dropBtn
            local ds = Instance.new("UIStroke")
            ds.Color = Color3.fromRGB(12, 12, 12)
            ds.Thickness = 1
            ds.Parent = dropBtn
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 14, 1, 0)
            arrow.Position = UDim2.new(1, -16, 0, 0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "v"
            arrow.TextColor3 = Color3.fromRGB(157, 157, 157)
            arrow.Font = Enum.Font.Code
            arrow.TextSize = 12
            arrow.ZIndex = 4
            arrow.Parent = dropBtn

            local dd = Instance.new("Frame")
            dd.Size = UDim2.new(0, 190, 0, 0)
            dd.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            dd.BorderSizePixel = 0
            dd.Visible = false
            dd.ZIndex = 60
            dd.Parent = ScreenGui
            local dds = Instance.new("UIStroke")
            dds.Color = Color3.fromRGB(12, 12, 12)
            dds.Thickness = 1
            dds.ZIndex = 60
            dds.Parent = dd

            local ctrl = {
                Value = default,
                Values = values,
                _changed = {},
                _cb = opts.Callback,
            }

            local optionBtns = {}

            local function syncText()
                dropBtn.Text = tostring(ctrl.Value)
            end

            local function rebuild()
                for _, b in ipairs(optionBtns) do
                    pcall(function() b:Destroy() end)
                end
                optionBtns = {}
                local list = ctrl.Values or {}
                dd.Size = UDim2.new(0, 190, 0, #list * 24)
                for i, opt in ipairs(list) do
                    local ti = i
                    local ob = Instance.new("TextButton")
                    ob.Size = UDim2.new(1, 0, 0, 24)
                    ob.Position = UDim2.new(0, 0, 0, (i - 1) * 24)
                    ob.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    ob.BorderSizePixel = 0
                    ob.Text = "  " .. tostring(opt)
                    ob.TextColor3 = (ctrl.Value == opt) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(205, 205, 205)
                    ob.Font = Enum.Font.Code
                    ob.TextSize = 13
                    ob.TextXAlignment = Enum.TextXAlignment.Left
                    ob.ZIndex = 61
                    ob.Parent = dd
                    ob.MouseButton1Click:Connect(function()
                        ctrl.Value = ctrl.Values[ti]
                        syncText()
                        for j, b in ipairs(optionBtns) do
                            b.TextColor3 = (j == ti) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(205, 205, 205)
                        end
                        dd.Visible = false
                        FireCtrl(ctrl, ctrl.Value)
                    end)
                    optionBtns[i] = ob
                end
            end

            local function CloseDD()
                dd.Visible = false
            end

            local ddState = {
                CloseDD = CloseDD,
                IsOpen = function() return dd.Visible end,
                Frame = dd,
                TriggerBtn = dropBtn,
            }
            DDStates[#DDStates + 1] = ddState

            local function OpenDD()
                pcall(CloseAllPickers)
                for _, st in ipairs(DDStates) do
                    if st ~= ddState then pcall(st.CloseDD) end
                end
                local x0 = dropBtn.AbsolutePosition.X - ScreenGui.AbsolutePosition.X
                local y0 = dropBtn.AbsolutePosition.Y - ScreenGui.AbsolutePosition.Y
                local sh = (DropdownContainer and DropdownContainer.AbsoluteSize.Y) or 400
                local ddH = #ctrl.Values * 24
                if y0 + 26 + ddH <= sh then
                    dd.Position = UDim2.new(0, x0, 0, y0 + 26)
                else
                    dd.Position = UDim2.new(0, x0, 0, math.max(0, y0 - ddH))
                end
                dd.Visible = true
            end

            dropBtn.MouseButton1Click:Connect(function()
                if dd.Visible then CloseDD() else OpenDD() end
            end)

            function ctrl:OnChanged(fn)
                table.insert(self._changed, fn)
                return self
            end

            function ctrl:SetValue(v)
                if self.Value == v then return end
                self.Value = v
                syncText()
                rebuild()
                FireCtrl(self, v)
            end

            function ctrl:SetValues(list)
                self.Values = list or {}
                local found = false
                for _, opt in ipairs(self.Values) do
                    if opt == self.Value then
                        found = true
                        break
                    end
                end
                if not found then
                    self.Value = self.Values[1]
                end
                syncText()
                rebuild()
            end

            syncText()
            rebuild()
            Options[id] = ctrl
            return ctrl
        end

        function api:AddColorPicker(id, opts)
            local ctrl = MakeColorPickerUI(frame, nextOrder(), id, opts)
            Options[id] = ctrl
            return ctrl
        end

        function api:AddKeyPicker(id, opts)
            local ctrl = MakeKeyPickerUI(frame, nextOrder(), id, opts)
            Options[id] = ctrl
            return ctrl
        end

        function api:AddInput(id, opts)
            local ctrl = MakeInputUI(frame, nextOrder(), id, opts)
            Options[id] = ctrl
            return ctrl
        end

        function api:AddButton(text, callback)
            local order = nextOrder()
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 28)
            btn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            btn.BorderSizePixel = 0
            btn.Text = ""
            btn.LayoutOrder = order
            btn.ZIndex = 2
            btn.Parent = frame
            local bg = Instance.new("UIGradient")
            bg.Color = ColorSequence.new(Color3.fromRGB(34, 34, 34), Color3.fromRGB(26, 26, 26))
            bg.Rotation = 90
            bg.Parent = btn
            local s1 = Instance.new("UIStroke")
            s1.Color = Color3.fromRGB(12, 12, 12)
            s1.Thickness = 1
            s1.Parent = btn
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
            lbl.Font = Enum.Font.Code
            lbl.TextSize = 14
            lbl.ZIndex = 4
            lbl.Parent = btn
            btn.MouseEnter:Connect(function()
                bg.Color = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(32, 32, 32))
            end)
            btn.MouseLeave:Connect(function()
                bg.Color = ColorSequence.new(Color3.fromRGB(34, 34, 34), Color3.fromRGB(26, 26, 26))
            end)
            btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
            return btn
        end

        function api:AddLabel(text)
            local order = nextOrder()
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 22)
            row.BackgroundTransparency = 1
            row.LayoutOrder = order
            row.ZIndex = 2
            row.Parent = frame

            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(0.55, 0, 1, 0)
            l.BackgroundTransparency = 1
            l.Text = text
            l.TextColor3 = Color3.fromRGB(205, 205, 205)
            l.Font = Enum.Font.Code
            l.TextSize = 14
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.ZIndex = 3
            l.Parent = row

            local labelApi = {}
            function labelApi:AddColorPicker(id, opts)
                opts = opts or {}
                if not opts.Title then opts.Title = text end
                opts._reuseRow = row
                local ctrl = MakeColorPickerUI(frame, order, id, opts)
                Options[id] = ctrl
                return ctrl
            end
            function labelApi:AddKeyPicker(id, opts)
                opts = opts or {}
                if not opts.Text then opts.Text = text end
                opts._reuseRow = row
                local ctrl = MakeKeyPickerUI(frame, order, id, opts)
                Options[id] = ctrl
                return ctrl
            end
            return labelApi
        end

        function api:AddDivider()
            return MakeDividerUI(frame, nextOrder())
        end

        function api:AddPanel(sizeY)
            local order = nextOrder()
            local panel = Instance.new("Frame")
            panel.Name = "Panel"
            panel.Size = UDim2.new(1, 0, 0, sizeY or 170)
            panel.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
            panel.BorderSizePixel = 0
            panel.LayoutOrder = order
            panel.ZIndex = 2
            panel.Parent = frame
            local cv = Instance.new("UIStroke")
            cv.Color = Color3.fromRGB(52, 52, 58)
            cv.Thickness = 1
            cv.Parent = panel
            local cr = Instance.new("UICorner")
            cr.CornerRadius = UDim.new(0, 4)
            cr.Parent = panel
            return panel
        end

        function api:AddDependencyBox()
            local dep = Instance.new("Frame")
            dep.Size = UDim2.new(1, 0, 0, 0)
            dep.AutomaticSize = Enum.AutomaticSize.Y
            dep.BackgroundTransparency = 1
            dep.LayoutOrder = nextOrder()
            dep.ZIndex = 2
            dep.Visible = false
            dep.Parent = frame

            local depList = Instance.new("UIListLayout")
            depList.SortOrder = Enum.SortOrder.LayoutOrder
            depList.Padding = UDim.new(0, 4)
            depList.Parent = dep

            local depPad = Instance.new("UIPadding")
            depPad.PaddingTop = UDim.new(0, 4)
            depPad.PaddingBottom = UDim.new(0, 4)
            depPad.Parent = dep

            local depApi = BindContainer(dep)
            local deps = nil

            local function check()
                if not deps then return end
                local show = true
                for _, d in ipairs(deps) do
                    local obj = d[1]
                    local need = d[2]
                    if obj and obj.Value ~= need then
                        show = false
                        break
                    end
                end
                dep.Visible = show
            end

            function depApi:SetupDependencies(list)
                deps = list or {}
                for _, d in ipairs(deps) do
                    local obj = d[1]
                    if obj and obj.OnChanged then
                        obj:OnChanged(function()
                            check()
                        end)
                    end
                end
                check()
            end

            return depApi
        end

        return api
    end

    local function MakeTabObj(tabIndex)
        local cols = EnsureTabCols(tabIndex)
        local t = {}

        function t:AddLeftGroupbox(name)
            cols.leftN = cols.leftN + 1
            local box = Instance.new("Frame")
            box.Name = name
            box.Size = UDim2.new(1, -4, 0, 0)
            box.AutomaticSize = Enum.AutomaticSize.Y
            box.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            box.BorderSizePixel = 0
            box.LayoutOrder = cols.leftN
            box.ZIndex = 2
            box.Parent = cols.left
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(40, 40, 40)
            stroke.Thickness = 1
            stroke.Parent = box
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -16, 0, 20)
            title.Position = UDim2.new(0, 10, 0, 4)
            title.BackgroundTransparency = 1
            title.Text = name
            title.TextColor3 = Color3.fromRGB(205, 205, 205)
            title.Font = Enum.Font.Code
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.ZIndex = 3
            title.Parent = box
            local accent = Instance.new("Frame")
            accent.Size = UDim2.new(1, -20, 0, 2)
            accent.Position = UDim2.new(0, 10, 0, 24)
            accent.BackgroundColor3 = MenuCol()
            accent.BorderSizePixel = 0
            accent.ZIndex = 3
            accent.Parent = box
            ChildAccents[#ChildAccents + 1] = accent
            local content = Instance.new("Frame")
            content.Name = "Content"
            content.Size = UDim2.new(1, -16, 0, 0)
            content.Position = UDim2.new(0, 8, 0, 30)
            content.BackgroundTransparency = 1
            content.AutomaticSize = Enum.AutomaticSize.Y
            content.ZIndex = 2
            content.Parent = box
            local list = Instance.new("UIListLayout")
            list.SortOrder = Enum.SortOrder.LayoutOrder
            list.Padding = UDim.new(0, 4)
            list.Parent = content
            local pad = Instance.new("UIPadding")
            pad.PaddingBottom = UDim.new(0, 8)
            pad.Parent = content
            return BindContainer(content)
        end
        function t:AddRightGroupbox(name)
            cols.rightN = cols.rightN + 1
            local box = Instance.new("Frame")
            box.Name = name
            box.Size = UDim2.new(1, -4, 0, 0)
            box.AutomaticSize = Enum.AutomaticSize.Y
            box.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            box.BorderSizePixel = 0
            box.LayoutOrder = cols.rightN
            box.ZIndex = 2
            box.Parent = cols.right
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(40, 40, 40)
            stroke.Thickness = 1
            stroke.Parent = box
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -16, 0, 20)
            title.Position = UDim2.new(0, 10, 0, 4)
            title.BackgroundTransparency = 1
            title.Text = name
            title.TextColor3 = Color3.fromRGB(205, 205, 205)
            title.Font = Enum.Font.Code
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.ZIndex = 3
            title.Parent = box
            local accent = Instance.new("Frame")
            accent.Size = UDim2.new(1, -20, 0, 2)
            accent.Position = UDim2.new(0, 10, 0, 24)
            accent.BackgroundColor3 = MenuCol()
            accent.BorderSizePixel = 0
            accent.ZIndex = 3
            accent.Parent = box
            ChildAccents[#ChildAccents + 1] = accent
            local content = Instance.new("Frame")
            content.Name = "Content"
            content.Size = UDim2.new(1, -16, 0, 0)
            content.Position = UDim2.new(0, 8, 0, 30)
            content.BackgroundTransparency = 1
            content.AutomaticSize = Enum.AutomaticSize.Y
            content.ZIndex = 2
            content.Parent = box
            local list = Instance.new("UIListLayout")
            list.SortOrder = Enum.SortOrder.LayoutOrder
            list.Padding = UDim.new(0, 4)
            list.Parent = content
            local pad = Instance.new("UIPadding")
            pad.PaddingBottom = UDim.new(0, 8)
            pad.Parent = content
            return BindContainer(content)
        end
        return t
    end

    Tabs.Combat = MakeTabObj(1)
    Tabs.AntiAim = MakeTabObj(2)
    Tabs.Legit = MakeTabObj(3)
    Tabs.Visuals = MakeTabObj(4)
    Tabs.Misc = MakeTabObj(5)
    Tabs.SkinChanger = MakeTabObj(6)
    Tabs.Settings = MakeTabObj(7)
    Tabs.Weapons = Tabs.Misc
    Tabs.World = Tabs.Misc

    function Window:AddTab(name)
        return MakeTabObj(1)
    end

    local debounceToggle = 0
    function Library:Toggle()
        local now = os.clock()
        if now - debounceToggle < 0.1 then return end
        debounceToggle = now
        KeyBindActive = nil
        menuOpen.v = not menuOpen.v
        pcall(function()
            UserInputService.MouseBehavior = menuOpen.v and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
            -- Блокируем/разблокируем управление персонажем
            local cm = require(LP:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
            if menuOpen.v then cm:Disable() else cm:Enable() end
            local cam = workspace.CurrentCamera
            if cam then
                if menuOpen.v then
                    local prev = cam.CameraType
                    if prev ~= Enum.CameraType.Scriptable then
                        prevCamType = prev
                        cam.CameraType = Enum.CameraType.Scriptable
                    end
                else
                    if prevCamType ~= nil then
                        cam.CameraType = prevCamType
                        prevCamType = nil
                    end
                end
            end
        end)
        if not menuOpen.v then
            pcall(CloseAllDDs)
            pcall(CloseAllPickers)
        end
    end

    function Library:Unload()
        if unloaded then return end
        unloaded = true
        _G.__PASTEHUB_FULLBUILD_INJECTED__ = nil
        _G.__PASTEHUB_FULLBUILD_UNLOAD__ = nil
        menuOpen.v = false
        pcall(function()
            UserInputService.MouseIconEnabled = false
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
            local cam = workspace.CurrentCamera
            if cam and prevCamType ~= nil then
                cam.CameraType = prevCamType
                prevCamType = nil
            end
        end)
        pcall(CloseAllDDs)
        pcall(CloseAllPickers)
        for _, conn in ipairs(Connections) do
            pcall(function() conn:Disconnect() end)
        end
        pcall(function() ScreenGui:Destroy() end)
    end

    local animAlpha = { v = 1 }
    local MenuCursor = nil

    Track(UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Escape and menuOpen.v then
            KeyBindActive = nil
            Library:Toggle()
            return
        end
        if KeyBindActive then return end
        if input.KeyCode.Value == GSConfig.menu_key and GSConfig.menu_key ~= 0 then
            Library:Toggle()
        end
    end))

    Track(RunService.RenderStepped:Connect(function(dt)
        if unloaded or not ScreenGui.Parent then return end
        if menuOpen.v then
            pcall(function()
                UserInputService.MouseIconEnabled = true
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            end)
        end
        local target = menuOpen.v and 1 or 0
        animAlpha.v = animAlpha.v + (target - animAlpha.v) * math.clamp(dt * 10, 0, 1)
        if not menuOpen.v and animAlpha.v < 0.01 then
            MainFrame.Visible = false
            return
        end
        MainFrame.Visible = true
        MainFrame.GroupTransparency = 1 - animAlpha.v
    end))

    Track(RunService.Heartbeat:Connect(function()
        if unloaded or not ScreenGui.Parent then return end
        if menuOpen.v then
            UserInputService.MouseIconEnabled = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            pcall(function()
                local mp = UserInputService:GetMouseLocation()
                local inset = Vector2.zero
                pcall(function() inset = game:GetService("GuiService"):GetGuiInset() end)
                MenuCursor.Position = UDim2.new(0, mp.X - inset.X, 0, mp.Y - inset.Y)
            end)
        end
        MenuCursor.Visible = menuOpen.v
    end))

    Track(RunService.RenderStepped:Connect(function()
        if unloaded or not ScreenGui.Parent then return end
        if not MainFrame.Visible then return end
        local mc = MenuCol()
        for _, acc in ipairs(ChildAccents) do
            acc.BackgroundColor3 = mc
        end
        for i = 1, #TabButtons do
            local pxs = TabIconPx[i]
            if pxs then
                local active = (CurTab.v == i - 1)
                local hover = false
                pcall(function() hover = TabButtons[i].isMouseOver or TabButtons[i]:IsMouseOver() end)
                local col = active and Color3.new(1, 1, 1) or (hover and IconHover or IconIdle)
                for _, p in ipairs(pxs) do
                    if p:IsA("ImageLabel") then
                        p.ImageColor3 = col
                    elseif p:IsA("TextLabel") then
                        p.TextColor3 = col
                    elseif p:IsA("UIStroke") then
                        p.Color = col
                    else
                        p.BackgroundColor3 = col
                    end
                end
            end
        end
    end))

    if not ScreenGui.Parent then
        pcall(AttachGui)
    end

    -- =========================================================================
    -- [ KEYBIND PANEL + WATERMARK ]
    -- =========================================================================

    local KeybindPanel = Instance.new("Frame")
    KeybindPanel.Name = "KeybindPanel"
    KeybindPanel.Size = UDim2.new(0, 190, 0, 40)
    KeybindPanel.Position = UDim2.new(0, 8, 0.5, 0)
    KeybindPanel.AnchorPoint = Vector2.new(0, 0.5)
    KeybindPanel.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    KeybindPanel.BackgroundTransparency = 0.1
    KeybindPanel.BorderSizePixel = 0
    KeybindPanel.ZIndex = 5
    KeybindPanel.Parent = ScreenGui
    local kpStroke = Instance.new("UIStroke")
    kpStroke.Color = Color3.fromRGB(60, 60, 60)
    kpStroke.Thickness = 1
    kpStroke.Parent = KeybindPanel
    local kpCorner = Instance.new("UICorner")
    kpCorner.CornerRadius = UDim.new(0, 4)
    kpCorner.Parent = KeybindPanel

    local kpAccent = Instance.new("Frame")
    kpAccent.Size = UDim2.new(1, 0, 0, 2)
    kpAccent.BackgroundColor3 = MenuCol()
    kpAccent.BackgroundTransparency = 0.15
    kpAccent.BorderSizePixel = 0
    kpAccent.ZIndex = 6
    kpAccent.Parent = KeybindPanel

    local kpTitle = Instance.new("TextLabel")
    kpTitle.Size = UDim2.new(1, -12, 0, 18)
    kpTitle.Position = UDim2.new(0, 6, 0, 5)
    kpTitle.BackgroundTransparency = 1
    kpTitle.Font = Enum.Font.Code
    kpTitle.TextSize = 13
    kpTitle.Text = "KEYBINDS"
    kpTitle.TextColor3 = MenuCol()
    kpTitle.TextXAlignment = Enum.TextXAlignment.Left
    kpTitle.ZIndex = 6
    kpTitle.Parent = KeybindPanel

    local kpList = Instance.new("Frame")
    kpList.Size = UDim2.new(1, -14, 0, 0)
    kpList.AutomaticSize = Enum.AutomaticSize.Y
    kpList.Position = UDim2.new(0, 7, 0, 27)
    kpList.BackgroundTransparency = 1
    kpList.ZIndex = 6
    kpList.Parent = KeybindPanel
    local kpLayout = Instance.new("UIListLayout")
    kpLayout.SortOrder = Enum.SortOrder.LayoutOrder
    kpLayout.Padding = UDim.new(0, 3)
    kpLayout.Parent = kpList

    local Watermark = Instance.new("Frame")
    Watermark.Name = "Watermark"
    Watermark.Size = UDim2.new(0, 0, 0, 22)
    Watermark.Position = UDim2.new(1, -8, 0, 8)
    Watermark.AnchorPoint = Vector2.new(1, 0)
    Watermark.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Watermark.BackgroundTransparency = 0.12
    Watermark.BorderSizePixel = 0
    Watermark.AutomaticSize = Enum.AutomaticSize.X
    Watermark.ZIndex = 5
    Watermark.Parent = ScreenGui
    local wmStroke = Instance.new("UIStroke")
    wmStroke.Color = Color3.fromRGB(40, 40, 40)
    wmStroke.Thickness = 1
    wmStroke.Parent = Watermark
    local wmLabel = Instance.new("TextLabel")
    wmLabel.Size = UDim2.new(0, 0, 1, 0)
    wmLabel.AutomaticSize = Enum.AutomaticSize.X
    wmLabel.Position = UDim2.new(0, 8, 0, 0)
    wmLabel.BackgroundTransparency = 1
    wmLabel.Font = Enum.Font.Code
    wmLabel.TextSize = 12
    wmLabel.TextXAlignment = Enum.TextXAlignment.Left
    wmLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
    wmLabel.ZIndex = 6
    wmLabel.Parent = Watermark
    local wmPad = Instance.new("UIPadding")
    wmPad.PaddingRight = UDim.new(0, 8)
    wmPad.Parent = Watermark

    -- собственный курсор (игра прячет системный)
    MenuCursor = Instance.new("Frame")
    MenuCursor.Name = "MenuCursor"
    MenuCursor.Size = UDim2.fromOffset(16, 16)
    MenuCursor.BackgroundTransparency = 1
    MenuCursor.ZIndex = 50
    MenuCursor.Active = false
    MenuCursor.Visible = false
    MenuCursor.Parent = ScreenGui
    local function mkCur(px, py, sx, sy, color, z)
        local f = Instance.new("Frame")
        f.Size = UDim2.fromOffset(sx, sy)
        f.Position = UDim2.fromOffset(px, py)
        f.BackgroundColor3 = color
        f.BackgroundTransparency = 0
        f.BorderSizePixel = 0
        f.ZIndex = z
        f.Parent = MenuCursor
        return f
    end
    mkCur(0, 0, 3, 15, Color3.new(0, 0, 0), 49)
    mkCur(0, 12, 11, 3, Color3.new(0, 0, 0), 49)
    mkCur(1, 1, 1, 13, Color3.new(1, 1, 1), 50)
    mkCur(1, 12, 8, 1, Color3.new(1, 1, 1), 50)

    -- карта: ctrl -> { Row, KeyLbl, NameLbl, State }
    local kpRowMap = {}
    local wmLt = 0
    local wmAcc = 0

    Track(RunService.RenderStepped:Connect(function()
        if unloaded or not ScreenGui.Parent then return end

        -- собираем активные
        local shown = {}
        for _, pc in ipairs(KeyPickers) do
            if pc._label ~= "MenuKeybind" then
                if pc.Value and pc.Value ~= "None" and pc.Value ~= "Always" and pc.Value ~= "Toggle" then
                    shown[#shown + 1] = pc
                end
            end
        end

        -- определяем какие ещё нужны
        local needSet = {}
        for _, pc in ipairs(shown) do
            needSet[pc] = true
        end

        -- удаляем лишние
        for pc, entry in pairs(kpRowMap) do
            if not needSet[pc] then
                pcall(function() entry.Row:Destroy() end)
                kpRowMap[pc] = nil
            end
        end

        -- создаём недостающие
        for i, pc in ipairs(shown) do
            local entry = kpRowMap[pc]
            if not entry then
                local row = Instance.new("Frame")
                row.Size = UDim2.new(0, 168, 0, 18)
                row.BackgroundTransparency = 1
                row.LayoutOrder = i
                row.ZIndex = 6
                row.Parent = kpList

                local keyLbl = Instance.new("TextLabel", row)
                keyLbl.Size = UDim2.new(0, 52, 1, 0)
                keyLbl.BackgroundTransparency = 1
                keyLbl.Font = Enum.Font.Code
                keyLbl.TextSize = 13
                keyLbl.Text = "[" .. tostring(pc.Value) .. "]"
                keyLbl.TextColor3 = MenuCol()
                keyLbl.TextXAlignment = Enum.TextXAlignment.Left
                keyLbl.ZIndex = 7

                local nameLbl = Instance.new("TextLabel", row)
                nameLbl.Size = UDim2.new(0, 86, 1, 0)
                nameLbl.Position = UDim2.new(0, 54, 0, 0)
                nameLbl.BackgroundTransparency = 1
                nameLbl.Font = Enum.Font.Code
                nameLbl.TextSize = 13
                nameLbl.Text = tostring(pc._label or "Key")
                nameLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
                nameLbl.TextXAlignment = Enum.TextXAlignment.Left
                nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
                nameLbl.ZIndex = 7

                local stateLbl = Instance.new("TextLabel", row)
                stateLbl.Size = UDim2.new(0, 28, 1, 0)
                stateLbl.Position = UDim2.new(0, 140, 0, 0)
                stateLbl.BackgroundTransparency = 1
                stateLbl.Font = Enum.Font.Code
                stateLbl.TextSize = 13
                stateLbl.Text = "OFF"
                stateLbl.TextColor3 = Color3.fromRGB(90, 90, 90)
                stateLbl.TextXAlignment = Enum.TextXAlignment.Right
                stateLbl.ZIndex = 7

                entry = { Row = row, KeyLbl = keyLbl, NameLbl = nameLbl, State = stateLbl }
                kpRowMap[pc] = entry
            end

            entry.Row.LayoutOrder = i
            entry.KeyLbl.Text = "[" .. tostring(pc.Value) .. "]"
            entry.NameLbl.Text = tostring(pc._label or "Key")

            local st, ok = pcall(function() return pc:GetState() end)
            local on = ok and st
            entry.State.Text = on and "ON" or "OFF"
            entry.State.TextColor3 = on and MenuCol() or Color3.fromRGB(90, 90, 90)
        end

        -- размер панели
        KeybindPanel.Size = UDim2.new(0, 190, 0, 30 + #shown * 21)
        KeybindPanel.Visible = #shown > 0

        -- watermark
        local now = os.clock()
        local dt = wmLt ~= 0 and (now - wmLt) or 0
        wmLt = now
        if dt > 0 then wmAcc = (wmAcc * 0.85) + ((1 / dt) * 0.15) end
        local fps = math.floor(wmAcc)
        wmLabel.Text = tostring(fps) .. " FPS   |   " ..
            tostring(LP and LP.Name or "player") ..
            "   |   VLONE.XYZ-PRIABTE GAMESENSE"
    end))

    SettingsGroup = Tabs.Settings:AddLeftGroupbox("Interface Settings")

    SettingsGroup:AddLabel("Menu Keybind"):AddKeyPicker("MenuKeybind", {
        Text = "MenuKeybind",
        Default = "RightShift",
        Mode = "Toggle",
        Callback = function()
            Library:Toggle()
        end,
    })

    SettingsGroup:AddLabel("Menu color"):AddColorPicker("MenuColorPicker", {
        Default = Color3.fromRGB(GSConfig.MenuColor[1], GSConfig.MenuColor[2], GSConfig.MenuColor[3]),
        Title = "Menu color",
        Callback = function(c)
            GSConfig.MenuColor[1] = math.floor(c.R * 255)
            GSConfig.MenuColor[2] = math.floor(c.G * 255)
            GSConfig.MenuColor[3] = math.floor(c.B * 255)
        end,
    })
end

-- =========================================================================
-- [ MISC TAB - MOVEMENT ]
-- =========================================================================

local MiscBox = Tabs.Misc:AddLeftGroupbox("Movement", "activity")

MiscBox:AddToggle("AutoBhop", { Text = "Auto Bhop", Default = false })
MiscBox:AddSlider("BhopSpeed", { Text = "Bhop Speed", Default = 18, Min = 5, Max = 30, Rounding = 1, Suffix = "spd" })

local LegitBox = Tabs.Legit:AddLeftGroupbox("No Fall", "shield")
LegitBox:AddToggle("NoFallDamage", { Text = "No Fall Damage", Default = false }):AddKeyPicker("NoFallKey", {
    Text = "No Fall Key",
    Default = "F",
    Mode = "Toggle",
})

RunService.Heartbeat:Connect(function()
    pcall(function()
        local Character = LP.Character
        if not Character then return end
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character:FindFirstChild("Humanoid")
        if not RootPart or not Humanoid then return end

        if Toggles.AutoBhop and Toggles.AutoBhop.Value then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                local RayParams = RaycastParams.new()
                RayParams.FilterDescendantsInstances = {Character}
                RayParams.FilterType = Enum.RaycastFilterType.Exclude
                local GroundCheck = Workspace:Raycast(RootPart.Position, Vector3.new(0, -4, 0), RayParams)
                if GroundCheck then Humanoid.Jump = true end
            end
            local Success, Result = pcall(function() return GetMoveDirection() end)
            if Success and Result.Magnitude > 0 then
                local currentBhopSpeed = math.clamp(Options.BhopSpeed and Options.BhopSpeed.Value or 18, 5, 30)
                local Direction = Result * currentBhopSpeed
                local Velocity = RootPart.AssemblyLinearVelocity
                local NewX = Velocity.X + (Direction.X - Velocity.X) * 0.2
                local NewZ = Velocity.Z + (Direction.Z - Velocity.Z) * 0.2
                RootPart.AssemblyLinearVelocity = Vector3.new(NewX, Velocity.Y, NewZ)
            end
        end
    end)
end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        local nofall = (Toggles.NoFallDamage and Toggles.NoFallDamage.Value)
        if Options.NoFallKey then
            local kState = Options.NoFallKey:GetState()
            if Options.NoFallKey.Value ~= "None" and Options.NoFallKey.Value ~= "Always" and Options.NoFallKey.Value ~= "Toggle" then
                nofall = kState
            end
        end
        if nofall then
            local character = LP.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    pcall(function()
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    end)
                end
            end
        end
    end)
end)

-- =========================================================================
-- [ ANTI-AIM TAB - SPINBOT + THIRD PERSON ]
-- =========================================================================

local AntiAimBox = Tabs.AntiAim:AddLeftGroupbox("Spinbot", "activity")

AntiAimBox:AddToggle("SpinBot", {
    Text = "Spinbot",
    Default = false,
}):AddKeyPicker("SpinBotKey", {
    Text = "Spinbot Key",
    Default = "None",
    Mode = "Toggle",
})

AntiAimBox:AddSlider("SpinBotSpeed", {
    Text = "Spinbot Speed",
    Default = 1000000,
    Min = 30,
    Max = 1000000,
    Rounding = 0,
    Suffix = "deg/s",
})

local spinHrp = nil
local function UpdateSpinHRP()
    local c = LP.Character
    spinHrp = c and c:FindFirstChild("HumanoidRootPart")
end
UpdateSpinHRP()
LP.CharacterAdded:Connect(UpdateSpinHRP)
task.spawn(function()
    while true do
        task.wait(0.5)
        UpdateSpinHRP()
    end
end)

RunService.RenderStepped:Connect(function(dt)
    local spinActive = (Toggles.SpinBot and Toggles.SpinBot.Value) or false
    if Options.SpinBotKey and Options.SpinBotKey.Value ~= "None" and Options.SpinBotKey.Value ~= "Always" and Options.SpinBotKey.Value ~= "Toggle" then
        spinActive = Options.SpinBotKey:GetState()
    end
    if spinActive then
        local rp = spinHrp
        if rp and rp.Parent then
            local spd = Options.SpinBotSpeed and Options.SpinBotSpeed.Value or 1000000
            rp.CFrame = rp.CFrame * CFrame.Angles(0, math.rad(spd) * dt, 0)
        end
    end
end)

local AntiAimThirdBox = Tabs.AntiAim:AddRightGroupbox("Third Person", "video")

local function isThirdPersonActive()
    local base = (Toggles.ThirdPerson and Toggles.ThirdPerson.Value) or false
    if Options.ThirdPersonKey and Options.ThirdPersonKey.Value ~= "None" and Options.ThirdPersonKey.Value ~= "Always" and Options.ThirdPersonKey.Value ~= "Toggle" then
        return Options.ThirdPersonKey:GetState()
    end
    return base
end

AntiAimThirdBox:AddToggle("ThirdPerson", {
    Text = "Third Person Camera",
    Default = false,
    Callback = function(Value)
        if Value then
            LP.CameraMode = Enum.CameraMode.Classic
            LP.CameraMaxZoomDistance = Options.ThirdPersonDist and Options.ThirdPersonDist.Value or 10
            LP.CameraMinZoomDistance = Options.ThirdPersonDist and Options.ThirdPersonDist.Value or 10
        else
            LP.CameraMode = Enum.CameraMode.LockFirstPerson
            LP.CameraMaxZoomDistance = 0.5
            LP.CameraMinZoomDistance = 0.5
        end
    end
}):AddKeyPicker("ThirdPersonKey", {
    Text = "Third Person Key",
    Default = "None",
    Mode = "Toggle",
})

AntiAimThirdBox:AddSlider("ThirdPersonDist", {
    Text = "Third Person Distance",
    Default = 10,
    Min = 5,
    Max = 50,
    Rounding = 1,
    Suffix = "studs",
    Callback = function(Value)
        if isThirdPersonActive() then
            LP.CameraMaxZoomDistance = Value
            LP.CameraMinZoomDistance = Value
        end
    end
})

-- =========================================================================
-- [ ANTI-AIM - GIRL MODEL (FULL 3D) ]
-- =========================================================================

do
local AntiAimGirlBox = Tabs.AntiAim:AddLeftGroupbox("Girl Model", "users")

-- ============================================================
-- НАСТРОЙКИ МОДЕЛЕЙ
-- ============================================================
local GIRL_MODELS = {
    ["Girl"] = {
        id      = 90779240680461,
        scale   = 1.6,
        offsetX = 0,
        offsetY = 0,
        offsetZ = 0,
        yaw     = 0,
    },
    ["Tun Tun Sahur"] = {
        id      = 94100079746169,
        scale   = 1.0,
        offsetX = 0,
        offsetY = 0,
        offsetZ = 0,
        yaw     = 0,
    },
}

local gModelNames = {}
for name in pairs(GIRL_MODELS) do
    table.insert(gModelNames, name)
end
table.sort(gModelNames)

AntiAimGirlBox:AddToggle("GirlModel", {
    Text = "Enable Models",
    Default = false,
})

AntiAimGirlBox:AddDropdown("GirlModelSelect", {
    Text = "Model",
    Values = gModelNames,
    Default = gModelNames[1],
})

-- ============================================================
-- СОСТОЯНИЕ
-- ============================================================
local gCurrentModel = gModelNames[1]
local gGirlModel        = nil
local gGirlHoldConn     = nil
local gGirlOrigProps    = nil
local gModelCache       = {}

local function gGetScale()    return GIRL_MODELS[gCurrentModel] and GIRL_MODELS[gCurrentModel].scale   or 1 end
local function gGetOffsetX()  return GIRL_MODELS[gCurrentModel] and GIRL_MODELS[gCurrentModel].offsetX or 0 end
local function gGetOffsetY()  return GIRL_MODELS[gCurrentModel] and GIRL_MODELS[gCurrentModel].offsetY or 0 end
local function gGetOffsetZ()  return GIRL_MODELS[gCurrentModel] and GIRL_MODELS[gCurrentModel].offsetZ or 0 end
local function gGetYaw()      return GIRL_MODELS[gCurrentModel] and GIRL_MODELS[gCurrentModel].yaw     or 0 end

-- ============================================================
-- ЛОГИКА
-- ============================================================
local function gGetTemplate(name)
    local entry = GIRL_MODELS[name]
    if not entry then return nil end
    local id = entry.id
    if gModelCache[id] then return gModelCache[id] end
    local ok, objs = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(id))
    end)
    if not ok or not objs or #objs == 0 then
        warn("[GirlModel] не загрузилось ID " .. tostring(id) .. " (" .. name .. ")")
        return nil
    end
    gModelCache[id] = objs[1]
    return objs[1]
end

local function gHideChar(char)
    if not char then return end
    gGirlOrigProps = gGirlOrigProps or {}
    for _, p in ipairs(char:GetDescendants()) do
        pcall(function()
            if p.Name == "HumanoidRootPart" or p.Name == "CameraPart" then return end
            if p:IsA("BasePart") then
                if p.Name == "Handle" and p:FindFirstAncestorOfClass("Accessory") then return end
                gGirlOrigProps[p] = gGirlOrigProps[p] or {}
                gGirlOrigProps[p].Transparency = p.Transparency
                gGirlOrigProps[p].CanCollide   = p.CanCollide
                p.Transparency = 1
                p.CanCollide   = false
            elseif p:IsA("Decal") or p:IsA("Texture") or p:IsA("SurfaceAppearance") then
                gGirlOrigProps[p] = gGirlOrigProps[p] or {}
                gGirlOrigProps[p].Transparency = p.Transparency
                p.Transparency = 1
            end
        end)
    end
    for _, acc in ipairs(char:GetChildren()) do
        if acc:IsA("Accessory") then
            gGirlOrigProps[acc] = gGirlOrigProps[acc] or {}
            gGirlOrigProps[acc].Parent = acc.Parent
            acc.Parent = nil
        end
    end
end

local function gShowChar(char)
    if gGirlOrigProps then
        for obj, props in pairs(gGirlOrigProps) do
            pcall(function()
                if obj:IsA("Accessory") and props.Parent then
                    obj.Parent = props.Parent
                elseif props.Transparency ~= nil then
                    obj.Transparency = props.Transparency
                end
                if props.CanCollide ~= nil then
                    obj.CanCollide = props.CanCollide
                end
            end)
        end
    end
    gGirlOrigProps = nil
    if gGirlHoldConn then gGirlHoldConn:Disconnect() gGirlHoldConn = nil end
    if gGirlModel then gGirlModel:Destroy() gGirlModel = nil end
end

local function gClearWelds()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, w in ipairs(hrp:GetChildren()) do
        if w.Name == "GirlModelWeld" then
            w:Destroy()
        end
    end
end

local gReloadGirl  -- forward declaration

local function gAttachGirl(char)
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if gGirlModel then gGirlModel:Destroy() gGirlModel = nil end
    if gGirlHoldConn then gGirlHoldConn:Disconnect() gGirlHoldConn = nil end
    gClearWelds()

    local template = gGetTemplate(gCurrentModel)
    if not template then return end

    local model = template:Clone()
    if not model:IsA("Model") then
        local wrap = Instance.new("Model")
        model.Parent = wrap
        model = wrap
    end

    gGirlModel = model
    model.Name = "GirlModel_Custom"
    model.Parent = char

    for _, d in ipairs(model:GetDescendants()) do
        pcall(function()
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
                d:Destroy()
            elseif d:IsA("Sound") then
                d:Destroy()
            elseif d:IsA("Humanoid") then
                d:Destroy()
            elseif d:IsA("Animator") or d:IsA("AnimationController") then
                d:Destroy()
            elseif d:IsA("BodyVelocity") or d:IsA("BodyGyro") or d:IsA("BodyPosition")
                or d:IsA("AlignPosition") or d:IsA("AlignOrientation")
                or d:IsA("VectorForce") or d:IsA("LinearVelocity")
                or d:IsA("Weld") or d:IsA("WeldConstraint")
                or d:IsA("Motor6D") or d:IsA("Snap") then
                d:Destroy()
            end
        end)
    end

    local sc = gGetScale()
    pcall(function()
        if sc ~= 1 then model:ScaleTo(sc) end
    end)

    for _, d in ipairs(model:GetDescendants()) do
        pcall(function()
            if d:IsA("BasePart") then
                d.CanCollide = false
                d.CanQuery   = false
                d.CanTouch   = false
                d.Massless   = true
                d.Anchored   = true
            end
        end)
    end

    pcall(function() model:PivotTo(CFrame.new(0, 0, 0)) end)

    local minY = math.huge
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("BasePart") then
            local bot = d.Position.Y - d.Size.Y / 2
            if bot < minY then minY = bot end
        end
    end
    if minY == math.huge then return end

    local pivot    = model:GetPivot().Position
    local footOff  = pivot.Y - minY
    local hrpPos   = hrp.Position
    local charFootY = hrpPos.Y - 3 + gGetOffsetY()
    local targetPos = Vector3.new(
        hrpPos.X + gGetOffsetX(),
        charFootY + footOff,
        hrpPos.Z + gGetOffsetZ()
    )
    local targetCF = CFrame.new(targetPos) * CFrame.Angles(0, math.rad(gGetYaw()), 0)
    pcall(function() model:PivotTo(targetCF) end)

    for _, d in ipairs(model:GetDescendants()) do
        pcall(function()
            if d:IsA("BasePart") then
                d.Anchored = false
                local offset = hrp.CFrame:ToObjectSpace(d.CFrame)
                local weld = Instance.new("Weld")
                weld.Name   = "GirlModelWeld"
                weld.Part0  = hrp
                weld.Part1  = d
                weld.C0     = offset
                weld.C1     = CFrame.new()
                weld.Parent = hrp
            end
        end)
    end

    gGirlHoldConn = RunService.Heartbeat:Connect(function()
        if not gGirlModel or not gGirlModel.Parent then
            if gGirlHoldConn then gGirlHoldConn:Disconnect() gGirlHoldConn = nil end
            return
        end
        local h = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not h then return end
        local hasWelds = false
        for _, w in ipairs(h:GetChildren()) do
            if w.Name == "GirlModelWeld" then
                hasWelds = true
                break
            end
        end
        if not hasWelds then
            gReloadGirl()
        end
    end)
end

gReloadGirl = function()
    local char = LP.Character
    if not char then return end
    if gGirlModel then gGirlModel:Destroy() gGirlModel = nil end
    if gGirlHoldConn then gGirlHoldConn:Disconnect() gGirlHoldConn = nil end
    gClearWelds()
    task.wait(0.05)
    gAttachGirl(char)
end

local function gStopGirl()
    if gGirlHoldConn then gGirlHoldConn:Disconnect() gGirlHoldConn = nil end
    gClearWelds()
    if gGirlModel then gGirlModel:Destroy() gGirlModel = nil end
    gShowChar(LP.Character)
end

local function gStartGirl()
    local char = LP.Character
    if char then
        gHideChar(char)
        task.wait(0.1)
        gAttachGirl(char)
    end
end

-- Следим за изменением модели в дропдауне
if Options.GirlModelSelect then
    Options.GirlModelSelect:OnChanged(function(v)
        if not GIRL_MODELS[v] then return end
        gCurrentModel = v
        if Toggles.GirlModel and Toggles.GirlModel.Value then
            gReloadGirl()
        end
    end)
end

-- Автоподхват активности
task.spawn(function()
    while true do
        task.wait(0.5)
        local active = Toggles.GirlModel and Toggles.GirlModel.Value
        -- Синхронизируем выбранную модель из дропдауна
        if Options.GirlModelSelect then
            local sel = Options.GirlModelSelect.Value
            if sel and GIRL_MODELS[sel] and sel ~= gCurrentModel then
                gCurrentModel = sel
            end
        end
        local char = LP.Character
        if not active then
            if gGirlModel and gGirlModel.Parent then
                gStopGirl()
            end
        elseif char and char.Parent then
            if not gGirlModel or not gGirlModel.Parent then
                gHideChar(char)
                task.wait(0.1)
                gAttachGirl(char)
            end
        end
    end
end)

-- Респавн
LP.CharacterAdded:Connect(function(newChar)
    if gGirlHoldConn then gGirlHoldConn:Disconnect() gGirlHoldConn = nil end
    gClearWelds()
    if gGirlModel then gGirlModel:Destroy() gGirlModel = nil end
    gGirlOrigProps = nil
    if Toggles.GirlModel and Toggles.GirlModel.Value then
        task.wait(1)
        gHideChar(newChar)
        task.wait(0.2)
        gAttachGirl(newChar)
    end
end)
end
-- =========================================================================
-- [ WORLD TAB SETUP ]
-- =========================================================================

local WorldBox = Tabs.Visuals:AddLeftGroupbox("World", "globe")
local WeaponVisualBox = Tabs.Visuals:AddRightGroupbox("Weapon Visual", "activity")

-- =========================================================================
-- [ WEAPON VISUAL - TRACERS ]
-- =========================================================================

WeaponVisualBox:AddToggle("BulletTracers", {
    Text = "Bullet Tracers",
    Default = false,
}):AddColorPicker("BulletTracersColor", {
    Default = Color3.fromRGB(0, 170, 255),
    Title = "Tracer Color",
})

WeaponVisualBox:AddDropdown("TracerStyle", {
    Text = "Tracer Style",
    Values = {"Block", "Cylinder (Obelius)"},
    Default = "Block",
})

WeaponVisualBox:AddToggle("TracerRainbow", {
    Text = "Tracer Rainbow Mode",
    Default = false,
})

WeaponVisualBox:AddSlider("TracerTime", {
    Text = "Tracer Time",
    Default = 2,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Suffix = "s"
})

WeaponVisualBox:AddToggle("BulletImpacts", {
    Text = "Bullet Impacts",
    Default = false,
}):AddColorPicker("BulletImpactsColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Impact Color",
})

-- =========================================================================
-- [ GRENADE ESP - TRACERS ONLY (NO WARNING BOX) ]
-- =========================================================================

local GrenadeVisualBox = Tabs.Visuals:AddRightGroupbox("Grenade ESP", "activity")

GrenadeVisualBox:AddToggle("GrenadeTracers", {
    Text = "Grenade Tracers",
    Default = false,
}):AddColorPicker("GrenadeTracerColor", {
    Default = Color3.fromRGB(255, 100, 0),
    Title = "Tracer Color",
})

GrenadeVisualBox:AddToggle("MolotovZoneESP", {
    Text = "Molotov Zone ESP",
    Default = false,
}):AddColorPicker("GrenadeZoneColor", {
    Default = Color3.fromRGB(255, 60, 0),
    Title = "Zone Color",
})

GrenadeVisualBox:AddToggle("SmokeZoneESP", {
    Text = "Smoke Zone ESP",
    Default = false,
}):AddColorPicker("SmokeZoneColor", {
    Default = Color3.fromRGB(180, 180, 180),
    Title = "Smoke Color",
})

-- =========================================================================
-- [ CUSTOM HANDS ]
-- =========================================================================

local CustomHandsBox = Tabs.Misc:AddRightGroupbox("Custom Hands Postition", "crosshair")

CustomHandsBox:AddToggle("CustomHandsEnabled", { Text = "Enable", Default = false })
CustomHandsBox:AddSlider("HandsX", { Text = "X", Default = 0.2, Min = -2, Max = 2, Rounding = 3, Suffix = "studs" })
CustomHandsBox:AddSlider("HandsY", { Text = "Y", Default = -0.155, Min = -2, Max = 2, Rounding = 3, Suffix = "studs" })
CustomHandsBox:AddSlider("HandsZ", { Text = "Z", Default = 0.075, Min = -2, Max = 2, Rounding = 3, Suffix = "studs" })

RunService.RenderStepped:Connect(function()
    pcall(function()
        if not Toggles.CustomHandsEnabled or not Toggles.CustomHandsEnabled.Value then return end
        local xOffset = Options.HandsX and Options.HandsX.Value or 0.2
        local yOffset = Options.HandsY and Options.HandsY.Value or -0.155
        local zOffset = Options.HandsZ and Options.HandsZ.Value or 0.075
        for _, child in ipairs(Camera:GetChildren()) do
            if child:IsA("Model") then
                local statsFolder = child:FindFirstChild("Stats")
                if statsFolder then
                    local defaultVal = statsFolder:FindFirstChild("Default")
                    if defaultVal and defaultVal:IsA("Vector3Value") then
                        defaultVal.Value = Vector3.new(xOffset, yOffset, zOffset)
                    end
                end
            end
        end
    end)
end)

-- =========================================================================
-- [ WEAPON CHAMS ]
-- =========================================================================

local WeaponChamsBox = Tabs.Visuals:AddRightGroupbox("Weapon Chams", "eye")

WeaponChamsBox:AddToggle("WeaponChamsEnabled", {
    Text = "Enable Weapon Chams",
    Default = false,
}):AddColorPicker("WeaponChamsColor", {
    Default = Color3.fromRGB(0, 150, 255),
    Title = "Chams Color",
})

WeaponChamsBox:AddDropdown("WeaponChamsMode", {
    Text = "Chams Material/Type",
    Values = {"Glass", "ForceField", "Metal", "Highlight", "Neon"},
    Default = "Glass",
})

WeaponChamsBox:AddSlider("GlassTransparency", { Text = "Glass Transparency", Default = 0.4, Min = 0, Max = 1, Rounding = 2 })
WeaponChamsBox:AddSlider("MetalReflectance", { Text = "Metal Reflectance", Default = 1.0, Min = 0, Max = 1, Rounding = 1 })

local activeNeonHighlights = {}

RunService.RenderStepped:Connect(function()
    pcall(function()
        local chamsEnabled = Toggles.WeaponChamsEnabled and Toggles.WeaponChamsEnabled.Value
        local chamsMode = Options.WeaponChamsMode and Options.WeaponChamsMode.Value or "Glass"
        local chamsColor = Options.WeaponChamsColor and Options.WeaponChamsColor.Value or Color3.fromRGB(0, 150, 255)

        local weaponModel = nil
        for _, child in ipairs(Camera:GetChildren()) do
            if child:IsA("Model") and child.Name ~= "Viewmodel" and not child.Name:lower():find("light") then
                local w = child:FindFirstChild("Weapon") or child
                if w:IsA("Model") and w.Name ~= "Viewmodel" and not w.Name:lower():find("light") then
                    weaponModel = w
                    break
                end
            end
        end

        if not chamsEnabled or not weaponModel then
            for _, h in pairs(activeNeonHighlights) do
                if h and h.Parent then h:Destroy() end
            end
            activeNeonHighlights = {}
            if not chamsEnabled or not weaponModel then return end
        end

        local currentNeonParts = {}

        for _, part in ipairs(weaponModel:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "Hitbox" and part.Name ~= "HumanoidRootPart" then
                if part.Name == "ViewmodelLight" or part:FindFirstAncestor("ViewmodelLight") or part:FindFirstAncestor("Viewmodel") then
                    continue
                end
                pcall(function()
                    if chamsMode == "Highlight" then
                        currentNeonParts[part] = true
                        local h = part:FindFirstChild("WeaponChamsHighlight")
                        if not h then
                            h = Instance.new("Highlight")
                            h.Name = "WeaponChamsHighlight"
                            h.Adornee = part
                            h.Parent = part
                            h.FillTransparency = 0
                            h.OutlineTransparency = 1
                            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            table.insert(activeNeonHighlights, h)
                        end
                        h.FillColor = chamsColor
                    else
                        local h = part:FindFirstChild("WeaponChamsHighlight")
                        if h then h:Destroy() end
                        if chamsMode ~= "Neon" then
                            for _, v in ipairs(part:GetChildren()) do
                                if v:IsA("SurfaceAppearance") or v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
                            end
                        end
                        if chamsMode == "Glass" then
                            part.Material = Enum.Material.Glass
                            part.Color = chamsColor
                            part.Transparency = Options.GlassTransparency and Options.GlassTransparency.Value or 0.4
                        elseif chamsMode == "ForceField" then
                            part.Material = Enum.Material.ForceField
                            part.Color = chamsColor
                            part.Transparency = 0
                        elseif chamsMode == "Metal" then
                            part.Material = Enum.Material.Metal
                            part.Color = chamsColor
                            part.Reflectance = Options.MetalReflectance and Options.MetalReflectance.Value or 1.0
                            part.Transparency = 0
                        elseif chamsMode == "Neon" then
                            part.Material = Enum.Material.Neon
                            part.Color = chamsColor
                            part.Transparency = 0
                            for _, v in ipairs(part:GetChildren()) do
                                if v:IsA("SurfaceAppearance") or v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
                            end
                        end
                    end
                end)
            end
        end

        if chamsMode == "Highlight" then
            for i = #activeNeonHighlights, 1, -1 do
                local h = activeNeonHighlights[i]
                if not h or not h.Parent or not currentNeonParts[h.Adornee] then
                    if h then h:Destroy() end
                    table.remove(activeNeonHighlights, i)
                end
            end
        end
    end)
end)

-- =========================================================================
-- [ COMBAT TAB - MEMESENSE MODE ]
-- =========================================================================

local CubeCombatBox = Tabs.Legit:AddLeftGroupbox("Legit mode", "crosshair")

CubeCombatBox:AddToggle("MemesenseMainToggle", {
    Text = "Legit Mode",
    Default = false,
}):AddKeyPicker("MemesenseKeybind", {
    Text = "Legit Mode Key",
    Default = "None",
    Mode = "Toggle",
})

local MemesenseDepBox = CubeCombatBox:AddDependencyBox()

MemesenseDepBox:AddToggle("CubeAimbotEnabled", { Text = "Enable Cube Smart Aimbot", Default = false })
MemesenseDepBox:AddToggle("CubeVisibleCheck", { Text = "Enable Visible Check", Default = false })

MemesenseDepBox:AddDropdown("CubeHitPart", {
    Text = "Target Hit Selection",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = "Head",
})

MemesenseDepBox:AddDivider()

MemesenseDepBox:AddToggle("CubeTriggerbot", { Text = "Enable Triggerbot", Default = false })
MemesenseDepBox:AddSlider("CubeTriggerbotDelay", { Text = "Triggerbot Delay", Default = 0.01, Min = 0, Max = 1, Rounding = 3 })

MemesenseDepBox:AddDivider()

MemesenseDepBox:AddToggle("BulletImpactV1Enabled", {
    Text = "Cube Checker",
    Default = false,
}):AddColorPicker("BulletImpactV1Color", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Cube Checker Color",
})

MemesenseDepBox:AddToggle("BulletImpactV1Rainbow", {
    Text = "Cube Checker Rainbow Mode",
    Default = false,
})

MemesenseDepBox:AddSlider("BulletImpactV1Size", {
    Text = "Impact Size",
    Default = 1.5,
    Min = 0.5,
    Max = 4,
    Rounding = 1,
    Suffix = "studs"
})

MemesenseDepBox:AddSlider("BulletImpactV1Dist", {
    Text = "Max Ray Distance",
    Default = 20,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Suffix = "m"
})

MemesenseDepBox:AddDivider()

MemesenseDepBox:AddToggle("ShowTargetPlayer", { Text = "Show Target Player", Default = false })

MemesenseDepBox:AddDropdown("ShowTargetMode", {
    Text = "Target Display Mode",
    Values = {"Line", "Crosshair"},
    Default = "Crosshair",
})

MemesenseDepBox:AddLabel("Line Color"):AddColorPicker("ShowTargetLineColor", {
    Default = Color3.fromRGB(0, 255, 255),
    Title = "Line Color",
})

MemesenseDepBox:AddLabel("Crosshair Color"):AddColorPicker("ShowTargetCrosshairColor", {
    Default = Color3.fromRGB(0, 255, 255),
    Title = "Crosshair Color",
})

CubeCombatBox:AddToggle("ShowPenetration", { Text = "Show Penetration", Default = false })

-- =========================================================================
-- [ PENETRATION VISUALIZER ]
-- =========================================================================

task.spawn(function()
    local PenText = Drawing.new("Text")
    PenText.Visible = false
    PenText.Center = true
    PenText.Size = 18
    PenText.Font = 2
    PenText.Color = Color3.fromRGB(0, 255, 0)
    PenText.Outline = true

    local penParams = RaycastParams.new()
    penParams.FilterType = Enum.RaycastFilterType.Exclude
    penParams.CollisionGroup = "Bullet"

    RunService.RenderStepped:Connect(function()
        local show = Toggles.ShowPenetration and Toggles.ShowPenetration.Value
        local cam = Workspace.CurrentCamera
        if show and cam then
            PenText.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2 - 70)
            local ignore = {LP.Character, cam, Workspace:FindFirstChild("BacktrackChams")}
            penParams.FilterDescendantsInstances = ignore
            local res = Workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 1000, penParams)
            if res then
                local stats = GetPenetrationStats(cam.CFrame.Position, cam.CFrame.LookVector, 4, {LP.Character, cam}, nil)
                if stats.Success then
                    PenText.Visible = true
                    PenText.Text = string.format("WALLBANG: YES\n(%.1f studs)", stats.TotalThickness or 0)
                    PenText.Color = Color3.fromRGB(0, 255, 0)
                else
                    PenText.Visible = true
                    PenText.Text = "WALLBANG: NO"
                    PenText.Color = Color3.fromRGB(255, 0, 0)
                end
            else
                PenText.Visible = false
            end
        else
            PenText.Visible = false
        end
    end)
end)

MemesenseDepBox:SetupDependencies({ {Toggles.MemesenseMainToggle, true} })

-- =========================================================================
-- [ HIT SOUND ]
-- =========================================================================

local HitSoundBox = Tabs.Misc:AddLeftGroupbox("Hit Sound", "volume-2")

HitSoundBox:AddToggle("HitSoundEnabled", { Text = "Enable Hit Sound", Default = false })
HitSoundBox:AddToggle("CustomHitSoundToggle", { Text = "Enable Custom Hit Sound", Default = false })
HitSoundBox:AddSlider("HitSoundVolume", { Text = "Hit Sound Volume", Default = 1, Min = 0.1, Max = 5, Rounding = 1, Suffix = "x" })

local HitSoundPresets = {
    ["Neverlose"] = "rbxassetid://139452805868562",
    ["Skeet"] = "rbxassetid://83717596220569",
    ["Bell"] = "rbxassetid://96481309571950",
    ["Bell2"] = "rbxassetid://124010691633262",
    ["Bubble"] = "rbxassetid://104824514322839",
    ["Rust"] = "rbxassetid://1255040462",
    ["Agro1"] = "rbxassetid://132463144859699",
    ["Agro2"] = "rbxassetid://102651850556408",
    ["Coins"] = "rbxassetid://5613553529",
    ["Schaater"] = "rbxassetid://17405655409",
    ["Pick"] = "rbxassetid://8616930816"
}

HitSoundBox:AddDropdown("HitSoundPreset", {
    Text = "Hit Sound Preset",
    Values = {"Neverlose", "Skeet", "Bell", "Bell2", "Bubble", "Rust", "Agro1", "Agro2", "Coins", "Schaater", "Pick"},
    Default = "Neverlose",
})

HitSoundBox:AddInput("CustomHitSoundID", {
    Text = "Custom Sound ID",
    Default = "",
    Placeholder = "Clean ID or rbxassetid://...",
})

local function PlayHitSound()
    pcall(function()
        if not Toggles.HitSoundEnabled.Value then return end
        local soundId = ""
        if Toggles.CustomHitSoundToggle and Toggles.CustomHitSoundToggle.Value then
            local customInput = Options.CustomHitSoundID and Options.CustomHitSoundID.Value
            if customInput and customInput ~= "" then
                if not customInput:find("rbxassetid://") then
                    local cleanId = customInput:gsub("%D", "")
                    if cleanId ~= "" then soundId = "rbxassetid://" .. cleanId end
                else
                    soundId = customInput
                end
            end
        end
        if soundId == "" then
            soundId = HitSoundPresets[Options.HitSoundPreset.Value] or "rbxassetid://139452805868562"
        end
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = Options.HitSoundVolume and Options.HitSoundVolume.Value or 1
        sound.Parent = SoundService
        sound:Play()
        task.spawn(function()
            sound.Ended:Wait()
            sound:Destroy()
        end)
    end)
end

-- =========================================================================
-- [ CUSTOM CAMERA ]
-- =========================================================================

local CustomCameraBox = Tabs.Misc:AddRightGroupbox("Custom Camera", "video")

CustomCameraBox:AddToggle("CustomFovToggle", {
    Text = "Custom FOV",
    Default = false,
}):AddKeyPicker("CustomFovKey", { Text = "Custom FOV Key", Default = "One", Mode = "Always" })

CustomCameraBox:AddSlider("FovAmount", { Text = "FOV Amount", Default = 90, Min = 70, Max = 120, Rounding = 0, Suffix = "deg" })

-- =========================================================================
-- [ CUSTOM SCOPE ]
-- =========================================================================

local CustomScopeBox = Tabs.Misc:AddRightGroupbox("Custom Scope", "crosshair")

CustomScopeBox:AddToggle("CustomScopeFov", { Text = "Custom Scope FOV", Default = false })
CustomScopeBox:AddSlider("ScopeFovValue", { Text = "Scope FOV", Default = 70, Min = 10, Max = 100, Rounding = 1, Suffix = "deg" })
CustomScopeBox:AddToggle("RemoveScope", { Text = "Remove Scope", Default = false })
CustomScopeBox:AddDivider()

CustomScopeBox:AddToggle("CustomScopeCrosshair", {
    Text = "Scope Crosshair",
    Default = false,
}):AddColorPicker("ScopeCrosshairColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Crosshair Color" })

CustomScopeBox:AddSlider("ScopeCrosshairThickness", { Text = "Crosshair Thickness", Default = 2, Min = 1, Max = 10, Rounding = 1, Suffix = "px" })
CustomScopeBox:AddSlider("ScopeCrosshairLengthLR", { Text = "Left & Right Length", Default = 150, Min = 0, Max = 1000, Rounding = 0, Suffix = "px" })
CustomScopeBox:AddSlider("ScopeCrosshairLengthTB", { Text = "Top & Bottom Length", Default = 100, Min = 0, Max = 1000, Rounding = 0, Suffix = "px" })

-- =========================================================================
-- [ HITMARKER ]
-- =========================================================================

local HitMarkerBox = Tabs.Visuals:AddLeftGroupbox("HitMarker", "crosshair")

HitMarkerBox:AddToggle("HitMarkerEnabled", {
    Text = "Enable HitMarker",
    Default = false,
}):AddColorPicker("HitMarkerColor", { Default = Color3.fromRGB(255, 255, 255), Title = "HitMarker Color" })

HitMarkerBox:AddToggle("HitMarkerRainbow", { Text = "Rainbow Mode", Default = false })
HitMarkerBox:AddSlider("HitMarkerDuration", { Text = "Display Duration", Default = 2, Min = 0.5, Max = 5, Rounding = 1, Suffix = "s" })
HitMarkerBox:AddSlider("HitMarkerSpinSpeed", { Text = "Spin Speed", Default = 720, Min = 0, Max = 1440, Rounding = 0, Suffix = "deg/s" })
HitMarkerBox:AddSlider("HitMarkerSize", { Text = "Size", Default = 25, Min = 5, Max = 50, Rounding = 0, Suffix = "px" })
HitMarkerBox:AddSlider("HitMarkerThickness", { Text = "Thickness", Default = 2, Min = 1, Max = 6, Rounding = 1, Suffix = "px" })

local TriggerHitMarkerEvent = nil

task.spawn(function()
    local activeHitMarkers = {}

    TriggerHitMarkerEvent = function(hitPos)
        if not Toggles.HitMarkerEnabled or not Toggles.HitMarkerEnabled.Value then return end
        local dur = Options.HitMarkerDuration and Options.HitMarkerDuration.Value or 2
        local thick = Options.HitMarkerThickness and Options.HitMarkerThickness.Value or 2
        local lines = {}
        for i = 1, 4 do
            local line = Drawing.new("Line")
            line.Thickness = thick
            line.Transparency = 1
            line.Visible = false
            lines[i] = line
        end
        table.insert(activeHitMarkers, {
            lines = lines,
            worldPos = hitPos,
            spawnTick = tick(),
            expireTick = tick() + dur
        })
    end

    RunService.RenderStepped:Connect(function()
        pcall(function()
            local currentTick = tick()
            local enabled = Toggles.HitMarkerEnabled and Toggles.HitMarkerEnabled.Value
            local col = Options.HitMarkerColor and Options.HitMarkerColor.Value or Color3.fromRGB(255, 255, 255)
            if Toggles.HitMarkerRainbow and Toggles.HitMarkerRainbow.Value then
                col = Color3.fromHSV((currentTick % 5) / 5, 1, 1)
            end
            local baseSize = Options.HitMarkerSize and Options.HitMarkerSize.Value or 25
            local spinSpeed = Options.HitMarkerSpinSpeed and Options.HitMarkerSpinSpeed.Value or 720
            local pulseFactor = 1 + 0.35 * math.sin(currentTick * math.pi)
            local currentSize = baseSize * pulseFactor
            local gap = 6 * pulseFactor

            for i = #activeHitMarkers, 1, -1 do
                local data = activeHitMarkers[i]
                if not enabled or currentTick > data.expireTick then
                    for _, line in ipairs(data.lines) do pcall(function() line:Remove() end) end
                    table.remove(activeHitMarkers, i)
                else
                    local screenPos, onScreen = Camera:WorldToViewportPoint(data.worldPos)
                    if onScreen then
                        local center = Vector2.new(screenPos.X, screenPos.Y)
                        local lifetime = currentTick - data.spawnTick
                        local currentAngle = math.rad((lifetime * spinSpeed) % 360)
                        local baseAngles = {0, 90, 180, 270}
                        for j = 1, 4 do
                            local line = data.lines[j]
                            line.Color = col
                            line.Thickness = Options.HitMarkerThickness and Options.HitMarkerThickness.Value or 2
                            local totalAngle = currentAngle + math.rad(baseAngles[j])
                            local cosA = math.cos(totalAngle)
                            local sinA = math.sin(totalAngle)
                            line.From = center + Vector2.new(cosA * gap, sinA * gap)
                            line.To = center + Vector2.new(cosA * (gap + currentSize), sinA * (gap + currentSize))
                            line.Visible = true
                        end
                    else
                        for _, line in ipairs(data.lines) do line.Visible = false end
                    end
                end
            end
        end)
    end)
end)

-- =========================================================================
-- [ SCOPE CROSSHAIR GUI ]
-- =========================================================================

task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "BloxStrike_GdcScopeCrosshair"
    crosshairGui.ResetOnSpawn = false
    pcall(function() crosshairGui.Parent = CoreGui end)

    local container = Instance.new("Frame", crosshairGui)
    container.BackgroundTransparency = 1
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.Size = UDim2.new(0, 0, 0, 0)

    local leftLine = Instance.new("Frame", container)
    leftLine.AnchorPoint = Vector2.new(1, 0.5)
    leftLine.BorderSizePixel = 0

    local rightLine = Instance.new("Frame", container)
    rightLine.AnchorPoint = Vector2.new(0, 0.5)
    rightLine.BorderSizePixel = 0

    local topLine = Instance.new("Frame", container)
    topLine.AnchorPoint = Vector2.new(0.5, 1)
    topLine.BorderSizePixel = 0

    local bottomLine = Instance.new("Frame", container)
    bottomLine.AnchorPoint = Vector2.new(0.5, 0)
    bottomLine.BorderSizePixel = 0

    RunService.RenderStepped:Connect(function()
        pcall(function()
            local isScoped = false
            local playerGui = LP:FindFirstChild("PlayerGui")
            if playerGui then
                local s, scope = pcall(function() return playerGui.MainGui.Gameplay.Middle.SniperScope end)
                if s and scope and scope.Visible then isScoped = true end
            end
            local enabled = Toggles.CustomScopeCrosshair and Toggles.CustomScopeCrosshair.Value and isScoped
            container.Visible = enabled
            if enabled then
                local col = Options.ScopeCrosshairColor and Options.ScopeCrosshairColor.Value or Color3.fromRGB(255, 255, 255)
                leftLine.BackgroundColor3 = col
                rightLine.BackgroundColor3 = col
                topLine.BackgroundColor3 = col
                bottomLine.BackgroundColor3 = col
                local t = Options.ScopeCrosshairThickness and Options.ScopeCrosshairThickness.Value or 2
                local lenLR = Options.ScopeCrosshairLengthLR and Options.ScopeCrosshairLengthLR.Value or 150
                local lenTB = Options.ScopeCrosshairLengthTB and Options.ScopeCrosshairLengthTB.Value or 100
                leftLine.Size = UDim2.new(0, lenLR, 0, t)
                leftLine.Position = UDim2.new(0, 0, 0, 0)
                rightLine.Size = UDim2.new(0, lenLR, 0, t)
                rightLine.Position = UDim2.new(0, 0, 0, 0)
                topLine.Size = UDim2.new(0, t, 0, lenTB)
                topLine.Position = UDim2.new(0, 0, 0, 0)
                bottomLine.Size = UDim2.new(0, t, 0, lenTB)
                bottomLine.Position = UDim2.new(0, 0, 0, 0)
            end
        end)
    end)
end)

-- =========================================================================
-- [ REMOVE SCOPE ]
-- =========================================================================

task.spawn(function()
    local CachedSniperScope = nil
    RunService.RenderStepped:Connect(function()
        if CachedSniperScope and not CachedSniperScope.Parent then CachedSniperScope = nil end
        if not CachedSniperScope then
            local playerGui = LP:FindFirstChild("PlayerGui")
            if playerGui then
                local s, scope = pcall(function() return playerGui.MainGui.Gameplay.Middle.SniperScope end)
                if s and scope then CachedSniperScope = scope end
            end
        end
        local scopeFrame = CachedSniperScope
        if not Toggles.RemoveScope or not Toggles.RemoveScope.Value then
            if scopeFrame then
                if scopeFrame.Size ~= UDim2.new(1, 0, 1, 0) then scopeFrame.Size = UDim2.new(1, 0, 1, 0) end
            end
            return
        end
        if scopeFrame then
            if scopeFrame.Visible == true then
                scopeFrame.Size = UDim2.new(0, 0, 0, 0)
            else
                if scopeFrame.Size ~= UDim2.new(1, 0, 1, 0) then scopeFrame.Size = UDim2.new(1, 0, 1, 0) end
            end
        end
    end)
end)

-- =========================================================================
-- [ CUSTOM SCOPE FOV ]
-- =========================================================================

task.spawn(function()
    RunService.RenderStepped:Connect(function()
        pcall(function()
            if Toggles.CustomScopeFov and Toggles.CustomScopeFov.Value then
                local cam = Workspace.CurrentCamera
                if cam then
                    local playerGui = LP:FindFirstChild("PlayerGui")
                    if playerGui then
                        local scope = playerGui:FindFirstChild("MainGui") and
                            playerGui.MainGui:FindFirstChild("Gameplay") and
                            playerGui.MainGui.Gameplay:FindFirstChild("Middle") and
                            playerGui.MainGui.Gameplay.Middle:FindFirstChild("SniperScope")
                        if scope and scope.Visible and Options.ScopeFovValue then
                            cam.FieldOfView = Options.ScopeFovValue.Value
                        end
                    end
                end
            end
        end)
    end)
end)

-- =========================================================================
-- [ METATABLE HOOK FOR THIRD PERSON ]
-- =========================================================================

task.spawn(function()
    if getrawmetatable and setreadonly then
        local mt = getrawmetatable(game)
        local oldNewIndex = mt.__newindex
        setreadonly(mt, false)
        mt.__newindex = newcclosure(function(self, key, value)
            if self == LP and isThirdPersonActive() then
                if key == "CameraMode" then
                    return oldNewIndex(self, key, Enum.CameraMode.Classic)
                elseif key == "CameraMaxZoomDistance" then
                    return oldNewIndex(self, key, Options.ThirdPersonDist and Options.ThirdPersonDist.Value or 10)
                elseif key == "CameraMinZoomDistance" then
                    return oldNewIndex(self, key, Options.ThirdPersonDist and Options.ThirdPersonDist.Value or 10)
                end
            end
            return oldNewIndex(self, key, value)
        end)
        setreadonly(mt, true)
    end
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        if Toggles.CustomFovToggle and Toggles.CustomFovToggle.Value then
            local keypicker = Options.CustomFovKey
            local active = true
            if keypicker and keypicker.Value ~= "Always" and keypicker.Value ~= "One" then
                active = keypicker:GetState()
            end
            if active then
                local cam = Workspace.CurrentCamera
                if cam then cam.FieldOfView = Options.FovAmount.Value or 90 end
            end
        end
        if isThirdPersonActive() then
            local clampedDist = math.clamp(Options.ThirdPersonDist and Options.ThirdPersonDist.Value or 10, 5, 50)
            LP.CameraMode = Enum.CameraMode.Classic
            LP.CameraMaxZoomDistance = clampedDist
            LP.CameraMinZoomDistance = clampedDist
        end
    end)
end)

-- =========================================================================
-- [ SKYBOX SYSTEM ]
-- =========================================================================

local skyboxtable = {
    ["Night"] = {
        SkyboxBk = "rbxassetid://1514717643", SkyboxDn = "rbxassetid://1514716936",
        SkyboxFt = "rbxassetid://1514715910", SkyboxLf = "rbxassetid://1514714945",
        SkyboxRt = "rbxassetid://1514714011", SkyboxUp = "rbxassetid://1514713374"
    },
    ["Ocean Sunset"] = {
        SkyboxBk = "rbxassetid://17525686840", SkyboxDn = "rbxassetid://17525678473",
        SkyboxFt = "rbxassetid://17525684686", SkyboxLf = "rbxassetid://17525680663",
        SkyboxRt = "rbxassetid://17525682665", SkyboxUp = "rbxassetid://17525674545"
    },
    ["My Summer Car"] = {
        SkyboxBk = "rbxassetid://16648590964", SkyboxDn = "rbxassetid://16648617436",
        SkyboxFt = "rbxassetid://16648595424", SkyboxLf = "rbxassetid://16648566370",
        SkyboxRt = "rbxassetid://16648577071", SkyboxUp = "rbxassetid://16648598180"
    },
    ["Standard"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=91458024",
        SkyboxDn = "http://www.roblox.com/asset/?id=91457980",
        SkyboxFt = "http://www.roblox.com/asset/?id=91458024",
        SkyboxLf = "http://www.roblox.com/asset/?id=91458024",
        SkyboxRt = "http://www.roblox.com/asset/?id=91458024",
        SkyboxUp = "http://www.roblox.com/asset/?id=91458002"
    },
    ["Minecraft"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=8735166756",
        SkyboxDn = "http://www.roblox.com/asset/?id=8735166707",
        SkyboxFt = "http://www.roblox.com/asset/?id=8735231668",
        SkyboxLf = "http://www.roblox.com/asset/?id=8735166755",
        SkyboxRt = "http://www.roblox.com/asset/?id=8735166751",
        SkyboxUp = "http://www.roblox.com/asset/?id=8735166729"
    },
    ["Spongebob"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=277099484",
        SkyboxDn = "http://www.roblox.com/asset/?id=277099500",
        SkyboxFt = "http://www.roblox.com/asset/?id=277099554",
        SkyboxLf = "http://www.roblox.com/asset/?id=277099531",
        SkyboxRt = "http://www.roblox.com/asset/?id=277099589",
        SkyboxUp = "http://www.roblox.com/asset/?id=277101591"
    },
    ["Deep Space"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=159248188",
        SkyboxDn = "http://www.roblox.com/asset/?id=159248183",
        SkyboxFt = "http://www.roblox.com/asset/?id=159248187",
        SkyboxLf = "http://www.roblox.com/asset/?id=159248173",
        SkyboxRt = "http://www.roblox.com/asset/?id=159248192",
        SkyboxUp = "http://www.roblox.com/asset/?id=159248176"
    },
    ["Clouded Sky"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=252760981",
        SkyboxDn = "http://www.roblox.com/asset/?id=252763035",
        SkyboxFt = "http://www.roblox.com/asset/?id=252761439",
        SkyboxLf = "http://www.roblox.com/asset/?id=252760980",
        SkyboxRt = "http://www.roblox.com/asset/?id=252760986",
        SkyboxUp = "http://www.roblox.com/asset/?id=252762652"
    },
    ["Retro"] = {
        SkyboxBk = "rbxasset://sky/null_plainsky512_bk.jpg",
        SkyboxDn = "rbxasset://sky/null_plainsky512_dn.jpg",
        SkyboxFt = "rbxasset://sky/null_plainsky512_ft.jpg",
        SkyboxLf = "rbxasset://sky/null_plainsky512_lf.jpg",
        SkyboxRt = "rbxasset://sky/null_plainsky512_rt.jpg",
        SkyboxUp = "rbxasset://sky/null_plainsky512_up.jpg"
    },
    ["City"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=9134792889",
        SkyboxDn = "http://www.roblox.com/asset/?id=9134791975",
        SkyboxFt = "http://www.roblox.com/asset/?id=9134793457",
        SkyboxLf = "http://www.roblox.com/asset/?id=9134791234",
        SkyboxRt = "http://www.roblox.com/asset/?id=9134790419",
        SkyboxUp = "http://www.roblox.com/asset/?id=9134791633"
    },
    ["Purple Nebula"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=15983968922",
        SkyboxDn = "http://www.roblox.com/asset/?id=15983966825",
        SkyboxFt = "http://www.roblox.com/asset/?id=15983965025",
        SkyboxLf = "http://www.roblox.com/asset/?id=15983967420",
        SkyboxRt = "http://www.roblox.com/asset/?id=15983966246",
        SkyboxUp = "http://www.roblox.com/asset/?id=15983964246"
    },
    ["Pink Sky"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=7890140060",
        SkyboxDn = "http://www.roblox.com/asset/?id=7890140060",
        SkyboxFt = "http://www.roblox.com/asset/?id=7890140060",
        SkyboxLf = "http://www.roblox.com/asset/?id=7890140060",
        SkyboxRt = "http://www.roblox.com/asset/?id=7890140060",
        SkyboxUp = "http://www.roblox.com/asset/?id=7890140060"
    }
}

local skyNames = {}
for k, _ in pairs(skyboxtable) do table.insert(skyNames, k) end
table.sort(skyNames)

local function UpdateSkybox(name)
    local data = skyboxtable[name]
    if not data then return end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") or v:IsA("Clouds") then v:Destroy() end
    end
    local sky = Lighting:FindFirstChild("Memesense_Sky")
    if not sky then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
        sky = Instance.new("Sky")
        sky.Name = "Memesense_Sky"
        sky.Parent = Lighting
    end
    sky.SkyboxBk = data.SkyboxBk
    sky.SkyboxDn = data.SkyboxDn
    sky.SkyboxFt = data.SkyboxFt
    sky.SkyboxLf = data.SkyboxLf
    sky.SkyboxRt = data.SkyboxRt
    sky.SkyboxUp = data.SkyboxUp
    sky.SunTextureId = ""
    sky.MoonTextureId = ""
    sky.StarCount = 0
end

-- =========================================================================
-- [ WEATHER SYSTEM ]
-- =========================================================================

local WeatherPart = nil
local GroundPart = nil

local function UpdateWeather(wType)
    if WeatherPart then WeatherPart:Destroy() WeatherPart = nil end
    if GroundPart then GroundPart:Destroy() GroundPart = nil end
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name == "Memesense_RainDrop" then v:Destroy() end
    end
    if wType == "None" then return end

    WeatherPart = Instance.new("Part")
    WeatherPart.Name = "Memesense_Weather_Sky"
    WeatherPart.Size = Vector3.new(100, 1, 100)
    WeatherPart.Transparency = 1
    WeatherPart.Anchored = true
    WeatherPart.CanCollide = false
    WeatherPart.Parent = Workspace.CurrentCamera
    local SkyEmitter = Instance.new("ParticleEmitter")
    SkyEmitter.Parent = WeatherPart
    SkyEmitter.EmissionDirection = Enum.NormalId.Bottom
    SkyEmitter.Enabled = true

    GroundPart = Instance.new("Part")
    GroundPart.Name = "Memesense_Weather_Ground"
    GroundPart.Size = Vector3.new(50, 1, 50)
    GroundPart.Transparency = 1
    GroundPart.Anchored = true
    GroundPart.CanCollide = false
    GroundPart.Parent = Workspace.CurrentCamera
    local GroundEmitter = Instance.new("ParticleEmitter")
    GroundEmitter.Parent = GroundPart
    GroundEmitter.Enabled = false

    if wType == "Rain" then
        SkyEmitter.Texture = "rbxassetid://241868005"
        SkyEmitter.Rate = 10000
        SkyEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        SkyEmitter.LightEmission = 0.2
        SkyEmitter.Transparency = NumberSequence.new(0)
        SkyEmitter.Size = NumberSequence.new(3, 6)
        SkyEmitter.Lifetime = NumberRange.new(2, 2.5)
        SkyEmitter.Speed = NumberRange.new(80, 100)
        SkyEmitter.SpreadAngle = Vector2.new(0, 0)
        SkyEmitter.Acceleration = Vector3.new(0, -50, 0)
        SkyEmitter.Orientation = Enum.ParticleOrientation.FacingCamera
    elseif wType == "Snow" then
        SkyEmitter.Texture = "rbxassetid://99851851"
        SkyEmitter.Rate = 200
        SkyEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        SkyEmitter.Size = NumberSequence.new(0.25, 0.35)
        SkyEmitter.Speed = NumberRange.new(30, 30)
        SkyEmitter.Lifetime = NumberRange.new(5, 10)
        SkyEmitter.Acceleration = Vector3.new(0, 0, 0)
        SkyEmitter.SpreadAngle = Vector2.new(50, 50)
        SkyEmitter.LightEmission = 0.5
        SkyEmitter.Rotation = NumberRange.new(0, 0)
        SkyEmitter.RotSpeed = NumberRange.new(0, 0)
    elseif wType == "Hell Fire" then
        SkyEmitter.Texture = "rbxassetid://242205518"
        SkyEmitter.Rate = 400
        SkyEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 100, 0), Color3.fromRGB(150, 0, 0))
        SkyEmitter.Size = NumberSequence.new(2, 4)
        SkyEmitter.Speed = NumberRange.new(40, 60)
        SkyEmitter.Lifetime = NumberRange.new(2, 3)
        SkyEmitter.Acceleration = Vector3.new(0, -10, 0)
        SkyEmitter.RotSpeed = NumberRange.new(50, 100)
    end
end

-- =========================================================================
-- [ LIGHTING SYSTEM ]
-- =========================================================================

local DefaultLighting = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    GlobalShadows = Lighting.GlobalShadows
}

local function UpdateLighting()
    if Toggles.EnableTime and Toggles.EnableTime.Value then
        Lighting.ClockTime = Options.WorldClockTime.Value
    else
        Lighting.ClockTime = DefaultLighting.ClockTime
    end
    if Toggles.EnableBrightness and Toggles.EnableBrightness.Value then
        Lighting.Brightness = Options.WorldBrightness.Value
    else
        Lighting.Brightness = DefaultLighting.Brightness
    end
    if Toggles.EnableColors and Toggles.EnableColors.Value then
        Lighting.Ambient = Options.WorldAmbient.Value
        Lighting.OutdoorAmbient = Options.WorldOutdoorAmbient.Value
    else
        Lighting.Ambient = DefaultLighting.Ambient
        Lighting.OutdoorAmbient = DefaultLighting.OutdoorAmbient
    end
end

WorldBox:AddToggle("EnableSkybox", {
    Text = "Enable Skybox",
    Default = false,
    Callback = function(v)
        if v then
            if Toggles.Atmosphere and Toggles.Atmosphere.Value then Toggles.Atmosphere:SetValue(false) end
            UpdateSkybox(Options.SkyboxPreset.Value)
        end
    end
})

WorldBox:AddDropdown("SkyboxPreset", {
    Text = "Skybox Preset",
    Values = skyNames,
    Default = "Night",
    Callback = function(v) if Toggles.EnableSkybox.Value then UpdateSkybox(v) end end
})

WorldBox:AddDropdown("WeatherType", {
    Text = "Weather",
    Values = {"None", "Rain", "Snow", "Hell Fire"},
    Default = "None",
    Callback = function(v) UpdateWeather(v) end
})

WorldBox:AddToggle("EnableTime", { Text = "Enable Time", Default = false, Callback = function(_) UpdateLighting() end })
WorldBox:AddSlider("WorldClockTime", { Text = "Clock Time", Default = 12, Min = 0, Max = 24, Rounding = 1, Suffix = "h", Callback = function(_) UpdateLighting() end })
WorldBox:AddToggle("EnableBrightness", { Text = "Enable Brightness", Default = false, Callback = function(_) UpdateLighting() end })
WorldBox:AddSlider("WorldBrightness", { Text = "Brightness", Default = 2, Min = 0, Max = 10, Rounding = 1, Suffix = "x", Callback = function(_) UpdateLighting() end })
WorldBox:AddToggle("EnableColors", { Text = "Enable Colors", Default = false, Callback = function(_) UpdateLighting() end })

WorldBox:AddLabel("Ambient Color"):AddColorPicker("WorldAmbient", {
    Default = Color3.fromRGB(127, 127, 127),
    Title = "Ambient Color",
    Callback = function(_) UpdateLighting() end
})

WorldBox:AddLabel("Outdoor Color"):AddColorPicker("WorldOutdoorAmbient", {
    Default = Color3.fromRGB(127, 127, 127),
    Title = "Outdoor Color",
    Callback = function(_) UpdateLighting() end
})

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if Toggles.EnableSkybox and Toggles.EnableSkybox.Value then
                UpdateSkybox(Options.SkyboxPreset.Value)
            end
            UpdateLighting()
        end)
    end
end)

RunService.RenderStepped:Connect(function()
    if not Workspace.CurrentCamera then return end
    local CamCF = Workspace.CurrentCamera.CFrame
    if WeatherPart then WeatherPart.CFrame = CamCF * CFrame.new(0, 30, 0) end
end)

-- =========================================================================
-- [ SKIN CHANGER SYSTEM ]
-- =========================================================================

local RS = ReplicatedStorage

local G = {
    knifeChangerSupported = true,
    executor = (identifyexecutor and identifyexecutor()) or "Unknown",
    inspectWarningShown = false
}

if string.find(G.executor, "RonixExploit", 1, true) or string.find(G.executor, "Xeno", 1, true) or string.find(G.executor, "Solara", 1, true) then
    G.knifeChangerSupported = false
end

local SD = {SkinsRoot = nil, SkinSelections = {}, GloveSelections = {}, GloveFolders = {}}

local function FindSkinsRoot()
    local ok, root = pcall(function()
        local assets = RS:FindFirstChild("Assets")
        if assets then return assets:FindFirstChild("Skins") end
        return nil
    end)
    if not ok then root = nil end
    if not root then
        local found
        pcall(function()
            for _, inst in ipairs(RS:GetDescendants()) do
                if inst.Name == "Skins" and inst:IsA("Folder") then
                    found = inst
                    break
                end
            end
        end)
        root = found
    end
    if not root and RS.Assets then
        local found
        pcall(function()
            for _, inst in ipairs(RS.Assets:GetDescendants()) do
                if inst.Name == "Skins" and inst:IsA("Folder") then
                    found = inst
                    break
                end
            end
        end)
        root = found
    end
    return root
end

pcall(function()
    SD.SkinsRoot = FindSkinsRoot()
end)

if SD.SkinsRoot then
    pcall(function()
        for _, wf in ipairs(SD.SkinsRoot:GetChildren()) do
            local skins = {}
            for _, sf in ipairs(wf:GetChildren()) do skins[#skins + 1] = sf.Name end
            table.sort(skins)
            SD.SkinSelections[wf.Name] = skins
        end
        for _, folder in ipairs(SD.SkinsRoot:GetChildren()) do
            if (folder.Name:match("Glove") or folder.Name:match("Gloves") or folder.Name == "Hand Wraps")
               and not (folder.Name:match("T Glove") or folder.Name:match("CT Glove") or folder.Name:match("T Gloves") or folder.Name:match("CT Gloves")) then
                SD.GloveFolders[#SD.GloveFolders + 1] = folder
            end
        end
    end)
end

for _, gf in ipairs(SD.GloveFolders) do
    local skins = {"Default"}
    for _, skin in ipairs(gf:GetChildren()) do skins[#skins + 1] = skin.Name end
    SD.GloveSelections[gf.Name] = skins
end

local Config = {
    SkinChanger = {Enabled = false, Skins = {}},
    KnifeChanger = {Enabled = false, Model = "Skeleton Knife"},
    GloveChanger = {Enabled = false, Gloves = {}, Model = "Sports Gloves", Skin = "Default"},
}

for w, s in pairs(SD.SkinSelections) do Config.SkinChanger.Skins[w] = s[1] or "Default" end
for _, gf in ipairs(SD.GloveFolders) do Config.GloveChanger.Gloves[gf.Name] = "Default" end

local Checkifbaseknife = {"CT Knife", "T Knife", "Knife"}
local function Checkknife(w)
    if not w then return false end
    for _, k in ipairs(Checkifbaseknife) do if w == k then return true end end
    return false
end

local SafeRequire = function(module)
    if not module then return nil end
    local success, result = pcall(function() return require(module) end)
    if success and result and type(result) == "table" then return result end
    return nil
end

local Router
pcall(function()
    local module = RS:FindFirstChild("Database") and RS.Database:FindFirstChild("Security") and RS.Database.Security:FindFirstChild("Router")
    if module then Router = SafeRequire(module) end
end)

local SkinsBox = Tabs.SkinChanger:AddLeftGroupbox("Weapon Skins", "palette")
local GlovesBox = Tabs.SkinChanger:AddRightGroupbox("Gloves Changer", "hand")
local KnifeBox = Tabs.SkinChanger:AddRightGroupbox("Knife Changer", "sword")

SkinsBox:AddToggle("EnableSkins", {
    Text = "Enable Weapon Skins",
    Default = false,
    Callback = function(v) Config.SkinChanger.Enabled = v end
})

local KM = {"Karambit", "Butterfly Knife", "Flip Knife", "Gut Knife", "M9 Bayonet", "Skeleton Knife", "Stiletto Knife"}
local EW = {"Driver Gloves", "Sports Gloves", "Operator Gloves", "Hand Wraps"}

KnifeBox:AddToggle("KnifeChangerToggle", {
    Text = "Enable Knife Changer",
    Default = false,
    Callback = function(v) Config.KnifeChanger.Enabled = v end
})

KnifeBox:AddDropdown("KnifeModel", {
    Text = "Knife Model",
    Values = KM,
    Default = "Skeleton Knife",
    Callback = function(v) Config.KnifeChanger.Model = v end
})

for _, kn in ipairs(KM) do
    local ks = SD.SkinSelections[kn]
    if ks then
        KnifeBox:AddDropdown("KnifeSkin_" .. kn, {
            Text = kn .. " Skin",
            Values = ks,
            Default = 1,
            Callback = function(v) Config.SkinChanger.Skins[kn] = v end
        })
    end
end

GlovesBox:AddToggle("GloveChangerToggle", {
    Text = "Enable Gloves Changer",
    Default = false,
    Callback = function(v) Config.GloveChanger.Enabled = v end
})

local GM = {}
for k in pairs(SD.GloveSelections) do GM[#GM + 1] = k end
table.sort(GM)

GlovesBox:AddDropdown("GloveModel", {
    Text = "Glove Model",
    Values = GM,
    Default = GM[1] or "Sports Gloves",
    Callback = function(v) Config.GloveChanger.Model = v end
})

for _, gFolder in ipairs(SD.GloveFolders) do
    local gName = gFolder.Name
    local gSkins = SD.GloveSelections[gName]
    if gSkins then
        GlovesBox:AddDropdown("GloveSkin_" .. gName, {
            Text = gName .. " Skin",
            Values = gSkins,
            Default = 1,
            Callback = function(v) Config.GloveChanger.Gloves[gName] = v end
        })
    end
end

for w, s in pairs(SD.SkinSelections) do
    if not table.find(KM, w) and not table.find(GM, w) and not table.find(EW, w) then
        SkinsBox:AddDropdown("Skin_" .. w, {
            Text = w,
            Values = s,
            Default = 1,
            Callback = function(v) Config.SkinChanger.Skins[w] = v end
        })
    end
end

task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if SD.SkinSelections then
                local count = 0
                for _ in pairs(SD.SkinSelections) do count = count + 1 end
                if count == 0 then
                    SD.SkinsRoot = FindSkinsRoot()
                    if SD.SkinsRoot then
                        for _, wf in ipairs(SD.SkinsRoot:GetChildren()) do
                            local skins = {}
                            for _, sf in ipairs(wf:GetChildren()) do skins[#skins + 1] = sf.Name end
                            table.sort(skins)
                            SD.SkinSelections[wf.Name] = skins
                        end
                    end
                end
            end
        end)
    end
end)

local function InitKnifeChanger()
    pcall(function()
        local SM = RS:FindFirstChild("Database") and RS.Database:FindFirstChild("Components") and
            RS.Database.Components:FindFirstChild("Libraries") and
            RS.Database.Components.Libraries:FindFirstChild("Skins")
        local VM = RS:FindFirstChild("Classes") and RS.Classes:FindFirstChild("WeaponComponent") and
            RS.Classes.WeaponComponent:FindFirstChild("Classes") and
            RS.Classes.WeaponComponent.Classes:FindFirstChild("Viewmodel")
        if not SM or not VM then return end

        local Sk = SafeRequire(SM)
        local Vm = SafeRequire(VM)
        if not Sk or not Vm then return end

        local oGCM = Sk.GetCameraModel
        Sk.GetCameraModel = function(w, sk, ...)
            if Config.KnifeChanger.Enabled and w and Checkknife(w) then
                local newKnife = Config.KnifeChanger.Model
                local newSkin = Config.SkinChanger.Skins[newKnife] or "Vanilla"
                local success, result = pcall(oGCM, newKnife, newSkin, ...)
                if success and result then return result end
            end
            local success, result = pcall(oGCM, w, sk, ...)
            if success then return result end
            return nil
        end

        local oGChM = Sk.GetCharacterModel
        Sk.GetCharacterModel = function(w, sk, ...)
            if Config.KnifeChanger.Enabled and w and Checkknife(w) then
                local newKnife = Config.KnifeChanger.Model
                local newSkin = Config.SkinChanger.Skins[newKnife] or "Vanilla"
                local success, result = pcall(oGChM, newKnife, newSkin, ...)
                if success and result then return result end
            end
            local success, result = pcall(oGChM, w, sk, ...)
            if success then return result end
            return nil
        end

        local oVN = Vm.new
        Vm.new = function(vc, w, sk, ...)
            if Config.KnifeChanger.Enabled and w and Checkknife(w) then
                local newKnife = Config.KnifeChanger.Model
                local newSkin = Config.SkinChanger.Skins[newKnife] or "Vanilla"
                local success, result = pcall(oVN, vc, newKnife, newSkin, ...)
                if success and result then return result end
            end
            local success, result = pcall(oVN, vc, w, sk, ...)
            if success then return result end
            return nil
        end

        if Sk.GetGloves then
            local oGG = Sk.GetGloves
            Sk.GetGloves = function(g, sk)
                if Config.GloveChanger.Enabled and Config.GloveChanger.Model then
                    local gModel = Config.GloveChanger.Model
                    local ts = Config.GloveChanger.Gloves[gModel] or "Default"
                    local success, result = pcall(oGG, gModel, ts)
                    if success and result then return result end
                end
                local success, result = pcall(oGG, g, sk)
                if success then return result end
                return nil
            end
        end
    end)
end

if G.knifeChangerSupported then InitKnifeChanger() end

local function UpdateInventoryNames()
    local invGui = LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("MainGui")
    if not invGui then return end
    local gameplay = invGui:FindFirstChild("Gameplay")
    if not gameplay then return end
    local bottom = gameplay:FindFirstChild("Bottom")
    if not bottom then return end
    local inv = bottom:FindFirstChild("Inventory")
    if not inv then return end
    local meleeSlot = inv:FindFirstChild("Melee")
    if meleeSlot and Config.KnifeChanger.Enabled then
        local weapon = meleeSlot:FindFirstChild("Weapon")
        if weapon then
            local weaponName = weapon:FindFirstChild("WeaponName")
            if weaponName and weaponName:IsA("TextLabel") then
                local knifeModel = Config.KnifeChanger.Model
                local sel = Config.SkinChanger.Skins[knifeModel]
                local star = utf8.char(9733)
                if sel and sel ~= "Default" then
                    weaponName.Text = star .. " " .. knifeModel .. " | " .. sel
                else
                    weaponName.Text = star .. " " .. knifeModel
                end
            end
        end
    end
end

local function GetWeaponModel()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    for _, ch in pairs(cam:GetChildren()) do
        if ch:IsA("Model") and ch.Name ~= "Arms" and ch.Name ~= "Arms1" and ch.Name ~= "Arms2" and ch.Name ~= "Viewmodel" then
            return ch
        end
    end
    return nil
end

local function ApplySkin()
    if not SD.SkinsRoot then return end
    local wm = GetWeaponModel()
    if not wm then return end
    local own = wm.Name
    local ewn = own
    local ca = false
    if Checkknife(own) then
        if Config.KnifeChanger.Enabled then ewn = Config.KnifeChanger.Model ca = true end
    else
        if Config.SkinChanger.Enabled then ca = true end
    end
    if not ca then return end
    local sel = Config.SkinChanger.Skins[ewn]
    if not sel or sel == "Default" then return end
    local wsf = SD.SkinsRoot:FindFirstChild(ewn)
    if not wsf then return end
    local sf = wsf:FindFirstChild(sel)
    if not sf then return end
    local cf = sf:FindFirstChild("Camera")
    if not cf then return end
    local fn = cf:FindFirstChild("Factory New")
    if not fn then return end
    for _, sa in pairs(fn:GetChildren()) do
        if sa:IsA("SurfaceAppearance") then
            local pt = wm:FindFirstChild(sa.Name, true)
            if pt and (pt:IsA("BasePart") or pt:IsA("MeshPart")) then
                for _, old in pairs(pt:GetChildren()) do
                    if old:IsA("SurfaceAppearance") then old:Destroy() end
                end
                sa:Clone().Parent = pt
            end
        end
    end
    UpdateInventoryNames()
end

local function ApplyGloves()
    if not Config.GloveChanger.Enabled then return end
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local am
    for _, ch in ipairs(cam:GetChildren()) do
        if ch:IsA("Model") and (ch.Name:match("Arms") or ch:FindFirstChild("Right Arm")) then
            am = ch
            break
        end
    end
    if not am then return end
    local la = am:FindFirstChild("Left Arm")
    local ra = am:FindFirstChild("Right Arm")
    if not la or not ra then return end
    local lg = la:FindFirstChild("Glove")
    local rg = ra:FindFirstChild("Glove")
    if not lg or not rg then return end
    for _, old in pairs(lg:GetChildren()) do if old:IsA("SurfaceAppearance") then old:Destroy() end end
    for _, old in pairs(rg:GetChildren()) do if old:IsA("SurfaceAppearance") then old:Destroy() end end
    local selectedModel = Config.GloveChanger.Model
    if not selectedModel then return end
    local sel = Config.GloveChanger.Gloves[selectedModel]
    if not sel or sel == "Default" then return end
    if not SD.SkinsRoot then return end
    local gloveSkinFolder = SD.SkinsRoot:FindFirstChild(selectedModel)
    if not gloveSkinFolder then return end
    local skinVariant = gloveSkinFolder:FindFirstChild(sel)
    if not skinVariant then return end
    local cameraFolder = skinVariant:FindFirstChild("Camera")
    if not cameraFolder then return end
    local factoryNew = cameraFolder:FindFirstChild("Factory New")
    if not factoryNew then return end
    for _, sa in pairs(factoryNew:GetChildren()) do
        if sa:IsA("SurfaceAppearance") then
            sa:Clone().Parent = lg
            sa:Clone().Parent = rg
        end
    end
end
task.spawn(function()
    while true do
        pcall(function()
            if Config.SkinChanger.Enabled or Config.KnifeChanger.Enabled then ApplySkin() end
            if Config.GloveChanger.Enabled then ApplyGloves() end
        end)
        task.wait(0.5)
    end
end)

-- =========================================================================
-- [ WEAPONS TAB ]
-- =========================================================================

local WeaponModsBox = Tabs.Combat:AddRightGroupbox("Weapon Mods", "wrench")
local GernadesBox = Tabs.Misc:AddRightGroupbox("Gernades", "bomb")

GernadesBox:AddToggle("Antiflashbang", {
    Text = "Enable No Flashbang",
    Default = false,
    Disabled = typeof(hookfunction) ~= "function",
    DisabledTooltip = "This feature is not available on your executor.",
})

GernadesBox:AddToggle("Antismoke", {
    Text = "Enable No Smoke",
    Default = false,
    Disabled = typeof(hookfunction) ~= "function",
    DisabledTooltip = "This feature is not available on your executor.",
})

WeaponModsBox:AddToggle("Firerate", {
    Text = "Enable Firerate Changer",
    Default = false,
})

WeaponModsBox:AddSlider("FirerateSlider", { Text = "Firerate", Default = 0.01, Min = 0, Max = 1, Rounding = 3 })

WeaponModsBox:AddToggle("NoRecoil", {
    Text = "Enable No Recoil",
    Default = false,
    Disabled = typeof(hookfunction) ~= "function",
    DisabledTooltip = "This feature is not available on your executor.",
})

WeaponModsBox:AddToggle("NoSpread", {
    Text = "Enable No Spread",
    Default = false,
    Disabled = typeof(hookfunction) ~= "function",
    DisabledTooltip = "This feature is not available on your executor.",
})

-- =========================================================================
-- [ COMBAT TAB - BLATANT + RAGE ]
-- =========================================================================

local RageBlatantBox = Tabs.Combat:AddLeftGroupbox("Ragebot", "flame")
local CombatBlatantBox = Tabs.Combat:AddLeftGroupbox("Silent Aim", "zap")

CombatBlatantBox:AddToggle("SilentAim", {
    Text = "Enable Silent Aim",
    Default = false,
    Disabled = typeof(hookfunction) ~= "function",
    DisabledTooltip = "This feature is not available on your executor.",
})

local BlatantDependencyBox = CombatBlatantBox:AddDependencyBox()

BlatantDependencyBox:AddToggle("SilentWallbang", { Text = "Wallbang", Default = false })

BlatantDependencyBox:AddToggle("SilentUseFovCircle", {
    Text = "Use FOV Circle",
    Default = false,
}):AddColorPicker("SilentFovColor", { Default = Color3.fromRGB(255, 0, 0), Title = "Silent FOV Color" })

BlatantDependencyBox:AddSlider("SilentFovCircleRadius", { Text = "FOV Radius", Default = 50, Min = 0, Max = 300, Rounding = 0 })

BlatantDependencyBox:AddDropdown("SilentHitPart", {
    Text = "Hit Selection",
    Values = {
        "HumanoidRootPart", "Head", "LeftLowerArm", "LowerTorso", "RightHand",
        "RightLowerArm", "LeftFoot", "LeftHand", "RightFoot", "RightLowerLeg",
        "LeftLowerLeg", "RightUpperArm", "LeftUpperArm", "UpperTorso", "RightUpperLeg", "LeftUpperLeg"
    },
    Default = "Head",
    Multi = false,
})

BlatantDependencyBox:AddToggle("SilentTeamCheck", { Text = "Enable Team Check", Default = true })
BlatantDependencyBox:SetupDependencies({ {Toggles.SilentAim, true} })

RageBlatantBox:AddToggle("Ragebot", {
    Text = "Enable Ragebot",
    Default = false,
    Disabled = typeof(hookfunction) ~= "function",
    DisabledTooltip = "This feature is not available on your executor.",
})

local RageDependencyBox = RageBlatantBox:AddDependencyBox()

RageDependencyBox:AddSlider("RageDelay", { Text = "Delay", Default = 0.01, Min = 0, Max = 1, Rounding = 3 })

RageDependencyBox:AddDropdown("RageHitPart", {
    Text = "Head / Hit Selection",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = "Head",
})

RageDependencyBox:AddToggle("RagebotVisibleCheck", { Text = "Enable Visible Check", Default = true })
RageDependencyBox:AddToggle("RagebotTeamCheck", { Text = "Enable Team Check", Default = true })
RageDependencyBox:AddToggle("RagebotWallCheck", { Text = "Enable Wall Check", Default = false })
RageDependencyBox:SetupDependencies({ {Toggles.Ragebot, true} })

RageDependencyBox:AddDivider()

local priorityTargetName = nil

local function refreshPriorityList()
    local names = {"[ AUTO ]"}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local pt = get_player_team(p)
            local lt = get_player_team(LP)
            if pt == nil or lt == nil or pt ~= lt then
                table.insert(names, p.Name)
            end
        end
    end
    return names
end

RageDependencyBox:AddDropdown("RagePriorityTarget", {
    Text    = "Priority Target",
    Values  = refreshPriorityList(),
    Default = "[ AUTO ]",
    Callback = function(v)
        priorityTargetName = (v == "[ AUTO ]") and nil or v
    end
})

RageDependencyBox:AddButton("Refresh List", function()
    Options.RagePriorityTarget:SetValues(refreshPriorityList())
    Options.RagePriorityTarget:SetValue("[ AUTO ]")
    priorityTargetName = nil
end)

-- =========================================================================
-- [ VISUALS TAB - ESP SYSTEM ]
-- =========================================================================

local VisualsESPBox = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")

VisualsESPBox:AddToggle("ESPEnabled",   { Text = "ESP Enabled", Default = false })
VisualsESPBox:AddToggle("ESPTeamCheck", { Text = "Team Check", Default = true })

VisualsESPBox:AddDropdown("ESPBoxType", {
    Text    = "Box ESP",
    Values  = {"2D Box","3D Box","Corner Box","Disabled"},
    Default = "2D Box",
})

VisualsESPBox:AddLabel("Box Color A"):AddColorPicker("ESPBoxColorA", { Default = Color3.fromRGB(255,255,255), Title = "Box Color A" })
VisualsESPBox:AddLabel("Box Color B"):AddColorPicker("ESPBoxColorB", { Default = Color3.fromRGB(0,200,255),   Title = "Box Color B" })

VisualsESPBox:AddToggle("ESPBoxFillGradient", { Text = "Fill Gradient", Default = false })
VisualsESPBox:AddLabel("Fill Color "):AddColorPicker("ESPFillColorA", { Default = Color3.fromRGB(255,50,50),  Title = "Fill Color A" })
VisualsESPBox:AddLabel("Fill Color "):AddColorPicker("ESPFillColorB", { Default = Color3.fromRGB(50,50,255),  Title = "Fill Color B" })
VisualsESPBox:AddToggle("ESPBoxFillRotation", { Text = "Fill Rotation", Default = false })
VisualsESPBox:AddSlider("ESPBoxRotationSpeed", { Text = "Rotation Speed", Min = 0.1, Max = 10, Default = 2, Rounding = 1 })

VisualsESPBox:AddToggle("ESPName", { Text = "Name ESP", Default = false })
VisualsESPBox:AddLabel("Name Color"):AddColorPicker("ESPNameColor", { Default = Color3.new(1,1,1), Title = "Name Color" })

VisualsESPBox:AddToggle("ESPHealth", { Text = "Health Bar", Default = false })
VisualsESPBox:AddLabel("Health Top Color"):AddColorPicker("ESPHealthTopColor",       { Default = Color3.fromRGB(0,255,0),   Title = "Health Top"    })
VisualsESPBox:AddLabel("Health Bottom Color"):AddColorPicker("ESPHealthBottomColor", { Default = Color3.fromRGB(255,0,0),   Title = "Health Bottom" })

VisualsESPBox:AddToggle("ESPHealthText", { Text = "Health Text", Default = false })
VisualsESPBox:AddLabel("HP Text Color"):AddColorPicker("ESPHealthTextColor",  { Default = Color3.new(1,1,1), Title = "HP Text Color" })

VisualsESPBox:AddToggle("ESPDistance", { Text = "Distance ESP", Default = false })
VisualsESPBox:AddLabel("Distance Color"):AddColorPicker("ESPDistanceColor",  { Default = Color3.new(1,1,1), Title = "Distance Color" })

VisualsESPBox:AddToggle("ESPWeapon", { Text = "Show Weapon Name", Default = false })
    :AddColorPicker("ESPWeaponColor", { Default = Color3.new(1,1,1), Title = "Weapon Color" })

VisualsESPBox:AddToggle("ESPTracer", { Text = "Tracer ESP", Default = false })
VisualsESPBox:AddLabel("Tracer Color"):AddColorPicker("ESPTracerColor",  { Default = Color3.new(1,1,1)             })
VisualsESPBox:AddLabel("Tracer Color "):AddColorPicker("ESPTracerColorB", { Default = Color3.fromRGB(255,0,128)     })
VisualsESPBox:AddDropdown("ESPTracerOrigin", {
    Text = "Tracer Origin", Values = {"Bottom","Top","Center","Mouse"}, Default = "Bottom",
})

VisualsESPBox:AddToggle("ESPSkeleton", { Text = "Skeleton ESP", Default = false })
VisualsESPBox:AddLabel("Skeleton Color"):AddColorPicker("ESPSkeletonColorA", { Default = Color3.new(1,1,1),         Title = "Skel A" })
VisualsESPBox:AddLabel("Skeleton Color "):AddColorPicker("ESPSkeletonColorB", { Default = Color3.fromRGB(0,255,255), Title = "Skel B" })

VisualsESPBox:AddToggle("ESPCircularTarget", { Text = "Circular Target", Default = false })
VisualsESPBox:AddLabel("Circular Target Color"):AddColorPicker("ESPCircularTargetColor", { Default = Color3.fromRGB(255,200,0), Title = "Circular Target Color" })

local ESPPreviewPanel = nil

-- =========================================================================
-- [ VEST DETAILS TEAM CHECK LOGIC ]
-- =========================================================================

local function hasVestDetails(character)
    if not character then return false end
    local armor = character:FindFirstChild("CharacterArmor")
    if armor and armor:FindFirstChild("VestDetails") then
        return true
    end
    return false
end

local function isCharacterAlly(targetChar)
    if not LP.Character then return false end
    local myHasVest = hasVestDetails(LP.Character)
    local targetHasVest = hasVestDetails(targetChar)
    
    if not myHasVest then
        return not targetHasVest
    else
        return targetHasVest
    end
end

local DEFAULT_ESP_COLOR = Color3.new(1,1,1)
getgenv().esplib_get_color = function(character) return DEFAULT_ESP_COLOR end

local function lerpColor(a,b,t)
    return Color3.new(a.R+(b.R-a.R)*t, a.G+(b.G-a.G)*t, a.B+(b.B-a.B)*t)
end

local _rotAngle = 0 

getgenv().esplib = {
    box = {
        enabled=false, type="2D",
        colorA=Color3.new(1,1,1), colorB=Color3.fromRGB(0,200,255),
        outline=Color3.new(0,0,0),
        fillGradient=false,
        fillColorA=Color3.fromRGB(255,50,50), fillColorB=Color3.fromRGB(50,50,255),
        fillRotation=false, rotationSpeed=2,
    },
    healthbar  = { enabled=false, topColor=Color3.fromRGB(0,255,0), bottomColor=Color3.fromRGB(255,0,0) },
    healthtext = { enabled=false, color=Color3.new(1,1,1), size=12 },
    name       = { enabled=false, fill=Color3.new(1,1,1), size=13 },
    distance   = { enabled=false, color=Color3.new(1,1,1), size=13 },
    tracer     = { enabled=false, fillA=Color3.new(1,1,1), fillB=Color3.fromRGB(255,0,128), outline=Color3.new(0,0,0), from="bottom" },
    skeleton   = { enabled=false, colorA=Color3.new(1,1,1), colorB=Color3.fromRGB(0,255,255), thickness=3.5 },
    weapon     = { enabled=false, fill=Color3.new(1,1,1), size=13 },
    circulartarget = { enabled=false, color=Color3.fromRGB(255,200,0) },
}

local esplib       = getgenv().esplib
local espinstances = {}
getgenv().esplib_instances = espinstances
local espfunctions = {}

local abs    = math.abs
local huge   = math.huge
local floor  = math.floor
local clamp  = math.clamp
local sin    = math.sin
local cos    = math.cos
local pi     = math.pi
local pi2    = pi * 2

local SKELETON_BONES_R6 = {
    {"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},
    {"Torso","Left Leg"},{"Torso","Right Leg"},
}
local SKELETON_BONES_R15 = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}
local AABB_CORNER_SIGNS = {
    {0,0,0},{1,0,0},{0,1,0},{1,1,0},{0,0,1},{1,0,1},{0,1,1},{1,1,1},
}
local BOX_3D_EDGES = {
    {1,2},{2,4},{4,3},{3,1},{5,6},{6,8},{8,7},{7,5},{1,5},{2,6},{3,7},{4,8},
}

local WorldToViewportPoint = Camera.WorldToViewportPoint
local boxCfg        = esplib.box
local healthCfg     = esplib.healthbar
local healthTextCfg = esplib.healthtext
local nameCfg       = esplib.name
local distCfg       = esplib.distance
local tracerCfg     = esplib.tracer
local skeletonCfg   = esplib.skeleton
local weaponCfg     = esplib.weapon
local circularTargetCfg = esplib.circulartarget

local WIDTH_MULT    = 0.52
local TOP_EXTRA     = -0.3
local BOTTOM_EXTRA  = 1.0
local BOX_THICKNESS = 1

getgenv().ESP_SetWidth = function(v) WIDTH_MULT = v or 0.65 end
getgenv().ESP_SetBottom = function(v) BOTTOM_EXTRA = v or 1.5 end
getgenv().ESP_SetTop = function(v) TOP_EXTRA = v or 0.2 end
getgenv().ESP_SetColor = function(c) boxCfg.colorA = c; boxCfg.colorB = c end
getgenv().ESP_Enable = function() boxCfg.enabled = true end
getgenv().ESP_Disable = function() boxCfg.enabled = false end

local partHalfExtentCache = setmetatable({},{__mode="k"})

local function get_part_half_extent(part)
    local c = partHalfExtentCache[part]
    if not c then
        local s=part.Size; c={hx=s.X*.5,hy=s.Y*.5,hz=s.Z*.5}; partHalfExtentCache[part]=c
    end
    return c.hx,c.hy,c.hz
end

local function compute_world_aabb(parts)
    local x0,y0,z0= huge, huge, huge
    local x1,y1,z1=-huge,-huge,-huge
    for i=1,#parts do
        local p=parts[i]
        local hx,hy,hz=get_part_half_extent(p)
        local px,py,pz,r00,r01,r02,r10,r11,r12,r20,r21,r22=p.CFrame:GetComponents()
        local ex=abs(r00)*hx+abs(r01)*hy+abs(r02)*hz
        local ey=abs(r10)*hx+abs(r11)*hy+abs(r12)*hz
        local ez=abs(r20)*hx+abs(r21)*hy+abs(r22)*hz
        if px-ex<x0 then x0=px-ex end; if py-ey<y0 then y0=py-ey end; if pz-ez<z0 then z0=pz-ez end
        if px+ex>x1 then x1=px+ex end; if py+ey>y1 then y1=py+ey end; if pz+ez>z1 then z1=pz+ez end
    end
    if x0==huge then return nil end
    return x0,y0,z0,x1,y1,z1
end

local function project_extents(x0,y0,z0,x1,y1,z1)
    local cx=(x0+x1)*.5; local cz=(z0+z1)*.5
    local topW  = Vector3.new(cx, y1 + TOP_EXTRA, cz)
    local botW  = Vector3.new(cx, y0 - BOTTOM_EXTRA, cz)
    local camPos = Camera.CFrame.Position
    local camLook = Camera.CFrame.LookVector
    if (topW - camPos):Dot(camLook) <= 0.5 or (botW - camPos):Dot(camLook) <= 0.5 then
        return nil, nil, false
    end
    local spTop, onTop = WorldToViewportPoint(Camera, topW)
    local spBot, onBot = WorldToViewportPoint(Camera, botW)
    if not onTop or not onBot then return nil, nil, false end
    if spTop.Z <= 0.5 or spBot.Z <= 0.5 then return nil, nil, false end
    local vp = Camera.ViewportSize
    if math.abs(spTop.X) > vp.X * 2 or math.abs(spBot.X) > vp.X * 2 then return nil, nil, false end
    local topY = spTop.Y
    local botY = spBot.Y
    if botY <= topY then return nil, nil, false end
    local h = botY - topY
    local w = h * WIDTH_MULT
    local cxS = spTop.X
    return Vector2.new(cxS - w * 0.5, topY), Vector2.new(cxS + w * 0.5, botY), true
end

local function project_aabb_corners_3d(x0,y0,z0,x1,y1,z1)
    local sc={}; local on=false
    for i=1,8 do
        local s=AABB_CORNER_SIGNS[i]
        local wx=s[1]==0 and x0 or x1; local wy=s[2]==0 and y0 or y1; local wz=s[3]==0 and z0 or z1
        local pos,vis=WorldToViewportPoint(Camera,Vector3.new(wx,wy,wz))
        sc[i]=Vector2.new(pos.X,pos.Y); if vis then on=true end
    end
    return sc,on
end

local function ensure_character_parts(instance,data)
    if data.partlist then return data.partlist end
    local list={}; local idx=setmetatable({},{__mode="k"})
    local function add(p)
        if p:IsA("BasePart") and not idx[p] then
            list[#list+1]=p; idx[p]=#list
            local c=p:GetPropertyChangedSignal("Size"):Connect(function() partHalfExtentCache[p]=nil end)
            data.sizeConns=data.sizeConns or {}; data.sizeConns[p]=c
        end
    end
    local function rem(p)
        local i=idx[p]; if not i then return end
        local last=#list; local lp=list[last]
        list[i]=lp; idx[lp]=i; list[last]=nil; idx[p]=nil
        if data.sizeConns and data.sizeConns[p] then data.sizeConns[p]:Disconnect(); data.sizeConns[p]=nil end
    end
    if instance:IsA("Model") then
        for _,p in next,instance:GetDescendants() do add(p) end
        data.partConnAdd=instance.DescendantAdded:Connect(add)
        data.partConnRemove=instance.DescendantRemoving:Connect(rem)
    elseif instance:IsA("BasePart") then add(instance) end
    data.partlist=list; return list
end

local MAX_FILL_LINES = 400 

local function setupFillLines()
    local lines = {}
    for i = 1, MAX_FILL_LINES do
        local l = Drawing.new("Line")
        l.Thickness = 4.0
        l.Transparency = 0.3
        l.Visible = false
        lines[i] = l
    end
    return lines
end

local function drawFillGradient360(fillLines, x, y, w, h, colorA, colorB, angle)
    local dx = cos(angle)
    local dy = sin(angle)
    local cx = x + w * 0.5
    local cy = y + h * 0.5
    local maxDot = math.max((abs(dx) * w + abs(dy) * h) * 0.5, 1)

    local targetRows = math.clamp(math.floor(h * 0.8), 15, MAX_FILL_LINES)
    local rowH = h / targetRows

    for i = 1, targetRows do
        local py = y + (i - 0.5) * rowH
        local dotL = ((x     - cx) * dx + (py - cy) * dy) / maxDot
        local dotR = ((x + w - cx) * dx + (py - cy) * dy) / maxDot
        local tL = clamp(dotL * 0.5 + 0.5, 0, 1)
        local tR = clamp(dotR * 0.5 + 0.5, 0, 1)
        
        local line = fillLines[i]
        line.Color = lerpColor(colorA, colorB, (tL + tR) * 0.5)
        line.Thickness = math.clamp(rowH + 1.5, 2, 8) 
        line.From  = Vector2.new(x + 1, py)
        line.To    = Vector2.new(x + w - 1, py)
        line.Visible = true
    end
    for i = targetRows + 1, #fillLines do 
        fillLines[i].Visible = false 
    end
end

local GRAD_STEPS = 4
local function drawBoxOutlineGradient(box, x, y, w, h, colorA, colorB, rotOff)
    local grad=box.grad_lines; local idx=0
    local sides={{x,y,x+w,y},{x+w,y,x+w,y+h},{x+w,y+h,x,y+h},{x,y+h,x,y}}
    for si=1,4 do
        local s=sides[si]; local x1,y1,x2,y2=s[1],s[2],s[3],s[4]
        for step=0,GRAD_STEPS-1 do
            idx=idx+1
            local tA=step/GRAD_STEPS; local tB=(step+1)/GRAD_STEPS
            local tMid=(((si-1)/4)+(tA/4)+rotOff)%1
            local col=lerpColor(colorA,colorB,tMid)
            local line=grad[idx]
            if line then
                line.From=Vector2.new(x1+(x2-x1)*tA,y1+(y2-y1)*tA)
                line.To  =Vector2.new(x1+(x2-x1)*tB,y1+(y2-y1)*tB)
                line.Color=col; line.Visible=true
            end
        end
    end
    for i=idx+1,#grad do grad[i].Visible=false end
end

local function hideBox(box)
    box.outline.Visible=false; box.fill.Visible=false
    for _,l in ipairs(box.grad_lines)      do l.Visible=false end
    for _,l in ipairs(box.fill_grad_lines)  do l.Visible=false end
    for _,l in ipairs(box.corner_fill)     do l.Visible=false end
    for _,l in ipairs(box.corner_outline)   do l.Visible=false end
    for _,l in ipairs(box.box_3d_lines)    do l.Visible=false end
end

function espfunctions.add_box(instance)
    if not instance or (espinstances[instance] and espinstances[instance].box) then return end
    local function mkLine(th) local l=Drawing.new("Line"); l.Thickness=th; l.Transparency=1; l.Visible=false; return l end
    local function mkSq(th,f) local s=Drawing.new("Square"); s.Thickness=th; s.Filled=f; s.Transparency=1; s.Visible=false; return s end
    local box={}
    box.outline=mkSq(BOX_THICKNESS + 2,false); box.fill=mkSq(BOX_THICKNESS,false)
    box.grad_lines={}; for i=1,16 do box.grad_lines[i]=mkLine(BOX_THICKNESS) end
    box.fill_grad_lines = setupFillLines()
    box.corner_fill={}; box.corner_outline={}
    for i=1,8 do box.corner_fill[i]=mkLine(BOX_THICKNESS); box.corner_outline[i]=mkLine(BOX_THICKNESS + 2) end
    box.box_3d_lines={}; for i=1,12 do box.box_3d_lines[i]=mkLine(BOX_THICKNESS) end
    espinstances[instance]=espinstances[instance] or {}
    espinstances[instance].box=box
end

local MAX_HP_SEGMENTS = 12

function espfunctions.add_healthbar(instance)
    if not instance or (espinstances[instance] and espinstances[instance].healthbar) then return end
    local bg = Drawing.new("Square")
    bg.Thickness = 1
    bg.Filled = true
    bg.Color = Color3.new(0, 0, 0)
    bg.Transparency = 0.5
    bg.Visible = false

    local segs = {}
    for i = 1, MAX_HP_SEGMENTS do
        local l = Drawing.new("Line")
        l.Thickness = 3
        l.Transparency = 1
        l.Visible = false
        segs[i] = l
    end

    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].healthbar = { background = bg, segments = segs }
end

function espfunctions.add_healthtext(instance)
    if not instance or (espinstances[instance] and espinstances[instance].healthtext) then return end
    local t = Drawing.new("Text")
    t.Center = false
    t.Outline = true
    t.Font = 1
    t.Transparency = 1
    t.Visible = false
    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].healthtext = t
end

function espfunctions.add_name(instance)
    if not instance or (espinstances[instance] and espinstances[instance].name) then return end
    local t=Drawing.new("Text"); t.Center=true; t.Outline=true; t.Font=1; t.Transparency=1
    espinstances[instance]=espinstances[instance] or {}; espinstances[instance].name=t
end

function espfunctions.add_distance(instance)
    if not instance or (espinstances[instance] and espinstances[instance].distance) then return end
    local t=Drawing.new("Text"); t.Center=true; t.Outline=true; t.Font=1; t.Transparency=1
    espinstances[instance]=espinstances[instance] or {}; espinstances[instance].distance=t
end

function espfunctions.add_tracer(instance)
    if not instance or (espinstances[instance] and espinstances[instance].tracer) then return end
    local o=Drawing.new("Line"); o.Thickness=3; o.Transparency=1
    local f=Drawing.new("Line"); f.Thickness=1; f.Transparency=1
    espinstances[instance]=espinstances[instance] or {}; espinstances[instance].tracer={outline=o,fill=f}
end

function espfunctions.add_skeleton(instance,options)
    if not instance or (espinstances[instance] and espinstances[instance].skeleton) then return end
    options=options or {}
    local isR15=instance:FindFirstChild("UpperTorso")~=nil
    local bones=isR15 and SKELETON_BONES_R15 or SKELETON_BONES_R6
    local lines={}; local bp={}
    for i=1,#bones do
        local l=Drawing.new("Line"); l.Thickness=options.thickness or 2; l.Transparency=1; l.Visible=false; lines[i]=l
        bp[i]={instance:FindFirstChild(bones[i][1]),instance:FindFirstChild(bones[i][2])}
    end
    espinstances[instance]=espinstances[instance] or {}
    espinstances[instance].skeleton={lines=lines,bone_parts=bp,screenCache={}}
end

function espfunctions.add_weapon(instance)
    if not instance or (espinstances[instance] and espinstances[instance].weapon) then return end
    local t=Drawing.new("Text"); t.Center=true; t.Outline=true; t.Font=1; t.Transparency=1; t.Visible=false
    espinstances[instance]=espinstances[instance] or {}; espinstances[instance].weapon=t
end

function espfunctions.add_circulartarget(instance)
    if not instance or (espinstances[instance] and espinstances[instance].circulartarget) then return end
    local SEGS=32; local lines={}
    for i=1,SEGS do local l=Drawing.new("Line"); l.Thickness=1.5; l.Transparency=1; l.Visible=false; lines[i]=l end
    
    local TRAIL_SEGS = 25
    local trailLines = {}
    local neonGlowLines = {}
    for i = 1, TRAIL_SEGS do 
        local l = Drawing.new("Line")
        l.Thickness = 2.5
        l.Transparency = 0.4
        l.Visible = false
        trailLines[i] = l

        local glow = Drawing.new("Line")
        glow.Thickness = 5.0
        glow.Transparency = 0.15
        glow.Visible = false
        neonGlowLines[i] = glow
    end
    
    espinstances[instance]=espinstances[instance] or {}
    espinstances[instance].circulartarget={
        lines = lines, 
        trailLines = trailLines, 
        neonGlowLines = neonGlowLines, 
        segments = SEGS, 
        alpha = 0, 
        movingUp = true, 
        trailHistory = {}
    }
end

local function hide_all(data)
    if data.box      then hideBox(data.box) end
    if data.healthbar then 
        data.healthbar.background.Visible=false
        for _,seg in ipairs(data.healthbar.segments) do seg.Visible=false end
    end
    if data.healthtext then data.healthtext.Visible=false end
    if data.name      then data.name.Visible=false end
    if data.distance  then data.distance.Visible=false end
    if data.tracer    then data.tracer.outline.Visible=false; data.tracer.fill.Visible=false end
    if data.skeleton  then for _,l in ipairs(data.skeleton.lines) do l.Visible=false end end
    if data.weapon    then data.weapon.Visible=false end
    if data.circulartarget then 
        for _,l in ipairs(data.circulartarget.lines) do l.Visible=false end 
        for _,l in ipairs(data.circulartarget.trailLines) do l.Visible=false end
        for _,l in ipairs(data.circulartarget.neonGlowLines) do l.Visible=false end
    end
end

local function cleanup_instance(instance,data)
    pcall(function()
        if data.box then
            data.box.outline:Remove(); data.box.fill:Remove()
            for _,l in next,data.box.grad_lines      do l:Remove() end
            for _,l in next,data.box.fill_grad_lines  do l:Remove() end
            for _,l in next,data.box.corner_fill      do l:Remove() end
            for _,l in next,data.box.corner_outline   do l:Remove() end
            for _,l in next,data.box.box_3d_lines     do l:Remove() end
        end
        if data.healthbar  then 
            data.healthbar.background:Remove()
            for _,seg in ipairs(data.healthbar.segments) do seg:Remove() end
        end
        if data.healthtext then data.healthtext:Remove() end
        if data.name       then data.name:Remove() end
        if data.distance   then data.distance:Remove() end
        if data.tracer     then data.tracer.outline:Remove(); data.tracer.fill:Remove() end
        if data.skeleton   then for _,l in next,data.skeleton.lines do l:Remove() end end
        if data.weapon     then data.weapon:Remove() end
        if data.circulartarget then 
            for _,l in ipairs(data.circulartarget.lines) do l:Remove() end 
            for _,l in ipairs(data.circulartarget.trailLines) do l:Remove() end
            for _,l in ipairs(data.circulartarget.neonGlowLines) do l:Remove() end
        end
        if data.partConnAdd    then data.partConnAdd:Disconnect() end
        if data.partConnRemove then data.partConnRemove:Disconnect() end
        if data.sizeConns then for _,c in next,data.sizeConns do c:Disconnect() end end
    end)
end

local weaponAttrCache={}; local weaponNameCache={}
local function GetWeaponName(player)
    if not player then return "None" end
    local attr=player:GetAttribute("CurrentEquipped")
    if attr~=weaponAttrCache[player] then
        weaponAttrCache[player]=attr
        if attr then
            local ok,dec=pcall(function() return game:GetService("HttpService"):JSONDecode(attr) end)
            weaponNameCache[player]=(ok and dec and dec.Name) or "None"
        else weaponNameCache[player]="None" end
    end
    return weaponNameCache[player] or "None"
end

local function get_cached_screen_pos(cache,part)
    local c=cache[part]; if c then return c[1],c[2] end
    local pos,vis=WorldToViewportPoint(Camera,part.Position)
    local sp=Vector2.new(pos.X,pos.Y); cache[part]={sp,vis}; return sp,vis
end

RunService.RenderStepped:Connect(function(dt)
    if boxCfg.fillRotation then
        _rotAngle = (_rotAngle + dt * (boxCfg.rotationSpeed or 2)) % pi2
    end

    local camPos          = Camera.CFrame.Position
    local vp              = Camera.ViewportSize
    local teamCheck       = Toggles.ESPTeamCheck and Toggles.ESPTeamCheck.Value
    local rotOff1         = _rotAngle / pi2

    for instance,data in next,espinstances do
        if not instance or not instance.Parent then
            cleanup_instance(instance,data); espinstances[instance]=nil; continue
        end
        
        if instance == LP.Character then
            hide_all(data); continue
        end
        -- Не рисовать ESP на GirlModel и на моделях внутри персонажа LP
        if instance.Name == "GirlModel_Custom" then
            hide_all(data); continue
        end
        if LP.Character and instance:IsDescendantOf(LP.Character) then
            hide_all(data); continue
        end

        if instance:IsA("Model") and not instance.PrimaryPart then 
            local head = instance:FindFirstChild("Head")
            local torso = instance:FindFirstChild("HumanoidRootPart") or instance:FindFirstChild("Torso") or instance:FindFirstChild("UpperTorso")
            if head then instance.PrimaryPart = head elseif torso then instance.PrimaryPart = torso end
        end

        if teamCheck and isCharacterAlly(instance) then
            hide_all(data); continue
        end

        local healthAttr = instance:GetAttribute("Health")
        local maxHealthAttr = instance:GetAttribute("MaxHealth") or 100
        local isDeadAttr = instance:GetAttribute("Dead")

        if isDeadAttr == true or (healthAttr and healthAttr <= 0) then 
            hide_all(data)
            continue 
        end

        local needBox    = boxCfg.enabled      and data.box      ~=nil
        local needHp     = healthCfg.enabled   and data.healthbar~=nil
        local needHpTxt  = healthTextCfg.enabled and data.healthtext~=nil
        local needName   = nameCfg.enabled     and data.name     ~=nil
        local needDist   = distCfg.enabled     and data.distance ~=nil
        local needTracer = tracerCfg.enabled   and data.tracer   ~=nil
        local needSkel   = skeletonCfg.enabled and data.skeleton ~=nil
        local needWep    = weaponCfg.enabled   and data.weapon   ~=nil
        local needCirc   = circularTargetCfg.enabled and data.circulartarget ~=nil

        if data.box      and not needBox    then hideBox(data.box) end
        if data.healthbar and not needHp    then 
            data.healthbar.background.Visible=false
            for _,seg in ipairs(data.healthbar.segments) do seg.Visible=false end
        end
        if data.healthtext and not needHpTxt then data.healthtext.Visible=false end
        if data.name     and not needName   then data.name.Visible=false end
        if data.distance and not needDist   then data.distance.Visible=false end
        if data.tracer   and not needTracer then data.tracer.outline.Visible=false; data.tracer.fill.Visible=false end
        if data.skeleton and not needSkel   then for _,l in ipairs(data.skeleton.lines) do l.Visible=false end end
        if data.weapon   and not needWep    then data.weapon.Visible=false end
        if data.circulartarget then 
            if not needCirc then 
                for _,l in ipairs(data.circulartarget.lines) do l.Visible=false end 
                for _,l in ipairs(data.circulartarget.trailLines) do l.Visible=false end
                for _,l in ipairs(data.circulartarget.neonGlowLines) do l.Visible=false end
            end
        end

        if not(needBox or needHp or needHpTxt or needName or needDist or needTracer or needSkel or needWep or needCirc) then continue end

        local parts=ensure_character_parts(instance,data)
        local min2,max2,onscreen=nil,nil,false
        local c3d,on3d=nil,false

        local x0,y0,z0,x1,y1,z1=compute_world_aabb(parts)
        if x0 then
            min2,max2,onscreen=project_extents(x0,y0,z0,x1,y1,z1)
            if needBox and boxCfg.type=="3D" then
                c3d,on3d=project_aabb_corners_3d(x0,y0,z0,x1,y1,z1)
            end
        end

        if data.box then
            if needBox and onscreen and min2 and max2 then
                local x,y = min2.X,min2.Y
                local w   = max2.X-min2.X
                local h   = max2.Y-min2.Y
                local cA  = boxCfg.colorA; local cB=boxCfg.colorB
                local fA  = boxCfg.fillColorA; local fB=boxCfg.fillColorB

                if boxCfg.type=="2D" then
                    if boxCfg.fillGradient then
                        drawFillGradient360(data.box.fill_grad_lines, x, y, w, h, fA, fB, _rotAngle)
                    else
                        for _,l in ipairs(data.box.fill_grad_lines) do l.Visible=false end
                    end
                    drawBoxOutlineGradient(data.box, x, y, w, h, cA, cB, rotOff1)
                    data.box.outline.Visible=false; data.box.fill.Visible=false
                    for _,l in ipairs(data.box.corner_fill)   do l.Visible=false end
                    for _,l in ipairs(data.box.corner_outline) do l.Visible=false end
                    for _,l in ipairs(data.box.box_3d_lines)   do l.Visible=false end

                elseif boxCfg.type=="Corner" then
                    for _,l in ipairs(data.box.grad_lines) do l.Visible=false end
                    data.box.outline.Visible=false; data.box.fill.Visible=false
                    if boxCfg.fillGradient then
                        drawFillGradient360(data.box.fill_grad_lines, x, y, w, h, fA, fB, _rotAngle)
                    else for _,l in ipairs(data.box.fill_grad_lines) do l.Visible=false end end
                    
                    local len=math.min(w,h)*.25
                    local corners={
                        {Vector2.new(x,y),     Vector2.new(x+len,y)  },
                        {Vector2.new(x,y),     Vector2.new(x,y+len)  },
                        {Vector2.new(x+w-len,y),Vector2.new(x+w,y)   },
                        {Vector2.new(x+w,y),   Vector2.new(x+w,y+len)},
                        {Vector2.new(x,y+h),   Vector2.new(x+len,y+h)},
                        {Vector2.new(x,y+h-len),Vector2.new(x,y+h)   },
                        {Vector2.new(x+w-len,y+h),Vector2.new(x+w,y+h)},
                        {Vector2.new(x+w,y+h-len),Vector2.new(x+w,y+h)},
                    }
                    for i=1,8 do
                        local t=(i-1)/8; local col=lerpColor(cA,cB,t)
                        data.box.corner_outline[i].From=corners[i][1]; data.box.corner_outline[i].To=corners[i][2]
                        data.box.corner_outline[i].Color=boxCfg.outline; data.box.corner_outline[i].Visible=true
                        data.box.corner_fill[i].From=corners[i][1]; data.box.corner_fill[i].To=corners[i][2]
                        data.box.corner_fill[i].Color=col; data.box.corner_fill[i].Visible=true
                    end
                    for _,l in ipairs(data.box.box_3d_lines) do l.Visible=false end

                elseif boxCfg.type=="3D" then
                    for _,l in ipairs(data.box.fill_grad_lines) do l.Visible=false end
                    for _,l in ipairs(data.box.grad_lines)      do l.Visible=false end
                    data.box.outline.Visible=false; data.box.fill.Visible=false
                    for _,l in ipairs(data.box.corner_fill)   do l.Visible=false end
                    for _,l in ipairs(data.box.corner_outline) do l.Visible=false end
                    if c3d and #c3d==8 then
                        for i=1,12 do
                            local e=BOX_3D_EDGES[i]
                            data.box.box_3d_lines[i].From=c3d[e[1]]; data.box.box_3d_lines[i].To=c3d[e[2]]
                            data.box.box_3d_lines[i].Color=lerpColor(cA,cB,(i-1)/12)
                            data.box.box_3d_lines[i].Visible=on3d
                        end
                    else for _,l in ipairs(data.box.box_3d_lines) do l.Visible=false end end
                end
            else hideBox(data.box) end
        end

        if data.healthbar then
            local bg = data.healthbar.background
            local segs = data.healthbar.segments
            if needHp and onscreen and min2 and max2 and healthAttr then
                local x = min2.X - 6
                local y = min2.Y
                local w = 3
                local h = max2.Y - min2.Y
                
                local maxHp = maxHealthAttr > 0 and maxHealthAttr or 100
                local hpFraction = clamp(healthAttr / maxHp, 0, 1)
                
                bg.Position = Vector2.new(x - 1, y - 1)
                bg.Size = Vector2.new(w + 2, h + 2)
                bg.Visible = true

                local barHeight = h * hpFraction
                local startY = y + (h - barHeight)
                
                local activeSegCount = math.clamp(math.floor(MAX_HP_SEGMENTS * hpFraction), 1, MAX_HP_SEGMENTS)
                local segH = barHeight / activeSegCount

                for i = 1, MAX_HP_SEGMENTS do
                    local segLine = segs[i]
                    if i <= activeSegCount then
                        local segmentFraction = (i - 0.5) / MAX_HP_SEGMENTS
                        segLine.Color = lerpColor(healthCfg.bottomColor, healthCfg.topColor, segmentFraction)
                        
                        local py1 = startY + (i - 1) * segH
                        local py2 = startY + i * segH
                        
                        segLine.From = Vector2.new(x + w * 0.5, py1)
                        segLine.To = Vector2.new(x + w * 0.5, py2)
                        segLine.Thickness = w
                        segLine.Visible = true
                    else
                        segLine.Visible = false
                    end
                end
            else
                bg.Visible = false
                for _,seg in ipairs(segs) do seg.Visible = false end
            end
        end

        if data.healthtext then
            if needHpTxt and onscreen and min2 and max2 and healthAttr then
                local currentHp = math.floor(healthAttr + 0.5)
                local maxHp = maxHealthAttr > 0 and maxHealthAttr or 100
                
                data.healthtext.Text = tostring(currentHp)
                data.healthtext.Size = healthTextCfg.size
                data.healthtext.Color = healthTextCfg.color
                
                local textX = max2.X + 4
                local textY = min2.Y + (max2.Y - min2.Y) * (1 - (healthAttr / maxHp)) - 4
                data.healthtext.Position = Vector2.new(textX, textY)
                data.healthtext.Visible = true
            else
                data.healthtext.Visible = false
            end
        end

        if data.name then
            if needName and onscreen and min2 and max2 then
                data.name.Text=instance.Name; data.name.Size=nameCfg.size; data.name.Color=nameCfg.fill
                data.name.Position=Vector2.new((min2.X+max2.X)*.5,min2.Y-15); data.name.Visible=true
            else data.name.Visible=false end
        end

        if data.distance then
            if needDist and onscreen and min2 and max2 then
                local dist=999
                if instance:IsA("Model") and instance.PrimaryPart then dist=(camPos-instance.PrimaryPart.Position).Magnitude
                elseif instance:IsA("BasePart") then dist=(camPos-instance.Position).Magnitude end
                data.distance.Text=tostring(floor(dist)).."m"; data.distance.Size=distCfg.size
                data.distance.Color=distCfg.color
                data.distance.Position=Vector2.new((min2.X+max2.X)*.5,max2.Y+2); data.distance.Visible=true
            else data.distance.Visible=false end
        end

        if data.weapon then
            if needWep and onscreen and min2 and max2 then
                if not data.player then data.player=Players:GetPlayerFromCharacter(instance) end
                local wn=data.player and GetWeaponName(data.player) or "None"
                data.weapon.Text="["..wn.."]"; data.weapon.Size=weaponCfg.size or 13
                data.weapon.Color=weaponCfg.fill
                data.weapon.Position=Vector2.new((min2.X+max2.X)*.5,max2.Y+15)
                data.weapon.Center=true; data.weapon.Visible=true
            else data.weapon.Visible=false end
        end

        if data.tracer then
            if needTracer and onscreen and min2 and max2 then
                local from_pos
                if tracerCfg.from=="mouse" then local ml=UserInputService:GetMouseLocation(); from_pos=Vector2.new(ml.X,ml.Y)
                elseif tracerCfg.from=="top" then from_pos=Vector2.new(vp.X/2,0)
                elseif tracerCfg.from=="center" then from_pos=Vector2.new(vp.X/2,vp.Y/2)
                else from_pos=Vector2.new(vp.X/2,vp.Y) end
                local to_pos=(min2+max2)/2
                local dist=0
                if instance:IsA("Model") and instance.PrimaryPart then dist=clamp((camPos-instance.PrimaryPart.Position).Magnitude/200,0,1) end
                local col=lerpColor(tracerCfg.fillA,tracerCfg.fillB,dist)
                data.tracer.outline.From=from_pos; data.tracer.outline.To=to_pos; data.tracer.outline.Color=tracerCfg.outline; data.tracer.outline.Visible=true
                data.tracer.fill.From=from_pos; data.tracer.fill.To=to_pos; data.tracer.fill.Color=col; data.tracer.fill.Visible=true
            else data.tracer.outline.Visible=false; data.tracer.fill.Visible=false end
        end

        if data.skeleton then
            if needSkel then
                local bp=data.skeleton.bone_parts; local lines=data.skeleton.lines; local sc=data.skeleton.screenCache
                for k in next,sc do sc[k]=nil end
                local anyDrawn = false
                for i=1,#bp do
                    local pair=bp[i]; local pA,pB=pair[1],pair[2]; local line=lines[i]
                    if pA and pB and pA.Parent and pB.Parent then
                        local posA,vA=get_cached_screen_pos(sc,pA); local posB,vB=get_cached_screen_pos(sc,pB)
                        if vA or vB then
                            line.From=posA; line.To=posB
                            line.Color=lerpColor(skeletonCfg.colorA,skeletonCfg.colorB,(i-1)/#bp)
                            line.Thickness=skeletonCfg.thickness; line.Visible=true
                            anyDrawn = true
                        else line.Visible=false end
                    else line.Visible=false end
                end
                if not anyDrawn then for _,l in ipairs(lines) do l.Visible=false end end
            else for _,l in ipairs(data.skeleton.lines) do l.Visible=false end end
        end

        if data.circulartarget then
            local ct = data.circulartarget
            local head = instance:FindFirstChild("Head")
            local root = instance:IsA("Model") and instance.PrimaryPart or instance:FindFirstChild("HumanoidRootPart") or head
            
            if needCirc and head and root then
                local speed = 2.0 
                if ct.movingUp then
                    ct.alpha = ct.alpha + dt * speed
                    if ct.alpha >= 1 then ct.alpha = 1; ct.movingUp = false end
                else
                    ct.alpha = ct.alpha - dt * speed
                    if ct.alpha <= 0 then ct.alpha = 0; ct.movingUp = true end
                end

                local footPos = root.Position - Vector3.new(0, (root.Size.Y * 0.8) + 1.2, 0)
                local headPos = head.Position + Vector3.new(0, 0.3, 0)
                local currentWorldPos = footPos:Lerp(headPos, ct.alpha)
                
                table.insert(ct.trailHistory, 1, currentWorldPos)
                if #ct.trailHistory > #ct.trailLines then table.remove(ct.trailHistory) end

                for i = 1, #ct.trailLines do
                    local trailLine = ct.trailLines[i]
                    local glowLine = ct.neonGlowLines[i]
                    local p1 = ct.trailHistory[i]
                    local p2 = ct.trailHistory[i + 1]
                    
                    if p1 and p2 then
                        local s1, v1 = WorldToViewportPoint(Camera, p1)
                        local s2, v2 = WorldToViewportPoint(Camera, p2)
                        if v1 or v2 then
                            local fadeFactor = clamp(1 - (i / #ct.trailLines), 0.05, 1)
                            
                            glowLine.From = Vector2.new(s1.X, s1.Y)
                            glowLine.To = Vector2.new(s2.X, s2.Y)
                            glowLine.Color = circularTargetCfg.color
                            glowLine.Transparency = fadeFactor * 0.35
                            glowLine.Visible = true

                            trailLine.From = Vector2.new(s1.X, s1.Y)
                            trailLine.To = Vector2.new(s2.X, s2.Y)
                            trailLine.Color = circularTargetCfg.color
                            trailLine.Transparency = fadeFactor * 0.85
                            trailLine.Visible = true
                        else
                            trailLine.Visible = false; glowLine.Visible = false
                        end
                    else
                        trailLine.Visible = false; glowLine.Visible = false
                    end
                end

                local R = 2.2
                local SEGS = ct.segments
                local col = circularTargetCfg.color
                for i = 1, SEGS do
                    local aA = pi2 * ((i - 1) / SEGS)
                    local aB = pi2 * (i / SEGS)
                    local wA = currentWorldPos + Vector3.new(cos(aA) * R, 0, sin(aA) * R)
                    local wB = currentWorldPos + Vector3.new(cos(aB) * R, 0, sin(aB) * R)
                    local sA, vA = WorldToViewportPoint(Camera, wA)
                    local sB, vB = WorldToViewportPoint(Camera, wB)
                    local line = ct.lines[i]
                    if vA or vB then
                        line.From = Vector2.new(sA.X, sA.Y)
                        line.To = Vector2.new(sB.X, sB.Y)
                        line.Color = col
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                end
            else
                for _,l in ipairs(ct.lines) do l.Visible=false end
                for _,l in ipairs(ct.trailLines) do l.Visible=false end
                for _,l in ipairs(ct.neonGlowLines) do l.Visible=false end
            end
        end
    end
end)

for k,v in next,espfunctions do esplib[k]=v end



local function updateESPSettings()
    local bt=Options.ESPBoxType.Value
    if bt=="Disabled" then esplib.box.enabled=false
    else esplib.box.enabled=Toggles.ESPEnabled.Value; esplib.box.type=bt:gsub(" Box","") end
    esplib.box.colorA        = Options.ESPBoxColorA.Value
    esplib.box.colorB        = Options.ESPBoxColorB.Value
    esplib.box.fillGradient  = Toggles.ESPBoxFillGradient.Value
    esplib.box.fillColorA    = Options.ESPFillColorA.Value
    esplib.box.fillColorB    = Options.ESPFillColorB.Value
    esplib.box.fillRotation  = Toggles.ESPBoxFillRotation.Value
    esplib.box.rotationSpeed = Options.ESPBoxRotationSpeed.Value
    esplib.name.enabled      = Toggles.ESPEnabled.Value and Toggles.ESPName.Value
    esplib.name.fill         = Options.ESPNameColor.Value
    esplib.healthbar.enabled     = Toggles.ESPEnabled.Value and Toggles.ESPHealth.Value
    esplib.healthbar.topColor    = Options.ESPHealthTopColor.Value
    esplib.healthbar.bottomColor = Options.ESPHealthBottomColor.Value
    esplib.healthtext.enabled    = Toggles.ESPEnabled.Value and Toggles.ESPHealthText.Value
    esplib.healthtext.color      = Options.ESPHealthTextColor.Value
    esplib.distance.enabled      = Toggles.ESPEnabled.Value and Toggles.ESPDistance.Value
    esplib.distance.color        = Options.ESPDistanceColor.Value
    esplib.tracer.enabled        = Toggles.ESPEnabled.Value and Toggles.ESPTracer.Value
    esplib.tracer.fillA          = Options.ESPTracerColor.Value
    esplib.tracer.fillB          = Options.ESPTracerColorB.Value
    esplib.tracer.from           = Options.ESPTracerOrigin.Value:lower()
    esplib.skeleton.enabled      = Toggles.ESPEnabled.Value and Toggles.ESPSkeleton.Value
    esplib.skeleton.colorA       = Options.ESPSkeletonColorA.Value
    esplib.skeleton.colorB       = Options.ESPSkeletonColorB.Value
    esplib.weapon.enabled        = Toggles.ESPEnabled.Value and Toggles.ESPWeapon.Value
    esplib.weapon.fill           = Options.ESPWeaponColor and Options.ESPWeaponColor.Value or Color3.new(1,1,1)
    esplib.circulartarget.enabled = Toggles.ESPEnabled.Value and Toggles.ESPCircularTarget.Value
    esplib.circulartarget.color   = Options.ESPCircularTargetColor.Value
end

local espCharacters={}

local function addEspToCharacter(character)
    if not character or espCharacters[character] then return end
    if character == LP.Character then return end
    -- Не рисовать ESP на GirlModel и на любой модели внутри персонажа LP
    if character.Name == "GirlModel_Custom" then return end
    if LP.Character and character:IsDescendantOf(LP.Character) then return end
    
    esplib.add_box(character)
    esplib.add_name(character)
    esplib.add_healthbar(character)
    esplib.add_healthtext(character)
    esplib.add_distance(character)
    esplib.add_tracer(character)
    esplib.add_skeleton(character, {thickness=3.5})
    esplib.add_weapon(character)
    esplib.add_circulartarget(character)
    
    espCharacters[character]=true
end

local function removeEspFromCharacter(character)
    if character then
        if espinstances[character] then
            cleanup_instance(character, espinstances[character])
            espinstances[character] = nil
        end
        espCharacters[character]=nil
    end
end

local charactersFolder = Workspace:WaitForChild("Characters", 5)

local function scanCharactersFolder()
    if not charactersFolder then return end
    
    local function processContainer(container)
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("Model") then
                if child.Name == "GirlModel_Custom" then continue end
                if LP.Character and child:IsDescendantOf(LP.Character) then continue end
                if child:GetAttribute("Health") ~= nil or child:FindFirstChild("Head") then
                    addEspToCharacter(child)
                end
                processContainer(child)
            end
        end
    end
    
    processContainer(charactersFolder)
end

scanCharactersFolder()

if charactersFolder then
    charactersFolder.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Model") then
            task.wait(0.1)
            if descendant.Name == "GirlModel_Custom" then return end
            if LP.Character and descendant:IsDescendantOf(LP.Character) then return end
            if descendant:GetAttribute("Health") ~= nil or descendant:FindFirstChild("Head") then
                addEspToCharacter(descendant)
            end
        end
    end)

    charactersFolder.DescendantRemoving:Connect(function(descendant)
        if descendant:IsA("Model") then
            removeEspFromCharacter(descendant)
        end
    end)
end

local function refreshAllCharacters()
    for c in next,espCharacters do removeEspFromCharacter(c) end
    scanCharactersFolder()
end

local function onChange() updateESPSettings(); refreshAllCharacters() end
Toggles.ESPEnabled:OnChanged(onChange); Toggles.ESPTeamCheck:OnChanged(onChange)
Options.ESPBoxType:OnChanged(updateESPSettings)
Options.ESPBoxColorA:OnChanged(updateESPSettings); Options.ESPBoxColorB:OnChanged(updateESPSettings)
Toggles.ESPBoxFillGradient:OnChanged(updateESPSettings)
Options.ESPFillColorA:OnChanged(updateESPSettings); Options.ESPFillColorB:OnChanged(updateESPSettings)
Toggles.ESPBoxFillRotation:OnChanged(updateESPSettings); Options.ESPBoxRotationSpeed:OnChanged(updateESPSettings)
Toggles.ESPName:OnChanged(updateESPSettings); Options.ESPNameColor:OnChanged(updateESPSettings)
Toggles.ESPHealth:OnChanged(updateESPSettings)
Options.ESPHealthTopColor:OnChanged(updateESPSettings); Options.ESPHealthBottomColor:OnChanged(updateESPSettings)
Toggles.ESPHealthText:OnChanged(updateESPSettings)
Options.ESPHealthTextColor:OnChanged(updateESPSettings)
Toggles.ESPDistance:OnChanged(updateESPSettings)
Options.ESPDistanceColor:OnChanged(updateESPSettings)
Toggles.ESPTracer:OnChanged(updateESPSettings)
Options.ESPTracerColor:OnChanged(updateESPSettings); Options.ESPTracerColorB:OnChanged(updateESPSettings)
Options.ESPTracerOrigin:OnChanged(updateESPSettings)
Toggles.ESPSkeleton:OnChanged(updateESPSettings)
Options.ESPSkeletonColorA:OnChanged(updateESPSettings); Options.ESPSkeletonColorB:OnChanged(updateESPSettings)
Toggles.ESPWeapon:OnChanged(updateESPSettings)
if Options.ESPWeaponColor then Options.ESPWeaponColor:OnChanged(updateESPSettings) end
Toggles.ESPCircularTarget:OnChanged(updateESPSettings); Options.ESPCircularTargetColor:OnChanged(updateESPSettings)

updateESPSettings()

Players.PlayerRemoving:Connect(function(p)
    if priorityTargetName and p.Name == priorityTargetName then
        priorityTargetName = nil
        pcall(function()
            Options.RagePriorityTarget:SetValues(refreshPriorityList())
            Options.RagePriorityTarget:SetValue("[ AUTO ]")
        end)
    end
end)

-- =========================================================================
-- [ FOV CIRCLES ]
-- =========================================================================

local SilentFovCircle = Drawing.new("Circle")
SilentFovCircle.NumSides = 128
SilentFovCircle.Thickness = 1
SilentFovCircle.Filled = false
SilentFovCircle.Visible = false

local AimbotFovCircle = Drawing.new("Circle")
AimbotFovCircle.NumSides = 128
AimbotFovCircle.Thickness = 1
AimbotFovCircle.Filled = false
AimbotFovCircle.Visible = false

task.spawn(function()
    while task.wait(5) do
        pcall(function()
            if not SilentFovCircle or not pcall(function() return SilentFovCircle.Visible end) then
                SilentFovCircle = Drawing.new("Circle")
                SilentFovCircle.NumSides = 128
                SilentFovCircle.Thickness = 1
                SilentFovCircle.Filled = false
            end
            if not AimbotFovCircle or not pcall(function() return AimbotFovCircle.Visible end) then
                AimbotFovCircle = Drawing.new("Circle")
                AimbotFovCircle.NumSides = 128
                AimbotFovCircle.Thickness = 1
                AimbotFovCircle.Filled = false
            end
        end)
    end
end)

-- =========================================================================
-- [ TARGET SYSTEM ]
-- =========================================================================

local SilentTarget = nil
local AimbotTarget = nil
local RageTarget = nil
local CubeSmartTarget = nil
local lockedTargetInstance = nil

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true

local frameCounter = 0

local function isVisible(target)
    local ignoreList = {LP.Character}
    local myTeam = get_player_team(LP)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and get_player_team(p) == myTeam and p.Character then
            table.insert(ignoreList, p.Character)
        end
    end
    rayParams.FilterDescendantsInstances = ignoreList
    local origin = Workspace.CurrentCamera.CFrame.Position
    local direction = target.Position - origin
    local result = Workspace:Raycast(origin, direction, rayParams)
    if result then
        local hitModel = result.Instance:FindFirstAncestorOfClass("Model")
        local hitPlayer = Players:GetPlayerFromCharacter(hitModel)
        if hitPlayer and hitPlayer.Character == target.Parent then return true end
        return false
    end
    return true
end

local function getMemesenseActive()
    local memesenseActive = Toggles.MemesenseMainToggle and Toggles.MemesenseMainToggle.Value
    if Options.MemesenseKeybind then
        local kState = Options.MemesenseKeybind:GetState()
        if Options.MemesenseKeybind.Value ~= "None" and Options.MemesenseKeybind.Value ~= "Always" and Options.MemesenseKeybind.Value ~= "Toggle" then
            memesenseActive = kState
        end
    end
    return memesenseActive
end

local function isEnemy(char)
    if not char then return false end
    local lchar = LP.Character
    if not lchar then return false end
    local myHasVest = hasVestDetails(lchar)
    local targetHasVest = hasVestDetails(char)
    if myHasVest then return not targetHasVest
    else return targetHasVest end
end

local function FindAllTargets()
    local camera = Workspace.CurrentCamera
    local lchar = LP.Character
    if not lchar then return end
    local myTeam = get_player_team(LP)
    local screenCenter = camera.ViewportSize / 2
    local sDist, sClose = math.huge, nil
    local rDist, rClose = math.huge, nil
    local cDist, cClose = math.huge, nil
    local memesenseActive = getMemesenseActive()

    local charsFolder = Workspace:FindFirstChild("Characters")
    if not charsFolder then return end

    local allChars = {}
    for _, obj in ipairs(charsFolder:GetDescendants()) do
        if obj:IsA("Model") then
            local head = obj:FindFirstChild("Head")
            local root = obj:FindFirstChild("HumanoidRootPart")
            if (head or root) and obj ~= lchar then
                -- Не добавлять GirlModel и модели внутри LP.Character
                if obj.Name == "GirlModel_Custom" then continue end
                if lchar and obj:IsDescendantOf(lchar) then continue end
                local isDead = obj:GetAttribute("Dead")
                    or obj:GetAttribute("Invincible")
                local hp = obj:GetAttribute("Health")
                if not isDead and (hp == nil or hp > 0) then
                    table.insert(allChars, obj)
                end
            end
        end
    end

    if memesenseActive then
        local chosenPartName = Options.CubeHitPart.Value or "Head"

        if lockedTargetInstance and lockedTargetInstance.Parent then
            local charModel = lockedTargetInstance.Parent
            local isDead = charModel:GetAttribute("Dead")
                or charModel:GetAttribute("Invincible")
            local hp = charModel:GetAttribute("Health")
            if isDead or (hp and hp <= 0) then
                lockedTargetInstance = nil
            elseif Toggles.CubeVisibleCheck and Toggles.CubeVisibleCheck.Value then
                if not isVisible(lockedTargetInstance) then
                    lockedTargetInstance = nil
                end
            end
        else
            lockedTargetInstance = nil
        end

        local bestTarget = lockedTargetInstance
        local bestDist = math.huge
        if lockedTargetInstance then
            local bp = lockedTargetInstance.Parent:FindFirstChild(chosenPartName) or lockedTargetInstance
            if bp then bestDist = (camera.CFrame.Position - bp.Position).Magnitude end
        end

        for _, char in ipairs(allChars) do
            if not isEnemy(char) then continue end
            local targetPart = char:FindFirstChild(chosenPartName)
                or char:FindFirstChild("Head")
                or char:FindFirstChild("HumanoidRootPart")
            if not targetPart then continue end

            local passVis = true
            if Toggles.CubeVisibleCheck and Toggles.CubeVisibleCheck.Value then
                if not isVisible(targetPart) then passVis = false end
            end
            if passVis then
                local dist = (camera.CFrame.Position - targetPart.Position).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestTarget = targetPart
                end
            end
        end
        lockedTargetInstance = bestTarget
        cClose = bestTarget
    else
        lockedTargetInstance = nil
    end

    for _, char in ipairs(allChars) do
        if not isEnemy(char) then continue end

        if Toggles.Ragebot and Toggles.Ragebot.Value then
            local rPart = char:FindFirstChild(Options.RageHitPart.Value)
                or char:FindFirstChild("Head")
                or char:FindFirstChild("HumanoidRootPart")
            if rPart then
                local _, rOnScreen = camera:WorldToViewportPoint(rPart.Position)
                local alive = true
                if Toggles.RagebotVisibleCheck and Toggles.RagebotVisibleCheck.Value and not rOnScreen then
                    alive = false
                end
                if alive and Toggles.RagebotWallCheck and Toggles.RagebotWallCheck.Value then
                    if not isVisible(rPart) then alive = false end
                end
                if alive then
                    local rd = (camera.CFrame.Position - rPart.Position).Magnitude
                    local p = Players:GetPlayerFromCharacter(char)
                    if priorityTargetName and p and p.Name == priorityTargetName then
                        rClose = rPart
                        rDist  = 0
                    else
                        if rd < rDist and rDist > 0 then
                            rDist  = rd
                            rClose = rPart
                        end
                    end
                end
            end
        end

        if Toggles.SilentAim and Toggles.SilentAim.Value then
            local silentPartName = Options.SilentHitPart and Options.SilentHitPart.Value or "Head"
            local sPart = char:FindFirstChild(silentPartName)
                or char:FindFirstChild("Head")
                or char:FindFirstChild("HumanoidRootPart")
            if sPart then
                local sScreenPos, sOnScreen = camera:WorldToViewportPoint(sPart.Position)
                if sOnScreen then
                    local sd = (Vector2.new(sScreenPos.X, sScreenPos.Y) - screenCenter).Magnitude
                    local maxRadius = (Toggles.SilentUseFovCircle and Toggles.SilentUseFovCircle.Value)
                        and (Options.SilentFovCircleRadius and Options.SilentFovCircleRadius.Value or 50)
                        or 999999
                    if sd <= maxRadius then
                        local wallOk = (Toggles.SilentWallbang and Toggles.SilentWallbang.Value) or isVisible(sPart)
                        if wallOk and sd < sDist then
                            sDist = sd; sClose = sPart
                        end
                    end
                end
            end
        end
    end

    SilentTarget    = sClose
    RageTarget      = rClose
    CubeSmartTarget = cClose
end

-- =========================================================================
-- [ SHOW TARGET SYSTEM ]
-- =========================================================================

local ShowTargetHitMarkerLines = {}
for i = 1, 4 do
    local l = Drawing.new("Line")
    l.Thickness = 2
    l.Transparency = 1
    l.Visible = false
    ShowTargetHitMarkerLines[i] = l
end

local ShowTargetConnectorLine = Drawing.new("Line")
ShowTargetConnectorLine.Thickness = 1.5
ShowTargetConnectorLine.Transparency = 1
ShowTargetConnectorLine.Visible = false

RunService.RenderStepped:Connect(function()
    pcall(function()
        local cam = Workspace.CurrentCamera
        local memesenseActive = getMemesenseActive()
        local showTargetEnabled = memesenseActive and (Toggles.ShowTargetPlayer and Toggles.ShowTargetPlayer.Value)
        local targetMode = Options.ShowTargetMode and Options.ShowTargetMode.Value or "Crosshair"
        local absoluteClosestPart = nil
        local minAbsoluteDist = math.huge
        local myTeam = get_player_team(LP)
        local chosenPartName = Options.CubeHitPart and Options.CubeHitPart.Value or "Head"

        if showTargetEnabled then
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= LP then
                    local char = v.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        local isDead = char:GetAttribute("Dead") or char:GetAttribute("Invincible") or (hum and hum.Health <= 0)
                        if not isDead then
                            local vTeam = get_player_team(v)
                            if myTeam ~= vTeam then
                                local pPart = char:FindFirstChild(chosenPartName) or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                                if pPart then
                                    local dist = (cam.CFrame.Position - pPart.Position).Magnitude
                                    if dist < minAbsoluteDist then
                                        minAbsoluteDist = dist
                                        absoluteClosestPart = pPart
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local lineVisible = false
        local crosshairVisible = false

        if showTargetEnabled and absoluteClosestPart and absoluteClosestPart.Parent then
            local screenPos, onScreen = cam:WorldToViewportPoint(absoluteClosestPart.Position)
            local center = Vector2.new(screenPos.X, screenPos.Y)
            local currentTick = tick()

            if targetMode == "Crosshair" then
                local crossCol = Options.ShowTargetCrosshairColor and Options.ShowTargetCrosshairColor.Value or Color3.fromRGB(0, 255, 255)
                local pulseFactor = 1 + 0.3 * math.sin(currentTick * math.pi * 2)
                local baseSize = 16 * pulseFactor
                local gap = 5 * pulseFactor
                local spinAngle = math.rad((currentTick * 180) % 360)
                local baseAngles = {0, math.pi/2, math.pi, (3*math.pi)/2}
                for j = 1, 4 do
                    local line = ShowTargetHitMarkerLines[j]
                    line.Color = crossCol
                    line.Thickness = 2
                    local totalAngle = spinAngle + baseAngles[j]
                    local cosA = math.cos(totalAngle)
                    local sinA = math.sin(totalAngle)
                    line.From = center + Vector2.new(cosA * gap, sinA * gap)
                    line.To = center + Vector2.new(cosA * (gap + baseSize), sinA * (gap + baseSize))
                    line.Visible = true
                end
                crosshairVisible = true
            elseif targetMode == "Line" then
                local lineCol = Options.ShowTargetLineColor and Options.ShowTargetLineColor.Value or Color3.fromRGB(0, 255, 255)
                local viewportCenter = cam.ViewportSize / 2
                ShowTargetConnectorLine.From = viewportCenter
                ShowTargetConnectorLine.To = center
                ShowTargetConnectorLine.Color = lineCol
                ShowTargetConnectorLine.Visible = true
                lineVisible = true
            end
        end

        if not crosshairVisible then
            for j = 1, 4 do ShowTargetHitMarkerLines[j].Visible = false end
        end
        if not lineVisible then ShowTargetConnectorLine.Visible = false end
        if not showTargetEnabled then
            for j = 1, 4 do ShowTargetHitMarkerLines[j].Visible = false end
            ShowTargetConnectorLine.Visible = false
        end
    end)
end)

-- =========================================================================
-- [ MAIN RENDER LOOP ]
-- =========================================================================

RunService.RenderStepped:Connect(function()
    frameCounter = frameCounter + 1
    local cam = Workspace.CurrentCamera
    local viewportCenter = cam.ViewportSize / 2

    pcall(function()
        SilentFovCircle.Position = viewportCenter
        SilentFovCircle.Radius = Options.SilentFovCircleRadius and Options.SilentFovCircleRadius.Value or 50
        SilentFovCircle.Color = Options.SilentFovColor and Options.SilentFovColor.Value or Color3.fromRGB(255, 0, 0)
        SilentFovCircle.Visible = Toggles.SilentAim and Toggles.SilentAim.Value and Toggles.SilentUseFovCircle and Toggles.SilentUseFovCircle.Value
        AimbotFovCircle.Position = viewportCenter
        AimbotFovCircle.Radius = Options.AimbotFovCircleRadius and Options.AimbotFovCircleRadius.Value or 50
        AimbotFovCircle.Color = Options.AimbotFovColor and Options.AimbotFovColor.Value or Color3.fromRGB(0, 255, 0)
        AimbotFovCircle.Visible = Toggles.Aimbot and Toggles.Aimbot.Value and Toggles.AimbotUseFovCircle and Toggles.AimbotUseFovCircle.Value
    end)

    if frameCounter % 2 == 0 then FindAllTargets() end

    local memesenseActive = getMemesenseActive()
    local targetToPull = nil

    if memesenseActive and CubeSmartTarget then
        targetToPull = CubeSmartTarget
    end

    if targetToPull and targetToPull.Parent then
        pcall(function()
            cam.CFrame = CFrame.new(cam.CFrame.Position, targetToPull.Position)
        end)
    end
end)

-- =========================================================================
-- [ CUBE CHECKER - RAINBOW MODE ]
-- =========================================================================

local BulletImpactV1Part = Instance.new("Part")
BulletImpactV1Part.Name = "CubeChecker_Physical"
BulletImpactV1Part.Size = Vector3.new(1.5, 1.5, 0.01)
BulletImpactV1Part.Anchored = true
BulletImpactV1Part.CanCollide = false
BulletImpactV1Part.CanQuery = false
BulletImpactV1Part.CanTouch = false
BulletImpactV1Part.Material = Enum.Material.Neon
BulletImpactV1Part.Transparency = 0.98
BulletImpactV1Part.Parent = Workspace

local selectionBox = Instance.new("SelectionBox")
selectionBox.Adornee = BulletImpactV1Part
selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
selectionBox.LineThickness = 0.04
selectionBox.Transparency = 0.2
selectionBox.Parent = BulletImpactV1Part

local impactRayParams = RaycastParams.new()
impactRayParams.FilterType = Enum.RaycastFilterType.Exclude
impactRayParams.IgnoreWater = true

RunService.RenderStepped:Connect(function()
    pcall(function()
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local memesenseActive = getMemesenseActive()
        local enabled = memesenseActive and (Toggles.BulletImpactV1Enabled and Toggles.BulletImpactV1Enabled.Value)
        BulletImpactV1Part.Parent = enabled and Workspace or nil

        if enabled then
            local sizeVal = Options.BulletImpactV1Size and Options.BulletImpactV1Size.Value or 1.5
            local maxDist = Options.BulletImpactV1Dist and Options.BulletImpactV1Dist.Value or 20
            BulletImpactV1Part.Size = Vector3.new(sizeVal, sizeVal, 0.01)

            local userColor = Options.BulletImpactV1Color and Options.BulletImpactV1Color.Value or Color3.fromRGB(255, 0, 0)

            if Toggles.BulletImpactV1Rainbow and Toggles.BulletImpactV1Rainbow.Value then
                local hue = (tick() % 5) / 5
                userColor = Color3.fromHSV(hue, 1, 1)
            end

            local origin = cam.CFrame.Position
            local direction = cam.CFrame.LookVector * maxDist
            impactRayParams.FilterDescendantsInstances = {LP.Character, BulletImpactV1Part}
            local result = Workspace:Raycast(origin, direction, impactRayParams)

            if result then
                BulletImpactV1Part.Parent = Workspace
                BulletImpactV1Part.CFrame = CFrame.lookAt(result.Position + (result.Normal * 0.02), result.Position + result.Normal)
                if CubeSmartTarget and memesenseActive and Toggles.CubeAimbotEnabled.Value then
                    BulletImpactV1Part.Color = Color3.fromRGB(0, 255, 0)
                    selectionBox.Color3 = Color3.fromRGB(0, 255, 0)
                else
                    BulletImpactV1Part.Color = userColor
                    selectionBox.Color3 = userColor
                end
            else
                BulletImpactV1Part.Parent = nil
            end
        end
    end)
end)

-- =========================================================================
-- [ GC HOOKS ]
-- =========================================================================

local original = {}
local firerateobjs = {}
local SendFunc = nil
local getCurrentEquipped = nil

pcall(function()
    for _, obj in next, getgc(true) do
        if type(obj) == "table" and rawget(obj, "FireRate") then
            pcall(function()
                table.insert(original, table.clone(obj))
                table.insert(firerateobjs, obj)
            end)
        end
        if type(obj) == "table" and rawget(obj, "setWeaponRecoil") then
            pcall(function()
                local oldSetWeaponRecoil
                oldSetWeaponRecoil = hookfunction(obj.setWeaponRecoil, function(...)
                    if Toggles.NoRecoil.Value then return end
                    return oldSetWeaponRecoil(...)
                end)
            end)
        end
        if type(obj) == "function" and debug.getinfo(obj).name == "calculateRecoilOffset" then
            pcall(function()
                local calculateRecoilOffset
                calculateRecoilOffset = hookfunction(obj, function(...)
                    if Toggles.NoRecoil.Value then return UDim2.new() end
                    return calculateRecoilOffset(...)
                end)
            end)
        end
        if type(obj) == "table" and rawget(obj, "weaponKick") then
            pcall(function()
                local oldweaponkick
                oldweaponkick = hookfunction(obj.weaponKick, function(p1, p2)
                    if Toggles.NoRecoil.Value then return end
                    return oldweaponkick(p1, p2)
                end)
            end)
        end
        if type(obj) == "table" and rawget(obj, "getTrueSpread") then
            pcall(function()
                local oldgettruespread
                oldgettruespread = hookfunction(obj.getTrueSpread, function(p1)
                    if Toggles.NoSpread.Value then return 0 end
                    return oldgettruespread(p1)
                end)
            end)
        end
        if type(obj) == "function" and debug.getinfo(obj).name == "Flash" then
            pcall(function()
                local oldflash
                oldflash = hookfunction(obj, function(...)
                    if Toggles.Antiflashbang.Value then return end
                    return oldflash(...)
                end)
            end)
        end
        if type(obj) == "function" and debug.getinfo(obj).name == "CreateVoxel" and debug.getupvalue(obj, 1) and tostring(debug.getupvalue(obj, 1)) == "Smoke" then
            pcall(function()
                local oldsmoke
                oldsmoke = hookfunction(obj, function(...)
                    if Toggles.Antismoke.Value then return end
                    return oldsmoke(...)
                end)
            end)
        end
        if type(obj) == "table" and rawget(obj, "shoot") and typeof(obj.shoot) == "function" then
            pcall(function()
                for _, uv in pairs(debug.getupvalues(obj.shoot)) do
                    if type(uv) == "table" and rawget(uv, "Inventory") and rawget(uv.Inventory, "ShootWeapon") then
                        SendFunc = uv.Inventory.ShootWeapon.Send
                        break
                    end
                end
            end)
        end
        if type(obj) == 'table' and rawget(obj, "getCurrentEquipped") then
            pcall(function() getCurrentEquipped = obj.getCurrentEquipped end)
        end
    end
end)

local function getEquipped()
    local success, result = pcall(function()
        return debug.getupvalue(getCurrentEquipped, 1).CurrentEquipped
    end)
    if not success then return nil end
    return result
end

local Weapon = nil

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if getEquipped then Weapon = getEquipped() end
        end)
    end
end)

-- =========================================================================
-- [ TRACER SYSTEM ]
-- =========================================================================

local function createTracerBean(startPos, endPos)
    if not Toggles.BulletTracers or not Toggles.BulletTracers.Value then return end
    if not startPos or not endPos then return end

    local style = Options.TracerStyle and Options.TracerStyle.Value or "Block"
    local tracerColor = Options.BulletTracersColor and Options.BulletTracersColor.Value or Color3.fromRGB(0, 170, 255)

    if Toggles.TracerRainbow and Toggles.TracerRainbow.Value then
        tracerColor = Color3.fromHSV((tick() % 5) / 5, 1, 1)
    end

    local duration = Options.TracerTime and Options.TracerTime.Value or 2
    local beamPart = Instance.new("Part")
    beamPart.Name = "Memesense_Tracer"

    if style == "Cylinder (Obelius)" then
        beamPart.Shape = Enum.PartType.Cylinder
        beamPart.Size = Vector3.new((startPos - endPos).Magnitude, 0.12, 0.12)
        beamPart.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -beamPart.Size.X / 2) * CFrame.Angles(0, math.rad(90), 0)
    else
        beamPart.Size = Vector3.new(0.1, 0.1, (startPos - endPos).Magnitude)
        beamPart.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -beamPart.Size.Z / 2)
    end

    beamPart.Anchored = true
    beamPart.CanCollide = false
    beamPart.CanQuery = false
    beamPart.CanTouch = false
    beamPart.Material = Enum.Material.Neon
    beamPart.Color = tracerColor
    beamPart.Transparency = 0
    beamPart.CastShadow = false
    beamPart.Parent = Workspace

    task.spawn(function()
        local startTime = tick()
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            beamPart.Transparency = alpha
            if Toggles.TracerRainbow and Toggles.TracerRainbow.Value then
                beamPart.Color = Color3.fromHSV((tick() % 5) / 5, 1, 1)
            end
            task.wait()
        end
        beamPart:Destroy()
    end)
end

local function createBulletImpact(hitPos)
    if not Toggles.BulletImpacts or not Toggles.BulletImpacts.Value then return end
    if not hitPos then return end
    local impactPart = Instance.new("Part")
    impactPart.Name = "Memesense_Impact"
    impactPart.Size = Vector3.new(0.6, 0.6, 0.6)
    impactPart.Shape = Enum.PartType.Block
    impactPart.Position = hitPos
    impactPart.Anchored = true
    impactPart.CanCollide = false
    impactPart.Material = Enum.Material.Neon
    impactPart.Color = Options.BulletImpactsColor.Value
    impactPart.Transparency = 0
    impactPart.Parent = Workspace
    task.spawn(function()
        local startTime = tick()
        local duration = 3
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            impactPart.Transparency = alpha
            task.wait()
        end
        impactPart:Destroy()
    end)
end

-- =========================================================================
-- [ RAGEBOT LOOP ]
-- =========================================================================

task.spawn(function()
    while true do
        task.wait(Options.RageDelay and Options.RageDelay.Value or 0.02)
        if Toggles.Ragebot and Toggles.Ragebot.Value and RageTarget and Weapon and Weapon.IsEquipped and Weapon.Rounds > 0 then
            Weapon:shoot()
        end
    end
end)

-- =========================================================================
-- [ TRIGGERBOT LOOP ]
-- =========================================================================

task.spawn(function()
    local trigRayParams = RaycastParams.new()
    trigRayParams.FilterType = Enum.RaycastFilterType.Exclude
    trigRayParams.IgnoreWater = true

    while true do
        task.wait(Options.TriggerbotDelay and Options.TriggerbotDelay.Value or 0.01)
        pcall(function()
            if Toggles.Triggerbot and Toggles.Triggerbot.Value then
                local cam = Workspace.CurrentCamera
                if not cam then return end
                local shouldShoot = false
                local origin = cam.CFrame.Position
                local direction = cam.CFrame.LookVector * 1000
                trigRayParams.FilterDescendantsInstances = {LP.Character}
                local result = Workspace:Raycast(origin, direction, trigRayParams)
                if result and result.Instance then
                    local char = result.Instance:FindFirstAncestorOfClass("Model")
                    if char then
                        -- Игнорируем если это модель внутри персонажа LP (GirlModel_Custom)
                        if LP.Character and char:IsDescendantOf(LP.Character) then
                            -- пропустить
                        else
                        local player = Players:GetPlayerFromCharacter(char)
                        if player and player ~= LP then
                            local _, onScreen = cam:WorldToViewportPoint(result.Instance.Position)
                            if onScreen then
                                if not char:GetAttribute("Dead") and not char:GetAttribute("Invincible") then
                                    if get_player_team(LP) ~= get_player_team(player) then
                                        shouldShoot = true
                                    end
                                end
                            end
                        end
                        end
                    end
                end
                if not shouldShoot and CubeSmartTarget and CubeSmartTarget.Parent then
                    local _, onScreen = cam:WorldToViewportPoint(CubeSmartTarget.Position)
                    if onScreen then
                        local camLook = cam.CFrame.LookVector
                        local toTarget = (CubeSmartTarget.Position - cam.CFrame.Position).Unit
                        if camLook:Dot(toTarget) > 0.88 then
                            local char = CubeSmartTarget.Parent
                            if char and char:IsA("Model") then
                                local isDead = char:GetAttribute("Dead") or char:GetAttribute("Invincible")
                                local hp = char:GetAttribute("Health")
                                if not isDead and (hp == nil or hp > 0) then
                                    if isEnemy(char) then
                                        shouldShoot = true
                                    end
                                end
                            end
                        end
                    end
                end
                if shouldShoot and Weapon then pcall(function() Weapon:shoot() end) end
            end
        end)
    end
end)

-- =========================================================================
-- [ CUBE TRIGGERBOT LOOP ]
-- =========================================================================

task.spawn(function()
    local cubeTrigRayParams = RaycastParams.new()
    cubeTrigRayParams.FilterType = Enum.RaycastFilterType.Exclude
    cubeTrigRayParams.IgnoreWater = true

    while true do
        task.wait(Options.CubeTriggerbotDelay and Options.CubeTriggerbotDelay.Value or 0.01)
        pcall(function()
            local memesenseActive = getMemesenseActive()
            if memesenseActive and (Toggles.CubeTriggerbot and Toggles.CubeTriggerbot.Value) then
                local cam = Workspace.CurrentCamera
                if not cam then return end
                local shouldShoot = false
                local origin = cam.CFrame.Position
                local direction = cam.CFrame.LookVector * 1000
                cubeTrigRayParams.FilterDescendantsInstances = {LP.Character}
                local result = Workspace:Raycast(origin, direction, cubeTrigRayParams)
                if result and result.Instance then
                    local char = result.Instance:FindFirstAncestorOfClass("Model")
                    if char then
                        -- Игнорируем если это модель внутри персонажа LP (GirlModel_Custom)
                        if LP.Character and char:IsDescendantOf(LP.Character) then
                            -- пропустить
                        else
                        local player = Players:GetPlayerFromCharacter(char)
                        if player and player ~= LP then
                            local _, onScreen = cam:WorldToViewportPoint(result.Instance.Position)
                            if onScreen then
                                if not char:GetAttribute("Dead") and not char:GetAttribute("Invincible") then
                                    if get_player_team(LP) ~= get_player_team(player) then
                                        shouldShoot = true
                                    end
                                end
                            end
                        end
                        end
                    end
                end
                                if not shouldShoot and CubeSmartTarget and CubeSmartTarget.Parent then
                    local _, onScreen = cam:WorldToViewportPoint(CubeSmartTarget.Position)
                    if onScreen then
                        local camLook = cam.CFrame.LookVector
                        local toTarget = (CubeSmartTarget.Position - cam.CFrame.Position).Unit
                        if camLook:Dot(toTarget) > 0.88 then
                            local char = CubeSmartTarget.Parent
                            if char and char:IsA("Model") then
                                local isDead = char:GetAttribute("Dead") or char:GetAttribute("Invincible")
                                local hp = char:GetAttribute("Health")
                                if not isDead and (hp == nil or hp > 0) then
                                    if isEnemy(char) then
                                        shouldShoot = true
                                    end
                                end
                            end
                        end
                    end
                end
                if shouldShoot and Weapon then pcall(function() Weapon:shoot() end) end
            end
        end)
    end
end)

-- =========================================================================
-- [ SHOOT HOOK ]
-- =========================================================================
local oldshoot
pcall(function()
    if not SendFunc then return end
    oldshoot = hookfunction(SendFunc, function(...)
        local args = {...}
        local memesenseActive = getMemesenseActive()

        if args[1] and type(args[1].Bullets) == "table" then
            for _, bullet in pairs(args[1].Bullets) do
                if type(bullet.Hits) == "table" then
                    for _, hitData in pairs(bullet.Hits) do
                        local targetPart = nil
                        if Toggles.Ragebot and Toggles.Ragebot.Value and RageTarget then
                            targetPart = RageTarget
                        elseif memesenseActive and Toggles.CubeAimbotEnabled and Toggles.CubeAimbotEnabled.Value and CubeSmartTarget then
                            local chosenPartName = Options.CubeHitPart and Options.CubeHitPart.Value or "Head"
                            targetPart = CubeSmartTarget.Parent and CubeSmartTarget.Parent:FindFirstChild(chosenPartName) or CubeSmartTarget
                        elseif Toggles.SilentAim and Toggles.SilentAim.Value and SilentTarget then
                            targetPart = SilentTarget
                        end
                        
                        if targetPart then
                            hitData.Instance = targetPart
                            hitData.Position = targetPart.Position
                        end
                        
                        pcall(function()
                            local cam = Workspace.CurrentCamera
                            if cam and hitData.Position then
                                local startPos = cam.CFrame.Position
                                local endPos = hitData.Position
                                
                                createTracerBean(startPos, endPos)
                                createBulletImpact(endPos)
                                
                                local isEnemyHit = false
                                if hitData.Instance then
                                    local ancestorModel = hitData.Instance:FindFirstAncestorOfClass("Model")
                                    if ancestorModel then
                                        local hitPlayer = Players:GetPlayerFromCharacter(ancestorModel)
                                        if hitPlayer and hitPlayer ~= LP then
                                            if get_player_team(hitPlayer) ~= get_player_team(LP) then
                                                isEnemyHit = true
                                            end
                                        end
                                    end
                                end

                                if isEnemyHit or targetPart then
                                    PlayHitSound()
                                    
                                    if TriggerHitMarkerEvent then
                                        pcall(function()
                                            TriggerHitMarkerEvent(endPos)
                                        end)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
        return oldshoot(unpack(args))
    end)
end)

-- =========================================================================
-- [ FIRERATE LOOP ]
-- =========================================================================

task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            if Toggles.Firerate and Toggles.Firerate.Value then
                for _, obj in next, firerateobjs do
                    pcall(function()
                        setreadonly(obj, false)
                        rawset(obj, "FireRate", math.max(Options.FirerateSlider.Value, 0.01))
                        setreadonly(obj, true)
                    end)
                end
            else
                for i, obj in next, firerateobjs do
                    pcall(function()
                        setreadonly(obj, false)
                        rawset(obj, "FireRate", original[i].FireRate)
                        setreadonly(obj, true)
                    end)
                end
            end
        end)
    end
end)

-- =========================================================================
-- [ WORLD COLOR / NIGHT MODE ]
-- =========================================================================

local WorldSettings = {
    WorldColorEnabled = false,
    WorldColor = Color3.fromRGB(255, 255, 255),
    SkyColorEnabled = false,
    SkyColor = Color3.fromRGB(255, 255, 255)
}

local function isLocalPlayerObject(obj)
    local char = LP.Character
    if char and (obj == char or obj:IsDescendantOf(char)) then return true end
    if obj:IsDescendantOf(Workspace.CurrentCamera) then return true end
    if obj.Name == "CubeChecker_Physical" or obj.Name:find("Memesense_") then return true end
    return false
end

local function colorObject(obj)
    if isLocalPlayerObject(obj) then return end
    if obj:IsA("BasePart") then
        if not obj:GetAttribute("OriginalColor") then obj:SetAttribute("OriginalColor", obj.Color) end
        obj.Color = WorldSettings.WorldColor
    elseif obj:IsA("Texture") or obj:IsA("Decal") then
        if not obj:GetAttribute("OriginalColor3") then obj:SetAttribute("OriginalColor3", obj.Color3) end
        obj.Color3 = WorldSettings.WorldColor
    end
end

local function restoreObject(obj)
    if obj:IsA("BasePart") then
        if obj:GetAttribute("OriginalColor") then obj.Color = obj:GetAttribute("OriginalColor") end
    elseif obj:IsA("Texture") or obj:IsA("Decal") then
        if obj:GetAttribute("OriginalColor3") then obj.Color3 = obj:GetAttribute("OriginalColor3") end
    end
end

local function RefreshWorldColor()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if WorldSettings.WorldColorEnabled then colorObject(obj) else restoreObject(obj) end
    end
end

Workspace.DescendantAdded:Connect(function(obj)
    if WorldSettings.WorldColorEnabled then
        task.defer(function()
            if obj and obj.Parent then colorObject(obj) end
        end)
    end
end)

RunService.RenderStepped:Connect(function()
    if WorldSettings.SkyColorEnabled then
        local skyColor = WorldSettings.SkyColor
        Lighting.Ambient = skyColor
        Lighting.OutdoorAmbient = skyColor
        Lighting.ColorShift_Bottom = skyColor
        Lighting.ColorShift_Top = skyColor
        Lighting.FogColor = skyColor
        local atmosphere = Lighting:FindFirstChild("KamibloxSky")
        if not atmosphere then
            atmosphere = Instance.new("Atmosphere")
            atmosphere.Name = "KamibloxSky"
            atmosphere.Parent = Lighting
        end
        atmosphere.Color = skyColor
        atmosphere.Decay = skyColor
    else
        local atmosphere = Lighting:FindFirstChild("KamibloxSky")
        if atmosphere then atmosphere:Destroy() end
    end
end)

local NightModeBox = Tabs.Visuals:AddLeftGroupbox("Night Mode", "moon")

NightModeBox:AddToggle("WorldColorToggle", {
    Text = "World Color",
    Default = false,
    Callback = function(state)
        WorldSettings.WorldColorEnabled = state
        RefreshWorldColor()
    end
}):AddColorPicker("WorldColorPicker", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "World Color",
    Callback = function(c)
        WorldSettings.WorldColor = c
        if WorldSettings.WorldColorEnabled then RefreshWorldColor() end
    end
})

NightModeBox:AddToggle("SkyColorToggle", {
    Text = "Second Color",
    Default = false,
    Callback = function(state) WorldSettings.SkyColorEnabled = state end
}):AddColorPicker("SkyColorPicker", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Second Color",
    Callback = function(c) WorldSettings.SkyColor = c end
})

-- =========================================================================
-- [ ATMOSPHERE ]
-- =========================================================================

local WorldBoxAtmosphere = Tabs.Visuals:AddLeftGroupbox("Atmosphere", "globe")

WorldBoxAtmosphere:AddToggle("Atmosphere", {
    Text = "Enable",
    Default = false,
    Callback = function(v)
        if v then
            if Toggles.EnableSkybox and Toggles.EnableSkybox.Value then Toggles.EnableSkybox:SetValue(false) end
        end
    end,
})

WorldBoxAtmosphere:AddSlider("AtmosphereDensity", { Text = "Atmosphere Density", Default = 0.3, Min = 0, Max = 1, Rounding = 2 })
WorldBoxAtmosphere:AddSlider("Sub-AtmosphereHaze", { Text = "Atmosphere Haze", Default = 0, Min = 0, Max = 10, Rounding = 1 })
WorldBoxAtmosphere:AddSlider("AtmosphereGlare", { Text = "Atmosphere Glare", Default = 0, Min = 0, Max = 10, Rounding = 1 })
WorldBoxAtmosphere:AddToggle("EnableColorCorrection", { Text = "Enabled Color Correction", Default = false })
WorldBoxAtmosphere:AddSlider("SaturationSlider", { Text = "Saturation", Default = 0, Min = -1, Max = 1, Rounding = 2 })
WorldBoxAtmosphere:AddSlider("ContrastSlider", { Text = "Contrast", Default = 0, Min = -1, Max = 1, Rounding = 1 })

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if Toggles.Atmosphere and Toggles.Atmosphere.Value then
                if Toggles.EnableSkybox and Toggles.EnableSkybox.Value then Toggles.EnableSkybox:SetValue(false) end
                local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
                if not atmosphere then atmosphere = Instance.new("Atmosphere", Lighting) end
                atmosphere.Density = Options.AtmosphereDensity and Options.AtmosphereDensity.Value or 0.3
                atmosphere.Haze = Options.SubAtmosphereHaze and Options.SubAtmosphereHaze.Value or 0
                atmosphere.Glare = Options.AtmosphereGlare and Options.AtmosphereGlare.Value or 0
            else
                local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
                if atmosphere then atmosphere:Destroy() end
            end
            if Toggles.EnableColorCorrection and Toggles.EnableColorCorrection.Value then
                local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
                if not cc then cc = Instance.new("ColorCorrectionEffect", Lighting) end
                cc.Enabled = true
                cc.Saturation = Options.SaturationSlider and Options.SaturationSlider.Value or 0
                cc.Contrast = Options.ContrastSlider and Options.ContrastSlider.Value or 0
            else
                local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
                if cc then cc.Enabled = false end
            end
        end)
    end
end)

-- =========================================================================
-- [ GRENADE ZONE ESP ]
-- =========================================================================

if _G.BS_CircleZoneLoaded then
    warn("[ZoneESP] Already running, skipping re-inject.")
else
    _G.BS_CircleZoneLoaded = true

    local function ZoneESPModule()
    if not game:IsLoaded() then game.Loaded:Wait() end
    task.wait(1)

    if type(_G.Config) ~= "table" then _G.Config = {} end
    _G.Config.SmokeZoneESP   = true
    _G.Config.MolotovZoneESP = true

    local function cfgDefault(k,v) if _G.Config[k]==nil then _G.Config[k]=v end end
    cfgDefault("GrenadeESP",     false)
    cfgDefault("GrenadeTracers", false)
    cfgDefault("ColoredSmoke",   false)
    cfgDefault("NoSmoke",        false)
    cfgDefault("SmokeColor",     Color3.fromRGB(255, 0, 0))

    local SETTINGS = {
        Smoke = {
            RadiusTrim   = 0.0,
            HeightOffset = 0.3,
            Segments     = 40,
            Thickness    = 0.28,
        },
        Molotov = {
            RadiusTrim   = 4.5,
            HeightOffset = 0.3,
            Segments     = 40,
            Thickness    = 0.28,
        },
    }

    local FADE_IN_TIME    = 0.4
    local FADE_OUT_TIME   = 0.6
    local RECALC_INTERVAL = 0.05
    local RAYCAST_DOWN    = 14

    local function GetMolotovColor()
        if Options and Options.GrenadeZoneColor then
            return Options.GrenadeZoneColor.Value
        end
        return Color3.fromRGB(255, 60, 0)
    end

    local function GetSmokeColor()
        if Options and Options.SmokeZoneColor then
            return Options.SmokeZoneColor.Value
        end
        return Color3.fromRGB(180, 180, 180)
    end

    local RunService = game:GetService("RunService")
    local Camera     = workspace.CurrentCamera

    local ActiveZones       = {}
    local DebrisConnections = {}

    local RayParams = RaycastParams.new()
    RayParams.FilterType = Enum.RaycastFilterType.Exclude

    local function ComputeZoneBounds(parent)
        local sumX, sumZ = 0, 0
        local minY = math.huge
        local count = 0
        local parts = {}
        for _, v in ipairs(parent:GetChildren()) do
            if v:IsA("BasePart") then
                count = count + 1
                sumX  = sumX + v.Position.X
                sumZ  = sumZ + v.Position.Z
                local b = v.Position.Y - v.Size.Y * 0.5
                if b < minY then minY = b end
                table.insert(parts, v)
            end
        end
        if count == 0 then return nil, nil, false end
        local cx, cz = sumX/count, sumZ/count
        local maxR = 0
        for _, p in ipairs(parts) do
            local dx  = p.Position.X - cx
            local dz  = p.Position.Z - cz
            local ext = math.max(p.Size.X, p.Size.Z) * 0.5
            local r   = math.sqrt(dx*dx + dz*dz) + ext
            if r > maxR then maxR = r end
        end
        return Vector3.new(cx, minY, cz), math.max(maxR, 1.2), true
    end

    local function GetGroundY(x, baseY, z, excludeList)
        RayParams.FilterDescendantsInstances = excludeList or {}
        local result = workspace:Raycast(
            Vector3.new(x, baseY + 5, z),
            Vector3.new(0, -RAYCAST_DOWN, 0),
            RayParams
        )
        return result and result.Position.Y or baseY
    end

    local function MakeCylinder(col, thickness)
        local p = Instance.new("Part")
        p.Name         = "BS_RingSeg"
        p.Anchored     = true
        p.CanCollide   = false
        p.CanQuery     = false
        p.CastShadow   = false
        p.Material     = Enum.Material.Neon
        p.Color        = col
        p.Transparency = 1
        p.Shape        = Enum.PartType.Cylinder
        p.Size         = Vector3.new(thickness, thickness, thickness)
        p.Parent       = workspace
        return p
    end

    local function CreateZoneRing(parent, cfg, isMolotov)
        if ActiveZones[parent] then return end

        local segments  = cfg.Segments  or 40
        local thickness = cfg.Thickness or 0.28
        local initColor = isMolotov and GetMolotovColor() or GetSmokeColor()

        local cylinders = {}
        local allParts  = {}
        for i = 1, segments do
            local cyl = MakeCylinder(initColor, thickness)
            table.insert(cylinders, cyl)
            table.insert(allParts, cyl)
        end

        local record = {
            cylinders  = cylinders,
            allParts   = allParts,
            cfg        = cfg,
            isMolotov  = isMolotov,
            lastRecalc = 0,
            lastRadius = 1,
            alive      = true,
            fadingOut  = false,
            fadeAlpha  = 0,
        }
        ActiveZones[parent] = record

        local fadeInStart = tick()

        local function CurrentAlpha()
            if record.fadingOut then return record.fadeAlpha end
            return math.clamp((tick() - fadeInStart) / FADE_IN_TIME, 0, 1)
        end

        local function FadeOut()
            if record.fadingOut then return end
            record.fadingOut = true
            record.fadeAlpha = CurrentAlpha()
            local startTick  = tick()
            local startAlpha = record.fadeAlpha
            local conn
            conn = RunService.Heartbeat:Connect(function()
                local t = math.clamp((tick() - startTick) / FADE_OUT_TIME, 0, 1)
                record.fadeAlpha = startAlpha * (1 - t)
                local transp = 1 - record.fadeAlpha
                for _, cyl in ipairs(cylinders) do
                    pcall(function() cyl.Transparency = transp end)
                end
                if t >= 1 then
                    conn:Disconnect()
                    record.alive = false
                    for _, cyl in ipairs(cylinders) do
                        pcall(function() cyl:Destroy() end)
                    end
                    ActiveZones[parent] = nil
                end
            end)
        end

        parent.AncestryChanged:Connect(function(_, newParent)
            if newParent == nil then FadeOut() end
        end)

        local updateConn
        updateConn = RunService.Heartbeat:Connect(function()
            if not record.alive then updateConn:Disconnect() return end
            if not parent or not parent.Parent then
                updateConn:Disconnect()
                FadeOut()
                return
            end

            local now = tick()
            if now - record.lastRecalc < RECALC_INTERVAL then return end
            record.lastRecalc = now

            local center, radius, found = ComputeZoneBounds(parent)
            if not found then return end

            local trim     = cfg.RadiusTrim or 0
            local smoothed = record.lastRadius + (radius - record.lastRadius) * 0.25
            record.lastRadius = smoothed
            local finalR   = math.max(smoothed - trim, 0.8)

            local alpha  = CurrentAlpha()
            local transp = 1 - alpha
            local col    = record.isMolotov and GetMolotovColor() or GetSmokeColor()

            for i, cyl in ipairs(cylinders) do
                local angleA   = (2*math.pi) * ((i-1) / segments)
                local angleB   = (2*math.pi) * (i     / segments)
                local angleMid = (angleA + angleB) / 2

                local xA = center.X + math.cos(angleA)   * finalR
                local zA = center.Z + math.sin(angleA)   * finalR
                local xB = center.X + math.cos(angleB)   * finalR
                local zB = center.Z + math.sin(angleB)   * finalR
                local xM = center.X + math.cos(angleMid) * finalR
                local zM = center.Z + math.sin(angleMid) * finalR

                local yA = GetGroundY(xA, center.Y, zA, allParts) + (cfg.HeightOffset or 0.3)
                local yB = GetGroundY(xB, center.Y, zB, allParts) + (cfg.HeightOffset or 0.3)
                local yM = (yA + yB) * 0.5

                local posA = Vector3.new(xA, yA, zA)
                local posB = Vector3.new(xB, yB, zB)
                local mid  = Vector3.new(xM, yM, zM)
                local dir  = posB - posA
                local len  = dir.Magnitude
                if len < 0.001 then continue end

                local cf = CFrame.lookAt(mid, mid + dir) * CFrame.Angles(0, math.rad(90), 0)

                cyl.CFrame       = cf
                cyl.Size         = Vector3.new(len, thickness, thickness)
                cyl.Color        = col
                cyl.Transparency = transp
            end
        end)

        record.updateConn = updateConn
    end

    local function IsToggleOn(name)
        if Toggles and Toggles[name] then return Toggles[name].Value end
        return false
    end

    local ScannedObjects = {}

    local function TryHandleObject(obj)
        if not obj or not obj.Parent then return end
        if ScannedObjects[obj] then return end

        local name = obj.Name:lower()

        local isMolotov = (
            name:find("firezone") or name:find("fire_zone") or
            name:find("molotov")  or name:find("voxelfire") or
            name:find("ignite")   or name:find("flamezone")  or
            name:find("firearea") or name:find("burnzone")
        )

        local isSmoke = (
            name:find("smokezone") or name:find("smoke_zone") or
            name:find("voxelsmoke") or name:find("smokearea") or
            name:find("gaszone")
        )

        if isMolotov and IsToggleOn("MolotovZoneESP") then
            ScannedObjects[obj] = true
            CreateZoneRing(obj, SETTINGS.Molotov, true)
            obj.AncestryChanged:Connect(function(_, p)
                if p == nil then ScannedObjects[obj] = nil end
            end)
        elseif isSmoke and IsToggleOn("SmokeZoneESP") then
            ScannedObjects[obj] = true
            CreateZoneRing(obj, SETTINGS.Smoke, false)
            obj.AncestryChanged:Connect(function(_, p)
                if p == nil then ScannedObjects[obj] = nil end
            end)
        end
    end

    local function ScanFolder(folder)
        if not folder then return end
        for _, child in ipairs(folder:GetChildren()) do
            TryHandleObject(child)
            for _, sub in ipairs(child:GetChildren()) do
                TryHandleObject(sub)
            end
        end
        folder.ChildAdded:Connect(function(child)
            task.wait()
            TryHandleObject(child)
            child.ChildAdded:Connect(function(sub)
                task.wait()
                TryHandleObject(sub)
            end)
        end)
    end

    task.spawn(function()
        task.wait(1)

        ScanFolder(Workspace)

        local debris = Workspace:FindFirstChild("Debris")
        if debris then ScanFolder(debris) end

        local effects = Workspace:FindFirstChild("Effects")
        if effects then ScanFolder(effects) end

        local fx = Workspace:FindFirstChild("FX")
        if fx then ScanFolder(fx) end

        Workspace.ChildAdded:Connect(function(child)
            local n = child.Name:lower()
            if n == "debris" or n == "effects" or n == "fx" then
                ScanFolder(child)
            end
            task.wait()
            TryHandleObject(child)
            child.ChildAdded:Connect(function(sub)
                task.wait()
                TryHandleObject(sub)
            end)
        end)

        while task.wait(3) do
            for _, child in ipairs(Workspace:GetChildren()) do
                TryHandleObject(child)
                for _, sub in ipairs(child:GetChildren()) do
                    TryHandleObject(sub)
                end
            end
        end
    end)
    end
    ZoneESPModule()
end

-- =========================================================================
-- [ GRENADE FLIGHT TRACER ]
-- =========================================================================

local GrenadeFlightTracers = {}

local function StartGrenadeFlightTracer(part)
    if not part or not part:IsA("BasePart") then return end
    if GrenadeFlightTracers[part] then return end

    local MAX_TRAIL = 30
    local history   = {}
    local lines     = {}

    for i = 1, MAX_TRAIL do
        local l = Drawing.new("Line")
        l.Visible      = false
        l.Thickness    = 2
        l.Transparency = 1
        lines[i] = l
    end

    GrenadeFlightTracers[part] = lines

    local conn
    conn = RunService.RenderStepped:Connect(function()
        local enabled = Toggles and Toggles.GrenadeTracers and Toggles.GrenadeTracers.Value
        local col = Options and Options.GrenadeTracerColor and Options.GrenadeTracerColor.Value or Color3.fromRGB(255, 100, 0)

        if not part or not part.Parent then
            conn:Disconnect()
            GrenadeFlightTracers[part] = nil
            for _, l in ipairs(lines) do
                pcall(function() l:Remove() end)
            end
            return
        end

        if not enabled then
            for _, l in ipairs(lines) do l.Visible = false end
            return
        end

        table.insert(history, 1, part.Position)
        if #history > MAX_TRAIL + 1 then table.remove(history) end

        local cam = workspace.CurrentCamera
        for i = 1, MAX_TRAIL do
            local l  = lines[i]
            local p1 = history[i]
            local p2 = history[i + 1]
            if not p1 or not p2 then
                l.Visible = false
                continue
            end
            local s1, o1 = cam:WorldToViewportPoint(p1)
            local s2, o2 = cam:WorldToViewportPoint(p2)
            if (o1 or o2) and s1.Z > 0 and s2.Z > 0 then
                local fade = 1 - (i / MAX_TRAIL)
                l.From      = Vector2.new(s1.X, s1.Y)
                l.To        = Vector2.new(s2.X, s2.Y)
                l.Color     = col
                l.Thickness = math.max(2 * fade, 0.5)
                l.Transparency = 1 - fade
                l.Visible   = true
            else
                l.Visible = false
            end
        end
    end)
end

local TrackedGrenades = {}

local GRENADE_PATTERNS = {
    "grenade","flash","molotov","bang","frag",
    "he_","_he","throwable","projectile","nade",
    "incendiary","decoy","c4"
}

local GRENADE_BLACKLIST = {
    "gun","rifle","pistol","bullet","casing","debris",
    "light","muzzle","launch","effect","arm","leg",
    "torso","head","humanoid","mesh","handle",
    "constraint","weld","motor","zone","voxel"
}

local function isGrenadeObject(obj)
    if not obj:IsA("BasePart") and not obj:IsA("Model") then return false end
    local name = obj.Name:lower()
    for _, p in ipairs(GRENADE_BLACKLIST) do
        if name:find(p) then return false end
    end
    if #name > 20 and name:find("%-") then return true end
    for _, p in ipairs(GRENADE_PATTERNS) do
        if name:find(p) then return true end
    end
    return false
end

local function TryTrackGrenade(obj)
    if TrackedGrenades[obj] then return end

    local part = obj
    if obj:IsA("Model") then
        part = obj:FindFirstChild("Handle")
             or obj:FindFirstChildWhichIsA("BasePart")
    end
    if not part or not part:IsA("BasePart") then return end
    if part.Size.Magnitude > 8 then return end
    if Players:GetPlayerFromCharacter(obj) then return end
    if Players:GetPlayerFromCharacter(obj.Parent) then return end

    TrackedGrenades[obj] = true

    local cc
    cc = obj.AncestryChanged:Connect(function(_, p)
        if p == nil then
            TrackedGrenades[obj] = nil
            cc:Disconnect()
        end
    end)

    StartGrenadeFlightTracer(part)
end

local function ScanForGrenades(folder)
    if not folder then return end
    for _, child in ipairs(folder:GetChildren()) do
        if isGrenadeObject(child) then TryTrackGrenade(child) end
        if child:IsA("Model") then
            for _, sub in ipairs(child:GetChildren()) do
                if isGrenadeObject(sub) then TryTrackGrenade(sub) end
            end
        end
    end
end

task.spawn(function()
    task.wait(0.5)
    ScanForGrenades(Workspace)

    local toWatch = {"Debris","Effects","FX","Projectiles","Grenades"}
    for _, fname in ipairs(toWatch) do
        local f = Workspace:FindFirstChild(fname)
        if f then
            ScanForGrenades(f)
            f.ChildAdded:Connect(function(child)
                task.wait()
                if isGrenadeObject(child) then TryTrackGrenade(child) end
            end)
        end
    end

    Workspace.ChildAdded:Connect(function(child)
        task.wait()
        if isGrenadeObject(child) then TryTrackGrenade(child) end
        local n = child.Name:lower()
        if n=="debris" or n=="effects" or n=="fx" or n=="projectiles" or n=="grenades" then
            ScanForGrenades(child)
            child.ChildAdded:Connect(function(sub)
                task.wait()
                if isGrenadeObject(sub) then TryTrackGrenade(sub) end
            end)
        end
        child.ChildAdded:Connect(function(sub)
            task.wait()
            if isGrenadeObject(sub) then TryTrackGrenade(sub) end
        end)
    end)
end)

-- =========================================================================
-- [ CHAMS V3 ]
-- =========================================================================

task.spawn(function()
    repeat task.wait() until Tabs and Tabs.Visuals
    repeat task.wait() until Toggles and Options

    local ChamsGroupbox = Tabs.Visuals:AddRightGroupbox("Chams")

    ChamsGroupbox:AddToggle("ChamsEnabled",   { Text = "Enabled",    Default = false })
    ChamsGroupbox:AddToggle("ChamsTeamCheck", { Text = "TeamCheck",  Default = true  })

    ChamsGroupbox:AddDivider()

    ChamsGroupbox:AddLabel("Visible")
    ChamsGroupbox:AddDropdown("ChamsMaterialVisible", {
        Text    = "MaterialVisible",
        Values  = {"Neon", "Metal", "ForceField", "SmoothPlastic"},
        Default = "Neon",
    })
    ChamsGroupbox:AddLabel("ColorVisible"):AddColorPicker("ChamsColorVisible", {
        Default = Color3.fromRGB(0, 200, 0),
        Title   = "ColorVisible",
    })
    ChamsGroupbox:AddSlider("ChamsAlphaVisible", {
        Text     = "FillTransparencyVisible",
        Default  = 0.3,
        Min      = 0,
        Max      = 1,
        Rounding = 2,
    })
    ChamsGroupbox:AddSlider("ChamsOutlineAlphaVisible", {
        Text     = "OutlineTransparencyVisible",
        Default  = 0,
        Min      = 0,
        Max      = 1,
        Rounding = 2,
    })

    ChamsGroupbox:AddDivider()

    ChamsGroupbox:AddLabel("Unvisible")
    ChamsGroupbox:AddDropdown("ChamsMaterialUnvisible", {
        Text    = "MaterialUnvisible",
        Values  = {"Neon", "Metal", "ForceField", "SmoothPlastic"},
        Default = "Metal",
    })
    ChamsGroupbox:AddLabel("ColorUnvisible"):AddColorPicker("ChamsColorUnvisible", {
        Default = Color3.fromRGB(200, 0, 0),
        Title   = "ColorUnvisible",
    })
    ChamsGroupbox:AddSlider("ChamsAlphaUnvisible", {
        Text     = "FillTransparencyUnvisible",
        Default  = 0.3,
        Min      = 0,
        Max      = 1,
        Rounding = 2,
    })
    ChamsGroupbox:AddSlider("ChamsOutlineAlphaUnvisible", {
        Text     = "OutlineTransparencyUnvisible",
        Default  = 0,
        Min      = 0,
        Max      = 1,
        Rounding = 2,
    })

    local Players   = game:GetService("Players")
    local RunService= game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local LP        = Players.LocalPlayer

    local ESPFolder
    pcall(function()
        ESPFolder = Instance.new("Folder", game:GetService("CoreGui"))
        ESPFolder.Name = "Chams_Container"
    end)

    local Highlights = {}

    local function getMaterial(str)
        if str == "Metal"          then return Enum.Material.Metal
        elseif str == "ForceField" then return Enum.Material.ForceField
        elseif str == "SmoothPlastic" then return Enum.Material.SmoothPlastic
        else return Enum.Material.Neon end
    end

    local function removeChams(char)
        if Highlights[char] then
            pcall(function() Highlights[char].visible:Destroy() end)
            pcall(function() Highlights[char].unvisible:Destroy() end)
            Highlights[char] = nil
        end
        if not char then return end
        for _, obj in ipairs(char:GetDescendants()) do
            pcall(function()
                if obj:IsA("BasePart") and obj:GetAttribute("OrigMat") then
                    obj.Material = Enum.Material[obj:GetAttribute("OrigMat")]
                    obj.Color    = obj:GetAttribute("OrigColor") or obj.Color
                    obj:SetAttribute("OrigMat",   nil)
                    obj:SetAttribute("OrigColor", nil)
                end
            end)
        end
    end

    local function hasVestDetails(char)
        if not char then return false end
        local armor = char:FindFirstChild("CharacterArmor")
        if armor then
            return armor:FindFirstChild("VestDetails") ~= nil
        end
        return false
    end

    local function isTeammate(char)
        if not char then return false end
        local myChar = LP.Character
        if not myChar then return false end
        local myHasVest  = hasVestDetails(myChar)
        local hisHasVest = hasVestDetails(char)
        return myHasVest == hisHasVest
    end

    local RayParams = RaycastParams.new()
    RayParams.FilterType = Enum.RaycastFilterType.Exclude

    local function isVisible(char)
        local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
        if not root then return false end
        local camPos = Workspace.CurrentCamera.CFrame.Position
        local dir    = root.Position - camPos
        RayParams.FilterDescendantsInstances = {LP.Character, char}
        local result = Workspace:Raycast(camPos, dir, RayParams)
        return result == nil
    end

    RunService.RenderStepped:Connect(function()
        local enabled     = Toggles.ChamsEnabled   and Toggles.ChamsEnabled.Value
        local teamCheckOn = Toggles.ChamsTeamCheck and Toggles.ChamsTeamCheck.Value

        local matVisible   = getMaterial(Options.ChamsMaterialVisible   and Options.ChamsMaterialVisible.Value   or "Neon")
        local matUnvisible = getMaterial(Options.ChamsMaterialUnvisible and Options.ChamsMaterialUnvisible.Value or "Metal")
        local colVisible   = Options.ChamsColorVisible   and Options.ChamsColorVisible.Value   or Color3.fromRGB(0,200,0)
        local colUnvisible = Options.ChamsColorUnvisible and Options.ChamsColorUnvisible.Value or Color3.fromRGB(200,0,0)

        local fillAlphaVis    = Options.ChamsAlphaVisible         and Options.ChamsAlphaVisible.Value         or 0.3
        local fillAlphaUnvis  = Options.ChamsAlphaUnvisible       and Options.ChamsAlphaUnvisible.Value       or 0.3
        local outAlphaVis     = Options.ChamsOutlineAlphaVisible   and Options.ChamsOutlineAlphaVisible.Value   or 0
        local outAlphaUnvis   = Options.ChamsOutlineAlphaUnvisible and Options.ChamsOutlineAlphaUnvisible.Value or 0

        local charactersFolder = Workspace:FindFirstChild("Characters")
        if not charactersFolder then return end

        local enemyChars = {}
        for _, obj in ipairs(charactersFolder:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                local char = obj
                if char == LP.Character then continue end
                if teamCheckOn and isTeammate(char) then
                    removeChams(char)
                    continue
                end
                if not enabled then
                    removeChams(char)
                    continue
                end
                table.insert(enemyChars, char)
            end
        end

        for _, char in ipairs(enemyChars) do
            if not Highlights[char] then
                local hlVis = Instance.new("Highlight")
                hlVis.DepthMode           = Enum.HighlightDepthMode.Occluded
                hlVis.Parent              = ESPFolder

                local hlUnvis = Instance.new("Highlight")
                hlUnvis.DepthMode         = Enum.HighlightDepthMode.AlwaysOnTop
                hlUnvis.Parent            = ESPFolder

                Highlights[char] = { visible = hlVis, unvisible = hlUnvis }

                char.AncestryChanged:Connect(function(_, newParent)
                    if newParent == nil then removeChams(char) end
                end)
            end

            local hl  = Highlights[char]
            local seen = isVisible(char)

            hl.visible.Adornee            = char
            hl.visible.FillColor          = colVisible
            hl.visible.OutlineColor       = colVisible
            hl.visible.FillTransparency   = fillAlphaVis
            hl.visible.OutlineTransparency= outAlphaVis
            hl.visible.Enabled            = seen

            hl.unvisible.Adornee            = char
            hl.unvisible.FillColor          = colUnvisible
            hl.unvisible.OutlineColor       = colUnvisible
            hl.unvisible.FillTransparency   = fillAlphaUnvis
            hl.unvisible.OutlineTransparency= outAlphaUnvis
            hl.unvisible.Enabled            = not seen

            local targetMat = seen and matVisible or matUnvisible
            local targetCol = seen and colVisible or colUnvisible

            for _, part in ipairs(char:GetDescendants()) do
                pcall(function()
                    if part:IsA("SurfaceAppearance") or part:IsA("Decal") or part:IsA("Texture") then
                        part:Destroy()
                    elseif part:IsA("MeshPart") and part.TextureID ~= "" then
                        part.TextureID = ""
                    elseif part:IsA("SpecialMesh") and part.TextureId ~= "" then
                        part.TextureId = ""
                    end
                    if part:IsA("BasePart") then
                        if not part:GetAttribute("OrigMat") then
                            part:SetAttribute("OrigMat",   part.Material.Name)
                            part:SetAttribute("OrigColor", part.Color)
                        end
                        part.Material = targetMat
                        part.Color    = targetCol
                    end
                end)
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        if player.Character then
            removeChams(player.Character)
        end
    end)
end)

-- =========================================================================
-- [ WEAPON — INSTANT RELOAD ]
-- =========================================================================

task.spawn(function()
    local MiscWeaponBox = Tabs.Combat:AddRightGroupbox("Weapon", "crosshair")

    MiscWeaponBox:AddToggle("InstantReload", {
        Text = "Instant Reload",
        Default = false,
    })

    local RELOAD_ANIMS = {
        ["Reload"]       = true,
        ["ReloadStart"]  = true,
        ["ReloadAction"] = true,
        ["ReloadEnd"]    = true,
        ["Reloading"]    = true,
        ["ReloadShot"]   = true,
        ["Reloading_Stand"] = true,
        ["Reload_Stand"]    = true,
    }

    local RELOAD_SPEED = 199
    local reloadHooked = {}

    local function getWeaponObjectSafe()
        local ok, IC = pcall(function()
            return require(game:GetService("ReplicatedStorage").Controllers.InventoryController)
        end)
        if not ok or not IC then return nil end
        return IC.peekCurrentEquippedForMovement and IC.peekCurrentEquippedForMovement() or nil
    end

    local function hookAnimationReload(animModule)
        if not animModule or reloadHooked[animModule] then return end
        reloadHooked[animModule] = true

        pcall(function()
            local origPlay = animModule.play
            animModule.play = function(self_anim, animName, ...)
                local track = origPlay(self_anim, animName, ...)
                if track and RELOAD_ANIMS[animName] then
                    task.defer(function()
                        pcall(function()
                            if Toggles.InstantReload and Toggles.InstantReload.Value then
                                if track.IsPlaying then
                                    track:AdjustSpeed(RELOAD_SPEED)
                                end
                            end
                        end)
                    end)
                end
                return track
            end
        end)
    end

    local lastReloadWeapon = nil

    task.spawn(function()
        while task.wait(0.03) do
            pcall(function()
                local weapon = getWeaponObjectSafe()
                if not weapon then return end

                if weapon ~= lastReloadWeapon then
                    lastReloadWeapon = weapon
                    if weapon.Viewmodel and weapon.Viewmodel.Animation then
                        hookAnimationReload(weapon.Viewmodel.Animation)
                    end
                    if weapon.CharacterAnimator then
                        hookAnimationReload(weapon.CharacterAnimator)
                    end
                end

                if not (Toggles.InstantReload and Toggles.InstantReload.Value) then return end

                    pcall(function()
                        if weapon.Viewmodel and weapon.Viewmodel.Animation and weapon.Viewmodel.Animation.Animations then
                            for name, track in pairs(weapon.Viewmodel.Animation.Animations) do
                                if RELOAD_ANIMS[name] and track.IsPlaying then
                                    track:AdjustSpeed(RELOAD_SPEED)
                                end
                            end
                        end
                        if weapon.CharacterAnimator and weapon.CharacterAnimator.Animations then
                            for name, track in pairs(weapon.CharacterAnimator.Animations) do
                                if RELOAD_ANIMS[name] and track.IsPlaying then
                                    track:AdjustSpeed(RELOAD_SPEED)
                                end
                            end
                        end
                    end)
            end)
        end
    end)

    pcall(function()
        local IC = require(game:GetService("ReplicatedStorage").Controllers.InventoryController)
        if IC.OnInventoryItemEquipped then
            IC.OnInventoryItemEquipped:Connect(function(_, weapon)
                if not weapon then return end
                task.defer(function()
                    if weapon.Viewmodel and weapon.Viewmodel.Animation then
                        hookAnimationReload(weapon.Viewmodel.Animation)
                    end
                    if weapon.CharacterAnimator then
                        hookAnimationReload(weapon.CharacterAnimator)
                    end
                end)
            end)
        end
    end)
end)

-- =========================================================================
-- [ SAVE MANAGER / THEME MANAGER ]
-- =========================================================================
local function smModule()
local smFolder = ""
local smSubFolder = ""
local smIgnore = {}
local smLibrary = nil

local function smPath(name)
    local p = smFolder
    if smSubFolder ~= "" then
        p = p .. "/" .. smSubFolder
    end
    return p .. "/" .. name .. ".json"
end

local function smEnsureFolder()
    if smFolder == "" then return end
    if not makefolder then return end
    pcall(function()
        local base = smFolder
        if smSubFolder ~= "" then base = base .. "/" .. smSubFolder end
        local cur = ""
        for segment in base:gmatch("[^/\\]+") do
            cur = cur == "" and segment or (cur .. "/" .. segment)
            pcall(function() makefolder(cur) end)
        end
    end)
end

local function serializeValue(v)
    local t = typeof(v)
    if t == "Color3" then
        return { __c3 = true, r = v.R, g = v.G, b = v.B }
    elseif t == "Vector2" then
        return { __v2 = true, x = v.X, y = v.Y }
    elseif t == "Vector3" then
        return { __v3 = true, x = v.X, y = v.Y, z = v.Z }
    elseif t == "EnumItem" then
        return tostring(v)
    elseif t == "table" then
        local out = {}
        local ok = true
        for k, val in pairs(v) do
            if type(k) == "number" or type(k) == "string" then
                out[k] = serializeValue(val)
            else
                ok = false
                break
            end
        end
        if ok then return out end
        return tostring(v)
    end
    return v
end

local function deserializeValue(v)
    if type(v) == "table" then
        if v.__c3 then
            return Color3.new(v.r or 1, v.g or 1, v.b or 1)
        elseif v.__v2 then
            return Vector2.new(v.x or 0, v.y or 0)
        elseif v.__v3 then
            return Vector3.new(v.x or 0, v.y or 0, v.z or 0)
        end
        local out = {}
        for k, val in pairs(v) do
            out[k] = deserializeValue(val)
        end
        return out
    end
    return v
end

local function collectState()
    local state = { T = {}, O = {} }
    if not smLibrary then return state end
    local toggles = smLibrary.Toggles or Toggles
    local options = smLibrary.Options or Options
    for id, obj in pairs(toggles) do
        if not smIgnore[id] and type(obj) == "table" and obj.Value ~= nil then
            state.T[id] = serializeValue(obj.Value)
        end
    end
    for id, obj in pairs(options) do
        if not smIgnore[id] and type(obj) == "table" and obj.Value ~= nil then
            state.O[id] = serializeValue(obj.Value)
        end
    end
    return state
end

local function applyState(state)
    if not smLibrary or type(state) ~= "table" then return end
    local toggles = smLibrary.Toggles or Toggles
    local options = smLibrary.Options or Options
    if type(state.T) == "table" then
        for id, val in pairs(state.T) do
            local obj = toggles[id]
            if obj and type(obj) == "table" and obj.SetValue and not smIgnore[id] then
                pcall(function() obj:SetValue(deserializeValue(val)) end)
            end
        end
    end
    if type(state.O) == "table" then
        for id, val in pairs(state.O) do
            local obj = options[id]
            if obj and type(obj) == "table" and obj.SetValue and not smIgnore[id] then
                pcall(function() obj:SetValue(deserializeValue(val)) end)
            end
        end
    end
end

local function writeFileSafe(path, content)
    local ok = false
    pcall(function()
        if writefile then
            writefile(path, content)
            ok = true
        end
    end)
    return ok
end

local function readFileSafe(path)
    local result = nil
    pcall(function()
        if readfile then
            result = readfile(path)
        end
    end)
    return result
end

local function listFilesSafe(folder)
    local list = {}
    pcall(function()
        if listfiles then
            local files = listfiles(folder)
            if type(files) == "table" then
                for _, f in ipairs(files) do
                    list[#list + 1] = f
                end
            end
        end
    end)
    return list
end

function SaveManager:SetLibrary(lib)
    smLibrary = lib
end

function SaveManager:IgnoreThemeSettings()
end

function SaveManager:SetIgnoreIndexes(list)
    smIgnore = {}
    if type(list) == "table" then
        for _, id in ipairs(list) do
            smIgnore[id] = true
        end
    end
end

function SaveManager:SetFolder(folder)
    smFolder = tostring(folder or "")
end

function SaveManager:SetSubFolder(sub)
    smSubFolder = tostring(sub or "")
end

function SaveManager:Save(name)
    name = tostring(name or "default"):gsub("[%c\\/:*?\"<>|]", ""):gsub("%s+", "_"):gsub("^_+|_+$", "")
    if name == "" then return false end
    smEnsureFolder()
    local state = collectState()
    local ok, encoded = pcall(function() return HttpService:JSONEncode(state) end)
    if not ok then return false end
    return writeFileSafe(smPath(name), encoded)
end

function SaveManager:Load(name)
    name = tostring(name or "default")
    local raw = readFileSafe(smPath(name))
    if not raw or raw == "" then return false end
    local ok, decoded = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok or type(decoded) ~= "table" then return false end
    applyState(decoded)
    return true
end

function SaveManager:Delete(name)
    name = tostring(name or "default")
    local path = smPath(name)
    pcall(function()
        if delfile then delfile(path) end
    end)
    return true
end

function SaveManager:GetConfigs()
    local out = {}
    local base = smFolder
    if smSubFolder ~= "" then base = base .. "/" .. smSubFolder end
    local files = listFilesSafe(base)
    for _, f in ipairs(files) do
        local name = tostring(f):match("([^/\\]+)%.json$")
        if name then
            out[#out + 1] = name
        end
    end
    table.sort(out)
    return out
end

function SaveManager:LoadAutoloadConfig()
    pcall(function()
        SaveManager:Load("autoload")
    end)
end

function ThemeManager:SetLibrary(lib)
end

function ThemeManager:SetFolder(folder)
end

function ThemeManager:ApplyToTab(tab)
end

function SaveManager:BuildConfigSection(tab)
    if not tab or not tab.AddLeftGroupbox then return end
    local box = tab:AddLeftGroupbox("Configs")

    box:AddInput("ConfigName", {
        Text = "Config Name",
        Default = "default",
        Placeholder = "enter name...",
    })

    local list = SaveManager:GetConfigs()
    local dd = box:AddDropdown("ConfigList", {
        Text = "Saved Configs",
        Values = #list > 0 and list or { "default" },
        Default = #list > 0 and list[1] or "default",
    })

    box:AddButton("Save Config", function()
        local name = (Options.ConfigName and Options.ConfigName.Value) or "default"
        if SaveManager:Save(name) then
            local configs = SaveManager:GetConfigs()
            if dd and dd.SetValues and #configs > 0 then
                dd:SetValues(configs)
                dd:SetValue(name)
            end
        end
    end)

    box:AddButton("Load Config", function()
        local name = nil
        if Options.ConfigList and Options.ConfigList.Value then
            name = Options.ConfigList.Value
        end
        if Options.ConfigName and Options.ConfigName.Value and Options.ConfigName.Value ~= "" then
            name = Options.ConfigName.Value
        end
        SaveManager:Load(name or "default")
    end)

    box:AddButton("Delete Config", function()
        local name = nil
        if Options.ConfigList and Options.ConfigList.Value then
            name = Options.ConfigList.Value
        end
        if Options.ConfigName and Options.ConfigName.Value and Options.ConfigName.Value ~= "" then
            name = Options.ConfigName.Value
        end
        SaveManager:Delete(name or "default")
        local configs = SaveManager:GetConfigs()
        if dd and dd.SetValues then
            dd:SetValues(#configs > 0 and configs or { "default" })
        end
    end)

    box:AddButton("Save as Autoload", function()
        local name = (Options.ConfigName and Options.ConfigName.Value) or "default"
        if SaveManager:Save(name) then
            SaveManager:Save("autoload")
        end
    end)
end
end
smModule()

-- =========================================================================
-- [ SETTINGS FINALIZATION ]
-- =========================================================================

SettingsGroup:AddButton("Unload Menu", function()
    Library:Unload()
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind", "MenuColorPicker", "ConfigName", "ConfigList" })

ThemeManager:SetFolder("pastehub")
SaveManager:SetFolder("pastehub/bloxstrike")
SaveManager:SetSubFolder("pastehub")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- SaveManager:LoadAutoloadConfig() -- отключено: не загружать сохранённый конфиг автоматически

_G.__PASTEHUB_FULLBUILD_UNLOAD__ = function()
    pcall(function() Library:Unload() end)
end

-- =========================================================================
-- [ END OF PASTEHUB | FULL BUILD ]
-- =========================================================================
