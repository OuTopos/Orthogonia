sprites = {}
sprites.table = {}
sprites.sheets = {}

function sprites.addSheet(imagePath, gx, gy)
	local image = love.graphics.newImage( "images/"..imagePath..".png" )
	local quads = {}
	local i = 0
	for x=0, image:getWidth()/gx do
		for y=0, image:getHeight()/gy do
			i = i + 1
			print(i.." "..x..":"..y)
			quads[i] = love.graphics.newQuad(x*gx, y*gy, gx, gy, image:getWidth(), image:getHeight())
		end
	end
	sprites.sheets[imagePath] = {}
	sprites.sheets[imagePath].image = image
	sprites.sheets[imagePath].quads = quads
end

function sprites.add(sheet, quad, x, y, z, ox, oy, sx, sy, r)
	local sprite = {}
	sprite.sheet = sheet
	sprite.quad = quad
	sprite.x = x
	sprite.y = y
	sprite.z = z
	sprite.ox = ox or 0
	sprite.oy = oy or 0
	sprite.sx = sx or 1
	sprite.sy = sy or 1
	sprite.r = r or 0
	table.insert(sprites.table, sprite)
end

function sprites.draw()
	table.sort( sprites.table, sprites.sort )
	local offset = map.tileSize/2

	love.graphics.setColor(255, 255, 255, 255)

	for index = 1, #sprites.table do
		love.graphics.drawq(tilesetImage, tileQuads[sprites.table[index].quad], sprites.table[index].x, sprites.table[index].y, sprites.table[index].r, sprites.table[index].sx, sprites.table[index].sy, sprites.table[index].ox, sprites.table[index].oy)
	end

	sprites.table = {}
end

function sprites.sort(a, b)
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