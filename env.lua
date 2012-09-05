env = {}
env.colors = {
	{15, 15, 45, 204},
	{0, 16, 60, 179},
	{0, 12, 70, 153},
	{0, 43, 140, 102},
	{0, 91, 194, 76},
	{0, 122, 216, 51},
	{0, 200, 198, 25},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{0, 0, 0, 0},
	{180, 169, 0, 25},
	{158, 89, 0, 51},
	{112, 18, 0, 76},
	{88, 0, 52, 102},
	{60, 0, 45, 127},
	{45, 0, 76, 153},
	{0, 0, 60, 179}
}
env.hour = 12
env.nexthour = env.hour + 1
env.counter = 0
env.color = env.colors[env.hour]

function env.update(dt)
	env.counter = env.counter + dt
	if env.counter > 1 then
		env.counter = env.counter - 1
		env.hour = env.hour + 1
		if env.hour > 24 then
			env.hour = 1
		end

		env.nexthour = env.hour + 1
		if env.nexthour > 24 then
			env.nexthour = 1
		end
	end
	
	--env.counter = 0
	--env.hour = 12
	--env.nexthour = 13


 	--print(env.nexthour)
	r = math.floor(env.colors[env.hour][1] * (1 - env.counter) + env.colors[env.nexthour][1] * env.counter)
	g = math.floor(env.colors[env.hour][2] * (1 - env.counter) + env.colors[env.nexthour][2] * env.counter)
	b = math.floor(env.colors[env.hour][3] * (1 - env.counter) + env.colors[env.nexthour][3] * env.counter)
	a = math.floor(env.colors[env.hour][4] * (1 - env.counter) + env.colors[env.nexthour][4] * env.counter)

	env.color = {r, g, b, a}
	--print(r, g, b, a)
end

function env.draw()
	-- Test post effects.
	love.graphics.setColor(env.color)
	love.graphics.setColorMode("modulate")
	--love.graphics.setBlendMode("multiplicative")
	love.graphics.rectangle("fill", camera.x, camera.y, screen.width, screen.height)

	love.graphics.setBlendMode("alpha")
end