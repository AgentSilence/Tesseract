local sides = {
["top"] = " ",
["bottom"] = " ",
["right"] = " ",
["left"] = " ",
["back"] = " ",
["front"] = " "}

local function calibrateside(sSide, pSide)
  if sides[sSide] ~= nil or sides[sSide] ~= " " then
    peripheral.call(pSide,"setBackgroundColor",colors.red)
    peripheral.call(pSide,"setTextColor",colors.black)
    peripheral.call(pSide,"clear")
    local w,h = peripheral.call(pSide,"getSize")
    peripheral.call(pSide,"setCursorPos",math.floor(w / 2 - #"Click the "..sSide / 2 + .5), math.floor(h / 2 + .5))
    peripheral.call(pSide,"write","Click the "..sSide)
  else
    peripheral.call(pSide,"setBackgroundColor",colors.white)
    peripheral.call(pSide,"setTextColor",colors.black)
    peripheral.call(pSide,"clear")
    sides[sSide] = pSide
  end
end

function calibrate()
  local monitors = {}
  for i,v in pairs(peripheral.getNames()) do
    if peripheral.getType(v) == "monitor" then
      table.insert(monitors, v)
    end
  end
end
