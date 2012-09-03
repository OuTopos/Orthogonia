PlayerObject = {}
PlayerObject.__index = PlayerObject

function PlayerObject:create(skin)
	local self = {}
	setmetatable(self, PlayerObject)

	self.x = 350
	self.y = 350
	self.z = 32
	self.speed = {}
	self.speed.x = 0
	self.speed.y = 0
	self.speed.max = 100
	self.speed.acceleration = 0.75
	self.speed.slowdown = 0.90
	self.state = "start"
	self.direction = "south"
	self.timer = 0
	self.frame = 1
	self.skin = skin

	sprites.addSheet(skin, 64, 64)

	return self
end

function PlayerObject:input(dt)
	if love.keyboard.isDown("right") then
		self.speed.x = self.speed.max
		self.state = "moving"
		self.direction = "east"
	elseif love.keyboard.isDown("left") then
		self.speed.x = -self.speed.max
		self.state = "moving"
		self.direction = "west"
	elseif self.speed.x > 0.1 or self.speed.x < -0.1 then
		self.speed.x = self.speed.x * self.speed.slowdown
		self.state = "sliing"
	elseif not (self.speed.x == 0) then
		self.speed.x = 0
		self.state = "stopped"
	end

	
	if love.keyboard.isDown("down") then
		self.speed.y = self.speed.max
		self.state = "moving"
		self.direction = "south"
	elseif love.keyboard.isDown("up") then
		self.speed.y = -self.speed.max
		self.state = "moving"
		self.direction = "north"
	elseif  self.speed.y > 0.1 or self.speed.y < -0.1 then
		self.speed.y = self.speed.y * self.speed.slowdown
		self.state = "sliding"
	elseif not (self.speed.y == 0) then
		self.speed.y = 0
		self.state = "stopped"
	end
end

function PlayerObject:move(dt)
	if self.x > 1024 then
		self.speed.x = -100
	end
	if self.y < -128 then
		self.speed.y = - self.speed.y * 2
	end
	
	self.x = self.x + self.speed.x * dt
	self.y = self.y + self.speed.y * dt
	self.xr = math.floor( self.x + 0.5 )
	self.yr = math.floor( self.y + 0.5 )
	self.zr = math.floor( self.z + 0.5 )

	self.RoundX = self.xr
	self.RoundY = self.yr
end

function PlayerObject:animate(dt)
	self.timer = self.timer + dt
	if self.timer > 0.1 then
		self.timer = self.timer - 0.1
		self.frame = self.frame + 1
		if self.frame > 7 then
			self.frame = 0
		end
	end

	if self.direction == "north" then
		sprites.addToBuffer(self.skin, 2 + self.frame, self.xr, self.yr, self.zr, 32, 48, 1, 1, 0)
	elseif self.direction == "west" then
		sprites.addToBuffer(self.skin, 11 + self.frame, self.xr, self.yr, self.zr, 32, 48, 1, 1, 0)
	elseif self.direction == "south" then
		sprites.addToBuffer(self.skin, 20 + self.frame, self.xr, self.yr, self.zr, 32, 48, 1, 1, 0)
	elseif self.direction == "east" then
		sprites.addToBuffer(self.skin, 29 + self.frame, self.xr, self.yr, self.zr, 32, 48, 1, 1, 0)
	end

end





players = {}
players.list = {}

function players.new(skin, id)
	local player = PlayerObject:create(skin)
	players.list[id] = player
	--table.insert(players.list, player)
end

function players.load()
end


function players.update(dt)
	-- Update for every player
	--for k, v in pairs(players.list) do
		-- Check for input on active player
	--	if k == ACTIVE_PLAYER then

		--players.list[ACTIVE_PLAYER]:input(dt)
	--	end
		-- Move the player
	--	players.list[ACTIVE_PLAYER]:move(dt)
	
	--for k, v in pairs(players.list) do	
		-- Animate
		--players.list[k]:animate(dt)
	--end



	for i = 1, #players.list do
		-- Check for input on active player
		if i == ACTIVE_PLAYER then
			players.list[i]:input(dt)
		end
		-- Move the player
		players.list[i]:move(dt)
		
		-- Animate
		players.list[i]:animate(dt)
	end
end