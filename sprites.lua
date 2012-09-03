sprites = {}
sprites.enabled = true
sprites.sheets = {}
sprites.buffer = {}

function sprites.addSheet(imagePath, gx, gy)
	if not sprites.sheets[imagePath] then
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
	SPRITES_IN_BUFFER = 0

	if sprites.enabled then
		SPRITES_IN_BUFFER = #sprites.buffer
		table.sort( sprites.buffer, sprites.sort )

		love.graphics.setColor(255, 255, 255, 255)

		for i = 1, SPRITES_IN_BUFFER do
			local sheet = sprites.sheets[sprites.buffer[i].sheet]
			love.graphics.drawq(sheet.image, sheet.quads[sprites.buffer[i].quad], sprites.buffer[i].x, sprites.buffer[i].y, sprites.buffer[i].r, sprites.buffer[i].sx, sprites.buffer[i].sy, sprites.buffer[i].ox, sprites.buffer[i].oy)
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