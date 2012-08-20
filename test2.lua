Tile = {}
Tile.__index = Tile

function Tile.create(x,y,z,type)
	local tiledata = {}
	setmetatable(tiledata,Tile)
	tiledata.x = x
	tiledata.y = y
	tiledata.z = z
	tiledata.type = type
	return tiledata
end



Map = {}
Map.__index = Map

function Map.create()
	local self = {}
	setmetatable(self, Map)
	self.tiles = {}
	return self
end


function Map:load()
	for z=0,1 do
		for y=0,99 do
			for x=0,99 do
				if z == 0 then
					self.tiles[x.."_"..y.."_"..z] = Tile.create(x, y, z, math.random(0,3))
				elseif z == 1 then
					self.tiles[x.."_"..y.."_"..z] = Tile.create(x, y, z, math.random(4,7))
				end
			end
		end
	end
end