--[[
Write a function to compute the volume of a right circular cone, given its height and the angle between a generatrix and the axis.
]]

function conevolume(h, theta)
  r = h * math.tan(theta)
  return math.pi * r^2 * h / 3
end

print(conevolume(1, math.rad(45))) --> 1.0471975511966
