TILESIZE = 32

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
	self.view.size = { x = 13, y = 9, z = 0}

	return self
end


function Map:load()
	-- Loading map
	testmap = require "worlds/orthogonia/test"
	self.size = { x = 100, y = 100, z = #testmap.layers}
	self.view.size.z = self.size.z

	sprites.addSheet("magecity", self.tileSize, self.tileSize)
end

function Map:unload()
	self.tiles = {}
end

function Map:update(x, y)
	-- Moving the map view to x,y
	self.view.x = math.floor( math.floor( x / self.tileSize + 0.5 ) - (self.view.size.x / 2) + 0.5 )
	self.view.y = math.floor( math.floor( y / self.tileSize + 0.5 ) - (self.view.size.y / 2) + 0.5 )

	-- Add tiles within the view to the sprite buffer
	for x=self.view.x, self.view.x+self.view.size.x-1 do
		for y=self.view.y, self.view.y+self.view.size.y-1 do
			for z=self.view.z, self.view.z+self.view.size.z-1 do

				if testmap.layers[z+1].data[y*self.size.x+x+1] then
					if testmap.layers[z+1].data[y*self.size.x+x+1] > 0 then
						sprites.addToBuffer("magecity", testmap.layers[z+1].data[y*self.size.x+x+1], x*self.tileSize, y*self.tileSize, z*self.tileSize, self.tileSize/2, self.tileSize/2, 1, 1, 0)
					end
				end

			end
		end
	end
end