Map = {}
Map.__index = Map

function Map.create()
	local self = {}
	setmetatable(self, Map)

	self.tileSize = 32 -- Stick to 16, 32, 64 or something like that.
	-- All values below are in tiles not pixels

	self.size = { x = 100, y = 100, z = 2}
	self.tiles = {}

	self.view = { x = 0, y = 0, z = 0}
	self.view.size = { x = 17, y = 10, z = 2}

	return self
end


function Map:load()
	-- Random tiles, replace with real loading later.
	for x=0,self.size.x-1 do
		self.tiles[x] = {}
		for y=0,self.size.y-1 do
			self.tiles[x][y] = {}
			for z=0,self.size.z-1 do
				if z == 0 then
					self.tiles[x][y][z] = math.random(0,3)
				elseif z == 1 then
					self.tiles[x][y][z] = math.random(4,7)
				end
			end
		end
	end

	tilesetImage = love.graphics.newImage( "sprites/tiles/magecity.png" )

	tileQuads = {}
	-- grass
	tileQuads[0] = love.graphics.newQuad(0 * self.tileSize, 0 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- kitchen floor tile
	tileQuads[1] = love.graphics.newQuad(2 * self.tileSize, 36 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- parquet flooring
	tileQuads[2] = love.graphics.newQuad(3 * self.tileSize, 36 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- middle of red carpet
	tileQuads[3] = love.graphics.newQuad(5 * self.tileSize, 36 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())

	-- plant
	tileQuads[4] = love.graphics.newQuad(2 * self.tileSize, 0 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- plant in pot
	tileQuads[5] = love.graphics.newQuad(4 * self.tileSize, 0 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- plant
	tileQuads[6] = love.graphics.newQuad(2 * self.tileSize, 1 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())
	-- barrel
	tileQuads[7] = love.graphics.newQuad(4 * self.tileSize, 1 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())


	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, self.view.size.x * self.view.size.y)
end

function Map:update(x, y)
	self.view.x = math.floor( math.floor( x / self.tileSize + 0.5 ) - (self.view.size.x / 2) + 0.5 )
	self.view.y = math.floor( math.floor( y / self.tileSize + 0.5 ) - (self.view.size.y / 2) + 0.5 )
end

function Map:draw()
	sprites = {}
	for x=self.view.x, self.view.x+self.view.size.x-1 do
		for y=self.view.y, self.view.y+self.view.size.y-1 do
			for z=self.view.z, self.view.z+self.view.size.z-1 do
				--love.graphics.drawq(tilesetImage, tileQuads[self.tiles[x][y][z]], x*self.tileSize-self.tileSize/2, y*self.tileSize-self.tileSize/2)
				local tile = {}
				tile.name= "Tile"
				tile.x = x * map.tileSize
				tile.y = y * map.tileSize
				tile.z = z
				tile.type = self.tiles[x][y][z]
				table.insert(sprites, tile)
			end
		end
	end

	local tile = {}
	tile.name= "Player"
	tile.x = player.RoundX
	tile.y = player.RoundY
	tile.z = 1
	tile.type = 7
	table.insert(sprites, tile)
	table.sort( sprites, sortfunction )

	for index = 1, #sprites do 
		love.graphics.drawq(tilesetImage, tileQuads[sprites[index].type], sprites[index].x-map.tileSize/2, sprites[index].y-map.tileSize/2)
	end

end

function sortfunction(a, b)
		if a.z < b.z then
			return true
		end

		if a.z == b.z then
			if a.y < b.y then
				return true
			end

			if a.y == b.y then
				if a.x < b.x then
					return true
				end
			end
		end

		return false
	end

-- Create list/table 
tiles_list = {}
sprites = {}


math.randomseed(os.time())
-- Create 1024 tiles
--for index = 1, 5 do
	-- print(index)
--	tile = Tile:new('Tile ' .. index, math.random(0, 9), math.random(0, 9), math.random(0, 9), math.random(0, 4))
--	table.insert(tiles_list, tile)
--end

function dannesversion()
		for z=0,1 do
			for y=0,9 do
				for x=0,9 do
					if z == 0 then
						--self.tiles[x.."_"..y.."_"..z] = Tile.create(x, y, z, math.random(0,3))
						local tile = {}
						tile.name= "Tile"
						tile.x = x * map.tileSize
						tile.y = y * map.tileSize
						tile.z = z
						tile.type = math.random(0, 3)
						--tile = Tile:new('Tile ', x, y, z, math.random(0, 3))
						table.insert(tiles_list, tile)
						table.insert(sprites, tile)
					elseif z == 1 then
						--self.tiles[x.."_"..y.."_"..z] = Tile.create(x, y, z, math.random(4,7))
						--tile = Tile:new('Tile ', x, y, z, math.random(4, 7))
						local tile = {}
						tile.name= "Tile"
						tile.x = x * map.tileSize
						tile.y = y * map.tileSize
						tile.z = z
						tile.type = math.random(4, 7)
						table.insert(tiles_list, tile)
						table.insert(sprites, tile)
					end
				end
			end
		end
		print(#tiles_list)
	-- Create single tile
	-- local t1 = Tile:new('Tile 1', 1, 2, 3)
	-- local t2 = Tile:new('Tile 2', 0, 0, 56)
	-- t2.x = 2

	-- t1:notice()
	-- t2:notice()

	-- Insert tiles in list/table
	-- table.insert(tiles_list, t1)
	-- table.insert(tiles_list, t2)


	-- foreach is deprecated in lua 5.1 use pairs() instead.
	-- table.foreach(tiles_list, printStuff)


	for index = 1, 5 do 
	    --tiles_list[index]:notice()
	end



	print('SORTING')
	
	table.sort( tiles_list, sortfunction )


	for index = 1, 5 do 
	    --tiles_list[index]:notice()
	    --print(tiles_list[index]:getType())
	end
end

function drawtiles()
	table.sort( sprites, sortfunction )
	for index = 1, #tiles_list do 
		--tiles_list[index]:notice()
		love.graphics.drawq(tilesetImage, tileQuads[sprites[index].type], sprites[index].x-map.tileSize/2, sprites[index].y-map.tileSize/2)
	end
end
