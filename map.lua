map = {}
map.world = "/worlds/orthogonia/"
map.view = { x = 0, y = 0, z = 0}
map.view.size = { x = 13, y = 9, z = 0}
map.view.buffer = {}

function map.load(file, world)
	map.world = world or map.world 

	-- Reseting collision data and unloading previous map.
	map.unload()

	-- Loading map
	map.loaded = require(map.world..file)
	if map.loaded.orientation == "orthogonal" then
		-- Loading objects (collision)
		for i,layer in ipairs(map.loaded.layers) do
			if layer.type == "objectgroup" and layer.properties.behavior == "block" then
				for i,object in ipairs(layer.objects) do
					collision.new(object.x, object.y, object.width, object.height)
				end
			end
		end

		-- Loading tilesets
		for i,tileset in ipairs(map.loaded.tilesets) do
			buffer:addSheet(string.match(tileset.image, "../../images/(.*).png"), tileset.tilewidth, tileset.tileheight)
		end

		-- Setting up map view
		map.view.size.x = math.floor(screen.width / map.loaded.tilewidth + 0.5 ) + 2
		map.view.size.y = math.floor(screen.height / map.loaded.tileheight + 0.5 ) + 2

		-- Setting camera boundaries
		camera:setBoundaries(0, map.loaded.width * map.loaded.tilewidth, 0, map.loaded.height * map.loaded.tileheight)

	else
		print("Map is not compatible.")
		map.unload()
	end
end

function map.unload()
	map.loaded = nil
	buffer:reset()
	collision.reset()
end

function map.findSheet(quad)
	i = #map.loaded.tilesets
	while map.loaded.tilesets[i] and quad < map.loaded.tilesets[i].firstgid do
		i = i - 1
	end
	return {string.match(map.loaded.tilesets[i].image, "../../images/(.*).png"), quad-(map.loaded.tilesets[i].firstgid-1)}
end

function map.update(x, y)
	if map.loaded then
		-- Moving the map view to x,y
		local xn = math.floor( x / map.loaded.tilewidth + 0.5 ) - 1
		local yn = math.floor( y / map.loaded.tileheight + 0.5 ) - 1
		if xn ~= map.view.x or yn ~= map.view.y then
			-- Player moved to another tile
			map.view.x = xn
			map.view.y = yn

			-- Trigger a buffer reset.
			buffer:reset()	
		end
	end
end

function map.draw()
	if map.loaded then
		-- Store layerdepth to speed up
		local layerdepth = #map.loaded.layers
		local z = 0
		local spriteset

		-- Iterate the x-axis.
		for x=map.view.x, map.view.x+map.view.size.x-1 do
			-- Check so that x is not outside the map.
			if x > -1 and x < map.loaded.width then
				
				-- Iterate the y-axis.
				for y=map.view.y, map.view.y+map.view.size.y-1 do
					-- Check so that y is not outside the map.
					if y > -1 and y < map.loaded.height then

						-- Assign a new table to spriteset
						spriteset = buffer.spriteset(x*map.loaded.tilewidth, y*map.loaded.tileheight, z*map.loaded.tileheight)

						-- Iterate the layerdepth
						for i=1, layerdepth do
							-- Check if layer is a tilelayer.
							if map.loaded.layers[i].type == "tilelayer" then

								-- Checking so tile exists.
								if map.loaded.layers[i].data[y*map.loaded.width+x+1] then
									-- Checking so tile is not empty.
									if map.loaded.layers[i].data[y*map.loaded.width+x+1] > 0 then
										
										-- Get z from tilelayer properties.
										z = tonumber(map.loaded.layers[i].properties.z)

										-- Check if z has changed.
										if z*map.loaded.tileheight ~= spriteset.z then
											-- Check for sprites in spriteset to avoid sending empty spriteset to buffer
											if next(spriteset.data) ~= nil then
												buffer:add(spriteset)
												spriteset = buffer.spriteset(x*map.loaded.tilewidth, y*map.loaded.tileheight, z*map.loaded.tileheight)
											end
											-- Setting spriteset z to new z
											spriteset.z = z*map.loaded.tileheight
										end

										-- Adding sprite to spriteset.
										poop = map.findSheet(map.loaded.layers[i].data[y*map.loaded.width+x+1])
										table.insert(spriteset.data, {sheet = poop[1], quad = poop[2]} )
										
									end
								end


							end

						end
						-- Check for sprites in spriteset to avoid sending empty spriteset to buffer
						if next(spriteset.data) ~= nil then
							buffer:add(spriteset)
						end

					end



				end
			end

		end
	end

end