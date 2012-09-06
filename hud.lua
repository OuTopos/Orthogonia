hud = {}
hud.enabled = false

function hud.draw()
	if hud.enabled then

		-- The tile if the player would have been 32 x 32
		love.graphics.setColor(0, 0, 0, 102)
		love.graphics.rectangle("line", players.list[ACTIVE_PLAYER].xr-16, players.list[ACTIVE_PLAYER].yr-16, 32, 32)

		-- Player collission box
		love.graphics.setColor(255, 0, 0, 102)
		love.graphics.rectangle("fill", players.list[ACTIVE_PLAYER].xr-16, players.list[ACTIVE_PLAYER].yr, 32, 8)

		-- Player position
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.circle("fill", players.list[ACTIVE_PLAYER].xr, players.list[ACTIVE_PLAYER].yr, 1, 16)

		-- Player numbers
		love.graphics.setColor(0, 255, 255, 255)
		for k, v in pairs(players.list) do
			love.graphics.print(k, players.list[k].xr + 2, players.list[k].yr + 0)
		end

		-- Text background
		love.graphics.setColor(0, 0, 0, 204)
		love.graphics.rectangle("fill", camera.x, camera.y, 100, 82)	

		-- Text
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 2)
		love.graphics.print("Cord: "..players.list[ACTIVE_PLAYER].xr..":"..players.list[ACTIVE_PLAYER].yr, camera.x + 2, camera.y + 12)
		love.graphics.print("Tile: "..math.floor( players.list[ACTIVE_PLAYER].xr / map.tileSize + 0.5 )..":"..math.floor( players.list[ACTIVE_PLAYER].yr / map.tileSize + 0.5 ), camera.x + 2, camera.y + 22)
		love.graphics.print("View: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 32)
		love.graphics.print("Buffer: "..buffer.length, camera.x + 2, camera.y + 42)

		love.graphics.print(players.list[ACTIVE_PLAYER].state, camera.x + 2, camera.y + 52)
		love.graphics.print("X: "..players.list[ACTIVE_PLAYER].speed.x, camera.x + 2, camera.y + 62)
		love.graphics.print("Y: "..players.list[ACTIVE_PLAYER].speed.y, camera.x + 2, camera.y + 72)
	end
end	