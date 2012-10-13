entities_eyeball_friend = {}

function entities_eyeball_friend.new(x, y, z)
	local self = {}
	local remove = false

	
	buffer:addSheet("entities/eyeball_friend", 32, 38)
	local spriteset = buffer.spriteset(x-16, y-16, z, 0, 8)
	table.insert(spriteset.data, {sheet = "entities/eyeball_friend", quad = 4} )

	-- Physics/Collision
	local collision = physics.newObject(love.physics.newBody(physics.world, x, y, "dynamic"), love.physics.newCircleShape(12), self)
	collision.body:setLinearDamping( 1 )
	collision.fixture:setRestitution( 0.9 )

	local speed = 100
	local direction = 0

	local target = {}
	target.x = 0
	target.y = 0
	target.marginal = 1
	target.active = true

	local twitch = {}
	twitch.delay = 1
	twitch.dt = 0

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

		twitch.dt = twitch.dt - dt

		if twitch.dt <= 0 then
			collision.body:applyLinearImpulse( math.random(-speed, speed), math.random(-speed, speed) )
			twitch.dt = twitch.dt + twitch.delay
		end


		x = math.floor( collision.body:getX() + 0.5 ) -16
		y = math.floor( collision.body:getY() + 0.5 ) -16
		direction = math.atan2(collision.body:getLinearVelocity()) / (math.pi / 180)

		spriteset.x = x
		spriteset.y = y

		self.updateAnimation(dt)
	end

	local animation = {}
	animation.quad = 1
	animation.dt = 0

	function self.updateAnimation(dt)
		if direction >= 135 or direction < -135 then
			-- Up
			self.animate(1, 3, 0.2, dt)
		elseif direction >= 45 and direction < 135 then
			-- Right / 90
			self.animate(10, 12, 0.2, dt)
		elseif direction >= -45 and direction < 45 then
			-- Down
			self.animate(7, 9, 0.2, dt)
		elseif direction >= -135 and direction < -45 then
			-- Left / -90
			self.animate(4, 6, 0.2, dt)
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
		spriteset.data[1].quad = animation.quad
	end

	function self.draw()
		-- Draw
		buffer:add(spriteset)
	end

	function self.setPosition(xn, yn)
		x, y = xn, yn
	end
	
	function self.getPosition()
		return x, y
	end

	function self.getX()
		return x
	end
	function self.getY()
		return y
	end
	function self.getDirection()
		return direction
	end

	return self
end