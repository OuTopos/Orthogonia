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

camera.follow = nil




function camera.set()
	love.graphics.push()
	love.graphics.rotate(-camera.rotation)
	love.graphics.scale(camera.scaleX, camera.scaleY)
	love.graphics.translate(-camera.x, -camera.y)
end

function camera.unset()
	love.graphics.pop()
end

function camera.move(dx, dy)
	camera.x = camera.x + (dx or 0)
	camera.y = camera.y + (dy or 0)
end

function camera.rotate(dr)
	camera.rotation = camera.rotation + dr
end

function camera.scale(sx, sy)
	sx = sx or 1
	camera.scaleX = camera.scaleX * sx
	camera.scaleY = camera.scaleY * (sy or sx)
end

function camera.setPosition(x, y)
	camera.x = x or camera.x
	camera.y = y or camera.y
end

function camera.setScale(sx, sy)
	camera.scaleX = sx or camera.scaleX
	camera.scaleY = sy or camera.scaleY
end

-- Mitt eget
function camera.update()
	if camera.follow then
		camera.x, camera.y = camera.follow.getPosition()

		camera.x = camera.x - screen.width / 2
		camera.y = camera.y - screen.height / 2

		if camera.x < camera.boundaries.left then
			camera.x = camera.boundaries.left
		elseif camera.x > camera.boundaries.right then
			camera.x = camera.boundaries.right
		end

		if camera.y < camera.boundaries.top then
			camera.y = camera.boundaries.top
		elseif camera.y > camera.boundaries.bottom then
			camera.y = camera.boundaries.bottom
		end
	end
end

function camera.center(dx, dy)
	camera.x = dx - screen.width / 2
	camera.y = dy - screen.height / 2

	if camera.x < camera.boundaries.left then
		camera.x = camera.boundaries.left
	elseif camera.x > camera.boundaries.right then
		camera.x = camera.boundaries.right
	end

	if camera.y < camera.boundaries.top then
		camera.y = camera.boundaries.top
	elseif camera.y > camera.boundaries.bottom then
		camera.y = camera.boundaries.bottom
	end
end

function camera.setBoundaries(left, right, top, bottom)
	camera.boundaries.left = left
	camera.boundaries.right = right - screen.width
	camera.boundaries.top = top
	camera.boundaries.bottom = bottom - screen.height
end