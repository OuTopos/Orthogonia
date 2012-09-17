buffer = {}
buffer.enabled = true
buffer.sheets = {}
buffer.data = {}

function buffer:addSheet(imagePath, gx, gy)
	if not self.sheets[imagePath] then
		print(imagePath)
		local image = love.graphics.newImage( "images/"..imagePath..".png" )
		local width = image:getWidth()
		local height = image:getHeight()
		local quads = {}
		local i = 0
		for y=0, math.floor(height/gy)-1 do
			for x=0, math.floor(width/gx)-1 do
				i = i + 1
				quads[i] = love.graphics.newQuad(x*gx, y*gy, gx, gy, width, height)
			end
		end
		self.sheets[imagePath] = {}
		self.sheets[imagePath].image = image
		self.sheets[imagePath].quads = quads
	end
end



function buffer.spriteset(x, y, z, ox, oy, sx, sy, r)
	local spriteset = {}
	spriteset.data = {}
	spriteset.x = x
	spriteset.y = y
	spriteset.z = z
	spriteset.ox = ox or 0
	spriteset.oy = oy or 0
	spriteset.sx = sx or 1
	spriteset.sy = sy or 1
	spriteset.r = r or 0
	return spriteset
end

function buffer.sprite(sheet, quad)
	local sprite = {}
	sprite.sheet = sheet
	sprite.quad = quad
	return sprite
end


function buffer:reset()
	buffer.data = {}
end

function buffer:add(spriteset)
	table.insert(buffer.data, spriteset)
end

function buffer:draw()
	-- Reset buffer length variable
	self.length = 0

	if self.enabled then
		self.length = #self.data
		table.sort(self.data, self.sort)

		love.graphics.setColor(255, 255, 255, 255)

		local spriteset
		for i = 1, self.length do
			spriteset = self.data[i]
			for i2 = 1, #spriteset.data do
				--print("Drawing: "..self.data[i].data[i2].sheet)
				local sheet = self.sheets[spriteset.data[i2].sheet]
				love.graphics.drawq(sheet.image, sheet.quads[spriteset.data[i2].quad], spriteset.x, spriteset.y, spriteset.r, spriteset.sx, spriteset.sy, spriteset.ox, spriteset.oy)
			end
		end
	end
	
	--self.data = {}
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