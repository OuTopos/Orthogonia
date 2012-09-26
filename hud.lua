hud = {}
hud.enabled = false

function hud.draw()
	if hud.enabled then
		-- Setting tilesizes
		local tilewidth = 1
		local tileheight = 1
		if map.loaded then
			tilewidth = map.loaded.tilewidth
			tileheight = map.loaded.tileheight
		end

		-- Draw collision
		collision.draw()

		-- Entities
		for i = 1, #entities.data do
			love.graphics.setColor(255, 255, 255, 102)
			love.graphics.rectangle("fill", entities.data[i].getX(), entities.data[i].getY(), 32, 32)
			if entities.data[i].collision then
				love.graphics.setColor(255, 0, 0, 153)
				love.graphics.rectangle("fill", entities.data[i].getCollision())
			end
			love.graphics.setColor(0, 255, 255, 255)
			love.graphics.print(i, entities.data[i].getX(), entities.data[i].getY())
		end
		
		-- Text background
		love.graphics.setColor(0, 0, 0, 204)
		love.graphics.rectangle("fill", camera.x, camera.y, 100, 82)	

		-- Text
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 2)
		--love.graphics.print("Cord: "..entities.data[entities.viewing].getX()..":"..entities.data[entities.viewing].getY(), camera.x + 2, camera.y + 12)
		--love.graphics.print("Tile: "..math.floor( entities.data[entities.viewing].getX() / tilewidth + 0.5 )..":"..math.floor( entities.data[entities.viewing].getY() / tileheight + 0.5 ), camera.x + 2, camera.y + 22)
		love.graphics.print("View: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 32)
		love.graphics.print("Buffer: "..buffer.length, camera.x + 2, camera.y + 42)

		--love.graphics.print(players.list[ACTIVE_PLAYER].state, camera.x + 2, camera.y + 52)
		--love.graphics.print("xvel: "..entities.data[entities.viewing].getXvel(), camera.x + 2, camera.y + 62)
		--love.graphics.print("yvel: "..entities.data[entities.viewing].getYvel(), camera.x + 2, camera.y + 72)
	end
end	