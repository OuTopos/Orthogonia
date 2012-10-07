require "screen"
require "camera"
require "buffer"
require "map"
require "gui"
require "hud"
require "env"
require "physics"

require "entities"
--require "client"

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
	map.load("test")
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
		map.load("test")
	end
	if key == "w" then
		map.load("house1", "bedside")
	end
	if key == "e" then
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
		entities.new("coin", math.random(127.91, 128.19), math.random(127.91, 128.19), 32)
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
	physics.update(dt)
	entities.update(dt)
	env.update(dt)

	map.update(camera.x, camera.y)
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