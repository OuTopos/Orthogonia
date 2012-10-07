entities_player = {}

function entities_player.new(view, control, xn, yn)
	local self = {}
	self.type = "player"


	local remove = false



	local x, y, z = xn, yn, 32
	local xr, yr, zr = x, y, z
	local xvel, yvel = 0, 0
	local speed = 0
	local friction = 0.99
	local direction = 0

	-- SPRITES
	--buffer:addSheet("tilesets/LPC/lori_angela_nagel_-_jastivs_artwork/png/female_dwing_walkcycle", 64, 64)
	buffer:addSheet("soldier", 64, 64)
	buffer:addSheet("HEAD_chain_armor_hood", 64, 64)
	buffer:addSheet("HEAD_chain_armor_helmet", 64, 64)
	buffer:addSheet("FEET_shoes_brown", 64, 64)

	local spriteset = buffer.spriteset(xr, yr, z, 16, 32)

	--table.insert(spriteset.data, {sheet = "tilesets/LPC/lori_angela_nagel_-_jastivs_artwork/png/female_dwing_walkcycle", quad = 14} )
	table.insert(spriteset.data, {sheet = "soldier", quad = 14} )
	table.insert(spriteset.data, {sheet = "HEAD_chain_armor_hood", quad = 14} )
	--table.insert(spriteset.data, {sheet = "HEAD_chain_armor_helmet", quad = 14} )
	table.insert(spriteset.data, {sheet = "FEET_shoes_brown", quad = 14} )




	-- COLLISION
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
		self.updatePosition(x + dx, y + dy)
		self.updateCollision()
	end
	bump.add(self)



	function self.update(dt)
		self.updateInput(dt)
		self.updateCollision()
		self.updateAnimation(dt)
	end

	function self.updateInput(dt)
		--x = x + xvel * dt
		--y = y + yvel * dt

		--if love.keyboard.isDown("right") then
		--	xvel = xvel + speed * dt
		--end
		--if love.keyboard.isDown("left") and xvel > -100 then
		--	xvel = xvel - speed * dt
		--end
		--if xvel > 100 then
		--	xvel = 100
		--elseif xvel < -100 then
		--	xvel = -100
		--end


		--if love.keyboard.isDown("down") then
		--	yvel = yvel + speed * dt
		--end
		--if love.keyboard.isDown("up") then
		--	yvel = yvel - speed * dt
		--end
		--if yvel > 100 then
		--	yvel = 100
		--elseif yvel < -100 then
		--	yvel = -100
		--end

		speed = 0
		velocity = 1000
		acceleration = velocity * dt
		if love.keyboard.isDown("up") then
			direction = 3.141592654
			speed = 250
			yvel = yvel - acceleration
		--elseif love.keyboard.isDown("up") and love.keyboard.isDown("right") then
		--	direction = 45
		--	speed = 1000
		end
		if love.keyboard.isDown("right") then
			direction = 1.570796327
			speed = 250
			xvel = xvel + acceleration
		--elseif love.keyboard.isDown("right") and love.keyboard.isDown("down") then
		--	direction = 135
		--	speed = 1000
		end
		if love.keyboard.isDown("down") then
			direction = 0
			speed = 250
			yvel = yvel + acceleration
		--elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
		--	direction = 225
		--	speed = 1000
		end
		if love.keyboard.isDown("left") then
			direction = 4.71238898
			speed = 250
			xvel = xvel - acceleration
		--elseif love.keyboard.isDown("left") and love.keyboard.isDown("up") then
		--	direction = 315
		--	speed = 1000
		end
		--print("direction = "..direction)
		--print("sin(o) = "..math.sin(direction))
		--print("cos(o) = "..math.cos(direction))

	--	xvel = xvel + math.sin(direction) * speed
	--	yvel = yvel + math.cos(direction) * speed

		if xvel < -100 then
			xvel = -100
		end
		if xvel > 100 then
			xvel = 100
		end
		if yvel < -100 then
			yvel = -100
		end
		if yvel > 100 then
			yvel = 100
		end

		x = x + xvel * dt
		y = y + yvel * dt


		xvel = xvel - (xvel * friction) * 10 * dt
		yvel = yvel - (yvel * friction) * 10 * dt



		self.updatePosition()
	end

	function self.updatePosition(xn, yn)
		x = xn or x
		y = yn or y
		xr = math.floor( x + 0.5 )
		yr = math.floor( y + 0.5 )

		-- Update sprite
		spriteset.x = xr
		spriteset.y = yr

		-- Set the camera
		camera:center(xr, yr)
	end

	local animation = {}
	animation.quad = 1
	animation.dt = 0

	function self.updateAnimation(dt)
		if direction > -0.785398163 and direction < 0.785398163 then
			-- Up
			if speed > 0 then
				self.animate(20, 27, 0.08, dt)
			else
				self.animate(19)
			end
		elseif direction > 0.785398163 and direction < 2.35619449 then
			-- Right
			if speed > 0 then
				self.animate(29, 36, 0.08, dt)
			else
				self.animate(28)
			end
		elseif direction > 2.35619449 and direction < 3.926990817 then
			-- Down
			if speed > 0 then
				self.animate(2, 9, 0.08, dt)
			else
				self.animate(1)
			end
		elseif direction > 3.926990817 and direction < 5.497787144 then
			-- Left
			if speed > 0 then
				self.animate(11, 18, 0.08, dt)
			else
				self.animate(10)
			end
		end

		for i = 1, #spriteset.data do
			spriteset.data[i].quad = animation.quad
		end
	end

	function self.animate(first, last, delay, dt)
		if dt then
			animation.dt = animation.dt + dt

			if animation.dt > delay then
				animation.dt = animation.dt - delay
				animation.quad = animation.quad + 1
			end

			if animation.quad < first or animation.quad > last then
					animation.quad = first
			end
		else
			animation.dt = 0
			animation.quad = first
		end
	end

	function self.draw()
		-- Draw
		buffer:add(spriteset)
	end

	function self.destroy()
		bump.remove(self)
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