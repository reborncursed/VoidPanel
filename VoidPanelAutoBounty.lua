-- ╔══════════════════════════════════════════════════════════╗
--   VOID PANEL AUTO BOUNTY  ·  by CursedExility
--   Blox Fruits  ·  Compatible with Delta Executor
--   Version 2.0 - ULTRA
-- ╚══════════════════════════════════════════════════════════╝

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

local CFG = {
    AutoBounty      = false,
    InstantKill     = false,
    FruitSupport    = false,
    AutoPickPirates = false,
    AutoSwitch      = false,
    ESP             = false,
    AntiAFK         = true,
    Humanizer       = true,
    KillDelay       = 0,
    SwitchDelay     = 0.5,
    SelectedFruit   = "TRex",
}

local FruitSkills = {
    TRex    = {"Q","E","R","T"},
    Kit     = {"Q","E","R","T"},
    Leo     = {"Q","E","R","T"},
    Dragon  = {"Q","E","R","T"},
    Kitsune = {"Q","E","R","T"},
    Dough   = {"Q","E","R","T"},
    Shadow  = {"Q","E","R","T"},
}

local currentTarget  = nil
local autoBountyConn = nil
local espTable       = {}
local killCount      = 0
local sessionStart   = tick()

local function getRoot()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function isAlive(p)
    if not p or not p.Character then return false end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function teleportTo(target)
    local root = getRoot()
    if not root or not target or not target.Character then return end
    local tr = target.Character:FindFirstChild("HumanoidRootPart")
    if tr then root.CFrame = tr.CFrame * CFrame.new(0, 0, -2.5) end
end

local function useSkills()
    local skills = FruitSkills[CFG.SelectedFruit]
    if not skills then return end
    for _, key in pairs(skills) do
        pcall(function()
            local vk = Enum.KeyCode[key]
            UserInputService.InputBegan:Fire(
                {KeyCode=vk, UserInputType=Enum.UserInputType.Keyboard}, false
            )
        end)
        task.wait(0.005)
    end
end

local function killTarget(target)
    if not target or not isAlive(target) then return end
    teleportTo(target)
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            for _, v in pairs(remotes:GetChildren()) do
                if v:IsA("RemoteEvent") then
                    pcall(function() v:FireServer(target.Character) end)
                end
            end
        end
    end)
    if CFG.FruitSupport then useSkills() end
    if CFG.InstantKill then
        for i = 1, 50 do
            teleportTo(target)
            pcall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes then
                    for _, v in pairs(remotes:GetChildren()) do
                        if v:IsA("RemoteEvent") then
                            pcall(function() v:FireServer(target.Character) end)
                        end
                    end
                end
            end)
            task.wait(0)
            if not isAlive(target) then
                killCount = killCount + 1
                break
            end
        end
    end
end

local function findBestTarget()
    local best, lowestHP = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p == LP then continue end
        if not isAlive(p) then continue end
        if CFG.AutoPickPirates and (p.Team and p.Team.Name ~= "Pirates") then continue end
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health < lowestHP then
            lowestHP = hum.Health
            best = p
        end
    end
    return best
end

local function startAutoBounty()
    if autoBountyConn then autoBountyConn:Disconnect() end
    autoBountyConn = RunService.Heartbeat:Connect(function()
        if not CFG.AutoBounty then return end
        if not currentTarget or not isAlive(currentTarget) then
            task.wait(CFG.SwitchDelay)
            currentTarget = findBestTarget()
            return
        end
        killTarget(currentTarget)
        if CFG.AutoSwitch and not isAlive(currentTarget) then
            task.wait(CFG.SwitchDelay)
            currentTarget = findBestTarget()
        end
        task.wait(CFG.Humanizer and math.random(1,3)/100 or CFG.KillDelay)
    end)
end

local function stopAutoBounty()
    if autoBountyConn then autoBountyConn:Disconnect(); autoBountyConn = nil end
    currentTarget = nil
end

local function clearESP()
    for _, v in pairs(espTable) do pcall(function() v:Destroy() end) end
    espTable = {}
end

local function updateESP()
    clearESP()
    if not CFG.ESP then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p == LP or not p.Character then continue end
        local root = p.Character:FindFirstChild("HumanoidRootPart")
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not root or not hum then continue end
        local bb = Instance.new("BillboardGui")
        bb.Size = UDim2.new(0,120,0,44)
        bb.StudsOffset = Vector3.new(0,3.5,0)
        bb.AlwaysOnTop = true
        bb.Adornee = root
        bb.Parent = root
        local nl = Instance.new("TextLabel",bb)
        nl.Size = UDim2.new(1,0,0.55,0)
        nl.BackgroundTransparency = 1
        nl.Text = p.Name
        nl.TextColor3 = Color3.fromRGB(180,120,255)
        nl.Font = Enum.Font.GothamBold
        nl.TextSize = 13
        nl.TextStrokeTransparency = 0
        nl.TextStrokeColor3 = Color3.new(0,0,0)
        local hl = Instance.new("TextLabel",bb)
        hl.Size = UDim2.new(1,0,0.45,0)
        hl.Position = UDim2.new(0,0,0.55,0)
        hl.BackgroundTransparency = 1
        hl.Text = "❤️ "..math.floor(hum.Health).." / "..math.floor(hum.MaxHealth)
        hl.TextColor3 = Color3.fromRGB(50,220,100)
        hl.Font = Enum.Font.Gotham
        hl.TextSize = 10
        hl.TextStrokeTransparency = 0
        hl.TextStrokeColor3 = Color3.new(0,0,0)
        table.insert(espTable, bb)
    end
end

RunService.Heartbeat:Connect(function()
    if CFG.ESP then updateESP() end
end)

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if CFG.AntiAFK then
        local VU = game:GetService("VirtualUser")
        VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidAutoBounty"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end

local C = {
    bg=Color3.fromRGB(8,6,18), surface=Color3.fromRGB(16,12,34),
    sur2=Color3.fromRGB(24,18,48), purple=Color3.fromRGB(130,70,210),
    purpleL=Color3.fromRGB(180,120,255), purpleD=Color3.fromRGB(55,28,95),
    cyan=Color3.fromRGB(80,200,220), text=Color3.fromRGB(220,200,255),
    dim=Color3.fromRGB(100,75,140), red=Color3.fromRGB(200,50,70),
    green=Color3.fromRGB(50,210,110), gold=Color3.fromRGB(220,180,60),
}

local function corner(p,r) local c=Instance.new("UICorner",p);c.CornerRadius=UDim.new(0,r or 8) end
local function stroke(p,col,th,tr) local s=Instance.new("UIStroke",p);s.Color=col or C.purple;s.Thickness=th or 1;s.Transparency=tr or 0.4 end
local function tw(obj,props,t) TweenService:Create(obj,TweenInfo.new(t or 0.2,Enum.EasingStyle.Quint),props):Play() end
local function lbl(par,txt,sz,col,bold,xa,x,y,w,h)
    local l=Instance.new("TextLabel",par)
    l.BackgroundTransparency=1;l.Text=txt;l.TextSize=sz
    l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextColor3=col;l.TextXAlignment=xa or Enum.TextXAlignment.Left
    l.Size=UDim2.new(0,w,0,h);l.Position=UDim2.new(0,x,0,y)
    return l
end

local W,H = 360,510
local Main = Instance.new("Frame",ScreenGui)
Main.Size = UDim2.new(0,W,0,0)
Main.Position = UDim2.new(0.5,-W/2,0.5,-H/2)
Main.BackgroundColor3 = C.bg
Main.BorderSizePixel = 0
corner(Main,12); stroke(Main,C.purple,1.5,0.25)

local TBar = Instance.new("Frame",Main)
TBar.Size = UDim2.new(1,0,0,46)
TBar.BackgroundColor3 = C.surface
TBar.BorderSizePixel = 0; corner(TBar,12)

lbl(TBar,"⚡",20,C.purpleL,true,Enum.TextXAlignment.Center,8,0,30,46)
lbl(TBar,"VOID AUTO BOUNTY",14,C.purpleL,true,Enum.TextXAlignment.Left,44,6,220,20)
lbl(TBar,"by CursedExility · v2.0",9,C.dim,false,Enum.TextXAlignment.Left,44,27,220,14)

local CloseBtn=Instance.new("TextButton",TBar)
CloseBtn.Size=UDim2.new(0,26,0,22)
CloseBtn.Position=UDim2.new(1,-32,0.5,-11)
CloseBtn.BackgroundColor3=C.red; CloseBtn.Text="✕"
CloseBtn.TextColor3=Color3.new(1,1,1); CloseBtn.Font=Enum.Font.GothamBold
CloseBtn.TextSize=11; CloseBtn.BorderSizePixel=0; corner(CloseBtn,5)
CloseBtn.MouseButton1Click:Connect(function()
    stopAutoBounty(); clearESP()
    tw(Main,{Size=UDim2.new(0,W,0,0)},0.3)
    task.wait(0.35); ScreenGui:Destroy()
end)

local statsPanel=Instance.new("Frame",Main)
statsPanel.Size=UDim2.new(1,-20,0,50); statsPanel.Position=UDim2.new(0,10,0,54)
statsPanel.BackgroundColor3=C.surface; statsPanel.BorderSizePixel=0
corner(statsPanel,8); stroke(statsPanel,C.purpleD,1,0.5)

local killsLbl=lbl(statsPanel,"⚔️ Kills: 0",11,C.gold,true,Enum.TextXAlignment.Left,10,6,160,16)
local timeLbl=lbl(statsPanel,"⏱ 0s",11,C.cyan,true,Enum.TextXAlignment.Right,0,6,W-30,16)
local statusLbl=lbl(statsPanel,"● Idle",10,C.dim,false,Enum.TextXAlignment.Left,10,28,160,14)
local targetLbl=lbl(statsPanel,"Target: None",10,C.dim,false,Enum.TextXAlignment.Right,0,28,W-30,14)

RunService.Heartbeat:Connect(function()
    killsLbl.Text="⚔️ Kills: "..killCount
    timeLbl.Text="⏱ "..math.floor(tick()-sessionStart).."s"
    if currentTarget and CFG.AutoBounty then
        targetLbl.Text="→ "..currentTarget.Name
    else
        targetLbl.Text="Target: None"
    end
end)

local tY=112
local function makeToggle(icon,label,desc,key,cb)
    local btn=Instance.new("TextButton",Main)
    btn.Size=UDim2.new(1,-20,0,46); btn.Position=UDim2.new(0,10,0,tY)
    btn.BackgroundColor3=C.surface; btn.Text=""
    btn.AutoButtonColor=false; btn.BorderSizePixel=0
    corner(btn,8); stroke(btn,C.purpleD,1,0.6)
    tY=tY+52
    local ibg=Instance.new("Frame",btn)
    ibg.Size=UDim2.new(0,36,0,36); ibg.Position=UDim2.new(0,5,0.5,-18)
    ibg.BackgroundColor3=C.purpleD; ibg.BorderSizePixel=0; corner(ibg,9)
    lbl(ibg,icon,17,C.purpleL,false,Enum.TextXAlignment.Center,0,0,36,36)
    lbl(btn,label,12,C.text,true,Enum.TextXAlignment.Left,48,8,220,18)
    lbl(btn,desc,9,C.dim,false,Enum.TextXAlignment.Left,48,27,220,13)
    local pill=Instance.new("Frame",btn)
    pill.Size=UDim2.new(0,42,0,22); pill.Position=UDim2.new(1,-52,0.5,-11)
    pill.BackgroundColor3=C.purpleD; pill.BorderSizePixel=0; corner(pill,11)
    local dot=Instance.new("Frame",pill)
    dot.Size=UDim2.new(0,18,0,18); dot.Position=UDim2.new(0,2,0.5,-9)
    dot.BackgroundColor3=Color3.fromRGB(120,100,160); dot.BorderSizePixel=0; corner(dot,9)
    local function upd()
        local on=CFG[key]
        tw(pill,{BackgroundColor3=on and C.purple or C.purpleD},0.2)
        tw(dot,{Position=on and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)},0.2)
        tw(dot,{BackgroundColor3=on and Color3.new(1,1,1) or Color3.fromRGB(120,100,160)},0.2)
        tw(btn,{BackgroundColor3=on and C.sur2 or C.surface},0.2)
        ibg.BackgroundColor3=on and C.purple or C.purpleD
    end
    btn.MouseButton1Click:Connect(function()
        CFG[key]=not CFG[key]; upd()
        if cb then cb(CFG[key]) end
    end)
    upd()
end

makeToggle("🎯","Auto Bounty Farm","Teleport & kill targets automatically","AutoBounty",function(on)
    if on then startAutoBounty(); statusLbl.Text="● Farming"; statusLbl.TextColor3=C.green
    else stopAutoBounty(); statusLbl.Text="● Idle"; statusLbl.TextColor3=C.dim end
end)
makeToggle("⚡","Instant Kill","Kill targets as fast as possible","InstantKill",nil)
makeToggle("🍎","Fruit Support","Use fruit skills on target","FruitSupport",nil)
makeToggle("🏴‍☠️","Auto Pick Pirates","Only target pirate team","AutoPickPirates",nil)
makeToggle("🔄","Auto Switch Target","Switch when target is dead","AutoSwitch",nil)
makeToggle("👁️","ESP","Show player names & HP","ESP",function(on) if not on then clearESP() end end)
makeToggle("🛡️","Anti AFK","Prevent auto kick","AntiAFK",nil)

local fsec=Instance.new("Frame",Main)
fsec.Size=UDim2.new(1,-20,0,56); fsec.Position=UDim2.new(0,10,0,tY+2)
fsec.BackgroundColor3=C.surface; fsec.BorderSizePixel=0
corner(fsec,8); stroke(fsec,C.purpleD,1,0.6)
lbl(fsec,"🍈  Select Fruit",11,C.purpleL,true,Enum.TextXAlignment.Left,10,6,200,16)

local fruits={"TRex","Kit","Leo","Dragon","Kitsune","Dough","Shadow"}
local fbtns={}
for i,f in ipairs(fruits) do
    local fb=Instance.new("TextButton",fsec)
    fb.Size=UDim2.new(0,44,0,24); fb.Position=UDim2.new(0,(i-1)*48+4,0,26)
    fb.BackgroundColor3=f==CFG.SelectedFruit and C.purple or C.purpleD
    fb.Text=f; fb.TextColor3=f==CFG.SelectedFruit and Color3.new(1,1,1) or C.dim
    fb.Font=Enum.Font.GothamBold; fb.TextSize=8
    fb.BorderSizePixel=0; corner(fb,6)
    table.insert(fbtns,{btn=fb,name=f})
    fb.MouseButton1Click:Connect(function()
        CFG.SelectedFruit=f
        for _,v in pairs(fbtns) do
            tw(v.btn,{BackgroundColor3=v.name==f and C.purple or C.purpleD},0.15)
            v.btn.TextColor3=v.name==f and Color3.new(1,1,1) or C.dim
        end
    end)
end

local drag,ds,sp=false,nil,nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        drag=true; ds=i.Position; sp=Main.Position
    end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)
UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
        local d=i.Position-ds
        Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
    end
end)

tw(Main,{Size=UDim2.new(0,W,0,H)},0.45)
print("[VoidAutoBounty v2.0] Loaded! by CursedExility")
