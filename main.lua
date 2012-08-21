love.graphics.setDefaultImageFilter( "nearest", "nearest" )

require "screen"
require "camera"
require "hud"
require "sprites"
require "map"
require "player"

-- Particle test
require "weather"

--require "screenObjectsHandler"

-- Libraries
local easing = require("lib/easing/easing")

function love.load()
	print("☻ Ey yo yo!")
	love.graphics.setDefaultImageFilter( "nearest", "nearest" )
	
	hamster = love.graphics.newImage("sprites/ape.png")
	arkanos = love.graphics.newImage("sprites/Arkanos.png")
	--farming = love.graphics.newImage("sprites/farming.png")
	playerSprite = love.graphics.newImage("sprites/player.png")

	grid = love.graphics.newImage("sprites/grid.png")

	love.graphics.setMode(screen.width, screen.height, false, true, 0) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing


	imagefont = love.graphics.newImage("sprites/imagefont2.png")
	font = love.graphics.newImageFont(imagefont,
	" abcdefghijklmnopqrstuvwxyz" ..
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	"123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)





	camera:scale(3)

	map = Map.create()
	map:load()
	--initiateFarticle()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
	if key == "h" then
		if hud.enabled then
			hud.enabled = false
		else
			hud.enabled = true
		end
	end
end

function love.update(dt)
	player.move(dt)
	map:update(player.RoundX, player.RoundY)

	--updateFarticle(dt)
end

function love.draw()
	camera:center(player.RoundX, player.RoundY)
	camera:set()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(arkanos, 0, 0, 0, 1)

	sprites.draw()
	hud.draw()

	camera:unset()
end