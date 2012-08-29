SPRITES_IN_BUFFER = 0 -- Number of sprites currently in the buffer

require "screen"
require "camera"
require "hud"
require "sprites"
require "map"
require "player"

-- Particle test
--require "weather"

-- Libraries
local easing = require("lib/easing/easing")

function love.load()
	love.graphics.setDefaultImageFilter( "nearest", "nearest" )
	love.graphics.setMode(screen.width, screen.height, false, true, 0) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing

	imagefont = love.graphics.newImage("images/imagefont2.png")
	font = love.graphics.newImageFont(imagefont,
	" abcdefghijklmnopqrstuvwxyz" ..
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	"123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)





	camera:scale(3)
	player.load()
	map = Map.create()
	map:load()
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
	if key == "s" then
		if sprites.enabled then
			sprites.enabled = false
		else
			sprites.enabled = true
		end
	end
end

function love.update(dt)
	player.move(dt)
	map:update(player.RoundX, player.RoundY)

	camera:center(player.RoundX, player.RoundY)
end

function love.draw()
	camera:set()

	-- Draw the sprite buffer
	sprites.draw()

	-- Draw the HUD
	hud.draw()

	camera:unset()
end