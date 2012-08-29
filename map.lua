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
					random = math.random(1,4)
					if random == 1 then
						self.tiles[x][y][z] = 2
					elseif random == 2 then
						self.tiles[x][y][z] = 10
					elseif random == 3 then
						self.tiles[x][y][z] = 331
					elseif random == 4 then
						self.tiles[x][y][z] = 2
					end
				elseif z == 1 then
					self.tiles[x][y][z] = math.random(4,7)
				elseif z == 2 then
					self.tiles[x][y][z] = 4
				end
			end
		end
	end

	sprites.addSheet("magecity", self.tileSize, self.tileSize)
end

function Map:update(x, y)
	-- Moving the map view to x,y
	self.view.x = math.floor( math.floor( x / self.tileSize + 0.5 ) - (self.view.size.x / 2) + 0.5 )
	self.view.y = math.floor( math.floor( y / self.tileSize + 0.5 ) - (self.view.size.y / 2) + 0.5 )

	-- Add map tiles to sprite buffer
	for x=self.view.x, self.view.x+self.view.size.x-1 do
		for y=self.view.y, self.view.y+self.view.size.y-1 do
			for z=self.view.z, self.view.z+self.view.size.z-1 do
				if self.tiles[x] then
					if self.tiles[x][y] then
						if self.tiles[x][y][z] then
							local tile = {}
							tile.x = x * self.tileSize
							tile.y = y * self.tileSize
							tile.z = z * self.tileSize
							tile.quad = self.tiles[x][y][z]
							sprites.addToBuffer("magecity", tile.quad, tile.x, tile.y, tile.z, 16, 16, 1, 1, 0)
						end
					end
				end
			end
		end
	end
end