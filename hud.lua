hud = {}
hud.enabled = false

function hud.draw()
	if hud.enabled then

		-- The tile if the player would have been 32 x 32
		love.graphics.setColor(0, 0, 0, 102)
		love.graphics.rectangle("line", entities.data[entities.viewing].getX()-16, entities.data[entities.viewing].getY()-16, 32, 32)

		-- Player collission box
		love.graphics.setColor(255, 0, 0, 102)
		love.graphics.rectangle("fill", entities.data[entities.viewing].getX()-16, entities.data[entities.viewing].getY(), 32, 8)

		-- Player position
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.circle("fill", entities.data[entities.viewing].getX(), entities.data[entities.viewing].getY(), 1, 16)

		-- Player numbers
		love.graphics.setColor(0, 255, 255, 255)
		for i = 1, #entities.data do
			love.graphics.print(i, entities.data[i].getX() + 2, entities.data[i].getY() + 0)
		end

		-- Text background
		love.graphics.setColor(0, 0, 0, 204)
		love.graphics.rectangle("fill", camera.x, camera.y, 100, 82)	

		-- Text
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 2)
		love.graphics.print("Cord: "..entities.data[entities.viewing].getX()..":"..entities.data[entities.viewing].getY(), camera.x + 2, camera.y + 12)
		love.graphics.print("Tile: "..math.floor( entities.data[entities.viewing].getX() / map.tileSize + 0.5 )..":"..math.floor( entities.data[entities.viewing].getY() / map.tileSize + 0.5 ), camera.x + 2, camera.y + 22)
		love.graphics.print("View: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 32)
		love.graphics.print("Buffer: "..buffer.length, camera.x + 2, camera.y + 42)

		--love.graphics.print(players.list[ACTIVE_PLAYER].state, camera.x + 2, camera.y + 52)
		love.graphics.print("xvel: "..entities.data[entities.viewing].getXvel(), camera.x + 2, camera.y + 62)
		love.graphics.print("yvel: "..entities.data[entities.viewing].getYvel(), camera.x + 2, camera.y + 72)
	end
end	