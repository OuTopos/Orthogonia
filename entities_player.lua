entities_player = {}

function entities_player.new(view, control)
	local self = {}


	local remove = false

	local sheet = "princess"
	buffer:addSheet(sheet, 64, 64)

	local x, y, z = 359, 359, 32
	local xr, yr, zr = x, y, z
	local xvel, yvel = 0, 0
	local speed = 20
	local friction = 10

	-- COLLISION
	self.collision = true
	local collision = {}
	collision.w = 28
	collision.h = 16
	collision.l = xr + 2
	collision.t = yr + 16
	function self.updateCollision()
		collision.l = xr + 2
		collision.t = yr + 16
	end
	function self.getCollision()
		return collision.l, collision.t, collision.w, collision.h
	end
	function self.collide(obj, dx, dy)
		print(dx, dy)
		x = x + dx
		y = y + dy
		xr = math.floor( x + 0.5 )
		yr = math.floor( y + 0.5 )
		self.updateCollision()
	end
	bump.add(self)


	function self.update(dt, i)
		if view then
			entities.view(i)
		end
		if control then
			self.control(dt, i)
		end

		-- Update rounded x y
		xr = math.floor( x + 0.5 )
		yr = math.floor( y + 0.5 )

		-- Update collision
		self.updateCollision()

		self.animate(dt, i)
	end

	function self.animate(dt, i)
		-- Draw
		buffer:add(sheet, 1, self.getX(), self.getY(), z, 16, 32, 1, 1, 0)
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