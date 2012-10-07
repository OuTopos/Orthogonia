entities_eyeball= {}

function entities_eyeball.new(view, control)
	local self = {}
	local remove = false


	local x, y, z = math.random(0,400), math.random(0,400), 32
	
	buffer:addSheet("entities/eyeball", 32, 38)
	local spriteset = buffer.spriteset(x-16, y-16, z, 0, 8)
	table.insert(spriteset.data, {sheet = "entities/eyeball", quad = 4} )

	-- Physics
	local object = physics.newObject(love.physics.newBody(physics.world, x, y, "dynamic"), love.physics.newCircleShape(12))
	object.body:setLinearDamping( 1 )
	object.body:setFixedRotation( true )
	object.fixture:setRestitution( 0.9 )
	function self.update(dt, i)
		x = math.floor( object.body:getX() + 0.5 ) -16
		y = math.floor( object.body:getY() + 0.5 ) -16

		spriteset.x = x
		spriteset.y = y
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