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

function player.move(derp)
	if love.keyboard.isDown("right") then
		player.speed.x = player.speed.max
		player.state = "moving"
	elseif love.keyboard.isDown("left") then
		player.speed.x = -player.speed.max
		player.state = "moving"
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
	elseif love.keyboard.isDown("up") then
		player.speed.y = -player.speed.max
		player.state = "moving"
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
end