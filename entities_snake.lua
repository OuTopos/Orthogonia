entities_snake = {}

function entities_snake.new(view, control)
	print("Hello! I am a snake!")
	local self = {}
	local remove = false
	local sheet = "entities/snake"
	buffer:addSheet(sheet, 32, 32)

	local x, y, z = math.random(0,400), math.random(0,400), 32

	function self.update(dt, i)
		x = x + math.random(-1,1)
		y = y + math.random(-1,1)

		-- Draw
		buffer:add(sheet, math.random(4,6), x, y, z, 16, 16, 1, 1, 0)
	end

	function self.setPosition(xn, yn)
		x, y = xn, yn
	end

	function self.getX()
		return x
	end
	function self.getY()
		return y
	end

	return self
end