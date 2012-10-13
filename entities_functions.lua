-- Basic functions
function self.setPosition(xn, yn)
	x, y = xn, yn
end

function self.getPosition()
	return x, y
end

function self.getX()
	return math.floor( x + 0.5 )
end
function self.getY()
	return math.floor( y + 0.5 )
end

function self.getXvel()
	return xvel
end
function self.getYvel()
	return yvel
end