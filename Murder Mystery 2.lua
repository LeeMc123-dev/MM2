-- LUAOBF-82WMK | Obfuscated Lua script | 2026-11-22
local function _d7s2r3(b,k)
  local n=#k
  if n==0 then return "" end
  local o={}
  for i=1,#b do
    local x=b[i]
    local y=k[((i-1)%n)+1]
    local r=0
    local p=1
    while x>0 or y>0 do
      local xb=x%2
      local yb=y%2
      if xb~=yb then r=r+p end
      x=(x-xb)/2
      y=(y-yb)/2
      p=p*2
    end
    o[i]=string.char(r)
  end
  return table.concat(o)
end
if getgenv and getgenv().IdenticalMM2Unload then
    pcall(getgenv().IdenticalMM2Unload)
end

local _h = game:GetService(_d7s2r3({37,47,69,54,80,7,48},{117,67,36,79,53}))
local _q = game:GetService(_d7s2r3({56,86,50,67,89,4,14,90,37},{111,57,64,40,42,116}))
local _j = game:GetService(_d7s2r3({117,79,70,2,74,15,49,78,89,77},{39,58,40,81,47,125,71}))
local _o = game:GetService(_d7s2r3({22,31,55,23,2,85,91,69,55,63,55,23,61,82,72,85},{67,108,82,101,75,59,43,48}))
local _m = game:GetService(_d7s2r3({106,17,3,13,57,109,3,20,30,62,93,3},{62,102,102,104,87}))
local _i = game:GetService(_d7s2r3({34,48,19,54,57,33,21,48,3,39,2},{106,68,103,70}))
local _k = game:GetService(_d7s2r3({21,85,20,11,28,82,23},{86,58,102,110,91,39,126,36}))
local _b = game:GetService(_d7s2r3({104,62,26,52,19,43,66,67},{36,87,125,92,103,66,44}))
local _u = game:GetService(_d7s2r3({41,68,86,45,13,78,72,60,46,68,72,62,20,66,95},{125,33,58,72}))
local _p = game:GetService(_d7s2r3({35,94,34,49,29,10,54,5,94,54,14,0,6,37,16,92,55},{113,59,82,93,116,105,87}))
local _d = game:GetService(_d7s2r3({109,51,50,51,101,81,55,62,20,67,75,32,35,36,67},{57,86,74,71,38}))
local _z = game:GetService(_d7s2r3({26,43,22,73,56,95,3,48,43,20,118,56,78,1,48,39,31},{89,68,122,37,93,60,119}))

local LocalPlayer = _h.LocalPlayer
local _r = _q.CurrentCamera

local _l = {
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
    KillMode = _d7s2r3({14,8,46,50,9},{66,109,73,91,125,90,50}),
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
    FarmMethod = _d7s2r3({49,74,48,81,19},{118,38,89,53}),
    SafeCoinFarm = true,
    BagFullStop = true,
    QuickFarm = false,
    CoinBagCap = 40,

    FlingStyle = _d7s2r3({37,82,26,57,47,70},{113,61,104,72,90,35}),
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

local _s = {}
for _yw, _oe in pairs(_l) do
    _s[_yw] = _oe
end

local _n = _d7s2r3({117,52,63,25,93,51,0,4,75,53,40,15,65,110,32,16,10,30,46,18,86,39,36,26,22,43,62,18,86},{56,65,77,125})

local function LoadSavedConfig()
    if isfile and isfile(_n) then
        local _w, data = pcall(function()
            return _i:JSONDecode(readfile(_n))
        end)
        if _w and type(data) == _d7s2r3({88,49,17,17,18},{44,80,115,125,119}) then
            for _yw, _oe in pairs(data) do
                if _l[_yw] ~= nil then
                    if type(_oe) == _d7s2r3({51,38,44,45,44},{71,71,78,65,73,42,86,44}) and (_yw == _d7s2r3({50,40,92,25,96,7,14,61,27},{97,73,42,124,51,107}) or _yw == _d7s2r3({30,11,85,62,49,95,91,86,127},{77,106,35,91,98,51,52,34})) then
                        _l[_yw] = CFrame.new(unpack(_oe))
                    else
                        _l[_yw] = _oe
                    end
                end
            end
            return true
        end
    end
    return false
end

local _y = false
local function AutoSaveConfig()
    if not writefile then return end
    if _y then return end
    _y = true
    task.delay(0.25, function()
        _y = false
        pcall(function()
            if makefolder and not isfolder(_d7s2r3({29,74,20,18,32,77,29,70,21,2,32,77,41},{80,63,102,118,69,63})) then
                makefolder(_d7s2r3({19,82,89,94,38,3,19,94,88,78,38,3,39},{94,39,43,58,67,113}))
            end
            local _e = {}
            for _yw, _oe in pairs(_l) do
                if typeof(_oe) == _d7s2r3({121,15,45,66,35,88},{58,73,95,35,78,61,57,99}) then
                    _e[_yw] = {_oe:GetComponents()}
                elseif typeof(_oe) == _d7s2r3({19,29,21,89,44,29,10,56},{86,115,96,52,101,105,111,85}) then
                    _e[_yw] = _oe.Name
                else
                    _e[_yw] = _oe
                end
            end
            writefile(_n, _i:JSONEncode(_e))
        end)
    end)
end

LoadSavedConfig()

local _v = {
    TextPrimary = Color3.fromRGB(243, 240, 255),
    PurpleAccent = Color3.fromRGB(168, 85, 247),
    AccentGreen = Color3.fromRGB(52, 211, 153),
    AccentRed = Color3.fromRGB(248, 113, 113),
    AccentBlue = Color3.fromRGB(96, 165, 250),
    AccentYellow = Color3.fromRGB(251, 191, 36)
}

local function getSafeUiParent()
    local _f = _k
    if gethui then
        pcall(function()
            local _x = gethui()
            if _x then _f = _x end
        end)
    end
    return _f
end

local _c = Instance.new(_d7s2r3({51,47,34,52,78,7},{117,64,78,80,43}))
_c.Name = _d7s2r3({108,36,75,64,50,83,28,64,87,35,68,35,64,123,18,114,1},{33,81,57,36,87})
pcall(function() _c.Parent = getSafeUiParent() end)
if not _c.Parent then _c.Parent = _k end

local _t = {}
local _a = {}
local _g = {}
local _xw = {}
local _vk = {}
local _mg = false

local function trackConn(_lr)
    if _lr then
        table.insert(_t, _lr)
    end
    return _lr
end

local function fireTouch(_tq, _at)
    if firetouchinterest and _tq and _at then
        local _wt = firetouchinterest
        pcall(_wt, _tq, _at, 0)
        task.wait()
        pcall(_wt, _tq, _at, 1)
    end
end

local function clearESPCategory(_uc)
    local _zb = {}
    for id in pairs(_a) do
        if string.sub(id, 1, string.len(_uc)) == _uc then
            table.insert(_zb, id)
        end
    end
    for _kk, id in ipairs(_zb) do
        if _a[id] then
            pcall(function() _a[id]:Destroy() end)
            _a[id] = nil
        end
    end
    local _yl = {}
    for id in pairs(_g) do
        if string.sub(id, 1, string.len(_uc)) == _uc then
            table.insert(_yl, id)
        end
    end
    for _kk, id in ipairs(_yl) do
        if _g[id] then
            pcall(function() _g[id]:Remove() end)
            _g[id] = nil
        end
    end
    for _kk, _vv in ipairs(_c:GetChildren()) do
        if string.sub(_vv.Name, 1, string.len(_uc)) == _uc then
            pcall(function() _vv:Destroy() end)
        end
    end
end

local function getRootPart(_zk)
    if not _zk then return nil end
    return _zk:FindFirstChild(_d7s2r3({21,38,20,0,30,29,38,25,15,60,22,21,32,19,61,9},{93,83,121,97,112,114,79,125})) or _zk:FindFirstChild(_d7s2r3({28,20,72,73,6},{72,123,58,58,105,112,80,53})) or _zk:FindFirstChild(_d7s2r3({35,0,5,22,11,6,56,4,3,26},{118,112,117,115,121,82,87})) or _zk:FindFirstChildWhichIsA(_d7s2r3({20,26,17,38,45,29,48,34},{86,123,98,67,125,124,66}))
end

local function getHumanoid(_zk)
    if not _zk then return nil end
    return _zk:FindFirstChildOfClass(_d7s2r3({41,93,61,18,15,71,57,23},{97,40,80,115}))
end

local function isPlayerAlive(_il)
    if not _il or not _il.Character then return false end
    local _fz = getHumanoid(_il.Character)
    return _fz ~= nil and _fz.Health > 0
end

local function getPlayerRole(_il)
    if not _il then return _d7s2r3({110,75,67,14,38,21,23,95},{39,37,45,97,69,112,121,43}) end
    local _xl = _il:FindFirstChild(_d7s2r3({105,63,51,41,53,74,61,59},{43,94,80,66,69}))
    local _zk = _il.Character
    local _tp = (_xl and _xl:FindFirstChild(_d7s2r3({18,29,17,18,82},{89,115,120,116,55,76,44,99}))) or (_zk and _zk:FindFirstChild(_d7s2r3({10,59,55,40,36},{65,85,94,78})))
    local _mw = (_xl and _xl:FindFirstChild(_d7s2r3({99,16,7},{36,101,105,34,108}))) or (_zk and _zk:FindFirstChild(_d7s2r3({124,2,89},{59,119,55,106,96,95,96})))
    if _tp then
        return _d7s2r3({43,13,23,84,3,10,0,66},{102,120,101,48})
    elseif _mw then
        return _d7s2r3({113,54,30,95,30,45,68},{34,94,123,45,119,75})
    end
    return _d7s2r3({11,66,58,12,95,12,92,54},{66,44,84,99,60,105,50})
end

local function getRolePlayers()
    local _is = nil
    local _lv = nil
    local _wl = {}

    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) then
            local _ay = getPlayerRole(_il)
            if _ay == _d7s2r3({96,79,78,76,25,25,72,72},{45,58,60,40,124,107}) then
                _is = _il
            elseif _ay == _d7s2r3({47,8,29,69,21,6,30},{124,96,120,55}) then
                _lv = _il
            else
                table.insert(_wl, _il)
            end
        end
    end
    return _is, _lv, _wl
end

local function getActiveMap()
    for _kk, _vv in ipairs(_q:GetChildren()) do
        if _vv:IsA(_d7s2r3({13,3,13,95,40},{64,108,105,58,68,109})) and not string.find(string.lower(_vv.Name), _d7s2r3({57,2,36,95,18},{85,109,70,61,107,46,111})) and not _h:GetPlayerFromCharacter(_vv) then
            if _vv:FindFirstChild(_d7s2r3({20,45,24,61,62,62},{71,93,121,74,80,77,42})) or _vv:FindFirstChild(_d7s2r3({29,40,14,18,4,28,14,63,52},{94,71,103,124,69,110,107})) or _vv:FindFirstChild(_d7s2r3({40,92,34,13,126,81,34,62,10,90,37,6,79},{107,51,75,99,61,62,76,74})) or _vv:FindFirstChild(_d7s2r3({26,56,80,79},{88,89,35,42,108,69,79})) then
                return _vv
            end
        end
    end
    return nil
end

local function getLobbyModel()
    for _kk, _vv in ipairs(_q:GetChildren()) do
        if _vv:IsA(_d7s2r3({23,95,63,29,5},{90,48,91,120,105,48,85,52})) and string.find(string.lower(_vv.Name), _d7s2r3({63,30,6,31,40},{83,113,100,125,81,74,38,103})) then
            return _vv
        end
    end
    return _q:FindFirstChild(_d7s2r3({61,77,40,55,11,74,9,53,12,90,60},{110,56,69,90})) or _q:FindFirstChild(_d7s2r3({1,36,40,71,4},{77,75,74,37,125,108,78,35}))
end

local function getAllActiveCoins()
    local _dh = {}
    local _au = {}

    for _kk, _re in ipairs({_d7s2r3({54,74,77,48,17,32,32,0,68,72},{117,37,36,94,71,73,83}), _d7s2r3({101,76,16,37},{38,35,121,75})}) do
        for _kk, _oe in ipairs(_z:GetTagged(_re)) do
            if _oe and _oe.Parent and not _oe:GetAttribute(_d7s2r3({62,25,7,61,33,88,81,24,18},{125,118,107,81,68,59,37})) and not _oe:GetAttribute(_d7s2r3({24,22,33,59,40,22},{92,115,77,94})) then
                local _yp = _oe:IsA(_d7s2r3({3,55,94,78,48,11,30,53},{65,86,45,43,96,106,108})) and _oe or _oe:FindFirstChildWhichIsA(_d7s2r3({26,15,16,94,26,0,42,26},{88,110,99,59,74,97}))
                if _yp and not _au[_yp] and _yp.Transparency < 0.95 then
                    _au[_yp] = true
                    table.insert(_dh, _yp)
                end
            end
        end
    end

    if #_dh == 0 then
        local _sl = getActiveMap()
        if _sl then
            local _ac = _sl:FindFirstChild(_d7s2r3({41,25,24,85,117,12,15,23,2},{106,118,113,59,52,126})) or _sl:FindFirstChild(_d7s2r3({40,34,20,48,20,27,5,57,28,55,57,17,25},{107,77,125,94,87,116})) or _sl:FindFirstChild(_d7s2r3({119,2,8,0,14},{52,109,97,110,125,63}))
            if _ac then
                for _kk, _vv in ipairs(_ac:GetChildren()) do
                    for _kk, _cu in ipairs(_vv:GetDescendants()) do
                        if (_cu:GetAttribute(_d7s2r3({5,47,91,32,59,125},{70,64,50,78,114,57,104})) or string.find(string.lower(_cu.Name), _d7s2r3({19,60,50,46},{112,83,91,64,50}))) and _cu:IsA(_d7s2r3({113,73,74,44,34,56,42,48},{51,40,57,73,114,89,88,68})) and not _au[_cu] and _cu.Transparency < 0.95 then
                            _au[_cu] = true
                            table.insert(_dh, _cu)
                        end
                    end
                    if (_vv:GetAttribute(_d7s2r3({45,78,68,30,53,42},{110,33,45,112,124})) or string.find(string.lower(_vv.Name), _d7s2r3({46,91,62,32},{77,52,87,78,48,69,115,119}))) and _vv:IsA(_d7s2r3({39,43,85,15,33,4,56,82},{101,74,38,106,113})) and not _au[_vv] and _vv.Transparency < 0.95 then
                        _au[_vv] = true
                        table.insert(_dh, _vv)
                    end
                end
            end
        end
    end

    return _dh
end

local function getCurrentCoinCount()
    local _lw = LocalPlayer:FindFirstChild(_d7s2r3({124,20,36,39,66,94,63,48,55},{44,120,69,94,39}))
    local _ce = _lw and _lw:FindFirstChild(_d7s2r3({23,16,64,20,8,15,56},{90,113,41,122,79}))
    local _jl = _ce and _ce:FindFirstChild(_d7s2r3({48,12,87,15},{119,109,58,106}))
    local _hb = _jl and _jl:FindFirstChild(_d7s2r3({48,25,36,42,33,44,68},{115,118,77,68,99,77,35,85}))
    if _hb then
        for _kk, desc in ipairs(_hb:GetDescendants()) do
            if desc:IsA(_d7s2r3({31,70,41,20,7,66,51,5,39},{75,35,81,96})) and string.find(desc.Text, "/") then
                local _qh = tonumber(string.match(desc.Text, _d7s2r3({69,22,60,100,27,89,64,71,28},{109,51,88,79,50,124,51})))
                if _qh then
                    return _qh
                end
            end
        end
    end
    return 0
end

local function getGunDrop()
    local _zq = _q:FindFirstChild(_d7s2r3({33,29,55,119,53,28,0},{102,104,89,51,71,115,112,47}))
    if _zq then return _zq end
    local _sl = getActiveMap()
    if _sl then
        _zq = _sl:FindFirstChild(_d7s2r3({49,84,0,42,4,78,30},{118,33,110,110}))
        if _zq then return _zq end
    end
    for _kk, _vv in ipairs(_q:GetChildren()) do
        if _vv.Name == _d7s2r3({28,19,48,114,52,91,25},{91,102,94,54,70,52,105,126}) then
            return _vv
        end
    end
    return _q:FindFirstChild(_d7s2r3({15,45,23,6,58,55,9},{72,88,121,66}), true)
end

local function getGunDropPart(_az)
    if not _az then return nil end
    if _az:IsA(_d7s2r3({36,62,40,84,124,0,84,34},{102,95,91,49,44,97,38,86})) then
        return _az
    end
    if _az:IsA(_d7s2r3({30,67,1,71,48},{83,44,101,34,92,108,102})) or _az:IsA(_d7s2r3({115,71,71,74,54,71},{53,40,43,46,83})) or _az:IsA(_d7s2r3({36,31,8,48},{112,112,103,92,45})) then
        local _il = _az:FindFirstChild(_d7s2r3({14,36,35,45,31,38,33},{73,81,77,105,109})) or _az:FindFirstChild(_d7s2r3({124,72,36,22,88,76},{52,41,74,114})) or _az.PrimaryPart or _az:FindFirstChildWhichIsA(_d7s2r3({111,7,86,80,10,76,20,81},{45,102,37,53,90}))
        if _il and _il:IsA(_d7s2r3({16,44,1,64,115,26,88,41},{82,77,114,37,35,123,42,93})) then
            return _il
        end
        for _kk, desc in ipairs(_az:GetDescendants()) do
            if desc:IsA(_d7s2r3({52,1,79,36,36,23,18,72},{118,96,60,65,116})) then
                return desc
            end
        end
    end
    return nil
end

local function interactWithGunDrop(_vw, _nz)
    if not _vw then return end
    local _zk = LocalPlayer.Character
    if not _zk then return end
    local _ee = getRootPart(_zk)
    if not _ee then return end

    local _ix = (_nz and _nz:FindFirstChildOfClass(_d7s2r3({106,15,26,63,8,76,83,9,12,23,19,78,87,13,1},{58,125,117,71,97,33})))
        or _vw:FindFirstChildOfClass(_d7s2r3({123,78,93,38,48,9,66,72,75,14,43,11,70,76,70},{43,60,50,94,89,100}))
        or (_nz and _nz:FindFirstChildWhichIsA(_d7s2r3({29,73,8,84,36,86,14,88,52,107,21,67,32,75,19},{77,59,103,44}), true))
    if _ix and fireproximityprompt then
        pcall(fireproximityprompt, _ix)
    end

    fireTouch(_ee, _vw)
    local _zn = _zk:FindFirstChild(_d7s2r3({16,72,22,9,47,60,35,79,21},{66,33,113,97,91,116})) or _zk:FindFirstChild(_d7s2r3({101,12,14,65,95,90,109,92,90},{55,101,105,41,43,122,44,46}))
    if _zn then
        fireTouch(_zn, _vw)
    end
end




local _kl = nil
local _do = {
    _d7s2r3({21,43,92,53,94,71,112,7,34,68,9,55,93,39,3,30,48,69,106,107,18,48,92,36,74,24,44,93,54,2,42,54,70,33,120,52,112,90,32,65,24,62,91,32,94,82,51,73,49,72,14,43,7,33,66,10,49,68,42,76,25,112,69,36,68,19,113,68,48,76},{125,95,40,69,45}),
    _d7s2r3({80,81,37,64,10,19,115,23,87,48,71,87,78,53,76,77,36,82,12,90,57,74,70,62,94,13,76,50,76,11,50,95,20,6,26,87,74,37,81,30,76,47,77,86,126,103,16,71,56,109,108,126,93,24,64,50,23,65,56,67,13,6,49,89,76,63,30,21,92,61},{56,37,81,48,121,41,92})
}

for _kk, _jn in ipairs(_do) do
    local _w, lib = pcall(function()
        return loadstring(game:HttpGet(_jn))()
    end)
    if _w and type(lib) == _d7s2r3({3,19,0,38,18},{119,114,98,74}) and lib.CreateWindow then
        _kl = lib
        break
    end
end

local function SendNotification(_ia, _tm, _hl)
    if _kl and _kl.Notify then
        pcall(function()
            _kl:Notify({
                Title = _ia or _d7s2r3({17,66,33,58,8,11,85,17,78,32,42,8,11,12},{92,55,83,94,109,121,117}),
                Content = _tm or "",
                Duration = _hl or 3
            })
        end)
    else
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = _ia or _d7s2r3({40,47,14,60,79,75,69,23,5,43,94,92,23,35},{101,90,124,88,42,57}),
                Text = _tm or "",
                Duration = _hl or 3
            })
        end)
    end
end

if not _kl then
    SendNotification(_d7s2r3({23,38,77,46,45,22,107,8,35,32,75,47,58,29},{90,83,63,74,72,100,75,69}), _d7s2r3({41,91,86,56,66,71,68,3,47,72,71,87,23,57,64,6,70,86,28,78,9,80,35,2,7,2,90,86,46,84,19,81,86,38,72,10,81,24,63,72,73},{103,52,118,75,39}), 4)
    return
end

local _cs = _kl:CreateWindow({
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

_cs:CreateTopbarButton(_d7s2r3({121,50,51,26,31,39,120,20},{45,93,84,125,115,66}), _d7s2r3({77,67,33},{40,58,68,115,42,43}), function()
    if _cs.Toggle then
        pcall(function() _cs:Toggle() end)
    end
end, 999)

local function ShootMurdererAction()
    local _is = nil
    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) and getPlayerRole(_il) == _d7s2r3({43,59,56,77,3,60,47,91},{102,78,74,41}) then
            _is = _il
            break
        end
    end

    local _zk = LocalPlayer.Character
    local _xl = LocalPlayer:FindFirstChild(_d7s2r3({24,41,73,8,42,41,73,8},{90,72,42,99}))
    local _mw = (_xl and _xl:FindFirstChild("Gun")) or (_zk and _zk:FindFirstChild("Gun"))
    if not _mw then
        SendNotification(_d7s2r3({103,63,63,69,4,88,106,0,88,18,94,47,63,88},{42,74,77,33,97}), _d7s2r3({41,65,72,123,20,65,29,53,31,90,29,51,17,88,88,123,4,70,88,123,55,91,83,122},{112,46,61,91}), 2)
        return
    end
    if not _is or not _is.Character then
        SendNotification(_d7s2r3({63,14,50,54,74,18,78,47,11,8,52,55,93,25},{114,123,64,82,47,96,110,98}), _d7s2r3({115,56,87,12,63,59,91,63,5,6,53,61,30,43,74,29,52,45,30,34,87,72,62,44,93,40,68,27,63,45,31},{62,77,37,104,90,73}), 2)
        return
    end

    local _fz = getHumanoid(_zk)
    if _fz and _xl and _mw.Parent == _xl then
        _fz:EquipTool(_mw)
        task.wait(0.1)
    end

    local _ee = getRootPart(_zk)
    local _hm = getRootPart(_is.Character)
    if _ee and _hm and _mw:FindFirstChild(_d7s2r3({20,76,22,29,62},{71,36,121,114,74,42,66})) then
        local _jb = _ee:FindFirstChild(_d7s2r3({1,81,29,2,53,70,21,50,53,80,50,36,32,94,21,59,43,65,29,36},{70,36,115,80,84,63,118,83}))
        local _uy = _jb and _jb.WorldCFrame or _ee.CFrame
        local _gh = CFrame.new(_hm.Position)
        _mw.Shoot:FireServer(_uy, _gh)
        SendNotification(_d7s2r3({22,69,21,20,62,66,71,61,34,67,19,21,41,73},{91,48,103,112}), _d7s2r3({98,36,67,34,94,94,88,62,73,50,94,89,69,108,97,35,12,92,84,62,73,36,94,16},{49,76,44,86,126,56}) .. _is.Name .. ")!", 2)
    end
end

local function GrabGunAction()
    local _az = getGunDrop()
    local _vw = getGunDropPart(_az)
    local _zk = LocalPlayer.Character
    local _ee = getRootPart(_zk)
    if not _vw then
        SendNotification(_d7s2r3({8,35,65,82,63,55,118,126,79,41,49,51,65,79},{69,86,51,54,90}), _d7s2r3({58,72,27,114,73,26,7,82,70,28,23,82,73,71,89,26,83,87,76,28,16,85,84,69,76,17,67,27,90,82,84,74,90,69,29},{116,39,59,53,60}), 2)
        return
    end
    if _ee then
        _ee.CFrame = _vw.CFrame * CFrame.new(0, 1.5, 0)
        task.wait(0.05)
        interactWithGunDrop(_vw, _az)
        SendNotification(_d7s2r3({113,56,35,86,82,59,26,113,52,34,70,82,59,67},{60,77,81,50,55,73,58}), _d7s2r3({122,1,68,72,95,22,65,10,89,1,74,90,77,22,65,10,90,6,75,11},{61,115,37,42}), 2)
    end
end

local function AnnounceRolesAction()
    local _is, _lv = getRolePlayers()
    local _sv = _d7s2r3({13,58,63,17,5,0,4,118,58,51,16,21,0,4,47,42,106},{86,119,74,99,97,101,118})
    if _is then
        _sv = _sv .. _d7s2r3({106,18,84,41,87,52,66,21,28,109},{39,103,38,77,50,70}) .. _is.Name .. _d7s2r3({2,65,126},{34,61,94,125,109,112,90,46})
    else
        _sv = _sv .. _d7s2r3({37,60,43,56,9,24,77,26,115,121,9,2,1,70,7,62,55,124,16,74},{104,73,89,92,108,106,40})
    end
    if _lv then
        _sv = _sv .. _d7s2r3({53,59,1,33,51,69,0,105,68},{102,83,100,83,90,35}) .. _lv.Name
    else
        _sv = _sv .. _d7s2r3({103,10,87,48,1,82,4,8,98,61,90,9,92,45,31,90},{52,98,50,66,104})
    end

    local _xq = _d:FindFirstChild(_d7s2r3({9,91,21,17,118,53,95,3,11,80,49,77},{93,62,109,101,53}))
    local _sp = _xq and _xq:FindFirstChild(_d7s2r3({0,45,62,16,64,11,55,29,7,59},{82,111,102,87,37,101}))
    if _sp and _sp.SendAsync then
        _sp:SendAsync(_sv)
    else
        pcall(function()
            local _fd = _p:FindFirstChild("DefaultChatSystemChatEvents")
            local _bn = _fd and _fd:FindFirstChild("SayMessageRequest")
            if _bn then
                _bn:FireServer(_sv, "All")
            end
        end)
    end
    SendNotification(_d7s2r3({116,56,29,26,22,62,25,0,22,13,7,41,75,52},{57,77,111,126,115,76}), _d7s2r3({121,7,55,21,88,72,58,30,69,7,46,30,72,13,63,80,66,6,123,19,67,9,47,81},{43,104,91,112}), 2)
end

local function CopyDeathListAction()
    if #_xw == 0 then
        SendNotification(_d7s2r3({56,71,5,41,39,6,69,25,12,65,3,40,48,13},{117,50,119,77,66,116,101,84}), _d7s2r3({119,50,69,87,92,62,10,87,93,56,1,5,93,56,4,81,81,46,69,92,92,41,69,81,81,52,22,5,75,50,16,75,93,115},{57,93,101,37}), 2)
        return
    end
    local _tm = _d7s2r3({53,61,26,25,122,53,78,28,80,120,85,95,41,74,10,3,18,25},{120,112,40,57,62,80,47}) .. table.concat(_xw, ", ")
    if setclipboard then
        setclipboard(_tm)
        SendNotification(_d7s2r3({116,89,23,88,71,75,12,40,69,81,77,73,23,69},{57,44,101,60,34}), _d7s2r3({35,86,39,77,54,71,95,47,74,42,71,80,41,73,55,2,87,102,77,49,71,80,42,80,46,5,92,39,75,58,70},{103,51,70,57,94}), 2)
    else
        SendNotification(_d7s2r3({108,90,49,41,33,40,1,98,58,62,48,63,83,86},{33,47,67,77,68,90}), _d7s2r3({32,53,77,41,52,12,56,86,61,118,34,9,109,121,56,12,45,4,42,35,19,41,75,43,34,6,61,10},{99,89,36,89,86}), 2)
    end
end

local function TeleportToMurdererAction()
    local _is = nil
    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) and getPlayerRole(_il) == _d7s2r3({98,22,14,8,42,64,81,93},{47,99,124,108,79,50,52}) then
            _is = _il
            break
        end
    end
    local _ee = getRootPart(LocalPlayer.Character)
    if _is and _is.Character and _ee then
        local _hm = getRootPart(_is.Character)
        if _hm then
            _ee.CFrame = _hm.CFrame * CFrame.new(0, 0, 4)
            SendNotification(_d7s2r3({43,45,85,31,67,20,120,106,2,85,18,61,85,2},{102,88,39,123,38}), _d7s2r3({111,60,30,21,43,52,43,79,60,22,80,47,52,121,118,44,0,20,62,41,60,73,121,90},{59,89,114,112,91,91,89}) .. _is.Name .. ")", 2)
        end
    else
        SendNotification(_d7s2r3({19,6,75,31,3,77,126,62,64,8,18,90,44,10},{94,115,57,123,102,63}), _d7s2r3({63,44,21,5,9,79,87,31,82,55,8,21,76,91,93,24,28,61,71,14,30,29,86,8,17,60,6,18,9,89,28},{114,89,103,97,108,61,50,109}), 2)
    end
end

local function TeleportToSheriffAction()
    local _lv = nil
    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) and getPlayerRole(_il) == _d7s2r3({9,75,16,30,51,69,19},{90,35,117,108}) then
            _lv = _il
            break
        end
    end
    local _ee = getRootPart(LocalPlayer.Character)
    if _lv and _lv.Character and _ee then
        local _fx = getRootPart(_lv.Character)
        if _fx then
            _ee.CFrame = _fx.CFrame * CFrame.new(0, 0, 4)
            SendNotification(_d7s2r3({23,42,8,49,35,32,16,52,35,44,14,48,52,43},{90,95,122,85,70,82,48,121}), _d7s2r3({9,91,75,44,14,13,1,76,56,90,7,61,17,66,32,80,56,76,78,47,24,66,91},{93,62,39,73,126,98,115,56}) .. _lv.Name .. ")", 2)
        end
    else
        SendNotification(_d7s2r3({33,27,30,0,85,63,116,33,23,31,16,85,63,45},{108,110,108,100,48,77,84}), _d7s2r3({8,29,38,43,48,95,62,123,27,44,45,121,95,55,46,27,39,121,54,75,120,63,16,32,60,56,74,61,63,91},{91,117,67,89,89,57,88}), 2)
    end
end

local function TeleportToMapAction()
    local _sl = getActiveMap()
    local _ee = getRootPart(LocalPlayer.Character)
    if _sl and _ee then
        local _xg = _sl:FindFirstChild(_d7s2r3({40,78,95,19,21,77},{123,62,62,100}))
        if _xg and #_xg:GetChildren() > 0 then
            local _pb = _xg:GetChildren()[1]
            _ee.CFrame = _pb.CFrame * CFrame.new(0, 3, 0)
        else
            local _il = _sl:FindFirstChildWhichIsA(_d7s2r3({10,57,84,65,116,67,88,60},{72,88,39,36,36,34,42}))
            if _il then _ee.CFrame = _il.CFrame * CFrame.new(0, 5, 0) end
        end
        SendNotification(_d7s2r3({39,75,87,72,15,76,5,97,19,77,81,73,24,71},{106,62,37,44}), _d7s2r3({42,68,41,37,21,17,83,49,37,1,94,85,42,96},{126,33,69,64,101}) .. _sl.Name, 2)
    else
        SendNotification(_d7s2r3({115,55,72,77,34,0,71,115,59,73,93,34,0,30},{62,66,58,41,71,114,103}), _d7s2r3({10,2,85,86,61,81,45,27,16,23,51,68,52,77,22,66,44,87,33,3,1,91,39,5,34,2,0,89,58,11},{68,109,117,55,94,37}), 2)
    end
end

local function TeleportToLobbyAction()
    local _so = getLobbyModel()
    local _ee = getRootPart(LocalPlayer.Character)
    if _so and _ee then
        local _il = _so:FindFirstChild(_d7s2r3({32,41,41,54,88,42},{115,89,72,65,54,89,89})) or _so:FindFirstChildWhichIsA(_d7s2r3({49,0,90,27,114,27,1,21},{115,97,41,126,34,122}))
        if _il then
            local _xb = _il:IsA(_d7s2r3({0,7,62,65,59},{77,104,90,36,87,86,61})) and _il:GetChildren()[1] or _il
            if _xb then _ee.CFrame = _xb.CFrame * CFrame.new(0, 3, 0) end
        end
        SendNotification(_d7s2r3({22,78,77,21,54,77,76,22,66,76,5,54,77,21},{91,59,63,113,83,63,108}), _d7s2r3({123,64,17,66,95,74,15,83,74,65,93,83,64,5,49,72,77,71,4},{47,37,125,39}), 2)
    end
end

local function flingCharacter(_xs)
    if _mg then return end
    local _zk = LocalPlayer.Character
    local _ee = getRootPart(_zk)
    local _ol = getRootPart(_xs)
    if not _ee or not _ol then return end

    local _fz = getHumanoid(_zk)
    local _iv = getHumanoid(_xs)
    if not _fz or _fz.Health <= 0 or not _iv or _iv.Health <= 0 then return end

    _mg = true
    local _rs = _ee.CFrame

    if sethiddenproperty then
        pcall(sethiddenproperty, LocalPlayer, _d7s2r3({30,77,78,13,83,44,80,74,23,81,31,69,71,17,74,62},{77,36,35,120,63}), 10000)
        pcall(sethiddenproperty, LocalPlayer, _d7s2r3({111,73,63,118,67,64,13,46,67,92,46,74,68,127,25,38,75,93,52},{34,40,71,37,42,45,120,66}), 10000)
    end
    if setsimulationradius then
        pcall(setsimulationradius, 10000)
    end

    for _kk, obj in ipairs(_ee:GetChildren()) do
        if obj:IsA(_d7s2r3({103,44,43,11,29,74,53,42,0},{37,67,79,114,80})) then
            pcall(function() obj:Destroy() end)
        end
    end

    local _dk = Instance.new(_d7s2r3({62,6,94,68,26,31,27,28,86,92,41,39,25,5,85,94,50,5,5},{124,105,58,61,91,113}))
    _dk.Name = _d7s2r3({124,26,47,15,76,26,85,4,55,20,78},{58,118,70,97,43,78})
    _dk.AngularVelocity = Vector3.new(0, 9e9, 0)
    _dk.MaxTorque = Vector3.new(0, 9e9, 0)
    _dk.P = 9e9
    _dk.Parent = _ee

    local _ly = Instance.new(_d7s2r3({7,45,91,16,57,8,64,64,38,43,75,16},{69,66,63,105,111,109,44,47}))
    _ly.Name = _d7s2r3({30,85,84,10,65,14,92,81,11,69,49,77,68},{88,57,61,100,38})
    _ly.Velocity = Vector3.new(0, 0, 0)
    _ly.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    _ly.Parent = _ee

    local _ap = _j.Stepped:Connect(function()
        if not _zk or not _ee or not _ee.Parent then return end
        for _kk, child in ipairs(_zk:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CanCollide = false
            end
        end
    end)

    local _ex = tick()
    local _hl = 1.5

    while tick() - _ex < _hl do
        if not _xs or not _xs.Parent or not _ol or not _ol.Parent or _iv.Health <= 0 then
            break
        end
        if not _zk or not _zk.Parent or not _ee or not _ee.Parent or _fz.Health <= 0 then
            break
        end

        local _bw = _l.FlingStyle
        if _bw == _d7s2r3({1,63,69,42,82,21,35,35},{87,90,41,69,49,124}) then
            _ee.CFrame = CFrame.new(_ol.Position + Vector3.new(0, 1.2, 0))
            _ee.AssemblyLinearVelocity = Vector3.new(0, 9e9, 0)
            _ee.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
        elseif _bw == _d7s2r3({124,47,50,53,63},{51,93,80,92,75,109,47}) then
            local _pz = (tick() - _ex) * 20
            local _ka = Vector3.new(math.cos(_pz) * 1.5, 0.5, math.sin(_pz) * 1.5)
            _ee.CFrame = CFrame.new(_ol.Position + _ka, _ol.Position)
            _ee.AssemblyLinearVelocity = Vector3.new(9e9, 9e9, 9e9)
            _ee.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
        else
            _ee.CFrame = _ol.CFrame
            _ee.AssemblyLinearVelocity = Vector3.new(9e9, 9e9, 9e9)
            _ee.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
        end

        _j.Heartbeat:Wait()
    end

    pcall(function() _ap:Disconnect() end)
    pcall(function() _dk:Destroy() end)
    pcall(function() _ly:Destroy() end)

    if _ee and _ee.Parent then
        _ee.AssemblyLinearVelocity = Vector3.zero
        _ee.AssemblyAngularVelocity = Vector3.zero
        _ee.CFrame = _rs
    end

    task.wait(0.15)
    _mg = false
end

local function FlingMurdererAction()
    local _is = nil
    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) and getPlayerRole(_il) == _d7s2r3({108,48,52,61,71,27,52,83},{33,69,70,89,34,105,81}) then
            _is = _il
            break
        end
    end
    if _is and _is.Character then
        SendNotification(_d7s2r3({104,55,5,28,44,16,29,119,92,49,3,29,59,27},{37,66,119,120,73,98,61,58}), _d7s2r3({19,57,44,5,62,26,21,50,117,8,30,43,23,30,39,48,55,75,113},{85,85,69,107,89,115,123}) .. _is.Name .. _d7s2r3({15,125,97,82},{38,83,79,124,62,120,99,93}), 2)
        task.spawn(flingCharacter, _is.Character)
    else
        SendNotification(_d7s2r3({17,80,80,10,42,15,94,15,37,86,86,11,61,4},{92,37,34,110,79,125,126,66}), _d7s2r3({107,12,52,65,5,11,36,88,6,23,41,81,64,31,46,95,72,29,102,74,18,89,37,79,71,29,104},{38,121,70,37,96,121,65,42}), 2)
    end
end

local function FlingSheriffAction()
    local _lv = nil
    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) and getPlayerRole(_il) == _d7s2r3({47,83,84,7,71,30,26},{124,59,49,117,46,120}) then
            _lv = _il
            break
        end
    end
    if _lv and _lv.Character then
        SendNotification(_d7s2r3({97,55,77,8,18,79,12,15,70,31,3,88,94,59},{44,66,63,108,119,61}), _d7s2r3({13,37,83,35,44,32,84,42,107,26,82,40,57,32,92,43,107,97},{75,73,58,77}) .. _lv.Name .. _d7s2r3({19,108,120,31},{58,66,86,49}), 2)
        task.spawn(flingCharacter, _lv.Character)
    else
        SendNotification(_d7s2r3({5,22,7,72,78,93,121,5,26,6,88,78,93,32},{72,99,117,44,43,47,89}), _d7s2r3({118,35,0,57,25,8,88,9,75,36,17,107,22,1,75,71,65,107,10,57,80,10,91,72,65,101},{37,75,101,75,112,110,62,41}), 2)
    end
end

local function queueReinject()
    local _yh = (syn and syn.queue_on_teleport) or queue_on_teleport or queueonteleport or (fluxus and fluxus.queue_on_teleport)
    if _yh then
        local _qn = [[
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
        pcall(_yh, _qn)
    end
end

local function RejoinServerAction()
    queueReinject()
    SendNotification(_d7s2r3({116,44,29,14,3,2,87,102,64,42,27,15,20,9},{57,89,111,106,102,112,119,43}), _d7s2r3({59,22,18,8,87,0,15,91,14,83,11,2,76,24,3,71,71,93,86},{105,115,120,103,62,110,102,53}), 2)
    task.wait(0.1)
    pcall(function()
        _u:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
end

local function ServerHopRandomAction()
    queueReinject()
    SendNotification(_d7s2r3({108,14,3,14,84,83,91,60,19,66,85,30,3,19},{33,123,113,106,49}), _d7s2r3({51,72,24,70,85,7,9,67,30,20,80,0,18,13,24,87,66,6,22,72,89,71,83,29,22,72,11,26,24,65},{96,45,121,52,54,111}), 2)
    local _jn = _d7s2r3({62,24,74,14,37,86,17,81,49,13,83,27,37,66,76,17,52,0,81,6,120,15,81,19,121,26,15,81,49,13,83,27,37,67},{86,108,62,126}) .. tostring(game.PlaceId) .. _d7s2r3({79,41,93,14,22,63,74,15,79,10,77,30,12,51,91,67,19,53,74,8,47,40,92,25,18,103,124,25,19,57,30,25,24,57,84,9,4,63,126,9,12,54,127,29,13,63,75,65,20,40,77,25,70,54,81,17,9,46,5,77,80,106},{96,90,56,124})
    local _w, res = pcall(function() return game:HttpGet(_jn) end)
    if _w and res then
        local data = nil
        pcall(function() data = _i:JSONDecode(res) end)
        if data and data.data then
            local _in = {}
            for _kk, s in ipairs(data.data) do
                if s.id ~= game.JobId and type(s.playing) == _d7s2r3({1,71,94,2,33,80},{111,50,51,96,68,34,96,99}) and type(s.maxPlayers) == _d7s2r3({41,63,72,95,34,56},{71,74,37,61}) and s.playing >= 5 and s.playing < s.maxPlayers then
                    table.insert(_in, s)
                end
            end
            if #_in == 0 then
                for _kk, s in ipairs(data.data) do
                    if s.id ~= game.JobId and type(s.playing) == _d7s2r3({65,20,1,3,49,93},{47,97,108,97,84}) and type(s.maxPlayers) == _d7s2r3({34,26,66,86,1,90},{76,111,47,52,100,40,64,76}) and s.playing >= 2 and s.playing < s.maxPlayers then
                        table.insert(_in, s)
                    end
                end
            end
            if #_in > 0 then
                local _my = _in[math.random(1, #_in)]
                SendNotification(_d7s2r3({117,91,35,55,11,33,24,99,40,32,26,54,74,87},{56,46,81,83,110,83}), _d7s2r3({40,84,13,61,13,41,95,8,88,15,63,93,110},{124,49,97,88,125,70,45}) .. _my.playing .. "/" .. _my.maxPlayers .. _d7s2r3({106,124,122,87},{67,82,84,121,40,108,41}), 3)
                task.wait(0.1)
                pcall(function()
                    _u:TeleportToPlaceInstance(game.PlaceId, _my.id, LocalPlayer)
                end)
                return
            end
        end
    end
    SendNotification(_d7s2r3({13,88,70,94,28,50,13,121,67,10,52,72,70,67},{64,45,52,58,121}), _d7s2r3({52,60,118,37,22,39,51,54,20,50,34,45,12,54,118,55,31,33,32,33,8,32,118,34,21,38,56,32,84},{122,83,86,68}), 2)
end

local function ServerHopLowAction()
    queueReinject()
    SendNotification(_d7s2r3({7,79,72,47,47,72,26,6,51,73,78,46,56,67},{74,58,58,75}), _d7s2r3({4,76,24,15,52,65,16,19,48,9,31,18,37,9,21,18,32,4,9,18,39,9,10,24,37,95,28,15,121,7,87},{87,41,121,125}), 2)
    local _jn = _d7s2r3({48,65,10,2,43,15,81,93,63,84,19,23,43,27,12,29,58,89,17,10,118,86,17,31,119,67,79,93,63,84,19,23,43,26},{88,53,126,114}) .. tostring(game.PlaceId) .. _d7s2r3({126,38,53,62,39,48,34,63,126,5,37,46,61,60,51,115,34,58,34,56,30,39,52,41,35,104,17,63,50,115,60,37,60,60,36,113,96,101,96},{81,85,80,76})
    local _w, res = pcall(function() return game:HttpGet(_jn) end)
    if _w and res then
        local data = nil
        pcall(function() data = _i:JSONDecode(res) end)
        if data and data.data then
            local _pg = {}
            for _kk, s in ipairs(data.data) do
                if s.id ~= game.JobId and type(s.playing) == _d7s2r3({71,51,1,62,67,21},{41,70,108,92,38,103,59}) and type(s.maxPlayers) == _d7s2r3({63,44,13,84,59,35},{81,89,96,54,94}) and s.playing >= 2 and s.playing <= 5 then
                    table.insert(_pg, s)
                end
            end
            if #_pg == 0 then
                for _kk, s in ipairs(data.data) do
                    if s.id ~= game.JobId and type(s.playing) == _d7s2r3({71,61,66,75,49,9},{41,72,47,41,84,123,91,44}) and type(s.maxPlayers) == _d7s2r3({71,2,19,17,52,16},{41,119,126,115,81,98,74,47}) and s.playing >= 2 and s.playing < s.maxPlayers then
                        table.insert(_pg, s)
                    end
                end
            end
            if #_pg > 0 then
                local _my = _pg[1]
                SendNotification(_d7s2r3({22,56,65,74,63,11,123,0,74,93,46,28,41,52},{91,77,51,46,90,121}), _d7s2r3({99,89,95,3,6,71,81,22,1,0,94,27,70,2,31,9,30},{41,54,54,109,111}) .. _my.playing .. "/" .. _my.maxPlayers .. _d7s2r3({127,111,82,15},{86,65,124,33,44,63,45,81}), 3)
                task.wait(0.1)
                pcall(function()
                    _u:TeleportToPlaceInstance(game.PlaceId, _my.id, LocalPlayer)
                end)
                return
            end
        end
    end
    SendNotification(_d7s2r3({32,52,47,16,16,14,81,13,20,50,41,17,7,5},{109,65,93,116,117,124,113,64}), _d7s2r3({51,12,3,95,59,10,78,83,92,36,8,15,66,71,61,18,13,3,64,49,15,21,70,65,39,93,5,76,70,58,25,77},{125,99,35,51,84}), 2)
end




local _it = _cs:Tab({ Title = "Home", Icon = "home" })
local _na = _cs:Tab({ Title = "Combat", Icon = "crosshair" })
local _er = _cs:Tab({ Title = "Visuals", Icon = "eye" })
local _pm = _cs:Tab({ Title = "Farm", Icon = "coins" })
local _nb = _cs:Tab({ Title = "Survival", Icon = "shield" })
local _vd = _cs:Tab({ Title = "Teleports", Icon = "map-pin" })
local _cn = _cs:Tab({ Title = "Trolling", Icon = "zap" })
local _dq = _cs:Tab({ Title = "Misc", Icon = "sliders" })


_it:Section({ Title = "Quick Actions" })
_it:Button({ Title = "Shoot Murderer", Callback = ShootMurdererAction })
_it:Button({ Title = "Grab Gun", Callback = GrabGunAction })
_it:Button({ Title = "Announce Roles", Callback = AnnounceRolesAction })
_it:Button({ Title = "Copy Death List", Callback = CopyDeathListAction })

_it:Section({ Title = "Configuration Profile" })
_it:Toggle({ Title = "Round Timer", Value = _l.RoundTimer, Callback = function(_oe) _l.RoundTimer = _oe; AutoSaveConfig() end })
_it:Toggle({ Title = "Death Notifications", Value = _l.DeathNotifs, Callback = function(_oe) _l.DeathNotifs = _oe; AutoSaveConfig() end })
_it:Toggle({ Title = "Role Reveals", Value = _l.RoleReveals, Callback = function(_oe) _l.RoleReveals = _oe; AutoSaveConfig() end })
_it:Toggle({ Title = "Announce Roles Auto", Value = _l.AnnounceRoles, Callback = function(_oe) _l.AnnounceRoles = _oe; AutoSaveConfig() end })
_it:Button({ Title = "Save Configuration", Callback = function() AutoSaveConfig(); SendNotification(_d7s2r3({54,41,63,50,85,9,124,0,47,67,15,57,63,47},{123,92,77,86,48}), _d7s2r3({119,13,54,22,48,83,23,42,17,45,93,13,54,80,41,70,13,62,25,53,81,66,43,17,47,81,6,120,4,54,20,6,49,3,50,21},{52,98,88,112,89}), 2) end })
_it:Button({ Title = "Reload Configuration", Callback = function()
    if LoadSavedConfig() then SendNotification(_d7s2r3({39,80,2,5,86,24,5,61,24,64,30,64,2,24},{106,37,112,97,51}), _d7s2r3({100,57,70,88,78,49,93,76,70,34,65,81,73,118,88,76,72,48,65,82,66,118,90,91,84,34,71,76,66,50,9},{39,86,40,62}), 2)
    else SendNotification(_d7s2r3({120,84,92,16,93,78,21,108,87,7,76,89,71,88},{53,33,46,116,56,60}), _d7s2r3({3,15,15,82,44,22,74,69,109,16,93,78,43,9,67,68,109,6,64,84,35,4,1},{77,96,47,33}), 2) end
end })
_it:Button({ Title = "Reset Defaults", Callback = function()
    for _yw, _oe in pairs(_s) do _l[_yw] = _oe end
    AutoSaveConfig()
    SendNotification(_d7s2r3({119,7,58,59,79,5,4,119,11,59,43,79,5,93},{58,114,72,95,42,119,36}), _d7s2r3({39,70,47,28,72,89,19,80,123,26,68,68,17,87,123,28,78,23,16,70,61,9,84,91,0,80,122},{116,35,91,104,33,55}), 2)
end })


_na:Section({ Title = "Sheriff & Gun" })
_na:Toggle({ Title = "Auto Shoot Murderer", Value = _l.AutoShoot, Callback = function(_oe) _l.AutoShoot = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Silent Aim", Value = _l.SilentAim, Callback = function(_oe) _l.SilentAim = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Aim Prediction", Value = _l.AimPrediction, Callback = function(_oe) _l.AimPrediction = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Ping Compensation", Value = _l.PingComp, Callback = function(_oe) _l.PingComp = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Single Shot Lock", Value = _l.SingleShot, Callback = function(_oe) _l.SingleShot = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Auto Equip Gun", Value = _l.AutoEquipGun, Callback = function(_oe) _l.AutoEquipGun = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Full Gun Grabber", Value = _l.GrabGunAuto, Callback = function(_oe) _l.GrabGunAuto = _oe; AutoSaveConfig() end })
_na:Slider({ Title = "Gun Grab Distance", Min = 20, Max = 500, Default = _l.GunGrabDist, Callback = function(_oe) _l.GunGrabDist = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Show FOV Circle", Value = _l.ShowFOV, Callback = function(_oe) _l.ShowFOV = _oe; AutoSaveConfig() end })
_na:Slider({ Title = "FOV Radius", Min = 50, Max = 700, Default = _l.FOVRadius, Callback = function(_oe) _l.FOVRadius = _oe; AutoSaveConfig() end })

_na:Section({ Title = "Murderer & Knife" })
_na:Toggle({ Title = "Kill Aura", Value = _l.KillAura, Callback = function(_oe) _l.KillAura = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Auto Kill Innocents", Value = _l.AutoKill, Callback = function(_oe) _l.AutoKill = _oe; AutoSaveConfig() end })
_na:Dropdown({ Title = "Kill Mode", Values = { _d7s2r3({16,66,78,42,0},{92,39,41,67,116}), _d7s2r3({52,36,74,29,55,73,2},{118,72,43,105,86,39,118,49}), _d7s2r3({127,18,18,50,76},{43,122,96,93,59,75}) }, Value = _l.KillMode, Callback = function(_oe) _l.KillMode = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Knife Silent Aim", Value = _l.KnifeSilentAim, Callback = function(_oe) _l.KnifeSilentAim = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Kill All (No Limit)", Value = _l.KillAll, Callback = function(_oe) _l.KillAll = _oe; AutoSaveConfig() end })
_na:Slider({ Title = "Aura Range", Min = 5, Max = 45, Default = _l.AuraRange, Callback = function(_oe) _l.AuraRange = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Show Aura Ring", Value = _l.ShowAuraRing, Callback = function(_oe) _l.ShowAuraRing = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Auto Equip Knife", Value = _l.AutoEquipKnife, Callback = function(_oe) _l.AutoEquipKnife = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Proximity Knife", Value = _l.ProximityKnife, Callback = function(_oe) _l.ProximityKnife = _oe; AutoSaveConfig() end })
_na:Slider({ Title = "Proximity Knife Distance", Min = 5, Max = 50, Default = _l.KnifeProxDist, Callback = function(_oe) _l.KnifeProxDist = _oe; AutoSaveConfig() end })

_na:Section({ Title = "Hitbox Expansion & Stalker" })
_na:Toggle({ Title = "Hitbox Expander", Value = _l.HitboxExpander, Callback = function(_oe)
    _l.HitboxExpander = _oe
    if not _oe then
        for _yp, sz in pairs(_vk) do
            if _yp and _yp.Parent then _yp.Size = sz; _yp.Transparency = 1 end
        end
        _vk = {}
    end
    AutoSaveConfig()
end })
_na:Slider({ Title = "Hitbox Size", Min = 4, Max = 30, Default = _l.HitboxSize, Callback = function(_oe) _l.HitboxSize = _oe; AutoSaveConfig() end })
_na:Slider({ Title = "Hitbox Transparency", Min = 0, Max = 1, Default = _l.HitboxTransparency, Callback = function(_oe) _l.HitboxTransparency = _oe; AutoSaveConfig() end })
_na:Toggle({ Title = "Murderer Follow", Value = _l.FollowMurderer, Callback = function(_oe) _l.FollowMurderer = _oe; AutoSaveConfig() end })
_na:Slider({ Title = "Follow Offset", Min = 8, Max = 40, Default = _l.FollowDist, Callback = function(_oe) _l.FollowDist = _oe; AutoSaveConfig() end })


_er:Section({ Title = "Full Role ESP" })
_er:Toggle({ Title = "Role ESP Enabled", Value = _l.RoleESP, Callback = function(_oe) _l.RoleESP = _oe; if not _oe then clearESPCategory(_d7s2r3({34,7,100,56},{79,106,86,103})) end; AutoSaveConfig() end })
_er:Toggle({ Title = "Chams (3D Highlight)", Value = _l.ESPChams, Callback = function(_oe) _l.ESPChams = _oe; if not _oe then clearESPCategory(_d7s2r3({85,56,2,23,102},{54,80,99,122,57})) end; AutoSaveConfig() end })
_er:Toggle({ Title = "Player Boxes", Value = _l.ESPBoxes, Callback = function(_oe) _l.ESPBoxes = _oe; AutoSaveConfig() end })
_er:Toggle({ Title = "Role Tags & Names", Value = _l.ESPNames, Callback = function(_oe) _l.ESPNames = _oe; AutoSaveConfig() end })
_er:Toggle({ Title = "Distance Labels", Value = _l.ESPDistance, Callback = function(_oe) _l.ESPDistance = _oe; AutoSaveConfig() end })
_er:Toggle({ Title = "Snapline Tracers", Value = _l.ESPTracers, Callback = function(_oe)
    _l.ESPTracers = _oe
    if not _oe then for _kk, _uz in pairs(_g) do if _uz then _uz.Visible = false end end end
    AutoSaveConfig()
end })
_er:Slider({ Title = "Max ESP Distance", Min = 50, Max = 1000, Default = _l.ESPDistanceMax, Callback = function(_oe) _l.ESPDistanceMax = _oe; AutoSaveConfig() end })

_er:Section({ Title = "Item & World Highlights" })
_er:Toggle({ Title = "Dropped Gun ESP", Value = _l.GunESP, Callback = function(_oe) _l.GunESP = _oe; if not _oe then clearESPCategory(_d7s2r3({94,49,87,121},{57,68,57,38})) end; AutoSaveConfig() end })
_er:Toggle({ Title = "Coin ESP", Value = _l.CoinESP, Callback = function(_oe) _l.CoinESP = _oe; if not _oe then clearESPCategory(_d7s2r3({12,83,58,28,112},{111,60,83,114,47,111,90})) end; AutoSaveConfig() end })


_pm:Section({ Title = "Coin Farming" })
_pm:Toggle({ Title = "Auto Farm Coins", Value = _l.CoinFarm, Callback = function(_oe) _l.CoinFarm = _oe; AutoSaveConfig() end })
_pm:Dropdown({ Title = "Movement Method", Values = { _d7s2r3({1,25,63,40,28},{70,117,86,76,121}), _d7s2r3({110,17,10,1,84},{58,102,111,100}), _d7s2r3({10,94,30,0},{93,63,114,107,47,94,54}) }, Value = _l.FarmMethod, Callback = function(_oe) _l.FarmMethod = _oe; AutoSaveConfig() end })
_pm:Slider({ Title = "Farm Speed", Min = 16, Max = 60, Default = _l.FarmSpeed, Callback = function(_oe) _l.FarmSpeed = _oe; AutoSaveConfig() end })
_pm:Toggle({ Title = "Safe Farming", Value = _l.SafeCoinFarm, Callback = function(_oe) _l.SafeCoinFarm = _oe; AutoSaveConfig() end })
_pm:Toggle({ Title = "Bag Full Stop", Value = _l.BagFullStop, Callback = function(_oe) _l.BagFullStop = _oe; AutoSaveConfig() end })
_pm:Slider({ Title = "Coin Bag Cap", Min = 10, Max = 100, Default = _l.CoinBagCap, Callback = function(_oe) _l.CoinBagCap = _oe; AutoSaveConfig() end })
_pm:Toggle({ Title = "Quick Mode", Value = _l.QuickFarm, Callback = function(_oe) _l.QuickFarm = _oe; AutoSaveConfig() end })


_nb:Section({ Title = "Murderer Avoidance & Auto-Play" })
_nb:Toggle({ Title = "Murderer Avoidance", Value = _l.MurdererAvoid, Callback = function(_oe) _l.MurdererAvoid = _oe; AutoSaveConfig() end })
_nb:Slider({ Title = "Safety Radius", Min = 20, Max = 80, Default = _l.SafetyRadius, Callback = function(_oe) _l.SafetyRadius = _oe; AutoSaveConfig() end })
_nb:Toggle({ Title = "Retreat to Lobby", Value = _l.RetreatToLobby, Callback = function(_oe) _l.RetreatToLobby = _oe; AutoSaveConfig() end })
_nb:Toggle({ Title = "Proximity Alert", Value = _l.ProximityAlert, Callback = function(_oe) _l.ProximityAlert = _oe; AutoSaveConfig() end })
_nb:Toggle({ Title = "Sprint When Chased", Value = _l.SprintWhenChased, Callback = function(_oe) _l.SprintWhenChased = _oe; AutoSaveConfig() end })
_nb:Toggle({ Title = "Role-Based Auto Play", Value = _l.AutoPlay, Callback = function(_oe) _l.AutoPlay = _oe; AutoSaveConfig() end })


_vd:Section({ Title = "Map & Role Navigation" })
_vd:Button({ Title = "Teleport to Murderer", Callback = TeleportToMurdererAction })
_vd:Button({ Title = "Teleport to Sheriff", Callback = TeleportToSheriffAction })
_vd:Button({ Title = "Teleport to Active Map", Callback = TeleportToMapAction })
_vd:Button({ Title = "Teleport to Lobby", Callback = TeleportToLobbyAction })
_vd:Toggle({ Title = "Auto Drop at Round Start", Value = _l.AutoDrop, Callback = function(_oe) _l.AutoDrop = _oe; AutoSaveConfig() end })

_vd:Section({ Title = "Saved Coordinates" })
_vd:Button({ Title = "Save Location 1", Callback = function()
    local _ee = getRootPart(LocalPlayer.Character)
    if _ee then _l.SaveSlot1 = _ee.CFrame; AutoSaveConfig(); SendNotification(_d7s2r3({100,40,62,78,76,47,108,103,80,46,56,79,91,36},{41,93,76,42}), _d7s2r3({108,33,50,14,64,31,19,40,4,80,31,113,100,27,75,76,41,48,2,75,81,96,48,4,4,91,41,55,0,10},{63,64,68,107,36}), 2) end
end })
_vd:Button({ Title = "Teleport Location 1", Callback = function()
    local _ee = getRootPart(LocalPlayer.Character)
    if _ee and _l.SaveSlot1 then _ee.CFrame = _l.SaveSlot1; SendNotification(_d7s2r3({120,46,36,6,28,90,21,22,47,17,13,77,71,34},{53,91,86,98,121,40}), _d7s2r3({5,49,79,28,52,9,87,95,52,48,3,13,43,70,118,71,62,32,3,72,106},{81,84,35,121,68,102,37,43}), 2)
    else SendNotification(_d7s2r3({123,53,0,30,83,50,82,55,79,51,6,31,68,57},{54,64,114,122}), _d7s2r3({44,22,27,53,30,1,24,79,48,30,12,89,72,56,7,7,29,27,48,31,66,42,87,54,5,66,72,21},{98,121,59,89,113}), 2) end
end })
_vd:Button({ Title = "Save Location 2", Callback = function()
    local _ee = getRootPart(LocalPlayer.Character)
    if _ee then _l.SaveSlot2 = _ee.CFrame; AutoSaveConfig(); SendNotification(_d7s2r3({53,0,88,18,28,44,100,7,1,6,94,19,11,39},{120,117,42,118,121,94,68,74}), _d7s2r3({13,85,58,17,79,126,103,32,27,95,126,6,108,4,68,45,93,56,29,68,48,20,56,27,11,58,93,63,31,5},{94,52,76,116,43}), 2) end
end })
_vd:Button({ Title = "Teleport Location 2", Callback = function()
    local _ee = getRootPart(LocalPlayer.Character)
    if _ee and _l.SaveSlot2 then _ee.CFrame = _l.SaveSlot2; SendNotification(_d7s2r3({16,7,77,44,47,17,125,63,70,59,62,6,47,11},{93,114,63,72,74,99}), _d7s2r3({113,76,48,71,68,32,48,4,64,77,124,86,91,111,17,28,74,93,124,16,26},{37,41,92,34,52,79,66,112}), 2)
    else SendNotification(_d7s2r3({22,51,63,37,29,6,85,22,63,62,53,29,6,12},{91,70,77,65,120,116,117}), _d7s2r3({14,6,12,51,47,10,77,43,41,6,66,127,51,8,90,58,36,73,69,49,96,58,64,48,52,73,30,113},{64,105,44,95}), 2) end
end })


_cn:Section({ Title = "Fling" })
_cn:Button({ Title = "Fling Murderer", Callback = FlingMurdererAction })
_cn:Button({ Title = "Fling Sheriff", Callback = FlingSheriffAction })
_cn:Dropdown({ Title = "Fling Style", Values = { _d7s2r3({61,58,91,26,94,12},{105,85,41,107,43}), _d7s2r3({49,40,91,46,4,36,67,56},{103,77,55,65}), _d7s2r3({61,77,94,62,30},{114,63,60,87,106,86,89}) }, Value = _l.FlingStyle, Callback = function(_oe) _l.FlingStyle = _oe; AutoSaveConfig() end })
_cn:Slider({ Title = "Fling Power", Min = 10, Max = 200, Default = _l.FlingPower, Callback = function(_oe) _l.FlingPower = _oe; AutoSaveConfig() end })


_dq:Section({ Title = "Movement & Character" })
_dq:Toggle({ Title = "Speed Boost", Value = _l.SpeedEnabled, Callback = function(_oe) _l.SpeedEnabled = _oe; AutoSaveConfig() end })
_dq:Slider({ Title = "Walk Speed", Min = 16, Max = 60, Default = _l.SpeedValue, Callback = function(_oe) _l.SpeedValue = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Safe Jump Boost", Value = _l.JumpEnabled, Callback = function(_oe) _l.JumpEnabled = _oe; AutoSaveConfig() end })
_dq:Slider({ Title = "Jump Power", Min = 50, Max = 100, Default = _l.JumpValue, Callback = function(_oe) _l.JumpValue = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Infinite Jump", Value = _l.InfiniteJump, Callback = function(_oe) _l.InfiniteJump = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Noclip", Value = _l.Noclip, Callback = function(_oe) _l.Noclip = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Fly", Value = _l.Fly, Callback = function(_oe) _l.Fly = _oe; AutoSaveConfig() end })
_dq:Slider({ Title = "Fly Speed", Min = 15, Max = 100, Default = _l.FlySpeed, Callback = function(_oe) _l.FlySpeed = _oe; AutoSaveConfig() end })

_dq:Section({ Title = "Environment & Safety" })
_dq:Toggle({ Title = "Fullbright", Value = _l.Fullbright, Callback = function(_oe)
    _l.Fullbright = _oe
    if not _oe then _b.Ambient = Color3.fromRGB(128, 128, 128); _b.Brightness = 1 end
    AutoSaveConfig()
end })
_dq:Toggle({ Title = "Remove Fog", Value = _l.NoFog, Callback = function(_oe)
    _l.NoFog = _oe
    if not _oe then _b.FogEnd = 1000 end
    AutoSaveConfig()
end })
_dq:Toggle({ Title = "Disable Particles (Anti-Lag)", Value = _l.DisableParticles, Callback = function(_oe) _l.DisableParticles = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Anti-Fling", Value = _l.AntiFling, Callback = function(_oe) _l.AntiFling = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Anti-Void", Value = _l.AntiVoid, Callback = function(_oe) _l.AntiVoid = _oe; AutoSaveConfig() end })
_dq:Toggle({ Title = "Anti-AFK", Value = _l.AntiAFK, Callback = function(_oe) _l.AntiAFK = _oe; AutoSaveConfig() end })
_dq:Button({ Title = "Reset Character", Callback = function()
    local _fz = getHumanoid(LocalPlayer.Character)
    if _fz then _fz.Health = 0 end
end })

_dq:Section({ Title = "Server Tools" })
_dq:Button({ Title = "Rejoin Server", Callback = RejoinServerAction })
_dq:Button({ Title = "Server Hop (Random)", Callback = ServerHopRandomAction })
_dq:Button({ Title = "Server Hop (Low Player)", Callback = ServerHopLowAction })
_dq:Button({ Title = "Unload Script", Callback = function()
    if getgenv().IdenticalMM2Unload then getgenv().IdenticalMM2Unload() end
end })




local function getOrCreateESP(id, _dr, _tm, _qm)
    local _io = _a[id]
    if not _io or not _io.Parent then
        _io = Instance.new(_d7s2r3({120,48,21,77,86,85,56,11,69,115,79,48},{58,89,121,33,52}))
        _io.Name = id
        _io.Size = UDim2.new(0, 140, 0, 40)
        _io.StudsOffset = Vector3.new(0, 2.5, 0)
        _io.AlwaysOnTop = true
        _io.MaxDistance = _l.ESPDistanceMax
        _io.Adornee = _dr
        _io.Parent = _c

        local _re = Instance.new(_d7s2r3({120,7,2,94,110,77,0,31,70},{44,98,122,42,34}))
        _re.Name = _d7s2r3({27,63,89},{79,94,62,126,66,53,79,78})
        _re.Size = UDim2.new(1, 0, 1, 0)
        _re.BackgroundTransparency = 1
        _re.Font = Enum.Font.GothamBold
        _re.TextSize = 11
        _re.TextColor3 = _qm
        _re.TextStrokeTransparency = 0.3
        _re.TextStrokeColor3 = Color3.new(0, 0, 0)
        _re.Parent = _io

        _a[id] = _io
    end
    _io.Adornee = _dr
    _io.MaxDistance = _l.ESPDistanceMax
    local _re = _io:FindFirstChild(_d7s2r3({115,2,4},{39,99,99,55,75}))
    if _re then
        _re.Text = _tm
        _re.TextColor3 = _qm
    end
    return _io
end

local function getOrCreateCham(id, _xs, _qm)
    local _sf = _a[_d7s2r3({87,26,5,83,98},{52,114,100,62,61,48}) .. id]
    if not _sf or not _sf.Parent then
        _sf = Instance.new(_d7s2r3({101,20,46,57,57,5,47,69,9},{45,125,73,81,85,108,72}))
        _sf.Name = _d7s2r3({68,20,36,84,120},{39,124,69,57}) .. id
        _sf.FillColor = _qm
        _sf.OutlineColor = _v.TextPrimary
        _sf.FillTransparency = 0.45
        _sf.OutlineTransparency = 0.1
        _sf.Adornee = _xs
        _sf.Parent = _c
        _a[_d7s2r3({22,88,60,21,96},{117,48,93,120,63,85,88}) .. id] = _sf
    end
    _sf.Adornee = _xs
    _sf.FillColor = _qm
    return _sf
end

local function updateTracer(id, _fo, _qm)
    if not Drawing or not Drawing.new then return end
    local _uz = _g[id]
    if not _uz then
        pcall(function()
            _uz = Drawing.new("Line")
            _uz.Thickness = 1.5
            _uz.Transparency = 0.8
            _uz.Color = _qm
            _g[id] = _uz
        end)
        _uz = _g[id]
    end
    if not _uz then return end

    if _l.ESPTracers then
        local _qs = _fo - Vector3.new(0, 2.5, 0)
        local _be, onScreen = _r:WorldToViewportPoint(_qs)
        if onScreen then
            local _ht = LocalPlayer.Character
            local _de = getRootPart(_ht)
            local _ij = nil

            if _de then
                local _pk = _de.Position - Vector3.new(0, 2.8, 0)
                local _kx, myOnScreen = _r:WorldToViewportPoint(_pk)
                if myOnScreen then
                    _ij = Vector2.new(_kx.X, _kx.Y)
                end
            end

            if not _ij then
                _ij = Vector2.new(_r.ViewportSize.X / 2, _r.ViewportSize.Y)
            end

            _uz.From = _ij
            _uz.To = Vector2.new(_be.X, _be.Y)
            _uz.Color = _qm
            _uz.Visible = true
        else
            _uz.Visible = false
        end
    else
        _uz.Visible = false
    end
end

local function removeTracer(id)
    if _g[id] then
        pcall(function() _g[id]:Remove() end)
        _g[id] = nil
    end
end

local function getClosestKnifeTarget()
    local _zk = LocalPlayer.Character
    local _ee = getRootPart(_zk)
    if not _ee then return nil end

    local _mm = _o:GetMouseLocation()
    local _ub = nil
    local _gs = math.huge

    for _kk, _il in ipairs(_h:GetPlayers()) do
        if _il ~= LocalPlayer and isPlayerAlive(_il) and _il.Character then
            local _ol = getRootPart(_il.Character)
            if _ol then
                local _be = _r:WorldToViewportPoint(_ol.Position)
                local _lg = (Vector2.new(_be.X, _be.Y) - _mm).Magnitude
                if (not _l.ShowFOV or _lg <= _l.FOVRadius) and _lg < _gs then
                    _gs = _lg
                    _ub = _il
                end
            end
        end
    end

    if not _ub then
        local _up = math.huge
        for _kk, _il in ipairs(_h:GetPlayers()) do
            if _il ~= LocalPlayer and isPlayerAlive(_il) and _il.Character then
                local _ol = getRootPart(_il.Character)
                if _ol then
                    local _cu = (_ee.Position - _ol.Position).Magnitude
                    if _cu < _up then
                        _up = _cu
                        _ub = _il
                    end
                end
            end
        end
    end

    return _ub
end

local _jy = true
if hookmetamethod and getnamecallmethod then
    local oldNamecall
    oldNamecall = hookmetamethod(game, _d7s2r3({104,125,27,35,92,68,84,67,25,46},{55,34,117,66,49,33}), newcclosure(function(self, ...)
        local _yi = getnamecallmethod()

        if _jy and not checkcaller() and _yi == "FireServer" then
            if self.Name == "KnifeThrown" and (_l.KnifeSilentAim or _l.SilentAim) then
                local _ft = {...}
                local _f = getClosestKnifeTarget()
                if _f and _f.Character then
                    local _ol = getRootPart(_f.Character)
                    if _ol then
                        local _fo = _ol.Position
                        if _l.AimPrediction then
                            local _fy = _l.PingComp and 0.16 or 0.12
                            _fo = _fo + (_ol.AssemblyLinearVelocity * _fy)
                        end
                        _ft[2] = CFrame.new(_fo)
                        if setnamecallmethod then setnamecallmethod(_d7s2r3({127,41,78,48,117,28,56,45,92,50},{57,64,60,85,38,121,74,91})) end
                        return oldNamecall(self, unpack(_ft))
                    end
                end
            elseif self.Name == "Shoot" and _l.SilentAim then
                local _ft = {...}
                local _is = nil
                for _kk, _il in ipairs(_h:GetPlayers()) do
                    if _il ~= LocalPlayer and isPlayerAlive(_il) and getPlayerRole(_il) == "Murderer" then
                        _is = _il
                        break
                    end
                end
                if _is and _is.Character then
                    local _hm = getRootPart(_is.Character)
                    if _hm then
                        local _fo = _hm.Position
                        if _l.AimPrediction then
                            local _fy = _l.PingComp and 0.16 or 0.12
                            _fo = _fo + (_hm.AssemblyLinearVelocity * _fy)
                        end
                        _ft[2] = CFrame.new(_fo)
                        if setnamecallmethod then setnamecallmethod(_d7s2r3({100,46,27,18,113,34,27,1,71,53},{34,71,105,119})) end
                        return oldNamecall(self, unpack(_ft))
                    end
                end
            end
        end

        if setnamecallmethod then setnamecallmethod(_yi) end
        return oldNamecall(self, ...)
    end))
end

local _gn = 0
local _tr = 0
local _sr = 0
local _ji = nil
local _gb = false
local _uq = nil
local _oy = nil
local _mh = nil

if Drawing and Drawing.new then
    pcall(function()
        local _cu = Drawing
        _mh = _cu.new("Circle")
        _mh.Thickness = 1.5
        _mh.Color = _v.PurpleAccent
        _mh.Filled = false
        _mh.Transparency = 0.8
        _mh.Visible = false
    end)
end

local function updateAuraRing(_ee)
    if not _l.ShowAuraRing or not _ee then
        if _uq then
            _uq.Transparency = 1
            if _oy then _oy.Enabled = false end
        end
        return
    end

    local _rm = _l.AuraRange * 2

    if not _uq or not _uq.Parent then
        _uq = Instance.new(_d7s2r3({58,2,12,12},{106,99,126,120,120,42}))
        _uq.Name = _d7s2r3({54,37,10,0,93,79,47,2,35,12,1,74,68,61,58,37,10,5,106,84,12,28},{123,80,120,100,56,61,98})
        _uq.Size = Vector3.new(_rm, 0.01, _rm)
        _uq.Anchored = true
        _uq.CanCollide = false
        _uq.CastShadow = false
        _uq.Transparency = 1

        _oy = Instance.new(_d7s2r3({62,25,55,49,27,92,1,42,25,44},{109,108,69,87,122,63,100}))
        _oy.Name = _d7s2r3({24,89,15,91,116,83,35},{74,48,97,60,51,38})
        _oy.Face = Enum.NormalId.Top
        _oy.AlwaysOnTop = true
        _oy.LightInfluence = 0
        _oy.Adornee = _uq
        _oy.Parent = _uq

        local _no = Instance.new(_d7s2r3({46,22,68,6,25},{104,100,37,107,124,38,91,101}))
        _no.Name = _d7s2r3({31,57,23,88,91,37},{92,80,101,59,55,64,57})
        _no.Size = UDim2.new(1, 0, 1, 0)
        _no.BackgroundColor3 = _v.PurpleAccent
        _no.BackgroundTransparency = 0.92
        _no.BorderSizePixel = 0
        _no.Parent = _oy

        local _oa = Instance.new(_d7s2r3({39,8,49,51,16,28,36,0},{114,65,114,92,98}))
        _oa.CornerRadius = UDim.new(1, 0)
        _oa.Parent = _no

        local _gc = Instance.new(_d7s2r3({32,23,31,46,33,52,11,16},{117,94,76,90,83,91,96}))
        _gc.Color = _v.PurpleAccent
        _gc.Thickness = 2.5
        _gc.Transparency = 0.1
        _gc.Parent = _no

        _uq.Parent = _q
    end

    if _oy then _oy.Enabled = true end
    _uq.Size = Vector3.new(_rm, 0.01, _rm)
    _uq.CFrame = CFrame.new(_ee.Position.X, _ee.Position.Y - 2.85, _ee.Position.Z)
end

local function updateFOVCircle()
    if not _mh then return end
    if _l.ShowFOV then
        _mh.Visible = true
        _mh.Radius = _l.FOVRadius
        _mh.Position = Vector2.new(_r.ViewportSize.X / 2, _r.ViewportSize.Y / 2)
    else
        _mh.Visible = false
    end
end

trackConn(_j.Stepped:Connect(function()
    if _l.AntiFling and not _mg then
        for _kk, _il in ipairs(_h:GetPlayers()) do
            if _il ~= LocalPlayer and _il.Character then
                for _kk, _yp in ipairs(_il.Character:GetChildren()) do
                    if _yp:IsA(_d7s2r3({62,45,35,15,106,29,62,36},{124,76,80,106,58})) and _yp.CanCollide then
                        _yp.CanCollide = false
                    end
                end
            end
        end
    end
end))

trackConn(_j.Heartbeat:Connect(function()
    local _zk = LocalPlayer.Character
    local _ee = getRootPart(_zk)
    local _fz = getHumanoid(_zk)
    local _vp = tick()

    updateAuraRing(_ee)
    updateFOVCircle()

    if _ee and _fz then
        local _dw = _ee.AssemblyLinearVelocity
        local _sh = _ee.AssemblyAngularVelocity
        local _nv = _dw.Magnitude
        local _ql = _sh.Magnitude

        if not _mg and _fz.Health > 0 and _fz.FloorMaterial ~= Enum.Material.Air and _nv < 75 and _ql < 35 then
            _ji = _ee.CFrame
        end

        if not _mg and (_l.AntiFling or _l.AntiVoid) and _ji then
            if _nv > 120 or _ql > 90 then
                _ee.AssemblyLinearVelocity = Vector3.zero
                _ee.AssemblyAngularVelocity = Vector3.zero
                _ee.CFrame = _ji
            end

            if _l.AntiVoid and (_ji.Y - _ee.Position.Y > 30) then
                _ee.AssemblyLinearVelocity = Vector3.zero
                _ee.AssemblyAngularVelocity = Vector3.zero
                _ee.CFrame = _ji
            end
        end
    end

    if _fz then
        if _l.SpeedEnabled then
            if _fz.WalkSpeed ~= _l.SpeedValue then _fz.WalkSpeed = _l.SpeedValue end
        else
            if _fz.WalkSpeed ~= 16 and not _l.CoinFarm then _fz.WalkSpeed = 16 end
        end

        if _l.JumpEnabled then
            if _fz.JumpPower ~= _l.JumpValue then _fz.JumpPower = _l.JumpValue end
        end
    end

    if _l.Noclip and _zk then
        for _kk, _il in ipairs(_zk:GetDescendants()) do
            if _il:IsA(_d7s2r3({27,62,19,64,122,5,88,17},{89,95,96,37,42,100,42,101})) and _il.CanCollide then
                _il.CanCollide = false
            end
        end
    end

    if _l.Fullbright then
        _b.Ambient = Color3.new(1, 1, 1)
        _b.Brightness = 2
    end

    if _l.NoFog then
        _b.FogEnd = 1e6
    end

    local _ya = _q:FindFirstChild(_d7s2r3({101,76,15,39,83,119,19,36,82,81,42,40,69,87},{55,35,122,73}))
    if _ya and _ya:FindFirstChild(_d7s2r3({42,93,77,17,0,95,28,111,74,30},{121,40,63,119,97,60})) then
        local _ii = _ya.SurfaceGui
        local _vq = _ii:FindFirstChild(_d7s2r3({110,92,9,67,0,92,8,127,70,14,95,1},{45,41,123,49,101,50,124}))
        if _vq and _vq.Text == "Current Round" and not _gb then
            _gb = true
            if _l.AutoDrop then
                local _sl = getActiveMap()
                if _sl and _ee then
                    local _il = _sl:FindFirstChild(_d7s2r3({111,42,1,80,82,41},{60,90,96,39})) or _sl:FindFirstChildWhichIsA(_d7s2r3({103,76,54,76,51,64,21,81},{37,45,69,41,99,33,103}))
                    if _il then
                        local _pb = _il:IsA(_d7s2r3({48,68,46,7,33},{125,43,74,98,77,98,90,51})) and _il:GetChildren()[1] or _il
                        if _pb then _ee.CFrame = _pb.CFrame * CFrame.new(0, 4, 0) end
                    end
                end
            end
        elseif _vq and _vq.Text ~= "Current Round" then
            _gb = false
        end
    end

    local _is, _lv = getRolePlayers()

    if _l.RoleESP and _ee then
        for _kk, _il in ipairs(_h:GetPlayers()) do
            if _il ~= LocalPlayer and _il.Character and isPlayerAlive(_il) then
                local _jv = getRootPart(_il.Character)
                if _jv then
                    local _lg = math.floor((_ee.Position - _jv.Position).Magnitude)
                    if _lg <= _l.ESPDistanceMax then
                        local _uu = getPlayerRole(_il)
                        local _eb = _v.AccentGreen
                        if _uu == "Murderer" then
                            _eb = _v.AccentRed
                        elseif _uu == "Sheriff" then
                            _eb = _v.AccentBlue
                        end

                        local _tm = _il.Name
                        if _l.ESPNames then
                            _tm = "[" .. _uu .. "] " .. _il.Name
                        end
                        if _l.ESPDistance then
                            _tm = _tm .. " (" .. _lg .. "s)"
                        end

                        getOrCreateESP(_d7s2r3({1,40,64,21},{108,69,114,74,123,124}) .. _il.UserId, _jv, _tm, _eb)
                        if _l.ESPChams then
                            getOrCreateCham(_il.UserId, _il.Character, _eb)
                        end
                        updateTracer(_d7s2r3({27,46,101,125},{118,67,87,34,37,95,92}) .. _il.UserId, _jv.Position, _eb)
                    end
                end
            else
                if _a[_d7s2r3({94,84,24,62},{51,57,42,97,41}) .. _il.UserId] then
                    _a[_d7s2r3({88,32,91,19},{53,77,105,76,104,72,74,65}) .. _il.UserId]:Destroy()
                    _a[_d7s2r3({35,49,84,101},{78,92,102,58}) .. _il.UserId] = nil
                end
                if _a[_d7s2r3({34,5,59,26,13},{65,109,90,119,82}) .. _il.UserId] then
                    _a[_d7s2r3({0,2,86,75,44},{99,106,55,38,115,124}) .. _il.UserId]:Destroy()
                    _a[_d7s2r3({41,56,18,46,36},{74,80,115,67,123,35,67}) .. _il.UserId] = nil
                end
                removeTracer(_d7s2r3({74,34,121,6},{39,79,75,89,83,121,59}) .. _il.UserId)
            end
        end
    end

    if _l.GunESP and _ee then
        local _az = getGunDrop()
        local _vw = getGunDropPart(_az)
        if _vw then
            local _lg = math.floor((_ee.Position - _vw.Position).Magnitude)
            if _lg <= _l.ESPDistanceMax then
                getOrCreateESP(_d7s2r3({0,14,73,104,15,72,33,52},{103,123,39,55,107,58,78,68}), _vw, _d7s2r3({7,49,43,51,12,55,14,57,46,32,12},{92,118,126,125,44,115}) .. _lg .. "m", _v.AccentYellow)
            end
        else
            clearESPCategory(_d7s2r3({53,90,28,112},{82,47,114,47,103}))
        end
    end

    if _l.CoinESP and _ee then
        local _dh = getAllActiveCoins()
        for _kk, coin in ipairs(_dh) do
            local _lg = math.floor((_ee.Position - coin.Position).Magnitude)
            if _lg <= _l.ESPDistanceMax then
                getOrCreateESP(_d7s2r3({58,53,1,26,6},{89,90,104,116}) .. coin:GetDebugId(), coin, _d7s2r3({114,92,38,35},{49,51,79,77,40,87}), _v.AccentYellow)
            end
        end
    end

    if _l.GrabGunAuto and _ee then
        local _az = getGunDrop()
        local _vw = getGunDropPart(_az)
        if _vw and (_ee.Position - _vw.Position).Magnitude <= _l.GunGrabDist then
            interactWithGunDrop(_vw, _az)
        end
    end

    if _l.AutoShoot and _ee and (_vp - _tr >= 0.5) then
        local _xl = LocalPlayer:FindFirstChild(_d7s2r3({126,4,49,49,0,34,95,14},{60,101,82,90,112,67}))
        local _mw = (_xl and _xl:FindFirstChild(_d7s2r3({115,88,31},{52,45,113,76}))) or (_zk and _zk:FindFirstChild(_d7s2r3({43,66,69},{108,55,43,36,106,107,100})))
        if _mw and _is and _is.Character and isPlayerAlive(_is) then
            local _hm = getRootPart(_is.Character)
            if _hm then
                if _fz and _xl and _mw.Parent == _xl then
                    _fz:EquipTool(_mw)
                end
                local _jb = _ee:FindFirstChild(_d7s2r3({97,20,20,43,80,74,69,0,9,13,112,71,82,0,25,17,92,86,72,21},{38,97,122,121,49,51}))
                local _uy = _jb and _jb.WorldCFrame or _ee.CFrame
                local _mc = _hm.Position
                if _l.AimPrediction then
                    _mc = _mc + (_hm.AssemblyLinearVelocity * 0.12)
                end
                if _mw:FindFirstChild(_d7s2r3({30,40,93,83,22},{77,64,50,60,98,96})) then
                    _mw.Shoot:FireServer(_uy, CFrame.new(_mc))
                    _tr = _vp
                    if _l.SingleShot then _l.AutoShoot = false end
                end
            end
        end
    end

    if (_l.KillAura or _l.AutoKill) and _ee and (_vp - _sr >= 0.2) then
        local _xl = LocalPlayer:FindFirstChild(_d7s2r3({46,25,93,21,54,13,27,85},{108,120,62,126,70}))
        local _tp = (_xl and _xl:FindFirstChild(_d7s2r3({34,93,69,23,74},{105,51,44,113,47}))) or (_zk and _zk:FindFirstChild(_d7s2r3({50,59,94,78,27},{121,85,55,40,126,72,95})))
        if _tp then
            if _fz and _xl and _tp.Parent == _xl then
                _fz:EquipTool(_tp)
            end
            local _fd = _tp:FindFirstChild(_d7s2r3({40,23,57,69,75,30},{109,97,92,43,63}))
            if _fd then
                if _l.KillMode == "Throw" and _fd:FindFirstChild(_d7s2r3({34,79,43,76,24,61,73,48,69,10,7},{105,33,66,42,125})) and _tp:FindFirstChild(_d7s2r3({15,57,60,81,43,64},{71,88,82,53,71,37})) then
                    local _f = getClosestKnifeTarget()
                    if _f and _f.Character then
                        local _ol = getRootPart(_f.Character)
                        if _ol then
                            local _cu = (_ee.Position - _ol.Position).Magnitude
                            if _l.KillAll or _cu <= _l.AuraRange then
                                local _fo = _ol.Position
                                if _l.AimPrediction then
                                    local _fy = _l.PingComp and 0.16 or 0.12
                                    _fo = _fo + (_ol.AssemblyLinearVelocity * _fy)
                                end
                                _fd.KnifeThrown:FireServer(_tp.Handle.CFrame, CFrame.new(_fo))
                                _sr = _vp
                            end
                        end
                    end
                elseif _fd:FindFirstChild(_d7s2r3({111,51,68,13,16,72,115,61,95,10,20,72,67},{39,82,42,105,124,45})) then
                    for _kk, _il in ipairs(_h:GetPlayers()) do
                        if _il ~= LocalPlayer and isPlayerAlive(_il) then
                            local _ol = getRootPart(_il.Character)
                            if _ol then
                                local _cu = (_ee.Position - _ol.Position).Magnitude
                                if _l.KillAll or _cu <= _l.AuraRange then
                                    _fd.HandleTouched:FireServer(_ol)
                                    if _fd:FindFirstChild(_d7s2r3({21,59,28,20,15,106,51,12,60,55,16,22},{94,85,117,114,106,57,71,109})) then
                                        _fd.KnifeStabbed:FireServer()
                                    end
                                    _sr = _vp
                                    if not _l.KillAll then
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

    if _l.HitboxExpander then
        for _kk, _il in ipairs(_h:GetPlayers()) do
            if _il ~= LocalPlayer and _il.Character and isPlayerAlive(_il) then
                local _qr = _il.Character:FindFirstChild(_d7s2r3({110,50,44,5,22,59,8,19,116,40,46,16,40,53,19,3},{38,71,65,100,120,84,97,119}))
                if _qr then
                    if not _vk[_qr] then
                        _vk[_qr] = _qr.Size
                    end
                    _qr.Size = Vector3.new(_l.HitboxSize, _l.HitboxSize, _l.HitboxSize)
                    _qr.Transparency = _l.HitboxTransparency
                    _qr.CanCollide = false
                end
            end
        end
    end

    if _l.MurdererAvoid and _ee and _is and _is.Character and isPlayerAlive(_is) then
        local _hm = getRootPart(_is.Character)
        if _hm then
            local _lg = (_ee.Position - _hm.Position).Magnitude
            if _lg < _l.SafetyRadius then
                if _l.SprintWhenChased and _fz then
                    _fz.WalkSpeed = math.max(_fz.WalkSpeed, 26)
                end
                if _l.RetreatToLobby then
                    local _so = getLobbyModel()
                    if _so then
                        local _pb = _so:FindFirstChildWhichIsA(_d7s2r3({45,52,51,66,54,67,67,27},{111,85,64,39,102,34,49}))
                        if _pb then _ee.CFrame = _pb.CFrame * CFrame.new(0, 3, 0) end
                    end
                else
                    local _bm = (_ee.Position - _hm.Position).Unit
                    _ee.CFrame = _ee.CFrame + Vector3.new(_bm.X * 0.8, 0, _bm.Z * 0.8)
                end
            end
        end
    end

    if _l.FollowMurderer and _ee and _is and _is.Character and isPlayerAlive(_is) then
        local _hm = getRootPart(_is.Character)
        if _hm then
            local _fo = _hm.Position - (_hm.CFrame.LookVector * _l.FollowDist)
            _ee.CFrame = _ee.CFrame:Lerp(CFrame.new(_fo, _hm.Position), 0.15)
        end
    end

    if _l.CoinFarm and _ee and (_vp - _gn >= 0.05) then
        if _l.BagFullStop and getCurrentCoinCount() >= _l.CoinBagCap then
            _l.CoinFarm = false
            SendNotification(_d7s2r3({116,87,91,48,44,17,100,116,91,90,32,44,17,61},{57,34,41,84,73,99,68}), _d7s2r3({58,44,42,30,89,33,34,23,89,47,42,29,16,55,99,2,28,34,32,24,28,39,98,80,63,34,49,29,16,45,36,80,10,55,44,0,9,38,39,94},{121,67,67,112}), 3)
        else
            local _dh = getAllActiveCoins()
            local _ef = nil
            local _gs = 1000

            for _kk, _vv in ipairs(_dh) do
                local _cu = (_ee.Position - _vv.Position).Magnitude
                local _mp = true
                if _l.SafeCoinFarm and _is and _is.Character and isPlayerAlive(_is) then
                    local _hm = getRootPart(_is.Character)
                    if _hm and (_vv.Position - _hm.Position).Magnitude < _l.SafetyRadius then
                        _mp = false
                    end
                end
                if _mp and _cu < _gs then
                    _gs = _cu
                    _ef = _vv
                end
            end

            if _ef then
                if _fz then
                    _fz.WalkSpeed = _l.FarmSpeed
                end
                local _fo = _ef.Position
                local _lg = (_ee.Position - _fo).Magnitude

                for _kk, _yp in ipairs(_zk:GetChildren()) do
                    if _yp:IsA(_d7s2r3({5,52,84,73,48,34,53,33},{71,85,39,44,96,67})) then
                        _yp.CanCollide = false
                    end
                end

                local _eq = _l.QuickFarm and 38 or math.clamp(_l.FarmSpeed, 16, 42)

                if _l.FarmMethod == "Tween" then
                    local _cq = math.max(_lg / _eq, 0.05)
                    local _xe = TweenInfo.new(_cq, Enum.EasingStyle.Linear)
                    local _wb = _m:Create(_ee, _xe, {CFrame = CFrame.new(_fo)})
                    _wb:Play()
                    if _lg < 7 then
                        fireTouch(_ee, _ef)
                        local _zn = _zk:FindFirstChild(_d7s2r3({106,74,23,55,76,107,17,49,92},{56,35,112,95})) or _zk:FindFirstChild(_d7s2r3({122,48,45,1,81,120,105,43,39},{40,89,74,105,37,88}))
                        if _zn then fireTouch(_zn, _ef) end
                    end
                elseif _l.FarmMethod == "Glide" or _l.QuickFarm then
                    local _qf = (_fo - _ee.Position)
                    if _qf.Magnitude > 0.3 then
                        _ee.AssemblyLinearVelocity = _qf.Unit * _eq
                    else
                        _ee.AssemblyLinearVelocity = Vector3.zero
                    end
                    if _lg < 7 then
                        fireTouch(_ee, _ef)
                        local _zn = _zk:FindFirstChild(_d7s2r3({26,17,26,85,60,48,28,83,44},{72,120,125,61})) or _zk:FindFirstChild(_d7s2r3({36,54,68,80,68,27,98,4,50},{118,95,35,56,48,59,35}))
                        if _zn then fireTouch(_zn, _ef) end
                    end
                else
                    if _fz then
                        _fz:MoveTo(_fo)
                        if _fo.Y > _ee.Position.Y + 2.0 and _fz:GetState() ~= Enum.HumanoidStateType.Jumping then
                            _fz:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                    if _lg < 7 then
                        fireTouch(_ee, _ef)
                        local _zn = _zk:FindFirstChild(_d7s2r3({118,6,72,80,18,108,14,65,92},{36,111,47,56,102})) or _zk:FindFirstChild(_d7s2r3({115,54,17,44,85,127,55,54,76},{33,95,118,68}))
                        if _zn then fireTouch(_zn, _ef) end
                    end
                end
                _gn = _vp
            end
        end
    end
end))

trackConn(_o.InputBegan:Connect(function(_ta, _he)
    if _he then return end
    if _ta.KeyCode == Enum.KeyCode.End then
        _l.KillAura = false
        _l.AutoShoot = false
        _l.CoinFarm = false
        _l.AutoKill = false
        SendNotification(_d7s2r3({44,8,84,70,33,19,93,107,91,55,21,24,84,91},{97,125,38,34,68}), _d7s2r3({115,36,105,60,30,115,43,121,111,73,127,58,22,102,95,26,112,12,77,26,44,68,0,73,22,1,77,2,45,83,1,20},{54,105,44,110,89,54,101,58}), 2)
    elseif _ta.KeyCode == Enum.KeyCode.Space and _l.InfiniteJump then
        local _fz = getHumanoid(LocalPlayer.Character)
        if _fz then _fz:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

local function hookPlayerDeath(_il)
    trackConn(_il.CharacterAdded:Connect(function(_vv)
        local _x = _vv:WaitForChild(_d7s2r3({119,18,4,8,44,59,77,73},{63,103,105,105,66,84,36,45}), 5)
        if _x then
            trackConn(_x.Died:Connect(function()
                table.insert(_xw, _il.Name)
                if _l.DeathNotifs then
                    local _ay = getPlayerRole(_il)
                    SendNotification(_d7s2r3({8,34,1,57,36,103,33,33,41,53,20},{76,71,96,77}), _il.Name .. " [" .. _ay .. _d7s2r3({60,90,8,46,27,16,81,43,4,30,65},{97,122,96,79,104,48,53,66}), 3)
                end
            end))
        end
    end))
end

for _kk, _il in ipairs(_h:GetPlayers()) do
    if _il ~= LocalPlayer then
        hookPlayerDeath(_il)
    end
end

trackConn(_h.PlayerAdded:Connect(function(_il)
    hookPlayerDeath(_il)
end))

trackConn(LocalPlayer.Idled:Connect(function()
    if _l.AntiAFK then
        local _rn = game:GetService(_d7s2r3({35,34,79,14,19,33,8,36,6,46,79},{117,75,61,122,102,64,100,113}))
        _rn:CaptureController()
        _rn:ClickButton2(Vector2.new(0, 0))
    end
end))

getgenv().IdenticalMM2Unload = function()
    for _kk, _lr in ipairs(_t) do
        pcall(function() _lr:Disconnect() end)
    end
    _t = {}
    clearESPCategory("")
    for id in pairs(_g) do
        pcall(function() _g[id]:Remove() end)
    end
    _g = {}
    _jy = false
    if _uq then
        _uq:Destroy()
        _uq = nil
    end
    if _mh then
        pcall(function() _mh:Remove() end)
        _mh = nil
    end
    for _yp, sz in pairs(_vk) do
        if _yp and _yp.Parent then
            _yp.Size = sz
            _yp.Transparency = 1
        end
    end
    _vk = {}
    if _cs and _cs.Destroy then
        pcall(function() _cs:Destroy() end)
    end
    getgenv().IdenticalMM2Unload = nil
end

SendNotification(_d7s2r3({43,58,21,47,0,60,70,2,30,56,17,43,20,54},{102,79,103,75,101,78}), _d7s2r3({19,83,2,55,3,59,28,20,58,18,55,28,52,58,8,59,105,42,114},{95,60,99,83,102}), 3)