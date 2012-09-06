buffer = {}
buffer.enabled = true
buffer.sheets = {}
buffer.data = {}

function buffer:addSheet(imagePath, gx, gy)
	if not self.sheets[imagePath] then
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

		self.sheets[imagePath] = {}
		self.sheets[imagePath].image = image
		self.sheets[imagePath].quads = quads
	end
end

function buffer:add(sheet, quad, x, y, z, ox, oy, sx, sy, r)
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
	table.insert(buffer.data, sprite)
end

function buffer:draw()
	-- Reset buffer length variable
	self.length = 0

	if self.enabled then
		self.length = #self.data
		table.sort(self.data, self.sort)

		love.graphics.setColor(255, 255, 255, 255)

		for i = 1, self.length do
			local sheet = self.sheets[self.data[i].sheet]
			love.graphics.drawq(sheet.image, sheet.quads[self.data[i].quad], self.data[i].x, self.data[i].y, self.data[i].r, self.data[i].sx, self.data[i].sy, self.data[i].ox, self.data[i].oy)
		end
	end
	
	self.data = {}
end

function buffer.sort(a, b)
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