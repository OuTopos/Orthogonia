entities_player = {}

function entities_player.new(view, control, xn, yn)
	local self = {}
	self.type = "player"


	local remove = false



	local x, y, z = xn, yn, 32
	local xr, yr, zr = x, y, z
	local xvel, yvel = 0, 0
	local speed = 1000
	local friction = 0.1

	-- SPRITES
	buffer:addSheet("tilesets/LPC/lori_angela_nagel_-_jastivs_artwork/png/female_dwing_walkcycle", 64, 64)
	buffer:addSheet("BODY_skeleton", 64, 64)
	buffer:addSheet("HEAD_chain_armor_hood", 64, 64)
	buffer:addSheet("HEAD_chain_armor_helmet", 64, 64)
	buffer:addSheet("FEET_shoes_brown", 64, 64)

	local spriteset = buffer.spriteset(xr, yr, z, 16, 32)

	table.insert(spriteset.data, {sheet = "tilesets/LPC/lori_angela_nagel_-_jastivs_artwork/png/female_dwing_walkcycle", quad = 14} )
	table.insert(spriteset.data, {sheet = "BODY_skeleton", quad = 14} )
	--table.insert(spriteset.data, {sheet = "HEAD_chain_armor_hood", quad = 14} )
	table.insert(spriteset.data, {sheet = "HEAD_chain_armor_helmet", quad = 14} )
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
	end

	function self.updateInput(dt)
		x = x + xvel * dt
		y = y + yvel * dt

		xvel = xvel - xvel * friction
		yvel = yvel - yvel * friction 

		if love.keyboard.isDown("right") then
			xvel = xvel + speed * dt
		end
		if love.keyboard.isDown("left") and xvel > -100 then
			xvel = xvel - speed * dt
		end
		if xvel > 100 then
			xvel = 100
		elseif xvel < -100 then
			xvel = -100
		end


		if love.keyboard.isDown("down") then
			yvel = yvel + speed * dt
		end
		if love.keyboard.isDown("up") then
			yvel = yvel - speed * dt
		end
		if yvel > 100 then
			yvel = 100
		elseif yvel < -100 then
			yvel = -100
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