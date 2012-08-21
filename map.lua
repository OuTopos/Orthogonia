TILESIZE = 32

Map = {}
Map.__index = Map

function Map.create()
	local self = {}
	setmetatable(self, Map)

	self.tileSize = 32 -- Stick to 16, 32, 64 or something like that.
	
	-- All values below are in tiles not pixels

	self.size = { x = 100, y = 100, z = 3}
	self.tiles = {}

	self.view = { x = 0, y = 0, z = 0}
	self.view.size = { x = 13, y = 7, z = 3}

	return self
end


function Map:load()
	-- Random tiles, replace with real loading later.
	math.randomseed(os.time())

	for x=0,self.size.x-1 do
		self.tiles[x] = {}
		for y=0,self.size.y-1 do
			self.tiles[x][y] = {}
			for z=0,self.size.z-1 do
				if z == 0 then
					self.tiles[x][y][z] = math.random(0,3)
				elseif z == 1 then
					self.tiles[x][y][z] = math.random(4,7)
				elseif z == 2 then
					self.tiles[x][y][z] = 6
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

	-- player
	tileQuads[8] = love.graphics.newQuad(4 * self.tileSize, 1 * self.tileSize, self.tileSize, self.tileSize,
	tilesetImage:getWidth(), tilesetImage:getHeight())



	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, self.view.size.x * self.view.size.y)
end

function Map:update(x, y)
	self.view.x = math.floor( math.floor( x / self.tileSize + 0.5 ) - (self.view.size.x / 2) + 0.5 )
	self.view.y = math.floor( math.floor( y / self.tileSize + 0.5 ) - (self.view.size.y / 2) + 0.5 )

	sprites2 = {}
	for x=self.view.x, self.view.x+self.view.size.x-1 do
		for y=self.view.y, self.view.y+self.view.size.y-1 do
			for z=self.view.z, self.view.z+self.view.size.z-1 do
				local tile = {}
				tile.name= "Tile"
				tile.x = x * self.tileSize
				tile.y = y * self.tileSize
				tile.z = z * self.tileSize
				tile.type = self.tiles[x][y][z]
				--table.insert(sprites2, tile)
				sprites.add("magecity", tile.type, tile.x, tile.y, tile.z, 16, 16, 1, 1, 0)
			end
		end
	end

	local tile = {}
	tile.name= "Player"
	tile.x = player.RoundX
	tile.y = player.RoundY
	tile.z = 1 * map.tileSize + 32 --Since it 64 pixels high instead 32.
	tile.type = 8
	sprites.add("magecity", tile.type, tile.x, tile.y, tile.z, 16, 8, 2, 2, 0)
end