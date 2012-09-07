screen = {}
screen.width = 340 -- use love.graphics.getMode() later
screen.height = 200 -- use love.graphics.getMode() later
screen.scale = 3

function screen.scaleToggle()
	screen.scale = screen.scale + 1
	if screen.scale > 4 then
		screen.scale = 1
	end

	love.graphics.setMode(screen.width*screen.scale, screen.height*screen.scale, false, true)
	camera:setScale(screen.scale, screen.scale)
end