entities_coin = {}

function entities_coin.new(x, y, z)
	local self = {}
	local remove = false

	local spriteset = nil
	local collision = nil

	function self.init()
		-- Spriteset
		buffer:addSheet("tilesets/LPC/clint_bellanger_-_animated_coins/coin_gold", 32, 32)
		spriteset = buffer.spriteset(x-16, y-16, z, 0, 0)
		table.insert(spriteset.data, {sheet = "tilesets/LPC/clint_bellanger_-_animated_coins/coin_gold", quad = 1} )

		-- Physics/Collision
		collision = physics.newObject(love.physics.newBody(physics.world, x, y, "dynamic"), love.physics.newCircleShape(8), self)
		collision.body:setLinearDamping( 0.1 )
		collision.fixture:setRestitution( 0.9 )
	end

	function self.update(dt)
		--x = math.floor( collision.body:getX() + 0.5 ) -16
		--y = math.floor( collision.body:getY() + 0.5 ) -16
		x = collision.body:getX() - 16
		y = collision.body:getY() - 16

		spriteset.x = x
		spriteset.y = y

		self.animate(1, 8, 0.1, dt)
	end

	local animation = {}
	animation.quad = 1
	animation.dt = 0

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
		spriteset.data[1].quad = animation.quad
	end

	function self.draw()
		-- Draw
		buffer:add(spriteset)
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