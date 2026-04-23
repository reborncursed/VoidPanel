-- ============================================================
--   RIVALS PANEL  ·  by iSacredRivals
--   Blox Fruits  ·  Compatible con Delta Executor
-- ============================================================

-- ============================================================
--  [0] INTRO DORADA
-- ============================================================
local function RunIntro()
    local TS2 = game:GetService("TweenService")
    local introGui = Instance.new("ScreenGui")
    introGui.Name = "RivalsIntro"
    introGui.IgnoreGuiInset = true
    introGui.DisplayOrder = 999
    pcall(function() introGui.Parent = game:GetService("CoreGui") end)
    if not introGui.Parent then
        introGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    local bg = Instance.new("Frame", introGui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(8,6,2)
    bg.BorderSizePixel = 0

    local title = Instance.new("TextLabel", bg)
    title.Size = UDim2.new(1,0,0,70)
    title.Position = UDim2.new(0,0,0.28,0)
    title.BackgroundTransparency = 1
    title.Text = "RIVALS PANEL"
    title.TextColor3 = Color3.fromRGB(201,168,76)
    title.Font = Enum.Font.Code -- fallback, reemplazado por CustomFont
    title.TextSize = 52
    title.TextScaled = false
    title.TextStrokeTransparency = 0.4
    title.TextStrokeColor3 = Color3.fromRGB(80,58,18)
    title.TextTransparency = 1
    -- Orbitron via ContentProvider
    pcall(function()
        local font = Font.new("rbxasset://fonts/families/Orbitron.json", Enum.FontWeight.ExtraBold)
        title.FontFace = font
    end)
    -- fallback si no existe el asset
    pcall(function()
        if title.FontFace == nil then
            title.Font = Enum.Font.GothamBlack
        end
    end)

    local sub1 = Instance.new("TextLabel", bg)
    sub1.Size = UDim2.new(1,0,0,26)
    sub1.Position = UDim2.new(0,0,0.28,74)
    sub1.BackgroundTransparency = 1
    sub1.Text = "by iSacredRivals"
    sub1.TextColor3 = Color3.fromRGB(240,208,128)
    sub1.Font = Enum.Font.GothamBold
    sub1.TextSize = 17
    sub1.TextTransparency = 1

    local sub2 = Instance.new("TextLabel", bg)
    sub2.Size = UDim2.new(1,0,0,20)
    sub2.Position = UDim2.new(0,0,0.28,108)
    sub2.BackgroundTransparency = 1
    sub2.Text = "Cargando protocolos dorados..."
    sub2.TextColor3 = Color3.fromRGB(120,100,52)
    sub2.Font = Enum.Font.Gotham
    sub2.TextSize = 14
    sub2.TextTransparency = 1

    -- línea removida por preferencia del usuario

    -- números matrix dorados
    task.spawn(function()
        for i = 1, 100 do
            task.spawn(function()
                while bg.Parent do
                    local m = Instance.new("TextLabel", bg)
                    m.Text = tostring(math.random(0,9))
                    m.Position = UDim2.new(math.random(),0,math.random(),0)
                    m.BackgroundTransparency = 1
                    m.TextColor3 = Color3.fromRGB(
                        math.random(150,220),
                        math.random(110,170),
                        math.random(30,70)
                    )
                    m.Font = Enum.Font.Code
                    m.TextSize = math.random(12,22)
                    m.TextTransparency = 1
                    m.Parent = bg
                    local dur = math.random(4,12)/10
                    TS2:Create(m, TweenInfo.new(dur/2), {TextTransparency=0}):Play()
                    task.wait(dur)
                    TS2:Create(m, TweenInfo.new(dur/2), {TextTransparency=1}):Play()
                    game:GetService("Debris"):AddItem(m, dur)
                    task.wait(math.random(1,4)/10)
                end
            end)
        end
    end)

    task.spawn(function()
        task.wait(0.8)
        TS2:Create(title, TweenInfo.new(0.7,Enum.EasingStyle.Quint), {TextTransparency=0}):Play()
        task.wait(0.35)
        TS2:Create(sub1, TweenInfo.new(0.5), {TextTransparency=0}):Play()
        task.wait(0.25)
        TS2:Create(sub2, TweenInfo.new(0.5), {TextTransparency=0}):Play()
        task.wait(3.5)
        local fi = TweenInfo.new(0.8, Enum.EasingStyle.Linear)
        TS2:Create(bg,    fi, {BackgroundTransparency=1}):Play()
        TS2:Create(title, fi, {TextTransparency=1}):Play()
        TS2:Create(sub1,  fi, {TextTransparency=1}):Play()
        TS2:Create(sub2,  fi, {TextTransparency=1}):Play()
        task.wait(0.9)
        introGui:Destroy()
    end)
end

RunIntro()
task.wait(5.5)

-- ============================================================
--  [1] SERVICIOS
-- ============================================================
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local TweenService      = game:GetService("TweenService")
local LP = Players.LocalPlayer

-- ============================================================
--  [2] COLORES
-- ============================================================
local C = {
    bg        = Color3.fromRGB(18,15,8),
    surface   = Color3.fromRGB(32,27,14),
    surface2  = Color3.fromRGB(42,35,16),
    gold      = Color3.fromRGB(201,168,76),
    goldLight = Color3.fromRGB(240,208,128),
    goldDark  = Color3.fromRGB(80,58,18),
    text      = Color3.fromRGB(230,214,155),
    textDim   = Color3.fromRGB(120,100,52),
    red       = Color3.fromRGB(160,40,40),
    white     = Color3.new(1,1,1),
}

-- ============================================================
--  [3] TAMAÑOS
-- ============================================================
local SIZES = {
    {name="Mini",   w=380, h=340},
    {name="Normal", w=500, h=430},
    {name="Grande", w=620, h=520},
    {name="Extra",  w=740, h=610},
}
local currentSizeIdx = 2

-- ============================================================
--  [4] HELPERS
-- ============================================================
local function corner(p,r)
    local c = Instance.new("UICorner",p); c.CornerRadius = UDim.new(0,r or 8)
end
local function stroke(p,col,th,tr)
    local s = Instance.new("UIStroke",p)
    s.Color=col or C.gold; s.Thickness=th or 1; s.Transparency=tr or 0.6
end
local function tw(obj,props,t)
    TweenService:Create(obj,TweenInfo.new(t or 0.22,Enum.EasingStyle.Quint),props):Play()
end
local function mkLbl(parent,text,sz,col,bold,xAl,x,y,w,h)
    local l = Instance.new("TextLabel",parent)
    l.BackgroundTransparency=1; l.Text=text; l.TextSize=sz
    l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextColor3=col; l.TextXAlignment=xAl or Enum.TextXAlignment.Left
    l.Size=UDim2.new(0,w,0,h); l.Position=UDim2.new(0,x,0,y)
    return l
end
local function goldGrad(f)
    local g = Instance.new("UIGradient",f)
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(18,15,8)),
        ColorSequenceKeypoint.new(0.2, C.gold),
        ColorSequenceKeypoint.new(0.8, C.gold),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(18,15,8)),
    })
end

-- ============================================================
--  [5] VARIABLES DE LÓGICA
-- ============================================================
local FastAttackEnabled  = false
local FastAttackRange    = 12000
local FastAttackConn     = nil
local FruitAttack        = false
local FruitAttackConn    = nil
local InfJumpEnabled     = false
local NoClipEnabled      = false
local WalkWater          = false
local SpeedEnabled       = false
local SpeedValue         = 16

-- Player / TP
local SelectedPlayer   = nil
local TeleportEnabled  = false
local InstaTpEnabled   = false
local SpectateEnabled  = false
local TeleportConn     = nil
local InstaTpConn      = nil
local SpectateConn     = nil
local ActiveTween      = nil
local YOffset          = 0
local PredictionStr    = 0
local TweenSpeed       = {X=350}

-- ESP
local ESPEnabled = false
local ESPBoxes   = false
local ESPNames   = false
local ESPObjects = {}

-- Azucar Hub vars
local SelectedPlayers   = {}
local KillFlashActive   = false
local TrackingActive    = false
local AntiPerrasActive  = false
local TweenTracking     = false
local FullBright        = false
local TrackerHeight     = 300
local OrbitDistance     = 5
local OrbitRot          = 0
local AzucarStayTime    = 0.3

-- Net
local Net            = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local RegisterHit    = Net["RE/RegisterHit"]
local RegisterAttack = Net["RE/RegisterAttack"]

-- ============================================================
--  [6] LÓGICA: FAST ATTACK
-- ============================================================
local function AttackMultipleTargets(targets)
    pcall(function()
        if not targets or #targets==0 then return end
        local all = {}
        for _,char in pairs(targets) do
            local head = char:FindFirstChild("Head")
            local hrp  = char:FindFirstChild("HumanoidRootPart")
            if hrp and getgenv().HitboxExpander then
                hrp.Size        = Vector3.new(30,30,30)
                hrp.Transparency= 0.7
                hrp.BrickColor  = BrickColor.new("White")
                hrp.Material    = Enum.Material.ForceField
                hrp.CanCollide  = false
            end
            if head then table.insert(all,{char,head}) end
        end
        if #all==0 then return end
        RegisterAttack:FireServer(0)
        RegisterHit:FireServer(all[1][2], all)
    end)
end

local function StartFastAttack()
    if FastAttackConn then task.cancel(FastAttackConn) end
    FastAttackConn = task.spawn(function()
        while FastAttackEnabled do
            task.wait(0.005)
            local myChar = LP.Character
            local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myHRP then continue end
            local targets = {}
            for _,pl in pairs(Players:GetPlayers()) do
                if pl~=LP and pl.Character then
                    local hum = pl.Character:FindFirstChild("Humanoid")
                    local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                    if hum and hrp and hum.Health>0 and
                       (hrp.Position-myHRP.Position).Magnitude<=FastAttackRange then
                        table.insert(targets, pl.Character)
                    end
                end
            end
            local en = workspace:FindFirstChild("Enemies")
            if en then
                for _,npc in pairs(en:GetChildren()) do
                    local hum = npc:FindFirstChild("Humanoid")
                    local hrp = npc:FindFirstChild("HumanoidRootPart")
                    if hum and hrp and hum.Health>0 and
                       (hrp.Position-myHRP.Position).Magnitude<=FastAttackRange then
                        table.insert(targets, npc)
                    end
                end
            end
            if #targets>0 then AttackMultipleTargets(targets) end
        end
    end)
end

-- ============================================================
--  [7] LÓGICA: NEAREST PLAYER + FRUIT ATTACK
-- ============================================================
local function GetNearestPlayer()
    local nearest, dist = nil, math.huge
    local myHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    for _,v in pairs(Players:GetPlayers()) do
        if v~=LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local d = (myHRP.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist=d; nearest=v end
        end
    end
    return nearest
end

local function StartFruitAttack(toolName, extraArg)
    if FruitAttackConn then task.cancel(FruitAttackConn) end
    FruitAttackConn = task.spawn(function()
        while FruitAttack do
            task.wait(0.001)
            local target = GetNearestPlayer()
            if target and target.Character then
                local tool = LP.Character:FindFirstChild(toolName)
                if tool then
                    local dir = (target.Character.HumanoidRootPart.Position -
                                 LP.Character.HumanoidRootPart.Position).Unit
                    pcall(function()
                        if extraArg then
                            tool:WaitForChild("LeftClickRemote"):FireServer(dir,1,true)
                        else
                            tool:WaitForChild("LeftClickRemote"):FireServer(dir,1)
                        end
                    end)
                end
            end
        end
    end)
end

-- ============================================================
--  [8] LÓGICA: MOVIMIENTO
-- ============================================================
RunService.Heartbeat:Connect(function()
    if SpeedEnabled and LP.Character then
        local hum = LP.Character:FindFirstChild("Humanoid")
        if hum and hum.MoveDirection.Magnitude>0 then
            LP.Character:TranslateBy(hum.MoveDirection*(SpeedValue/55))
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled and LP.Character then
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

RunService.Stepped:Connect(function()
    if NoClipEnabled and LP.Character then
        for _,v in pairs(LP.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local char = LP.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if WalkWater and hrp then
        if hrp.Position.Y>=9.5 and hrp.Velocity.Y<=0 then
            local wp = workspace:FindFirstChild("RivalsWaterSolid")
            if not wp then
                wp = Instance.new("Part",workspace)
                wp.Name="RivalsWaterSolid"; wp.Size=Vector3.new(20,1,20)
                wp.Transparency=1; wp.Anchored=true
                wp.CanCollide=true; wp.CanQuery=false
            end
            wp.CFrame = CFrame.new(hrp.Position.X,9.2,hrp.Position.Z)
        else
            local wp = workspace:FindFirstChild("RivalsWaterSolid")
            if wp then wp:Destroy() end
        end
    else
        local wp = workspace:FindFirstChild("RivalsWaterSolid")
        if wp then wp:Destroy() end
    end
end)

-- ============================================================
--  [9] LÓGICA: PLAYER LOCK
-- ============================================================
local function SetNoCollide()
    pcall(function()
        if not LP.Character then return end
        for _,v in ipairs(LP.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end)
end
local function SetCollide()
    pcall(function()
        if not LP.Character then return end
        for _,v in ipairs(LP.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide=true end
        end
    end)
end
local function TweenToPlayer(targetHRP)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local HRP  = LP.Character.HumanoidRootPart
    local pred = targetHRP.Position + (targetHRP.Velocity * PredictionStr)
    local tCF  = CFrame.new(pred) * CFrame.Angles(0,math.rad(targetHRP.Orientation.Y),0) * CFrame.new(0,YOffset,0)
    local dist = (tCF.Position - HRP.Position).Magnitude
    if ActiveTween then ActiveTween:Cancel() end
    ActiveTween = TweenService:Create(HRP, TweenInfo.new(dist/TweenSpeed.X,Enum.EasingStyle.Linear), {CFrame=tCF})
    ActiveTween:Play()
end

-- ============================================================
--  [10] LÓGICA: ESP
-- ============================================================
local function ClearESP()
    for _,o in pairs(ESPObjects) do if o and o.Parent then o:Destroy() end end
    ESPObjects = {}
end
local function UpdateESP()
    ClearESP()
    if not ESPEnabled then return end
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local char = p.Character
            local head = char:FindFirstChild("Head")
            local hrp  = char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            if ESPNames and head then
                local bb = Instance.new("BillboardGui")
                bb.Name="RivalsESP_N"; bb.Adornee=head
                bb.Size=UDim2.new(0,120,0,30); bb.StudsOffset=Vector3.new(0,3,0)
                bb.AlwaysOnTop=true; bb.Parent=head
                local nl = Instance.new("TextLabel",bb)
                nl.BackgroundTransparency=1; nl.Size=UDim2.new(1,0,1,0)
                nl.Text=p.Name; nl.Font=Enum.Font.GothamBold; nl.TextSize=14
                nl.TextColor3=Color3.new(0,1,1); nl.TextStrokeTransparency=0
                table.insert(ESPObjects,bb)
            end
            if ESPBoxes then
                local bb2 = Instance.new("BillboardGui")
                bb2.Name="RivalsESP_B"; bb2.Adornee=hrp
                bb2.Size=UDim2.new(0,50,0,70)
                bb2.AlwaysOnTop=true; bb2.Parent=hrp
                local box = Instance.new("Frame",bb2)
                box.Size=UDim2.new(1,0,1,0); box.BackgroundTransparency=1
                stroke(box, Color3.new(1,1,0), 2, 0)
                table.insert(ESPObjects,bb2)
            end
        end
    end
end
task.spawn(function()
    while true do task.wait(5) if ESPEnabled then UpdateESP() end end
end)

-- ============================================================
--  ESP ROSA (Drawing API - Azucar Hub)
-- ============================================================
local ESPRosaEnabled = false
local function CreateESPRosa(plr)
    local tag = Drawing.new("Text")
    tag.Visible=false; tag.Center=true; tag.Outline=true
    tag.Font=2; tag.Size=14
    tag.Color=Color3.fromRGB(255,20,147)
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if ESPRosaEnabled and plr and plr.Parent and plr.Character
        and plr.Character:FindFirstChild("HumanoidRootPart") and plr~=LP then
            local hrp=plr.Character.HumanoidRootPart
            local myHRP=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if not myHRP then tag.Visible=false; return end
            local pos,onScreen=workspace.CurrentCamera:WorldToViewportPoint(hrp.Position+Vector3.new(0,3,0))
            if onScreen then
                local dist=(myHRP.Position-hrp.Position).Magnitude
                tag.Position=Vector2.new(pos.X,pos.Y)
                tag.Text=plr.Name.." ["..math.floor(dist).."m]"
                tag.Visible=true
            else tag.Visible=false end
        else
            tag.Visible=false
            if not plr or not plr.Parent then tag:Remove(); conn:Disconnect() end
        end
    end)
end
for _,v in pairs(Players:GetPlayers()) do CreateESPRosa(v) end
Players.PlayerAdded:Connect(CreateESPRosa)

-- ============================================================
--  LOOP DE FONDO (Azucar Hub - trackers, orbit, kill flash)
-- ============================================================
task.spawn(function()
    while true do
        task.wait(0.01)
        pcall(function()
            local char = LP.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local target = SelectedPlayers[1]

            if TweenTracking and target and target.Character
            and target.Character:FindFirstChild("HumanoidRootPart") then
                local tPos = target.Character.HumanoidRootPart.Position + Vector3.new(0,TrackerHeight,0)
                local dist = (root.Position-tPos).Magnitude
                TweenService:Create(root, TweenInfo.new(dist/TweenSpeed.X,Enum.EasingStyle.Linear), {CFrame=CFrame.new(tPos)}):Play()

            elseif AntiPerrasActive and target and target.Character
            and target.Character:FindFirstChild("HumanoidRootPart") then
                OrbitRot = OrbitRot + 0.15
                root.CFrame = target.Character.HumanoidRootPart.CFrame
                    * CFrame.Angles(0,OrbitRot,0)
                    * CFrame.new(OrbitDistance,2,0)

            elseif KillFlashActive and #SelectedPlayers>0 then
                for _,t in pairs(SelectedPlayers) do
                    if t.Character and t.Character:FindFirstChild("Humanoid")
                    and t.Character.Humanoid.Health>0 then
                        root.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,TrackerHeight,0)
                        task.wait(0.15)
                        root.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
                        task.wait(AzucarStayTime)
                    end
                end

            elseif TrackingActive and target and target.Character
            and target.Character:FindFirstChild("HumanoidRootPart") then
                root.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,TrackerHeight,0)
            end

            if FullBright then
                game.Lighting.Ambient = Color3.fromRGB(255,255,255)
                game.Lighting.ClockTime = 14
                game.Lighting.FogEnd = 9e9
            end
        end)
    end
end)

-- ============================================================
--  [11] TECLAS  U = Fast Attack  |  B = Fly Up
-- ============================================================
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.U then
        FastAttackEnabled = not FastAttackEnabled
        if FastAttackEnabled then StartFastAttack()
        else if FastAttackConn then task.cancel(FastAttackConn) end end
    end
    if input.KeyCode == Enum.KeyCode.B then
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local flag = hrp:FindFirstChild("UpLoop")
            if flag then flag:Destroy() else
                flag = Instance.new("BoolValue",hrp); flag.Name="UpLoop"
                task.spawn(function()
                    while flag.Parent do
                        hrp.CFrame = hrp.CFrame * CFrame.new(0,273861,0)
                        task.wait(0.05)
                    end
                end)
            end
        end
    end
end)

-- ============================================================
--  [12] ROOT GUI
-- ============================================================
local pgui = LP:WaitForChild("PlayerGui")
if pgui:FindFirstChild("RivalsPanel") then pgui.RivalsPanel:Destroy() end
local ScreenGui = Instance.new("ScreenGui",pgui)
ScreenGui.Name="RivalsPanel"; ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local S = SIZES[currentSizeIdx]
local W, H = S.w, S.h
local HDR_H  = 54
local CHIP_H = 46
local SB_H   = 30
local SIDE_W = 120
local BODY_Y = HDR_H + CHIP_H + 10
local BODY_H = H - BODY_Y - SB_H

-- ============================================================
--  MAIN FRAME
-- ============================================================
local Main = Instance.new("Frame",ScreenGui)
Main.Name="Main"; Main.Size=UDim2.new(0,W,0,H)
Main.Position=UDim2.new(0.5,-W/2,0.3,0)
Main.BackgroundColor3=C.bg; Main.Active=true; Main.Draggable=true
Main.ClipsDescendants=true; corner(Main,10); stroke(Main,C.gold,1,0.5)

-- Reopen button (shown when minimized)
local ReopenBtn = Instance.new("TextButton",ScreenGui)
ReopenBtn.Size=UDim2.new(0,140,0,34); ReopenBtn.Position=UDim2.new(0.5,-70,0.3,0)
ReopenBtn.BackgroundColor3=C.surface; ReopenBtn.Text="▲  RIVALS PANEL"
ReopenBtn.TextColor3=C.goldLight; ReopenBtn.Font=Enum.Font.GothamBold
ReopenBtn.TextSize=11; ReopenBtn.BorderSizePixel=0; ReopenBtn.Visible=false
corner(ReopenBtn,8); stroke(ReopenBtn,C.gold,1,0.3)

-- ============================================================
--  HEADER
-- ============================================================
local Hdr = Instance.new("Frame",Main)
Hdr.Size=UDim2.new(1,0,0,HDR_H); Hdr.BackgroundColor3=C.surface
Hdr.BorderSizePixel=0; corner(Hdr,10)
local HFill = Instance.new("Frame",Hdr)
HFill.Size=UDim2.new(1,0,0,12); HFill.Position=UDim2.new(0,0,1,-12)
HFill.BackgroundColor3=C.surface; HFill.BorderSizePixel=0
local HDLine = Instance.new("Frame",Hdr)
HDLine.Size=UDim2.new(1,0,0,1); HDLine.Position=UDim2.new(0,0,1,-1)
HDLine.BackgroundColor3=C.gold; HDLine.BorderSizePixel=0; goldGrad(HDLine)

mkLbl(Hdr,"RIVALS PANEL",17,C.goldLight,true,Enum.TextXAlignment.Left,14,7,200,26)
mkLbl(Hdr,"by iSacredRivals",10,C.textDim,false,Enum.TextXAlignment.Left,14,35,160,16)

local ProF = Instance.new("Frame",Hdr)
ProF.Size=UDim2.new(0,36,0,20); ProF.Position=UDim2.new(0,193,0,10)
ProF.BackgroundColor3=C.goldDark; corner(ProF,5)
mkLbl(ProF,"PRO",10,C.goldLight,true,Enum.TextXAlignment.Center,0,0,36,20)

local function winBtn(txt,bg2,xOff)
    local b = Instance.new("TextButton",Hdr)
    b.Size=UDim2.new(0,24,0,24); b.Position=UDim2.new(1,xOff,0,15)
    b.BackgroundColor3=bg2; b.Text=txt; b.TextColor3=C.white
    b.Font=Enum.Font.GothamBold; b.TextSize=12; b.BorderSizePixel=0; corner(b,12)
    return b
end
local CloseBtn = winBtn("✕",C.red,-30)
local MinBtn   = winBtn("–",C.surface2,-58)

-- ============================================================
--  CHIPS
-- ============================================================
local CHIP_Y = HDR_H+4
local function makeChip(icon,top,bot,xPos)
    local f = Instance.new("Frame",Main)
    f.Size=UDim2.new(0,(W-28)/2,0,CHIP_H); f.Position=UDim2.new(0,xPos,0,CHIP_Y)
    f.BackgroundColor3=C.surface; f.BorderSizePixel=0; corner(f,8); stroke(f,C.gold,1,0.62)
    mkLbl(f,icon,20,C.gold,false,Enum.TextXAlignment.Left,8,0,34,CHIP_H)
    mkLbl(f,top,9,C.textDim,false,Enum.TextXAlignment.Left,44,6,160,14)
    mkLbl(f,bot,14,C.goldLight,true,Enum.TextXAlignment.Left,44,21,160,20)
end
makeChip("🎮","JUEGO","Blox Fruits",12)
makeChip("⚡","EJECUTOR","Delta",12+(W-28)/2+4)

local GLine = Instance.new("Frame",Main)
GLine.Size=UDim2.new(1,-20,0,1); GLine.Position=UDim2.new(0,10,0,CHIP_Y+CHIP_H+2)
GLine.BackgroundColor3=C.gold; GLine.BorderSizePixel=0; goldGrad(GLine)

-- ============================================================
--  SIDEBAR + CONTENT
-- ============================================================
local Sidebar = Instance.new("ScrollingFrame",Main)
Sidebar.Size=UDim2.new(0,SIDE_W,1,-BODY_Y-SB_H); Sidebar.Position=UDim2.new(0,0,0,BODY_Y)
Sidebar.BackgroundColor3=C.surface; Sidebar.BorderSizePixel=0
Sidebar.ScrollBarThickness=2; Sidebar.ScrollBarImageColor3=C.goldDark
Sidebar.CanvasSize=UDim2.new(0,0,0,0); Sidebar.AutomaticCanvasSize=Enum.AutomaticSize.Y

local SBLine = Instance.new("Frame",Main)
SBLine.Size=UDim2.new(0,1,1,-BODY_Y-SB_H); SBLine.Position=UDim2.new(0,SIDE_W,0,BODY_Y)
SBLine.BackgroundColor3=C.goldDark; SBLine.BorderSizePixel=0

local ContentBG = Instance.new("Frame",Main)
ContentBG.Size=UDim2.new(1,-SIDE_W-1,1,-BODY_Y-SB_H)
ContentBG.Position=UDim2.new(0,SIDE_W+1,0,BODY_Y)
ContentBG.BackgroundColor3=C.bg; ContentBG.BorderSizePixel=0
ContentBG.ClipsDescendants=true

-- ============================================================
--  PAGE SYSTEM
-- ============================================================
local pages      = {}
local currentPage = nil
local sideBtnRefs = {}

local function newPage(id)
    local sf = Instance.new("ScrollingFrame",ContentBG)
    sf.Name=id; sf.Size=UDim2.new(1,0,1,0); sf.BackgroundTransparency=1
    sf.ScrollBarThickness=3; sf.ScrollBarImageColor3=C.gold
    sf.CanvasSize=UDim2.new(0,0,0,0); sf.AutomaticCanvasSize=Enum.AutomaticSize.Y
    sf.Visible=false; sf.BorderSizePixel=0
    local ul = Instance.new("UIListLayout",sf)
    ul.Padding=UDim.new(0,6); ul.HorizontalAlignment=Enum.HorizontalAlignment.Center
    ul.SortOrder=Enum.SortOrder.LayoutOrder
    local up = Instance.new("UIPadding",sf)
    up.PaddingTop=UDim.new(0,10); up.PaddingBottom=UDim.new(0,10)
    up.PaddingLeft=UDim.new(0,8); up.PaddingRight=UDim.new(0,8)
    pages[id]=sf; return sf
end

local function showPage(id)
    for pid,pg in pairs(pages) do pg.Visible=(pid==id) end
    currentPage=id
    for _,r in pairs(sideBtnRefs) do
        local act=(r.page==id)
        r.bar.BackgroundColor3 = act and C.gold or C.surface
        r.lbl.TextColor3       = act and C.goldLight or C.textDim
        r.frame.BackgroundColor3 = act and C.surface2 or C.surface
    end
end

-- ============================================================
--  COMPONENT BUILDERS
-- ============================================================
local function secLabel(text,parent,lo)
    local wrap = Instance.new("Frame",parent)
    wrap.Size=UDim2.new(1,0,0,22); wrap.BackgroundTransparency=1; wrap.LayoutOrder=lo
    local l = Instance.new("TextLabel",wrap)
    l.Size=UDim2.new(0,0,1,0); l.AutomaticSize=Enum.AutomaticSize.X
    l.BackgroundTransparency=1; l.Text=text; l.Font=Enum.Font.GothamBold
    l.TextSize=9; l.TextColor3=C.textDim; l.TextXAlignment=Enum.TextXAlignment.Left
    local line = Instance.new("Frame",wrap)
    line.Size=UDim2.new(1,-85,0,1); line.Position=UDim2.new(0,81,0.5,0)
    line.BackgroundColor3=C.goldDark; line.BorderSizePixel=0
end

local function makeToggle(icon,name,desc,parent,lo,callback)
    local row = Instance.new("TextButton",parent)
    row.Size=UDim2.new(1,0,0,56); row.BackgroundColor3=C.surface
    row.Text=""; row.AutoButtonColor=false; row.BorderSizePixel=0; row.LayoutOrder=lo
    corner(row,8); stroke(row,C.goldDark,1,0.5)
    mkLbl(row,icon,20,C.gold,false,Enum.TextXAlignment.Left,10,0,32,56)
    local nameLbl=mkLbl(row,name,13,C.text,true,Enum.TextXAlignment.Left,46,9,W-SIDE_W-100,20)
    mkLbl(row,desc,10,C.textDim,false,Enum.TextXAlignment.Left,46,30,W-SIDE_W-100,16)
    local swBg = Instance.new("Frame",row)
    swBg.Size=UDim2.new(0,40,0,22); swBg.Position=UDim2.new(1,-50,0.5,-11)
    swBg.BackgroundColor3=Color3.fromRGB(38,30,12); swBg.BorderSizePixel=0
    corner(swBg,11); stroke(swBg,C.goldDark,1,0.4)
    local knob = Instance.new("Frame",swBg)
    knob.Size=UDim2.new(0,16,0,16); knob.Position=UDim2.new(0,2,0.5,-8)
    knob.BackgroundColor3=C.textDim; knob.BorderSizePixel=0; corner(knob,8)
    local isOn = false
    local function setState(on)
        isOn=on
        if on then
            tw(knob,{Position=UDim2.new(0,22,0.5,-8),BackgroundColor3=C.gold},0.2)
            tw(swBg,{BackgroundColor3=Color3.fromRGB(55,42,12)},0.2)
            tw(row, {BackgroundColor3=Color3.fromRGB(35,28,10)},0.2)
            nameLbl.TextColor3=C.goldLight
            local rs=row:FindFirstChildOfClass("UIStroke"); if rs then rs.Color=C.gold; rs.Transparency=0.2 end
            local ss=swBg:FindFirstChildOfClass("UIStroke"); if ss then ss.Color=C.gold; ss.Transparency=0.2 end
        else
            tw(knob,{Position=UDim2.new(0,2,0.5,-8),BackgroundColor3=C.textDim},0.2)
            tw(swBg,{BackgroundColor3=Color3.fromRGB(38,30,12)},0.2)
            tw(row, {BackgroundColor3=C.surface},0.2)
            nameLbl.TextColor3=C.text
            local rs=row:FindFirstChildOfClass("UIStroke"); if rs then rs.Color=C.goldDark; rs.Transparency=0.5 end
            local ss=swBg:FindFirstChildOfClass("UIStroke"); if ss then ss.Color=C.goldDark; ss.Transparency=0.4 end
        end
        if callback then callback(on) end
    end
    row.MouseButton1Click:Connect(function() setState(not isOn) end)
    return row, setState
end

local function makeBtn(icon,name,desc,parent,lo,callback)
    local btn = Instance.new("TextButton",parent)
    btn.Size=UDim2.new(1,0,0,52); btn.BackgroundColor3=C.surface
    btn.Text=""; btn.AutoButtonColor=false; btn.BorderSizePixel=0; btn.LayoutOrder=lo
    corner(btn,8); stroke(btn,C.goldDark,1,0.5)
    mkLbl(btn,icon,20,C.gold,false,Enum.TextXAlignment.Left,10,0,32,52)
    local nameLbl=mkLbl(btn,name,13,C.text,true,Enum.TextXAlignment.Left,46,8,W-SIDE_W-80,20)
    mkLbl(btn,desc,10,C.textDim,false,Enum.TextXAlignment.Left,46,28,W-SIDE_W-80,16)
    mkLbl(btn,"▶",14,C.textDim,true,Enum.TextXAlignment.Right,0,0,W-SIDE_W-12,52)
    btn.MouseEnter:Connect(function()
        tw(btn,{BackgroundColor3=Color3.fromRGB(35,28,10)},0.15); nameLbl.TextColor3=C.goldLight
        local s=btn:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.gold; s.Transparency=0.2 end
    end)
    btn.MouseLeave:Connect(function()
        tw(btn,{BackgroundColor3=C.surface},0.15); nameLbl.TextColor3=C.text
        local s=btn:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.goldDark; s.Transparency=0.5 end
    end)
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return btn
end

local function makeTpBtn(icon,name,coords,parent,lo,cb)
    local btn = Instance.new("TextButton",parent)
    btn.Size=UDim2.new(1,0,0,52); btn.BackgroundColor3=C.surface
    btn.Text=""; btn.AutoButtonColor=false; btn.BorderSizePixel=0; btn.LayoutOrder=lo
    corner(btn,8); stroke(btn,C.goldDark,1,0.5)
    mkLbl(btn,icon,20,C.gold,false,Enum.TextXAlignment.Left,10,0,32,52)
    local nameLbl=mkLbl(btn,name,13,C.text,true,Enum.TextXAlignment.Left,46,8,W-SIDE_W-80,20)
    mkLbl(btn,coords,10,C.textDim,false,Enum.TextXAlignment.Left,46,29,W-SIDE_W-80,16)
    mkLbl(btn,"›",20,C.textDim,true,Enum.TextXAlignment.Right,0,0,W-SIDE_W-12,52)
    btn.MouseEnter:Connect(function()
        tw(btn,{BackgroundColor3=Color3.fromRGB(35,28,10)},0.15); nameLbl.TextColor3=C.goldLight
        local s=btn:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.gold; s.Transparency=0.2 end
    end)
    btn.MouseLeave:Connect(function()
        tw(btn,{BackgroundColor3=C.surface},0.15); nameLbl.TextColor3=C.text
        local s=btn:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.goldDark; s.Transparency=0.5 end
    end)
    btn.MouseButton1Click:Connect(function() if cb then cb() end end)
    return btn
end

local function makeSlider(name,minV,maxV,startV,parent,lo,callback)
    local card = Instance.new("Frame",parent)
    card.Size=UDim2.new(1,0,0,62); card.BackgroundColor3=C.surface
    card.BorderSizePixel=0; card.LayoutOrder=lo; corner(card,8); stroke(card,C.goldDark,1,0.5)
    mkLbl(card,name,12,C.text,true,Enum.TextXAlignment.Left,12,6,W-SIDE_W-90,16)
    local valLbl=mkLbl(card,tostring(startV),12,C.gold,true,Enum.TextXAlignment.Right,0,6,W-SIDE_W-16,16)

    -- minus button
    local minusBtn=Instance.new("TextButton",card)
    minusBtn.Size=UDim2.new(0,28,0,28); minusBtn.Position=UDim2.new(0,10,0,28)
    minusBtn.BackgroundColor3=C.surface2; minusBtn.Text="−"
    minusBtn.TextColor3=C.goldLight; minusBtn.Font=Enum.Font.GothamBold
    minusBtn.TextSize=16; minusBtn.BorderSizePixel=0; corner(minusBtn,6)

    -- plus button
    local plusBtn=Instance.new("TextButton",card)
    plusBtn.Size=UDim2.new(0,28,0,28); plusBtn.Position=UDim2.new(1,-38,0,28)
    plusBtn.BackgroundColor3=C.surface2; plusBtn.Text="+"
    plusBtn.TextColor3=C.goldLight; plusBtn.Font=Enum.Font.GothamBold
    plusBtn.TextSize=16; plusBtn.BorderSizePixel=0; corner(plusBtn,6)

    -- track
    local trackBg=Instance.new("Frame",card)
    trackBg.Size=UDim2.new(1,-86,0,4); trackBg.Position=UDim2.new(0,44,0,42)
    trackBg.BackgroundColor3=Color3.fromRGB(40,32,12); trackBg.BorderSizePixel=0; corner(trackBg,2)

    local fill=Instance.new("Frame",trackBg)
    local initPct = (startV-minV)/(maxV-minV)
    fill.Size=UDim2.new(initPct,0,1,0)
    fill.BackgroundColor3=C.gold; fill.BorderSizePixel=0; corner(fill,2)

    local val=startV
    local step=math.max(1,math.floor((maxV-minV)/20))

    local function updateVal(newVal)
        val=math.clamp(newVal,minV,maxV)
        valLbl.Text=tostring(val)
        local pct=(val-minV)/(maxV-minV)
        fill.Size=UDim2.new(pct,0,1,0)
        if callback then callback(val) end
    end

    minusBtn.MouseButton1Click:Connect(function() updateVal(val-step) end)
    plusBtn.MouseButton1Click:Connect(function()  updateVal(val+step) end)

    -- touch drag on track
    local dragging=false
    trackBg.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or
           i.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or
           i.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType==Enum.UserInputType.Touch or
           i.UserInputType==Enum.UserInputType.MouseMovement then
            local tAbs=trackBg.AbsolutePosition; local tSz=trackBg.AbsoluteSize
            local pct=math.clamp((i.Position.X-tAbs.X)/tSz.X,0,1)
            updateVal(math.floor(minV+(maxV-minV)*pct))
        end
    end)
    return card
end

local function makeDropdown(labelTxt,parent,lo,onSelect)
    local CW = W-SIDE_W-16
    local card = Instance.new("Frame",parent)
    card.Size=UDim2.new(1,0,0,44); card.BackgroundColor3=C.surface
    card.BorderSizePixel=0; card.LayoutOrder=lo; card.ClipsDescendants=false
    corner(card,8); stroke(card,C.goldDark,1,0.5)
    mkLbl(card,labelTxt,11,C.textDim,false,Enum.TextXAlignment.Left,12,0,CW-60,44)
    local selLbl=mkLbl(card,"None",12,C.gold,true,Enum.TextXAlignment.Right,0,0,CW-8,44)
    local arrow =mkLbl(card,"▾",14,C.textDim,true,Enum.TextXAlignment.Right,0,0,CW-8,44)
    local listFrame = Instance.new("Frame",ContentBG)
    listFrame.BackgroundColor3=C.surface2; listFrame.BorderSizePixel=0
    listFrame.Visible=false; listFrame.ZIndex=20; corner(listFrame,6); stroke(listFrame,C.gold,1,0.4)
    local lLayout = Instance.new("UIListLayout",listFrame)
    lLayout.Padding=UDim.new(0,1); lLayout.SortOrder=Enum.SortOrder.LayoutOrder
    local expanded=false
    local function buildList()
        for _,c in pairs(listFrame:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        local opts={"None"}
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP then table.insert(opts,p.Name) end
        end
        for i,opt in ipairs(opts) do
            local item = Instance.new("TextButton",listFrame)
            item.Size=UDim2.new(1,0,0,30); item.BackgroundColor3=C.surface
            item.Text=opt; item.TextColor3=C.text; item.Font=Enum.Font.GothamBold
            item.TextSize=11; item.BorderSizePixel=0; item.ZIndex=21; item.LayoutOrder=i
            item.MouseButton1Click:Connect(function()
                selLbl.Text=opt; expanded=false; listFrame.Visible=false; arrow.Text="▾"
                if onSelect then onSelect(opt~="None" and opt or nil) end
            end)
            item.MouseEnter:Connect(function() item.BackgroundColor3=C.surface2 end)
            item.MouseLeave:Connect(function() item.BackgroundColor3=C.surface end)
        end
        listFrame.Size=UDim2.new(0,CW-16,0,math.min(#opts,6)*31)
    end
    local hBtn = Instance.new("TextButton",card)
    hBtn.Size=UDim2.new(1,0,1,0); hBtn.BackgroundTransparency=1
    hBtn.Text=""; hBtn.BorderSizePixel=0; hBtn.ZIndex=10
    hBtn.MouseButton1Click:Connect(function()
        expanded=not expanded
        if expanded then
            buildList()
            local abs  = card.AbsolutePosition
            local cbAb = ContentBG.AbsolutePosition
            listFrame.Position=UDim2.new(0,abs.X-cbAb.X+8,0,abs.Y-cbAb.Y+44)
            listFrame.Visible=true; arrow.Text="▴"
        else
            listFrame.Visible=false; arrow.Text="▾"
        end
    end)
    return card, buildList
end

-- ============================================================
--  PAGES
-- ============================================================

-- ── HOME ────────────────────────────────────────────────────
local pgHome = newPage("home")

local logoCard = Instance.new("Frame",pgHome)
logoCard.Size=UDim2.new(1,0,0,90); logoCard.BackgroundColor3=C.surface
logoCard.BorderSizePixel=0; logoCard.LayoutOrder=1; corner(logoCard,8); stroke(logoCard,C.gold,1,0.55)
local ring = Instance.new("Frame",logoCard)
ring.Size=UDim2.new(0,60,0,60); ring.Position=UDim2.new(0,14,0.5,-30)
ring.BackgroundColor3=Color3.fromRGB(28,22,8); ring.BorderSizePixel=0; corner(ring,30); stroke(ring,C.gold,2,0.2)
mkLbl(ring,"⚔️",26,C.gold,false,Enum.TextXAlignment.Center,0,0,60,60)
mkLbl(logoCard,"RIVALS PANEL",17,C.goldLight,true,Enum.TextXAlignment.Left,88,10,220,24)
mkLbl(logoCard,"by iSacredRivals",10,C.textDim,false,Enum.TextXAlignment.Left,88,34,180,16)
mkLbl(logoCard,"[U] Fast Attack  ·  [B] Fly Up",10,C.gold,false,Enum.TextXAlignment.Left,88,52,220,16)

secLabel("TAMAÑO DE UI",pgHome,2)
local sizeWrap = Instance.new("Frame",pgHome)
sizeWrap.Size=UDim2.new(1,0,0,44); sizeWrap.BackgroundColor3=C.surface
sizeWrap.BorderSizePixel=0; sizeWrap.LayoutOrder=3; corner(sizeWrap,8); stroke(sizeWrap,C.goldDark,1,0.5)
local szLay = Instance.new("UIListLayout",sizeWrap)
szLay.FillDirection=Enum.FillDirection.Horizontal; szLay.Padding=UDim.new(0,4)
szLay.HorizontalAlignment=Enum.HorizontalAlignment.Center; szLay.VerticalAlignment=Enum.VerticalAlignment.Center
local szPad = Instance.new("UIPadding",sizeWrap)
szPad.PaddingLeft=UDim.new(0,6); szPad.PaddingRight=UDim.new(0,6)
local sizeBtns = {}

local function applySize(idx)
    currentSizeIdx=idx
    local ns=SIZES[idx]
    W=ns.w; H=ns.h
    tw(Main,{Size=UDim2.new(0,ns.w,0,ns.h)},0.3)
    for i,sb in pairs(sizeBtns) do
        sb.BackgroundColor3 = i==idx and C.goldDark or C.surface2
        sb.TextColor3       = i==idx and C.goldLight or C.textDim
    end
end

for i,sz in ipairs(SIZES) do
    local sb = Instance.new("TextButton",sizeWrap)
    -- use scale width so they always fill the container equally
    sb.Size=UDim2.new(0.24,-5,0,32)
    sb.BackgroundColor3=i==currentSizeIdx and C.goldDark or C.surface2
    sb.TextColor3=i==currentSizeIdx and C.goldLight or C.textDim
    sb.Text=sz.name; sb.Font=Enum.Font.GothamBold; sb.TextSize=11
    sb.BorderSizePixel=0; corner(sb,6)
    sb.MouseButton1Click:Connect(function() applySize(i) end)
    table.insert(sizeBtns,sb)
end

-- ── COMBATE ─────────────────────────────────────────────────
local pgC = newPage("combat")

secLabel("FAST ATTACK",pgC,1)
makeToggle("⚡","Fast Attack  [U]","Rango "..FastAttackRange.." studs · Tecla U",pgC,2,function(on)
    FastAttackEnabled=on
    if on then StartFastAttack() else if FastAttackConn then task.cancel(FastAttackConn) end end
end)
makeSlider("Fast Attack Range",0,12000,12000,pgC,3,function(v) FastAttackRange=v end)

secLabel("HITBOX",pgC,4)
makeToggle("📦","Hitbox Visible","Expande hitboxes a 30×30×30",pgC,5,function(on)
    getgenv().HitboxExpander=on
end)

secLabel("EXPLOITS",pgC,6)
makeToggle("🦘","Infinite Jump","Salta sin límite en el aire",pgC,7,function(on)
    InfJumpEnabled=on
end)
makeToggle("👻","No Clip","Atraviesa paredes",pgC,8,function(on)
    NoClipEnabled=on
end)
makeToggle("🌊","Walk on Water","Camina sobre el agua",pgC,9,function(on)
    WalkWater=on
end)

secLabel("GOD MODE 🛡️",pgC,10)
local GodModeEnabled = false
local GodModeConns = {}
makeToggle("🛡️","God Mode","Mantiene tu vida al máximo constantemente",pgC,11,function(on)
    GodModeEnabled = on
    for _,c in pairs(GodModeConns) do pcall(function() c:Disconnect() end) end
    GodModeConns = {}
    if on then
        table.insert(GodModeConns, RunService.Stepped:Connect(function()
            pcall(function()
                local char = LP.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                hum.Health = hum.MaxHealth
                if hum:GetState() == Enum.HumanoidStateType.Dead then
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
                char:SetAttribute("UnbreakableAll", true)
            end)
        end))
        table.insert(GodModeConns, RunService.RenderStepped:Connect(function()
            pcall(function()
                local char = LP.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end)
        end))
        table.insert(GodModeConns, LP.CharacterAdded:Connect(function(newChar)
            if not GodModeEnabled then return end
            task.wait(0.1)
            local hum = newChar:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = hum.MaxHealth end
            newChar:SetAttribute("UnbreakableAll", true)
        end))
    end
end)

secLabel("SHOTHO",pgC,12)
local shothoEnabled = false
local shothoLoopRunning = false

-- Botón flotante
local shothoGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
shothoGui.Name = "ShothoFloat"
shothoGui.ResetOnSpawn = false
shothoGui.DisplayOrder = 10
shothoGui.Enabled = false  -- oculto por defecto

local shothoBtn = Instance.new("TextButton", shothoGui)
shothoBtn.Size = UDim2.new(0,130,0,44)
shothoBtn.Position = UDim2.new(0.05,0,0.7,0)
shothoBtn.BackgroundColor3 = C.surface
shothoBtn.Text = "💀 SHOTHO OFF"
shothoBtn.TextColor3 = C.textDim
shothoBtn.Font = Enum.Font.GothamBold
shothoBtn.TextSize = 12
shothoBtn.BorderSizePixel = 0
shothoBtn.Active = true
corner(shothoBtn, 8)
stroke(shothoBtn, C.gold, 1, 0.4)

-- Drag
local sthoDragging = false
local sthoDragStart, sthoStartPos
shothoBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or
       input.UserInputType == Enum.UserInputType.MouseButton1 then
        sthoDragging = true
        sthoDragStart = input.Position
        sthoStartPos = shothoBtn.Position
    end
end)
shothoBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or
       input.UserInputType == Enum.UserInputType.MouseButton1 then
        sthoDragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if sthoDragging and (input.UserInputType == Enum.UserInputType.Touch or
                         input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - sthoDragStart
        shothoBtn.Position = UDim2.new(
            sthoStartPos.X.Scale, sthoStartPos.X.Offset + delta.X,
            sthoStartPos.Y.Scale, sthoStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Función para actualizar visual del botón flotante
local function updateShothoBtn()
    if shothoEnabled then
        shothoBtn.Text = "💀 SHOTHO ON"
        shothoBtn.TextColor3 = C.goldLight
        tw(shothoBtn, {BackgroundColor3 = Color3.fromRGB(35,28,10)}, 0.2)
        local s = shothoBtn:FindFirstChildOfClass("UIStroke")
        if s then s.Color=C.gold; s.Transparency=0 end
    else
        shothoBtn.Text = "💀 SHOTHO OFF"
        shothoBtn.TextColor3 = C.textDim
        tw(shothoBtn, {BackgroundColor3 = C.surface}, 0.2)
        local s = shothoBtn:FindFirstChildOfClass("UIStroke")
        if s then s.Color=C.gold; s.Transparency=0.4 end
    end
end

-- Loop del shotho
local function runShothoLoop()
    if shothoLoopRunning then return end
    shothoLoopRunning = true
    task.spawn(function()
        while shothoEnabled do
            local char = LP.Character
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos = hrp.Position
                hrp.CFrame = CFrame.new(pos.X, pos.Y - 795679695796326795679695796326, pos.Z)
            end
            task.wait(0.01)
        end
        shothoLoopRunning = false
    end)
end

-- Botón flotante: activa/desactiva el shotho
shothoBtn.MouseButton1Click:Connect(function()
    shothoEnabled = not shothoEnabled
    updateShothoBtn()
    if shothoEnabled then runShothoLoop() end
end)

-- Toggle en Combate: muestra/oculta el botón flotante
makeToggle("💀","Shotho","Muestra el botón flotante para activar/desactivar",pgC,11,function(on)
    shothoGui.Enabled = on
    if not on then
        shothoEnabled = false
        updateShothoBtn()
    end
end)

-- ── TP & PLAYERS ────────────────────────────────────────────
local pgTP = newPage("tp")

secLabel("JUGADOR OBJETIVO",pgTP,1)
local _,ddRefresh = makeDropdown("Seleccionar jugador",pgTP,2,function(name)
    SelectedPlayer=name
end)
makeBtn("🔄","Refrescar lista","Actualiza los jugadores disponibles",pgTP,3,function()
    ddRefresh()
end)

secLabel("MOVIMIENTO",pgTP,5)
makeToggle("🌀","Tween to Player","Se mueve suavemente hacia el objetivo",pgTP,6,function(on)
    TeleportEnabled=on
    if on then
        TeleportConn=RunService.Heartbeat:Connect(function()
            if SelectedPlayer then
                local t=Players:FindFirstChild(SelectedPlayer)
                if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
                    TweenToPlayer(t.Character.HumanoidRootPart); SetNoCollide()
                end
            end
        end)
    else
        if TeleportConn then TeleportConn:Disconnect() end
        if ActiveTween then ActiveTween:Cancel() end
        SetCollide()
    end
end)
makeToggle("⚡","Insta TP","Teleporta instantáneamente al objetivo",pgTP,7,function(on)
    InstaTpEnabled=on
    if on then
        InstaTpConn=RunService.Stepped:Connect(function()
            if SelectedPlayer then pcall(function()
                local t=Players:FindFirstChild(SelectedPlayer)
                if t and t.Character then
                    LP.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,YOffset,0)
                    LP.Character.HumanoidRootPart.Velocity=Vector3.new(0,0,0)
                end
            end) end
        end)
    else
        if InstaTpConn then InstaTpConn:Disconnect() end
    end
end)
makeToggle("👁️","Spectate Player","Cambia la cámara al objetivo",pgTP,8,function(on)
    SpectateEnabled=on
    if on then
        SpectateConn=RunService.RenderStepped:Connect(function()
            if SelectedPlayer then
                local t=Players:FindFirstChild(SelectedPlayer)
                if t and t.Character then
                    workspace.CurrentCamera.CameraSubject=t.Character.Humanoid
                end
            end
        end)
    else
        if SpectateConn then SpectateConn:Disconnect() end
        if LP.Character then workspace.CurrentCamera.CameraSubject=LP.Character.Humanoid end
    end
end)

secLabel("TRACKERS & KILL",pgTP,9)
makeToggle("🛰️","Tracker Aéreo","Se posiciona arriba del jugador objetivo",pgTP,10,function(on)
    TrackingActive=on
    if on and SelectedPlayer then
        local p=Players:FindFirstChild(SelectedPlayer)
        SelectedPlayers = p and {p} or {}
    end
end)
makeSlider("Altura Tracker",2,1000,300,pgTP,11,function(v) TrackerHeight=v end)

secLabel("FRUIT ATTACK",pgTP,13)
makeToggle("🦊","Fruit Attack — Kitsune","Auto-ataca al jugador más cercano",pgTP,14,function(on)
    FruitAttack=on
    if on then StartFruitAttack("Kitsune-Kitsune",true)
    else if FruitAttackConn then task.cancel(FruitAttackConn) end end
end)
makeToggle("🦖","Fruit Attack — T-Rex","Auto-ataca al jugador más cercano",pgTP,15,function(on)
    FruitAttack=on
    if on then StartFruitAttack("T-Rex-T-Rex",false)
    else if FruitAttackConn then task.cancel(FruitAttackConn) end end
end)

secLabel("AUTOMATIZACIÓN",pgTP,16)
local autoV4On = false
makeToggle("🔮","Auto V4 Awakening","Activa el despertar V4 automáticamente",pgTP,17,function(on)
    autoV4On = on
    if on then
        task.spawn(function()
            while autoV4On do
                task.wait(0.5)
                pcall(function()
                    local tool = LP.Backpack:FindFirstChild("Awakening") or LP.Character:FindFirstChild("Awakening")
                    if tool and tool:FindFirstChild("RemoteFunction") then
                        tool.RemoteFunction:InvokeServer(true)
                    end
                end)
            end
        end)
    end
end)

-- ── UBICACIONES ─────────────────────────────────────────────
local pgLoc = newPage("locations")

secLabel("SEA 3",pgLoc,1)
makeTpBtn("⚓","Tp Barco","CFrame: -6500, 129, -123",pgLoc,2,function()
    if LP.Character then LP.Character.HumanoidRootPart.CFrame=CFrame.new(-6500,129,-123) end
end)
makeTpBtn("🌀","Tp Rivals Vacío","CFrame: -11997, 332, -8837",pgLoc,3,function()
    if LP.Character then LP.Character.HumanoidRootPart.CFrame=CFrame.new(-11997,332,-8837) end
end)

secLabel("OTRAS FUNCIONES",pgLoc,4)
makeBtn("🛸","Rivals Fly","Activa el sistema de vuelo",pgLoc,5,function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- ── OTRAS FUNCIONES ──────────────────────────────────────────
local pgAz = newPage("azucar")

secLabel("MISC 🌀",pgAz,1)
makeToggle("☀️","Full Bright","Iluminación máxima en el mapa",pgAz,2,function(on)
    FullBright=on
    if not on then
        game.Lighting.Ambient=Color3.fromRGB(0,0,0)
        game.Lighting.ClockTime=14
        game.Lighting.FogEnd=100000
    end
end)
makeToggle("👻","Modo Invisible","Hace tu personaje invisible",pgAz,3,function(on)
    if LP.Character then
        for _,part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = on and 1 or 0
            end
        end
        -- mantener HRP semi-visible internamente pero invisible visualmente
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Transparency = 1 end
    end
end)
makeBtn("🚫","Anti-AFK","Evita ser expulsado por inactividad",pgAz,4,function()
    local vu=game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- ── ESP ──────────────────────────────────────────────────────
local pgESP = newPage("esp")

secLabel("VISIÓN",pgESP,1)
makeToggle("👁️","Enable ESP","Activa el sistema ESP",pgESP,2,function(on)
    ESPEnabled=on; UpdateESP()
end)
makeToggle("📛","Names ESP","Nombres sobre jugadores",pgESP,3,function(on)
    ESPNames=on; if ESPEnabled then UpdateESP() end
end)
makeToggle("📦","Boxes ESP","Cajas alrededor de jugadores",pgESP,4,function(on)
    ESPBoxes=on; if ESPEnabled then UpdateESP() end
end)
makeToggle("🌸","ESP Rosa","Muestra nombres con distancia en rosa",pgESP,5,function(on)
    ESPRosaEnabled=on
end)

-- ── CONFI ────────────────────────────────────────────────────
local pgConfi = newPage("confi")

secLabel("COLOR DE UI 🎨",pgConfi,1)

local colorOptions = {
    {name="Dorado",  gold=Color3.fromRGB(201,168,76),  goldLight=Color3.fromRGB(240,208,128), goldDark=Color3.fromRGB(80,58,18)},
    {name="Azul",    gold=Color3.fromRGB(70,140,255),  goldLight=Color3.fromRGB(140,190,255), goldDark=Color3.fromRGB(20,50,120)},
    {name="Verde",   gold=Color3.fromRGB(80,200,100),  goldLight=Color3.fromRGB(150,240,160), goldDark=Color3.fromRGB(20,80,30)},
    {name="Rojo",    gold=Color3.fromRGB(220,70,70),   goldLight=Color3.fromRGB(255,140,140), goldDark=Color3.fromRGB(100,20,20)},
    {name="Morado",  gold=Color3.fromRGB(160,80,220),  goldLight=Color3.fromRGB(210,150,255), goldDark=Color3.fromRGB(60,20,100)},
    {name="Cyan",    gold=Color3.fromRGB(0,210,210),   goldLight=Color3.fromRGB(100,255,255), goldDark=Color3.fromRGB(0,70,80)},
}

local previewCard = Instance.new("Frame",pgConfi)
previewCard.Size=UDim2.new(1,0,0,50); previewCard.BackgroundColor3=C.surface
previewCard.BorderSizePixel=0; previewCard.LayoutOrder=2; corner(previewCard,8); stroke(previewCard,C.gold,1,0.4)
local previewLbl = mkLbl(previewCard,"Color actual: Dorado",13,C.goldLight,true,Enum.TextXAlignment.Center,0,0,W-SIDE_W-16,50)

local colorBtns={}
local function applyColor(idx)
    local col=colorOptions[idx]
    C.gold=col.gold; C.goldLight=col.goldLight; C.goldDark=col.goldDark
    previewLbl.Text="Color actual: "..col.name
    previewLbl.TextColor3=col.goldLight
    previewCard:FindFirstChildOfClass("UIStroke").Color=col.gold
    for _,v in pairs(Main:GetDescendants()) do
        if v:IsA("UIStroke") then v.Color=col.gold end
        if v:IsA("Frame") and v.Name=="ActiveBar" then v.BackgroundColor3=col.gold end
    end
    local ms=Main:FindFirstChildOfClass("UIStroke"); if ms then ms.Color=col.gold end
    showPage(currentPage)
    for i,cb in pairs(colorBtns) do
        cb.BackgroundColor3 = i==idx and col.gold or C.surface2
        cb.TextColor3 = i==idx and Color3.new(0,0,0) or C.textDim
    end
end

local colorRow = Instance.new("Frame",pgConfi)
colorRow.Size=UDim2.new(1,0,0,44); colorRow.BackgroundColor3=C.surface
colorRow.BorderSizePixel=0; colorRow.LayoutOrder=3; corner(colorRow,8); stroke(colorRow,C.goldDark,1,0.5)
local crLay=Instance.new("UIListLayout",colorRow)
crLay.FillDirection=Enum.FillDirection.Horizontal; crLay.Padding=UDim.new(0,3)
crLay.HorizontalAlignment=Enum.HorizontalAlignment.Center; crLay.VerticalAlignment=Enum.VerticalAlignment.Center
local crPad=Instance.new("UIPadding",colorRow); crPad.PaddingLeft=UDim.new(0,5); crPad.PaddingRight=UDim.new(0,5)

for i,col in ipairs(colorOptions) do
    local cb=Instance.new("TextButton",colorRow)
    cb.Size=UDim2.new(0,(W-SIDE_W-46)/6,0,32)
    cb.BackgroundColor3=i==1 and col.gold or C.surface2
    cb.TextColor3=i==1 and Color3.new(0,0,0) or C.textDim
    cb.Text=col.name; cb.Font=Enum.Font.GothamBold; cb.TextSize=9
    cb.BorderSizePixel=0; corner(cb,6)
    cb.MouseButton1Click:Connect(function() applyColor(i) end)
    table.insert(colorBtns,cb)
end

-- ── PERFILES ─────────────────────────────────────────────────
local pgPerfiles = newPage("perfiles")

local profileSlot = 1

-- Slot selector card
secLabel("SLOT DE PERFIL",pgPerfiles,1)

local slotCard = Instance.new("Frame",pgPerfiles)
slotCard.Size=UDim2.new(1,0,0,52); slotCard.BackgroundColor3=C.surface
slotCard.BorderSizePixel=0; slotCard.LayoutOrder=2; corner(slotCard,8); stroke(slotCard,C.goldDark,1,0.5)

mkLbl(slotCard,"Slot activo:",12,C.textDim,false,Enum.TextXAlignment.Left,12,0,120,52)
local slotValLbl = mkLbl(slotCard,"1",18,C.gold,true,Enum.TextXAlignment.Center,0,0,W-SIDE_W-16,52)

local slotBtnRow = Instance.new("Frame",slotCard)
slotBtnRow.Size=UDim2.new(0,170,0,36); slotBtnRow.Position=UDim2.new(1,-178,0.5,-18)
slotBtnRow.BackgroundTransparency=1; slotBtnRow.BorderSizePixel=0

local slotLayout=Instance.new("UIListLayout",slotBtnRow)
slotLayout.FillDirection=Enum.FillDirection.Horizontal
slotLayout.Padding=UDim.new(0,4)
slotLayout.HorizontalAlignment=Enum.HorizontalAlignment.Right
slotLayout.VerticalAlignment=Enum.VerticalAlignment.Center

for s=1,6 do
    local sb=Instance.new("TextButton",slotBtnRow)
    sb.Size=UDim2.new(0,24,0,24)
    sb.BackgroundColor3=s==1 and C.gold or C.surface2
    sb.TextColor3=s==1 and Color3.new(0,0,0) or C.textDim
    sb.Text=tostring(s); sb.Font=Enum.Font.GothamBold; sb.TextSize=11
    sb.BorderSizePixel=0; corner(sb,5)
    sb.MouseButton1Click:Connect(function()
        profileSlot=s
        slotValLbl.Text=tostring(s)
        for _,child in pairs(slotBtnRow:GetChildren()) do
            if child:IsA("TextButton") then
                local isActive = (tonumber(child.Text)==s)
                child.BackgroundColor3 = isActive and C.gold or C.surface2
                child.TextColor3 = isActive and Color3.new(0,0,0) or C.textDim
            end
        end
    end)
end

secLabel("TÍTULOS",pgPerfiles,3)

local titles = {
    {name="Pirate King",         code=786, icon="👑"},
    {name="Pink Portal",         code=458, icon="🌸"},
    {name="YouTuber",            code=680, icon="🎬"},
    {name="Krazy Editor",        code=693, icon="✂️"},
    {name="Cotton Candy Pain",   code=478, icon="🍬"},
    {name="Red Legion",          code=695, icon="🔴"},
    {name="Equal to the Heaven", code=737, icon="⭐"},
}

for i,title in ipairs(titles) do
    local btn=Instance.new("TextButton",pgPerfiles)
    btn.Size=UDim2.new(1,0,0,52); btn.BackgroundColor3=C.surface
    btn.Text=""; btn.AutoButtonColor=false; btn.BorderSizePixel=0
    btn.LayoutOrder=i+3; corner(btn,8); stroke(btn,C.goldDark,1,0.5)

    mkLbl(btn,title.icon,22,C.gold,false,Enum.TextXAlignment.Left,10,0,36,52)
    local nameLbl=mkLbl(btn,title.name,13,C.text,true,Enum.TextXAlignment.Left,46,8,W-SIDE_W-100,20)
    mkLbl(btn,"Code: "..title.code,10,C.textDim,false,Enum.TextXAlignment.Left,46,29,W-SIDE_W-100,16)
    mkLbl(btn,"▶",14,C.textDim,true,Enum.TextXAlignment.Right,0,0,W-SIDE_W-12,52)

    btn.MouseEnter:Connect(function()
        tw(btn,{BackgroundColor3=Color3.fromRGB(35,28,10)},0.15)
        nameLbl.TextColor3=C.goldLight
        local s=btn:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.gold; s.Transparency=0.2 end
    end)
    btn.MouseLeave:Connect(function()
        tw(btn,{BackgroundColor3=C.surface},0.15)
        nameLbl.TextColor3=C.text
        local s=btn:FindFirstChildOfClass("UIStroke"); if s then s.Color=C.goldDark; s.Transparency=0.5 end
    end)
    btn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("Remotes")
                :WaitForChild("UpdatePlayerProfileValue")
                :InvokeServer("Showcase", profileSlot, title.code)
        end)
    end)
end

-- ============================================================
--  SIDEBAR
-- ============================================================
local sideY = 6
local function addSideSection(txt)
    local l = Instance.new("TextLabel",Sidebar)
    l.Size=UDim2.new(1,-10,0,18); l.Position=UDim2.new(0,10,0,sideY)
    l.BackgroundTransparency=1; l.Text=txt; l.Font=Enum.Font.GothamBold
    l.TextSize=8; l.TextColor3=C.textDim; l.TextXAlignment=Enum.TextXAlignment.Left
    sideY=sideY+20
end
local function addSideBtn(icon,txt,pageId)
    local frame = Instance.new("TextButton",Sidebar)
    frame.Size=UDim2.new(1,0,0,34); frame.Position=UDim2.new(0,0,0,sideY)
    frame.BackgroundColor3=C.surface; frame.Text=""
    frame.AutoButtonColor=false; frame.BorderSizePixel=0
    local bar = Instance.new("Frame",frame)
    bar.Size=UDim2.new(0,3,0.6,0); bar.Position=UDim2.new(0,0,0.2,0)
    bar.BackgroundColor3=C.surface; bar.BorderSizePixel=0; corner(bar,2)
    mkLbl(frame,icon,14,C.gold,false,Enum.TextXAlignment.Left,10,0,24,34)
    local nameLbl=mkLbl(frame,txt,11,C.textDim,true,Enum.TextXAlignment.Left,36,0,SIDE_W-42,34)
    frame.MouseButton1Click:Connect(function() showPage(pageId) end)
    frame.MouseEnter:Connect(function()
        if currentPage~=pageId then tw(frame,{BackgroundColor3=C.surface2},0.15) end
    end)
    frame.MouseLeave:Connect(function()
        if currentPage~=pageId then tw(frame,{BackgroundColor3=C.surface},0.15) end
    end)
    table.insert(sideBtnRefs,{frame=frame,bar=bar,lbl=nameLbl,page=pageId})
    sideY=sideY+34
end

addSideSection("INICIO")
addSideBtn("🏠","Home","home")
addSideSection("COMBAT")
addSideBtn("⚔️","Combate","combat")
addSideSection("TP & PLAYERS")
addSideBtn("🎯","TP Players","tp")
addSideSection("LUGARES")
addSideBtn("📍","Ubicaciones","locations")
addSideSection("OTRAS FUNC.")
addSideBtn("🍭","Otras Func.","azucar")
addSideSection("VISION")
addSideBtn("👁️","ESP","esp")
addSideSection("PERFILES")
addSideBtn("👑","Perfiles","perfiles")
addSideSection("CONFI")
addSideBtn("⚙️","Confi","confi")

-- ============================================================
--  STATUS BAR
-- ============================================================
local SB = Instance.new("Frame",Main)
SB.Size=UDim2.new(1,0,0,SB_H); SB.Position=UDim2.new(0,0,1,-SB_H)
SB.BackgroundColor3=C.surface; SB.BorderSizePixel=0
local sbTop = Instance.new("Frame",SB)
sbTop.Size=UDim2.new(1,0,0,1); sbTop.BackgroundColor3=C.goldDark; sbTop.BorderSizePixel=0
local dot = Instance.new("Frame",SB)
dot.Size=UDim2.new(0,6,0,6); dot.Position=UDim2.new(0,12,0.5,-3)
dot.BackgroundColor3=C.gold; dot.BorderSizePixel=0; corner(dot,3)
mkLbl(SB,"Listo",10,C.textDim,false,Enum.TextXAlignment.Left,24,0,50,SB_H)
mkLbl(SB,"|",10,C.goldDark,false,Enum.TextXAlignment.Left,72,0,10,SB_H)
local sbSpeed=mkLbl(SB,"Speed: 16",10,C.textDim,true,Enum.TextXAlignment.Left,86,0,90,SB_H)
mkLbl(SB,"iSacredRivals",10,C.textDim,false,Enum.TextXAlignment.Right,0,0,W-10,SB_H)

RunService.Heartbeat:Connect(function()
    sbSpeed.Text="Speed: "..tostring(SpeedValue)
end)

-- ============================================================
--  MINIMIZE / REOPEN / CLOSE
-- ============================================================
local minimized = false

-- ============================================================
--  MINIMIZE / REOPEN / CLOSE
-- ============================================================
local minimized = false
local reopenDragging = false
local reopenDragStart, reopenStartPos
local reopenMoved = false

local function doMinimize()
    minimized = true
    tw(Main, {Size=UDim2.new(0,W,0,0)}, 0.25)
    task.spawn(function()
        task.wait(0.28)
        Main.Visible = false
        ReopenBtn.Position = UDim2.new(0, Main.AbsolutePosition.X, 0, Main.AbsolutePosition.Y)
        ReopenBtn.Visible = true
    end)
end

local function doReopen()
    minimized = false
    ReopenBtn.Visible = false
    Main.Visible = true
    tw(Main, {Size=UDim2.new(0,W,0,H)}, 0.3)
end

-- Drag del botón reabrir
ReopenBtn.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch or
       input.UserInputType==Enum.UserInputType.MouseButton1 then
        reopenDragging=true; reopenMoved=false
        reopenDragStart=input.Position
        reopenStartPos=ReopenBtn.Position
    end
end)
ReopenBtn.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch or
       input.UserInputType==Enum.UserInputType.MouseButton1 then
        if not reopenMoved then doReopen() end
        reopenDragging=false; reopenMoved=false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if reopenDragging and (input.UserInputType==Enum.UserInputType.Touch or
                           input.UserInputType==Enum.UserInputType.MouseMovement) then
        local delta = input.Position - reopenDragStart
        if delta.Magnitude > 5 then
            reopenMoved = true
            ReopenBtn.Position = UDim2.new(
                reopenStartPos.X.Scale, reopenStartPos.X.Offset + delta.X,
                reopenStartPos.Y.Scale, reopenStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    if not minimized then doMinimize() else doReopen() end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ESPEnabled=false; ClearESP(); WalkWater=false
    local wp=workspace:FindFirstChild("RivalsWaterSolid"); if wp then wp:Destroy() end
    tw(Main,{Size=UDim2.new(0,W,0,0)},0.25)
    task.wait(0.3); ScreenGui:Destroy()
end)

-- ============================================================
--  INIT
-- ============================================================
showPage("home")
