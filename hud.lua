hud = {}
hud.enabled = false

function hud.draw()
	if hud.enabled then

		-- The tile if the player would have been 32 x 32
		love.graphics.setColor(0, 0, 0, 102)
		love.graphics.rectangle("line", player.RoundX-16, player.RoundY-16, 32, 32)

		-- Player collission box
		love.graphics.setColor(255, 0, 0, 102)
		love.graphics.rectangle("fill", player.RoundX-16, player.RoundY, 32, 8)

		-- Player position
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.circle("fill", player.RoundX, player.RoundY, 1, 16)

		-- Text
		love.graphics.setColor(255, 255, 255, 153)
		love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 0)
		love.graphics.print("Cord: "..player.RoundX..":"..player.RoundY, camera.x + 2, camera.y + 17)
		love.graphics.print("Tile: "..math.floor( player.RoundX / map.tileSize + 0.5 )..":"..math.floor( player.RoundY / map.tileSize + 0.5 ), camera.x + 2, camera.y + 34)
		love.graphics.print("View: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 51)
		love.graphics.print("Sprites: "..SPRITES_IN_BUFFER, camera.x + 2, camera.y + 68)

		love.graphics.print(player.state, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 51)
		love.graphics.print("X: "..player.speed.x, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 34)
		love.graphics.print("Y: "..player.speed.y, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 17)
	end
end	