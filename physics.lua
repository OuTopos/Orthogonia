physics = {}
physics.enabled = true
physics.objects = {}
physics.worlds = {}


function physics.newWorld(world, xg, yg, meter, sleep)
end

function physics.setWorld(world, xg, yg, meter, sleep)
	love.physics.setMeter(meter or 32)

	if not physics.worlds[world] then
		physics.worlds[world] = love.physics.newWorld(xg, yg, sleep or false)
		physics.worlds[world]:setCallbacks(physics.beginContact, physics.endContact)
	end
	physics.world = physics.worlds[world]

	--physics.destroy()
	--love.physics.setMeter(meter or 32)
	--physics.world = love.physics.newWorld(xg, yg, sleep or false)
	--physics.world:setCallbacks(physics.beginContact, physics.endContact)
end

function physics.newObject(body, shape, userdata, sensor)
	local object = {body = body, shape = shape}
	object.fixture = love.physics.newFixture(object.body, object.shape, 5)
	object.fixture:setUserData(userdata)
	if sensor then
		object.fixture:setSensor(true)
	end
	table.insert(physics.objects, object)
	return object
end

function physics.destroy()
	print("DESTROY WORLD NOOOO!")
	if physics.world then
		physics.world:destroy()
		physics.world = nil
	end
	physics.objects = {}
end


function physics.update(dt)
	if physics.enabled then
		if physics.world then
			physics.world:update(dt)
		end
	end
end

function physics.draw()
	for i = 1, #physics.objects do
		if physics.objects[i].body:getType() == "static" then
			if physics.objects[i].fixture:isSensor() then
				love.graphics.setColor(255, 0, 255, 102)
			elseif physics.objects[i].fixture:getUserData() then
				love.graphics.setColor(255, 255, 0, 102)
			else
				love.graphics.setColor(255, 0, 0, 102)
			end
		elseif physics.objects[i].body:getType() == "dynamic" then
			if physics.objects[i].fixture:isSensor() then
				love.graphics.setColor(0, 255, 255, 102)
			elseif physics.objects[i].fixture:getUserData() then
				love.graphics.setColor(0, 255, 0, 102)
			else
				love.graphics.setColor(0, 0, 255, 102)
			end
		end

		if physics.objects[i].shape:getType() == "circle" then
			love.graphics.circle("fill", physics.objects[i].body:getX(), physics.objects[i].body:getY(), physics.objects[i].shape:getRadius())
		elseif physics.objects[i].shape:getType() == "polygon" then
			love.graphics.polygon("fill", physics.objects[i].body:getWorldPoints(physics.objects[i].shape:getPoints()))
		elseif physics.objects[i].shape:getType() == "edge" then
			love.graphics.line(physics.objects[i].body:getWorldPoints(physics.objects[i].shape:getPoints()))
		elseif physics.objects[i].shape:getType() == "chain" then
			love.graphics.line(physics.objects[i].body:getWorldPoints(physics.objects[i].shape:getPoints()))
		end
	end
end


function physics.beginContact(a, b, contact)
	if a:getUserData() == player then
		a:getUserData().beginContact(b, contact)
	end
	if b:getUserData() == player then
		b:getUserData().beginContact(a, contact)
	end
end

function physics.endContact(a, b, contact)
	
end

--physics.preSolve, physics.postSolve