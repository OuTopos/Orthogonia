entities_player = {}

function entities_player.new(view, control)
	print("Hello! I am a player!")
	local self = {}
	local remove = false

	local sheet = "princess"
	buffer:addSheet(sheet, 64, 64)

	local x, y, z = 359, 359, 32
	local xvel, yvel = 0, 0
	local speed = 20
	local friction = 10



	function self.update(dt, i)
		if view then
			entities.view(i)
		end
		if control then
			self.control(dt, i)
		end

		-- Draw
		buffer:add(sheet, 1, self.getX(), self.getY(), z, 32, 48, 1, 1, 0)
	end

	function self.control(dt, i)
		x = x + xvel
		y = y + yvel

		xvel = xvel * (1 - math.min(dt*friction, 1))
		yvel = yvel * (1 - math.min(dt*friction, 1))

		if love.keyboard.isDown("right") and xvel < 15 then
			xvel = xvel + speed * dt
		end

		if love.keyboard.isDown("left") and xvel > -15 then
			xvel = xvel - speed * dt
		end

		if love.keyboard.isDown("down") and yvel < 15 then
			yvel = yvel + speed * dt
		end

		if love.keyboard.isDown("up") and yvel > -15 then
			yvel = yvel - speed * dt
		end
	end

	-- Basic functions
	function self.setPosition(xn, yn)
		x, y = xn, yn
	end

	function self.getX()
		return math.floor( x + 0.5 )
	end
	function self.getY()
		return math.floor( y + 0.5 )
	end

	function self.getXvel()
		return xvel
	end
	function self.getYvel()
		return yvel
	end

	return self
end