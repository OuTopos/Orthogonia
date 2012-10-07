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


	-- Physics
	local physics = physics.newObject(love.physics.newBody(physics.world, x, y, "dynamic"), love.physics.newCircleShape(14))
	physics.body:setLinearDamping( 10 )
	physics.body:setFixedRotation( true )


	function self.update(dt)
		self.updateInput(dt)
		self.updatePosition()
		self.updateAnimation(dt)
	end

	function self.updateInput(dt)
		fx, fy = 0, 0

		if love.keyboard.isDown("up") then
			direction = 3.141592654
			fy = -5000
		end
		if love.keyboard.isDown("right") then
			direction = 1.570796327
			fx = 5000
		end
		if love.keyboard.isDown("down") then
			direction = 0
			fy = 5000
		end
		if love.keyboard.isDown("left") then
			direction = 4.71238898
			fx = -5000
		end


		xvel = xvel - (xvel * friction) * 10 * dt
		yvel = yvel - (yvel * friction) * 10 * dt

		physics.body:applyForce( fx, fy )
		x = physics.body:getX() - 16
		y = physics.body:getY() - 16
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