SPRITES_IN_BUFFER = 0 -- Number of sprites currently in the buffer
TIMESCALE = 1
ACTIVE_PLAYER = 1





require "screen"
require "camera"
require "gui"
require "hud"
require "sprites"
require "map"
require "env"
require "players"
require "client"

-- Particle test
--require "weather"

-- Libraries
--0local easing = require("lib/easing/easing")

function love.load()
	love.graphics.setDefaultImageFilter( "nearest", "nearest" )
	--love.graphics.setMode(screen.width, screen.height, false, true, 0) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing

	--imagefont = love.graphics.newImage("images/imagefont2.png")
	--font = love.graphics.newImageFont(imagefont,
	--" abcdefghijklmnopqrstuvwxyz" ..
	--"ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	--"123456789.,!?-+/():;%&`'*#=[]\"")

	imagefont = love.graphics.newImage("images/font.png")
	font = love.graphics.newImageFont(imagefont," abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)




	camera:scale(screen.scale)

	gui.load()


	ACTIVE_PLAYER = 1 --math.random(99999)
	players.new("BODY_skeleton", ACTIVE_PLAYER)
	players.new("soldier", 2)
	players.new("princess", 3)
	players.new("hollow_woman", 4)

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
	if key == "m" then
		map:unload()
	end
	if key == "n" then
		map:load()
	end

	if key == "1" then
		ACTIVE_PLAYER = 1
	end
	if key == "2" then
		ACTIVE_PLAYER = 2
	end
	if key == "3" then
		ACTIVE_PLAYER = 3
	end
	if key == "4" then
		ACTIVE_PLAYER = 4
	end
	if key == "0" then
		screen.scaleToggle()
	end
end

function love.update(dt)
	dt = dt * TIMESCALE

	players.update(dt)

	-- Update the camera according to the active players position
	camera:center(players.list[ACTIVE_PLAYER].xr, players.list[ACTIVE_PLAYER].yr)

	-- Update the map according to the active players position
	map:update(players.list[ACTIVE_PLAYER].xr, players.list[ACTIVE_PLAYER].yr)

	env.update(dt)
end

function love.draw()
	camera:set()

	-- Draw the sprite buffer
	sprites.draw()

	-- Draw env stuff
	env.draw()

	-- Draw the GUI
	gui.draw()

	-- Draw the HUD
	hud.draw()

	camera:unset()
end