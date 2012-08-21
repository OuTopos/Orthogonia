hud = {}
hud.enabled = false

function hud.draw()
	if hud.enabled then
		love.graphics.setColor(255, 255, 255, 255)

		love.graphics.draw(playerSprite, player.RoundX-32, player.RoundY-60, 0, 1)


		love.graphics.setColor(0, 0, 255, 102)
		love.graphics.circle("fill", player.RoundX, player.RoundY, 8, 40)
		love.graphics.setColor(255, 0, 0, 102)
		love.graphics.circle("fill", player.RoundX, player.RoundY, 1, 40)
		
		love.graphics.setColor(0, 255, 255, 102)
		love.graphics.rectangle("fill", player.RoundX-12, player.RoundY-8, 24, 16)
		love.graphics.setColor(255, 0, 0, 102)
		love.graphics.rectangle("fill", player.RoundX-16, player.RoundY-4, 32, 8)

		love.graphics.setColor(255, 255, 255, 153)
		love.graphics.print("FPS: "..love.timer.getFPS(), camera.x + 2, camera.y + 0)
		love.graphics.print("Cord: "..player.RoundX..":"..player.RoundY, camera.x + 2, camera.y + 17)
		love.graphics.print("Tile: "..math.floor( player.RoundX / map.tileSize + 0.5 )..":"..math.floor( player.RoundY / map.tileSize + 0.5 ), camera.x + 2, camera.y + 34)
		love.graphics.print("View: "..map.view.x..":"..map.view.y, camera.x + 2, camera.y + 51)

		love.graphics.print(player.state, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 51)
		love.graphics.print("X: "..player.speed.x, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 34)
		love.graphics.print("Y: "..player.speed.y, camera.x + 2, camera.y + camera.screenHeight / camera.scaleY - 17)
	end
end	