-- set to 1 if you want to input your own view model x y and z
local overrideViewmodels = 0

local xVM = -5
local yVM = 0
local zVM = -10


--local tahoma = draw.CreateFont("Tahoma Bold", 15, 590, 0x200)
local arial = draw.CreateFont("Arial Bold", 15, 590, 0x200)
local current_fps = 0
local ping = 0


function RGBRainbow(frequency)
  local curtime = globals.CurTime()
  local r, g, b
  r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
  g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
  b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

  return r, g, b
end

local function primary()
  if globals.FrameCount() % 100 == 0 then
    current_fps = math.floor(1 / globals.FrameTime())
    if clientstate.GetClientSignonState() == 0 then
      ping = "Not In a Server"
    elseif clientstate.GetClientSignonState() > 1 and clientstate.GetClientSignonState() < 6 then
      ping = "Connecting To Server"
    else
      ping = math.floor((clientstate.GetLatencyOut() - clientstate.GetLatencyIn()) * 1000)
      --ping = math.floor(10/clientstate.GetLatencyOut())
      --ping = math.floor(10/clientstate.GetDeltaTick())
    end
  end
  if overrideViewmodels == 1 then
    client.RemoveConVarProtection( "tf_viewmodels_offset_override" )
    client.SetConVar( "tf_viewmodels_offset_override", xVM .. " " .. yVM .. " " .. zVM)
  end
  
  local r, g, b = RGBRainbow(1)

  draw.SetFont(arial)
  draw.Color(r, g, b, 255)
  draw.Text(15, 320, "hi there!")
  draw.Text(15, 340, "FrameRate:  " .. current_fps .. "")
  draw.Text(15, 360, "Real Ping:  " .. ping .. "")
  if overrideViewmodels == 1 then
    draw.Color(r, g, b, 255)
    draw.Text(15, 520, "x ViewModel:  " .. xVM .. "")
    draw.Text(15, 540, "y ViewModel:  " .. yVM .. "")
    draw.Text(15, 560, "z ViewModel:  " .. zVM .. "")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 520, "Override Viewmodels Not Enabled")
  end
end

local function secondary()
  -- get cheat values
  local aimbot = gui.GetValue("aim bot")
  local aimbotMethod = gui.GetValue("aim method")
  local aimbotfov = gui.GetValue("aim fov")
  local dt = gui.GetValue("double tap (beta)")
  local aa = gui.GetValue("anti aim")
  local chams = gui.GetValue("colored players")
  local esp = gui.GetValue("players")
  local fakepingvalue = gui.GetValue("fake latency value")
  local fakeping = gui.GetValue("fake latency")
  local triggerbot = gui.GetValue("trigger shoot")
  local bhop = gui.GetValue("bunny hop")
  local antiobs = gui.GetValue("anti-obs")
  local nohands = gui.GetValue("no hands")
  local noscope = gui.GetValue("no scope")
  local customfov = gui.GetValue("enable custom fov")
  local fovvalue = gui.GetValue("custom fov value")
  local thirdperson = gui.GetValue("thirdperson")
  local fakeLag = gui.GetValue("fake lag")
  local fakeLagAmount = gui.GetValue("fake lag value")
  local r, g, b = RGBRainbow(1)


  draw.SetFont(arial)


  -- checks if the aimbot is enabled then renders text
  if (aimbot == 1) then
    draw.Color(r, g, b, 255)
    draw.Text(15, 380, "AimBot: " .. aimbotfov .. "/" .. string.upper(aimbotMethod) .. "")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 380, "AimBot: OFF")
  end

  -- checks if ESP is enabled then renders text
  if (esp == 1) then
    draw.Color(r, g, b, 255)
    draw.Text(15, 400, "ESP: ON")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 400, "ESP: OFF")
  end

  --checks if AA is enabled and renders text
  if (aa == 1) then
    draw.Color(r, g, b, 255)
    draw.Text(15, 420, "AA:ON")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 420, "AA: OFF")
  end

  -- checks if BunnyHop is enabled then renders text
  if (bhop == 1) then
    draw.Color(r, g, b, 255)
    draw.Text(15, 440, "Bunnyhop: ON")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 440, "Bunnyhop: OFF")
  end

  -- checks if FOV chamger is on and displays it
  if (customfov == 1) then
    draw.Color(r, g, b, 255)
    draw.Text(15, 460, "Custom FOV: " .. fovvalue .. "")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 460, "Custom FOV: OFF")
  end

  --checks to see if fake ping is on and displays it
  if (fakeping == 1) then
    draw.Color(r, g, b, 255)
    draw.Text(15, 480, "Fake Ping: " .. fakepingvalue .. "")
  else
    draw.Color(255, 255, 255, 255)
    draw.Text(15, 480, "Fake Ping: OFF")
  end

    --checks to see if fake lag is on and displays it
    if (fakeLag == 1) then
      draw.Color(r, g, b, 255)
      draw.Text(15, 500, "Fake Lag: " .. fakeLagAmount .. "")
    else
      draw.Color(255, 255, 255, 255)
      draw.Text(15, 500, "Fake Lag: OFF")
    end

end

callbacks.Register("Draw", primary)
callbacks.Register("Draw", "draw", secondary)
