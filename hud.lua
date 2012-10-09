hud = {}
hud.enabled = false

--open = love.joystick.open( 1 )
--print(open)
function hud.draw()
	if hud.enabled then
		-- Setting tilesizes
		local tilewidth = 1
		local tileheight = 1
		if map.loaded then
			tilewidth = map.loaded.tilewidth
			tileheight = map.loaded.tileheight
		end

		physics.draw()

		-- Entities
		for i = 1, #entities.data do
			love.graphics.setColor(255, 255, 255, 102)
		--	love.graphics.rectangle("fill", entities.data[i].getX(), entities.data[i].getY(), 32, 32)

			love.graphics.setColor(0, 255, 255, 255)
			love.graphics.print(i, entities.data[i].getX(), entities.data[i].getY())
		end
		
		-- Text background
		love.graphics.setColor(0, 0, 0, 204)
		love.graphics.rectangle("fill", camera.x, camera.y, 100, 82)	

		-- Text
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 2)
		if player then
			love.graphics.print("Cord: "..player.getX()..":"..player.getY(), camera.x + 2, camera.y + 12)
			love.graphics.print("Tile: "..math.floor( player.getX() / tilewidth + 0.5 )..":"..math.floor( player.getY() / tileheight + 0.5 ), camera.x + 2, camera.y + 22)
		end
		love.graphics.print("View: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 32)
		love.graphics.print("Buffer: "..buffer.length, camera.x + 2, camera.y + 42)
		love.graphics.print("Physics: "..physics.world:getBodyCount(), camera.x + 2, camera.y + 52)

		if love.joystick.getNumJoysticks() > 0 then
			xisDir1, axisDir2, axisDirN = love.joystick.getAxes( 1 )
			love.graphics.print(xisDir1, camera.x + 2, camera.y + 52)
			love.graphics.print(axisDir2, camera.x + 2, camera.y + 62)
			love.graphics.print(love.joystick.getNumAxes(1), camera.x + 2, camera.y + 72)
		end
	end
end	