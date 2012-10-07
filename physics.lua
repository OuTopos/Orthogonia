physics = {}
physics.objects = {}


function physics.setWorld(xg, yg, meter, sleep)
	love.physics.setMeter(meter or 32)

	physics.world = nil
	physics.world = love.physics.newWorld(0, 0, sleep or false)
end

function physics.newObject(body, shape, sensor)
	local object = {body = body, shape = shape}
	object.fixture = love.physics.newFixture(object.body, object.shape, 5) 
	table.insert(physics.objects, object)
	if sensor then
		object.fixture:setSensor(true)
	end
	return object
end

function physics.destroy()
	if physics.world then
		physics.world:destroy()
		physics.world = nil
	end
	physics.objects = {}
end


function physics.update(dt)
	if physics.world then
		physics.world:update(dt)
	end
end

function physics.draw()
	for i = 1, #physics.objects do
		love.graphics.setColor(255, 0, 255, 204)
		if physics.objects[i].fixture:isSensor() then
			love.graphics.setColor(0, 255, 255, 102)
		else
			love.graphics.setColor(255, 0, 0, 102)
		end

		if physics.objects[i].shape:getType() == "circle" then
			love.graphics.circle("fill", physics.objects[i].body:getX(), physics.objects[i].body:getY(), physics.objects[i].shape:getRadius(), 16)
		elseif physics.objects[i].shape:getType() == "polygon" then
			love.graphics.polygon("fill", physics.objects[i].body:getWorldPoints(physics.objects[i].shape:getPoints()))
		elseif physics.objects[i].shape:getType() == "edge" then
			love.graphics.line(physics.objects[i].body:getWorldPoints(physics.objects[i].shape:getPoints()))
		elseif physics.objects[i].shape:getType() == "chain" then
			love.graphics.line(physics.objects[i].body:getWorldPoints(physics.objects[i].shape:getPoints()))
		end
	end
end