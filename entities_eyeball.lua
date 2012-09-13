entities_eyeball= {}

function entities_eyeball.new(view, control)
	local self = {}

	--local input, view = initial_input or false, initial_view or false

	local remove = false
	local sheet = "entities/eyeball"
	buffer:addSheet(sheet, 32, 38)

	local x, y, z = math.random(0,400), math.random(0,400), 32

	function self.update(dt, i)
		if view then
			entities.view(i)
		end
		x = x + math.random(-1,1)
		y = y + math.random(-1,1)

		-- Draw
		buffer:add(sheet, math.random(1,3)*3+1, x, y, z, 0, 8, 1, 1, 0)
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