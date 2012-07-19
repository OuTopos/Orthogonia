screenObjectsHandler = {}
screenObjects = {}

function screenObjectsHandler.create(id, type, t)
	screenObjects[id] = {}
	if type == "sprite" then
		--drawable, x, y, r, sx, sy, ox, oy, kx, ky
		screenObjects[id].type = type
		screenObjects[id].drawable = t[1]
		screenObjects[id].x = t[2]
		screenObjects[id].y = t[3]
		screenObjects[id].r = t[4]
	end
	--table.insert(screenObjects, screenObject)
end

--function ScreenObjects:load()
	-- load all SOs
--end

function screenObjectsHandler.draw()
	for key,value in pairs(screenObjects) do
		--print(key,value)
		--print(value.type)
	--for i=1,# screenObjects do
		if value.type == "sprite" then
			love.graphics.draw(hamster, value.x, value.y, value.r, 1, 1, 40, 40)
		end
	end

	for key,value in pairs(screenObjects) do
		--print(key,value)
		--print(value.type)
	--for i=1,# screenObjects do
		if value.type == "sprite" then
			love.graphics.draw(hamster, value.x, value.y, value.r, 1, 1, 40, 40)
		end
	end
	--test = 0
	for zk,zv in next,map.view.drawables,nil do
		--test = test +1
		--print("Drawing; "..zk)
		for yk,yv in pairs(map.view.drawables[zk]) do
			for xk,xv in pairs(map.view.drawables[zk][yk]) do
				--print(zk,yk,xk,map.view.drawables[zk][yk][xk])
				--{"tilesetImage", map.tiles[z][y][x]}
				love.graphics.drawq(tilesetImage, tileQuads[map.view.drawables[zk][yk][xk][2]], xk, yk)
				
			end
		end
	end

	--print("Drawing END")
	--print(test)

	--for z=0, map.view.width-1 do
	--	for y=0, map.view.height-1 do
	--		for x=0, 2-1 do
	--			love.graphics.drawq(tilesetImage, tileQuads[map.tiles[x+map.view.x][y+map.view.y][z]], (x+map.view.x)*map.tileSize-map.tileSize/2, (y+map.view.y)*map.tileSize-map.tileSize/2)
	--		end
	--	end
	--end
end