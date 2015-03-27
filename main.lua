local sides = {
["top"] = " ",
["bottom"] = " ",
["right"] = " ",
["left"] = " ",
["back"] = " ",
["front"] = " "}

local function calibrateSide(sSide, pSide)
  if sides[sSide] ~= " " then
    peripheral.call(pSide,"setBackgroundColor",colors.red)
    peripheral.call(pSide,"setTextColor",colors.black)
    peripheral.call(pSide,"clear")
    local w,h = peripheral.call(pSide,"getSize")
    peripheral.call(pSide,"setCursorPos",math.floor(w / 2 - #"Click the "..sSide.." monitor." / 2 + .5), math.floor(h / 2 + .5))
    peripheral.call(pSide,"write","Click the "..sSide.." monitor.")
    return false
  else
    peripheral.call(pSide,"setBackgroundColor",colors.white)
    peripheral.call(pSide,"setTextColor",colors.black)
    peripheral.call(pSide,"clear")
    sides[sSide] = pSide
    return true
  end
end

function calibrate()
  local monitors = {}
  for i,v in pairs(peripheral.getNames()) do
    if peripheral.getType(v) == "monitor" then
      table.insert(monitors, v)
    end
  end
  for i,val in pairs(sides) do
  	for k,v in pairs(monitors) do
  	  peripheral.call(v,"setBackgroundColor",colors.lightBlue)
      peripheral.call(v,"setTextColor",colors.black)
      peripheral.call(v,"clear")
      local w,h = peripheral.call(v,"getSize")
      peripheral.call(v,"setCursorPos",math.floor(w / 2 - #"Click the "..i.." monitor." / 2 + .5), math.floor(h / 2 + .5))
      peripheral.call(v,"write","Click the "..i.." monitor.")
    end
    repeat
      local event, side, x, y = os.pullEventRaw("monitor_touch")
      local isCalibrated = calibrateSide(i,side)
      if isCalibrated == true then
      	for k,v in ipairs(monitors) do
      	  if side == v then
            table.remove(monitors, k)
          end
        end
      end
    until isCalibrated == true
  end
  local monitors = {}
  monitors.top = peripheral.wrap(sides["top"])
  monitors.bottom = peripheral.wrap(sides["bottom"])
  monitors.front = peripheral.wrap(sides["front"])
  monitors.back = peripheral.wrap(sides["back"])
  monitors.left = peripheral.wrap(sides["left"])
  monitors.right = peripheral.wrap(sides["right"])
  return monitors
end
