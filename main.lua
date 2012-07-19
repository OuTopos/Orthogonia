require "screen"
require "camera"
require "map"
require "player"
require "tiles"

-- Libraries
local easing = require("lib/easing/easing")


require "screenObjectsHandler"


function love.load()
	love.graphics.setDefaultImageFilter( "nearest", "nearest" )
	
	hamster = love.graphics.newImage("sprites/ape.png")
	arkanos = love.graphics.newImage("sprites/Arkanos.png")
	farming = love.graphics.newImage("sprites/farming.png")
	playerSprite = love.graphics.newImage("sprites/player.png")

	grid = love.graphics.newImage("sprites/grid.png")

	screenObjectsHandler.create("apeball", "sprite", {"hamster", 100, 100, math.rad(90)})
	
	--screenObjectsHandler.create("ball2", "sprite", {"hamster", 120, 20, math.rad(90)})

	
	--screenObjectsHandler.create("test1", "sprite", {"ape", 400, 300, 0, 1, 1, 40, 40})
	--screenObjectsHandler.create("test2", "sprite", {"ape", 440, 300, 0, 1, 1, 40, 40})
	--screenObjectsHandler.create("test3", "sprite", {"ape", 480, 300, 0, 1, 1, 40, 40})

		--initial graphics setup
	--love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
	love.graphics.setMode(1366, 768, true, true, 0) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing


	imagefont = love.graphics.newImage("sprites/imagefont.png")
	font = love.graphics.newImageFont(imagefont,
	" abcdefghijklmnopqrstuvwxyz" ..
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	"123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)





	camera:scale(3)

	map.load()
	--updateTilesetBatch()
end

function love.keypressed(key)   -- we do not need the unicode, so we can leave it out
	if key == "escape" then
		love.event.push("quit")   -- actually causes the app to quit
	end
end

function love.update(dt)
	player.move(dt)
	
	map.updateTilesetBatch(player.RoundX, player.RoundY)
	map:updateView()
end

function love.draw()
	camera:center(player.RoundX, player.RoundY)
	camera:set()
	--		screenObjects[value.link].x = physicsObjects[id].body:getX()
	--	screenObjects[value.link].y = physicsObjects[id].body:getY()
	--	screenObjects[value.link].r = physicsObjects[id].body:getAngle()
	--love.graphics.rotate(physicsObjects.papeball.body:getAngle())
	--love.graphics.translate(-(physicsObjects.papeball.body:getX()+1366/2*2), -(physicsObjects.papeball.body:getY()+768/2*2))
	--love.graphics.scale(2, 2)
	--love.graphics.setColor(50, 50, 150, 255)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(arkanos, 0, 0, 0, 1)
	love.graphics.draw(farming, -768, 0, 0, 1)
	screenObjectsHandler.draw()
--	love.graphics.draw(tilesetBatch, map.view.x*map.tileSize-map.tileSize/2, map.view.y*map.tileSize-map.tileSize/2)
	--love.graphics.rectangle("fill", player.RoundX, player.RoundY, 32, 16)
	love.graphics.setColor(0, 255, 255, 102)
	love.graphics.rectangle("fill", player.RoundX-12, player.RoundY-8, 24, 16)
	love.graphics.setColor(255, 0, 0, 102)
	love.graphics.rectangle("fill", player.RoundX-16, player.RoundY-4, 32, 8)
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.draw(playerSprite, player.RoundX-32, player.RoundY-60, 0, 1)


	love.graphics.setColor(0, 0, 255, 102)
	love.graphics.circle("fill", player.RoundX, player.RoundY, 8, 40)
	love.graphics.setColor(255, 0, 0, 102)
	love.graphics.circle("fill", player.RoundX, player.RoundY, 1, 40)
	love.graphics.setColor(255, 255, 255, 255)

	--love.graphics.setColor(50, 50, 150, 255)


	-- Text Test
	love.graphics.setColor(255, 153, 153, 255)
	love.graphics.print('Hello World!', 204, 288)

	love.graphics.print(love.graphics.getMode(), 400, 420)
	
	-- Debug Text
	love.graphics.setColor(255, 255, 255, 153)
	love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 0)
	love.graphics.print("Cord: "..player.RoundX..":"..player.RoundY, camera.x + 2, camera.y + 17)
	love.graphics.print("Tile: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 34)
	love.graphics.print("Stuff: "..easing.linear(9, 0, 100, 10), camera.x + 2, camera.y + 51)

	love.graphics.setColor(255, 255, 255, 255)

	for x=0, 100-1 do
		y = easing.inSine(x, 0, 100, 100)
		love.graphics.circle("fill", camera.x + 2 + x, camera.y + 200 - y, 1)
	end

	xx = 50 
	yy = easing.inSine(xx, 0, 100, 100)
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.circle("fill", camera.x + 2 + xx, camera.y + 200 - yy, 1)

	love.graphics.setColor(255, 255, 255, 153)


	love.graphics.print(player.state, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 51)
	love.graphics.print("X: "..player.speed.x, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 34)
	love.graphics.print("Y: "..player.speed.y, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 17)
	
	camera:unset()
end