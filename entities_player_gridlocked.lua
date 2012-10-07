entities_player = {}

function entities_player.new(view, control, xn, yn)
	local self = {}
	self.type = "player"


	local remove = false



	local x, y, z = xn, yn, 32
	local xr, yr, zr = x, y, z
	local xvel, yvel = 0, 0
	local speed = 128
	local friction = 0.1
	local direction = "down"

	local moving = 0

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
	collision.w = 32
	collision.h = 16
	collision.l = xr
	collision.t = yr + 16
	function self.updateCollision()
		collision.l = xr
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
		step = 0
		if moving > 0 then
			step = speed * dt
			moving = moving - step
		end

		if moving <= 0 then
			if love.keyboard.isDown("up") then
				move_to = {x, y-1}
				moving = moving + 32
				direction = "up"
			elseif love.keyboard.isDown("right") then
				move_to = {x+1, y}
				moving = moving + 32
				direction = "right"
			elseif love.keyboard.isDown("down") then
				move_to = {x, y+1}
				moving = moving + 32
				direction = "down"
			elseif love.keyboard.isDown("left") then
				move_to = {x-1, y}
				moving = moving + 32
				direction = "left"
			end
		end

		if moving < 0 then
			step = step + moving
			moving = 0
		end
			
		if direction == "up" then
			y = y - step
		elseif direction == "right" then
			x = x + step
		elseif direction == "down" then
			y = y + step
		elseif direction == "left" then
			x = x - step
		end

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

	local animationdt = 0
	local animation = {}
	animation.quad = 1
	function self.updateAnimation(dt)
		animationdt = animationdt + dt

		if direction == "up" then
			-- Up
			if moving > 0 then
				self.animate(2, 9, 1, dt)
			else
				animation.quad = 1
			end
		elseif direction == "right" then
			-- Right
			if moving > 0 then
				self.animate(29, 36, 1, dt)
			else
				animation.quad = 28
			end
		elseif direction == "down" then
			-- Down
			if moving > 0 then
				self.animate(20, 27, 1, dt)
			else
				animation.quad = 19
			end
		elseif direction == "left" then
			-- Left
			if moving > 0 then
				self.animate(11, 18, 1, dt)
			else
				animation.quad = 10
			end
		end

		for i = 1, #spriteset.data do
			spriteset.data[i].quad = animation.quad
		end
	end

	function self.animate(first, last, speed, dt)
		animationdt = animationdt + dt
		print(dt)

		if animation.quad < first then
			animation.quad = first
		end

		if animationdt > 0.2 then
			animationdt = animationdt - 0.2
			animation.quad = animation.quad + 1
			if animation.quad > last then
				animation.quad = first
			end
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