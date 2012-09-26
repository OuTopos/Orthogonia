TIMESCALE = 1
ACTIVE_PLAYER = 1


require "screen"
require "camera"
require "buffer"
require "map"
require "gui"
require "hud"
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

	imagefont2 = love.graphics.newImage("images/imagefont2.png")
	font2 = love.graphics.newImageFont(imagefont2,
	" abcdefghijklmnopqrstuvwxyz" ..
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	"123456789.,!?-+/():;%&`'*#=[]\"")

	imagefont = love.graphics.newImage("images/font.png")
	font = love.graphics.newImageFont(imagefont," abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)




	camera:scale(screen.scale)

	gui.load()


	--ACTIVE_PLAYER = 1 --math.random(99999)
	--players.new("BODY_skeleton", ACTIVE_PLAYER)
	--players.new("soldier", 2)
	--players.new("princess", 3)
	--players.new("hollow_woman", 4)

	--entities.new("player", true, true)
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("eyeball")
	--entities.new("snake")

	--collision.new(128, 128, 64, 64)
	--collision.new(224, 128, 32, 32)

	--collision.new(96, 224, 64, 32)
	--collision.new(128, 96, 32, 32)

	map.load("house1", "bedside")
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
		map.unload()
	end
	if key == "q" then
		map.load("arena")
	end
	if key == "w" then
		map.load("test", "tats_house_door")
	end
	if key == "e" then
		map.load("16")
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
	--camera:center(entities.data[entities.viewing].getX(), entities.data[entities.viewing].getY())

	-- Update the map according to the active players position
	map.update(camera.x, camera.y)

	env.update(dt)
end

function love.draw()
	camera:set()

	
	-- Draw the sprite buffer
	if next(buffer.data) == nil then
		entities.draw()
		map.draw()
	end
	buffer:draw()

	-- Draw env stuff
	env.draw()

	-- Draw the GUI
	gui.draw()

	-- Draw the HUD
	hud.draw()

	camera:unset()
end