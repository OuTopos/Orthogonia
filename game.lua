game = {}
game.host = false

function game:start(host)
	if host then
		--Do the host/server things.
		self.host = true
		-- load map and much more
	else
		-- Client things
		client.load()
		-- fetch map and much more
	end
end

function game:update()
	if self.host then

	else
		client.update(dt)
	end
end

function game.host()
	-- This should be similar to what will be in the dedicated server.lua
end