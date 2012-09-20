bump = require "lib.bump"

-- bump config

-- When a collision occurs, call collideWithBlock with the appropiate parameters
function bump.collision(obj1, obj2, dx, dy)
	if obj1.type == "player" or obj2.type == "player" then
		local player
		if obj1.type == "player" then
			player = obj1
			other = obj2
		else
			player = obj2
			other = obj1
			dx = -dx
			dy = -dy
		end

		if other.behavior == "portal" then
			collision.trigger = {"map.load", other.data.map, other.data.spawn, other.data.world}
		elseif other.behavior == "block" then
			player.collide(other, dx, dy)
		end
	end
	--	print('booom1')
	--	obj1.collide(obj2, dx,dy)
	--end
	--if obj2.collide then
	--	print('booom2')
	--	obj2.collide(obj1, -dx,-dy)
	--end
end

-- only the player collides with stuff. Blocks don't collide with themselves
function bump.shouldCollide(obj1, obj2)
	--return obj1 == player or obj2 == player
	return true
end

-- return the bounding box of an object - the player or a block
function bump.getBBox(obj)
	if obj.l then
		return obj.l, obj.t, obj.w, obj.h
	else
		return obj.getCollision()
	end
	
end

-- Collision

collision = {}
collision.data = {}
--collision.trigger

function collision.new(x, y, width, height, behavior, data)
	local box = {l=x, t=y, w=width, h=height, behavior=behavior, data=data}
	table.insert(collision.data, box)
	bump.addStatic(box)
end

function collision.update(dt)
	bump.collide()
	if collision.trigger then
		map.load(collision.trigger[2], collision.trigger[3], collision.trigger[4])
		collision.trigger = nil
	end
end

function collision.draw()

	love.graphics.setColor(255, 0, 0, 153)

	for i = 1, #collision.data do
		love.graphics.rectangle("fill", collision.data[i].l, collision.data[i].t, collision.data[i].w, collision.data[i].h)
	end

	bump_debug.draw(0,0,1280,1280)
end



function collision.reset()
	for i = 1, #collision.data do
		bump.remove(collision.data[i])
	end
	collision.data = {}
end














--- DEBUG

 bump_debug = {}

-- transform grid coords into world coords
local function _getCellBoundingBox(x,y)
  local cellSize = bump.getCellSize()
  return (x - 1)*cellSize, (y-1)*cellSize, cellSize, cellSize
end

local function _drawCell(cell, gx, gy)
  local l,t,w,h   = _getCellBoundingBox(gx, gy)
  local intensity = cell.itemCount * 40 + 30
  love.graphics.setColor(intensity, intensity, intensity)
  love.graphics.print(cell.itemCount, l+12, t+12)
  love.graphics.rectangle('line', l,t,w,h)
end

function bump_debug.draw(l,t,w,h)
  bump.eachCell(_drawCell, l,t,w,h)
end

return bump_debug