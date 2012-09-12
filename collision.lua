hc = require "lib/hardoncollider"
collider = hc(100, on_collision)

collision = {}
collision.data = {}

function collision.new(x, y, width, height)
	local rectangle = collider:addRectangle(x, y, width, height)
	table.insert(collision.data, rectangle)
end



function collision.update(dt)
	collider:update(dt)
end

function collision.draw()
	love.graphics.setColor(255, 0, 0, 153)
	for i = 1, #collision.data do
		collision.data[i]:draw("fill")
	end
end

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	print("booom")
end