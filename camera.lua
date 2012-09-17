camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0

--camera.screenWidth = screen.width -- use love.graphics.getMode() later
--camera.screenHeight = screen.height -- use love.graphics.getMode() later

--camera.width = screen.width
--camera.height = screen.height

camera.position = {}
camera.position.x = camera.x
camera.position.y = camera.y

camera.boundaries = {}
camera.boundaries.left = 0
camera.boundaries.right = 1000
camera.boundaries.top = 0
camera.boundaries.bottom = 1000




function camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(self.scaleX, self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
	love.graphics.pop()
end

function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
	self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end

-- Mitt eget
function camera:center(dx, dy)
	self.x = dx - screen.width / 2
	self.y = dy - screen.height / 2

	if self.x < camera.boundaries.left then
		self.x = camera.boundaries.left
	elseif self.x > camera.boundaries.right then
		self.x = camera.boundaries.right
	end

	if self.y < camera.boundaries.top then
		self.y = camera.boundaries.top
	elseif self.y > camera.boundaries.bottom then
		self.y = camera.boundaries.bottom
	end
end

function camera:setBoundaries(left, right, top, bottom)
	camera.boundaries.left = left
	camera.boundaries.right = right - screen.width
	camera.boundaries.top = top
	camera.boundaries.bottom = bottom - screen.height
end