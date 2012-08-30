player = {}
player.x = 350
player.y = 350
player.speed = {}
player.speed.x = 0
player.speed.y = 0
player.speed.max = 100
player.speed.acceleration = 0.75
player.speed.slowdown = 0.90
player.state = "start"
player.direction = "south"

function player.load()
	sprites.addSheet("BODY_skeleton", 64, 64)
end

function player.move(derp)
	if love.keyboard.isDown("right") then
		player.speed.x = player.speed.max
		player.state = "moving"
		player.direction = "east"
	elseif love.keyboard.isDown("left") then
		player.speed.x = -player.speed.max
		player.state = "moving"
		player.direction = "west"
	elseif  player.speed.x > 0.1 or player.speed.x < -0.1 then
		player.speed.x = player.speed.x * player.speed.slowdown
		player.state = "sliding"
	elseif not (player.speed.x == 0) then
		player.speed.x = 0
		player.state = "stopped"
	end

	
	if love.keyboard.isDown("down") then
		player.speed.y = player.speed.max
		player.state = "moving"
		player.direction = "south"
	elseif love.keyboard.isDown("up") then
		player.speed.y = -player.speed.max
		player.state = "moving"
		player.direction = "north"
	elseif  player.speed.y > 0.1 or player.speed.y < -0.1 then
		player.speed.y = player.speed.y * player.speed.slowdown
		player.state = "sliding"
	elseif not (player.speed.y == 0) then
		player.speed.y = 0
		player.state = "stopped"
	end




	if player.x > 1024 then
		player.speed.x = -100
	end
	if player.y < -128 then
		player.speed.y = - player.speed.y * 2
	end

	player.x = player.x + player.speed.x * derp
	player.y = player.y + player.speed.y * derp

	player.RoundX = math.floor( player.x + 0.5 )
	player.RoundY = math.floor( player.y + 0.5 )

	local tile = {}
	tile.name= "Player"
	tile.x = player.RoundX
	tile.y = player.RoundY
	tile.z = 1 * map.tileSize --+ 32 --Since it 64 pixels high instead 32.
	tile.type = 13

	if player.direction == "north" then
		sprites.addToBuffer("BODY_skeleton", 1, tile.x, tile.y, tile.z, 32, 48, 1, 1, 0)
	elseif player.direction == "west" then
		sprites.addToBuffer("BODY_skeleton", 10, tile.x, tile.y, tile.z, 32, 48, 1, 1, 0)
	elseif player.direction == "south" then
		sprites.addToBuffer("BODY_skeleton", 19, tile.x, tile.y, tile.z, 32, 48, 1, 1, 0)
	elseif player.direction == "east" then
		sprites.addToBuffer("BODY_skeleton", 28, tile.x, tile.y, tile.z, 32, 48, 1, 1, 0)
	end
end