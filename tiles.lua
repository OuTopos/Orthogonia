map = {}
map.tileSize = 32 -- Stick to 16, 32, 64 or something like that.
-- All below is in tiles not pixels
map.size = { x = 100, y = 100, z = 2}
map.width = 100
map.height = 100
map.view = {}
map.view.x = 0
map.view.y = 0
map.view.z = 0
map.view.size = {}
map.view.size.x = 11
map.view.size.y = 7
map.view.size.z = 2
map.view.width = 11
map.view.height = 7
map.view.tiles = {}

function map:load()
	map.tiles = {}
	for z=0,map.size.z-1 do
		print("Loading: "..z)
		map.tiles[z] = {}
		for y=0,map.size.y-1 do
			map.tiles[z][y] = {}
			for x=0,map.size.x-1 do
				if z == 1 then
					map.tiles[z][y][x] = math.random(0,3)
				elseif z == 0 then
					map.tiles[z][y][x] = math.random(4,7)
				end
			end
		end
	end

	tilesetImage = love.graphics.newImage( "sprites/tiles/magecity.png" )

	tileQuads = {}
	-- grass
	tileQuads[0] = love.graphics.newQuad(0 * map.tileSize, 0 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- kitchen floor tile
	tileQuads[1] = love.graphics.newQuad(2 * map.tileSize, 36 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- parquet flooring
	tileQuads[2] = love.graphics.newQuad(3 * map.tileSize, 36 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- middle of red carpet
	tileQuads[3] = love.graphics.newQuad(5 * map.tileSize, 36 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())

	-- plant
	tileQuads[4] = love.graphics.newQuad(2 * map.tileSize, 0 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- plant in pot
	tileQuads[5] = love.graphics.newQuad(4 * map.tileSize, 0 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- plant
	tileQuads[6] = love.graphics.newQuad(2 * map.tileSize, 1 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- barrel
	tileQuads[7] = love.graphics.newQuad(4 * map.tileSize, 1 * map.tileSize, map.tileSize, map.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())


	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, map.view.width * map.view.height)
end

function map:updateTilesetBatch()
	--tilesetBatch:clear()
	--for x=0, map.view.width-1 do
	--	for y=0, map.view.height-1 do
	--		tilesetBatch:addq(tileQuads[map.tiles[x+map.view.x][y+map.view.y]], x*map.tileSize, y*map.tileSize)
	--	end
	--end
end

map.entities = {}

function map:updateEntities()
	map.entities.player = {x = player.RoundX, y = player.RoundY, z = 1}
end

function map:updateView()
	map.view.x = math.floor( math.floor( player.RoundX / map.tileSize + 0.5 ) - (map.view.width / 2) + 0.5 )
	map.view.y = math.floor( math.floor( player.RoundY / map.tileSize + 0.5 ) - (map.view.height / 2) + 0.5 )

	map.view.drawables = {}

	--viewtest = 0
	--print("map.view.y: "..map.view.y, map.view.size.y-1)
	for z=map.view.z, map.view.z+map.view.size.z-1 do
		--print("Drawables:"..z )
		map.view.drawables[z] = {}
		for y=map.view.y, map.view.y+map.view.size.y-1 do
			--viewtest = viewtest +1
			map.view.drawables[z][y*map.tileSize-map.tileSize/2] = {}
			for x=map.view.x, map.view.x+map.view.size.x-1 do
				map.view.drawables[z][y*map.tileSize-map.tileSize/2][x*map.tileSize-map.tileSize/2] = {"tilesetImage", map.tiles[z][y][x]}
				love.graphics.drawq(tilesetImage, tileQuads[map.tiles[z][y+map.view.y][x+map.view.x]], (x+map.view.x)*map.tileSize-map.tileSize/2, (y+map.view.y)*map.tileSize-map.tileSize/2)
			end
		end
	end
	--print("Drawables END" )

	--print("Viewtest: "..viewtest)
	--map.view.tiles = {}
	--for x=0, map.view.width-1 do
	--	for y=0, map.view.height-1 do
	--		tilesetBatch:addq(tileQuads[map.tiles[x+map.view.x][y+map.view.y]], x*map.tileSize, y*map.tileSize)
	--	end
	--end


end