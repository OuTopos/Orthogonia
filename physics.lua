physics = {}
physics.objects = {}


function physics.setWorld(xg, yg, meter, sleep)
	physics.destroy()
	love.physics.setMeter(meter or 32)
	physics.world = love.physics.newWorld(0, 0, sleep or false)
end

function physics.newObject(body, shape, entity, sensor)
	local object = {body = body, shape = shape}
	object.fixture = love.physics.newFixture(object.body, object.shape, 5)
	object.fixture:setUserData(entity)
	if sensor then
		object.fixture:setSensor(true)
	end
	table.insert(physics.objects, object)
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