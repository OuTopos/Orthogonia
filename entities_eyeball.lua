entities_eyeball= {}

function entities_eyeball.new(x, y, z)
	local self = {}
	local remove = false

	
	buffer:addSheet("entities/eyeball", 32, 38)
	local spriteset = buffer.spriteset(x-16, y-16, z, 0, 8)
	table.insert(spriteset.data, {sheet = "entities/eyeball", quad = 4} )

	-- Physics/Collision
	local collision = physics.newObject(love.physics.newBody(physics.world, x, y, "dynamic"), love.physics.newCircleShape(12), self)
	collision.body:setLinearDamping( 1 )
	collision.fixture:setRestitution( 0.9 )

	local speed = 100
	local target = {}
	target.x = 256
	target.y = 256
	target.marginal = 25
	target.active = true
	local twitchtimer = 1

	function self.update(dt)
		target.x = player.getX()
		target.y = player.getY()

		if target.active then
			fx, fy = 0, 0
			target.active = false

			if collision.body:getX() < target.x - target.marginal then
				fx = speed
				target.active = true
			elseif collision.body:getX() > target.x  + target.marginal then
				fx = -speed
				target.active = true
			end

			if collision.body:getY() < target.y - target.marginal then
				fy = speed
				target.active = true
			elseif collision.body:getY() > target.y + target.marginal then
				fy = -speed
				target.active = true
			end

			collision.body:applyForce( fx, fy )
		end

		--if target.active == false then
		--	target.x = target.x + 32
		--	target.active = true
		--end

		twitchtimer = twitchtimer - dt

		if twitchtimer <= 0 then
			collision.body:applyLinearImpulse( math.random(-speed, speed), math.random(-speed, speed) )
			twitchtimer = twitchtimer + 1
		end

		x = math.floor( collision.body:getX() + 0.5 ) -16
		y = math.floor( collision.body:getY() + 0.5 ) -16

		spriteset.x = x
		spriteset.y = y

		self.animate(7, 9, 0.2, dt)
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