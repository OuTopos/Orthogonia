sprites = {}
sprites.enabled = true
sprites.sheets = {}
sprites.buffer = {}

function sprites.addSheet(imagePath, gx, gy)
	local image = love.graphics.newImage( "images/"..imagePath..".png" )
	local width = image:getWidth()
	local height = image:getHeight()
	local quads = {}
	local i = 0
	for y=0, math.floor(height/gx)-1 do
		for x=0, math.floor(width/gy)-1 do
			i = i + 1
			quads[i] = love.graphics.newQuad(x*gx, y*gy, gx, gy, width, height)
		end
	end

	sprites.sheets[imagePath] = {}
	sprites.sheets[imagePath].image = image
	sprites.sheets[imagePath].quads = quads
end

function sprites.addToBuffer(sheet, quad, x, y, z, ox, oy, sx, sy, r)
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
	table.insert(sprites.buffer, sprite)
end

function sprites.draw()
	if sprites.enabled then
		SPRITES_IN_BUFFER = #sprites.buffer
		table.sort( sprites.buffer, sprites.sort )

		love.graphics.setColor(255, 255, 255, 255)

		for index = 1, SPRITES_IN_BUFFER do
			local sheet = sprites.sheets[sprites.buffer[index].sheet]
			love.graphics.drawq(sheet.image, sheet.quads[sprites.buffer[index].quad], sprites.buffer[index].x, sprites.buffer[index].y, sprites.buffer[index].r, sprites.buffer[index].sx, sprites.buffer[index].sy, sprites.buffer[index].ox, sprites.buffer[index].oy)
		end
	end

	sprites.buffer = {}
end

function sprites.sort(a, b)
	if a.y+a.z < b.y+b.z then
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