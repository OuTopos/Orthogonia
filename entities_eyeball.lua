eyeball = {}

function eyeball.new()
	print("Hello! I am an eyeball!")
	local self = {}
	local remove = false
	local sheet = "entities/eyeball"
	buffer:addSheet(sheet, 32, 38)

	local x, y, z = math.random(0,400), math.random(0,400), 32

	function self.update(dt)
		x = x + math.random(-1,1)
		y = y + math.random(-1,1)

		-- Draw
		buffer:add(sheet, math.random(1,3)*3+1, x, y, z, 16, 22, 1, 1, 0)
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