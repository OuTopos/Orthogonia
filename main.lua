TIMESCALE = 1
ACTIVE_PLAYER = 1


require "screen"
require "buffer"
require "camera"
require "gui"
require "hud"
require "map"
require "env"
--require "players"

require "collision"
require "entities"
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
	--players.new("BODY_skeleton", ACTIVE_PLAYER)
	--players.new("soldier", 2)
	--players.new("princess", 3)
	--players.new("hollow_woman", 4)

	map = Map.create()
	map:load()
	entities.new("player", true, true)
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("eyeball")
	entities.new("snake")

	collision.new(100, 100, 100, 100)
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
	if key == "b" then
		if buffer.enabled then
			buffer.enabled = false
		else
			buffer.enabled = true
		end
	end
	if key == "m" then
		map:unload()
	end
	if key == "n" then
		poop = #entities.data
		table.insert(entities.remove, poop)
		entities.refresh = true
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

	entities.update(dt)
	collision.update(dt)
	-- Update the camera according to the active players position
	camera:center(entities.data[entities.viewing].getX(), entities.data[entities.viewing].getY())

	-- Update the map according to the active players position
	map:update(entities.data[entities.viewing].getX(), entities.data[entities.viewing].getY())

	env.update(dt)
end

function love.draw()
	camera:set()

	-- Draw the sprite buffer
	buffer:draw()

	-- Draw env stuff
	env.draw()
	-- Draw collision
	collision.draw()

	-- Draw the GUI
	gui.draw()

	-- Draw the HUD
	hud.draw()

	camera:unset()
end