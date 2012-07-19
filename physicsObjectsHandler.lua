physicsObjectsHandler = {}
physicsObjects = {}

function physicsObjectsHandler.create(id, link, body, shape)
	physicsObjects[id] = {}
	physicsObjects[id].link = link
	physicsObjects[id].body = love.physics.newBody(world, body[1], body[2], body[3]) --place the body in the center of the world and make it dynamic, so it can move around
	physicsObjects[id].shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
	physicsObjects[id].fixture = love.physics.newFixture(physicsObjects[id].body, physicsObjects[id].shape, 1) -- Attach fixture to body and give it a density of 1.
	physicsObjects[id].fixture:setRestitution(0.9) --let the ball bounce
end

function physicsObjectsHandler.update()
	for id,value in pairs(physicsObjects) do
		--print(key,value)
		--print(value.type)
	--for i=1,# screenObjects do
		screenObjects[value.link].x = physicsObjects[id].body:getX()
		screenObjects[value.link].y = physicsObjects[id].body:getY()
		screenObjects[value.link].r = physicsObjects[id].body:getAngle()
	end
end