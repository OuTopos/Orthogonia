entities = {}
entities.data = {}
entities.remove = {}
entities.refresh = false


-- All the types of entities
require	"entities_player"
require	"entities_player_platform"
require	"entities_eyeball"
require	"entities_eyeball_friend"
require	"entities_ghost"
require	"entities_snake"
require	"entities_coin"

function entities.new(type, x, y, z)
	local entity = _G["entities_"..type].new(x, y, z)
	table.insert(entities.data, entity)
	entity.init()
	buffer:reset()
	return entity
end

function entities.load(data)
	entities.data = data
	for i,entity in ipairs(entities.data) do
		--entity.init()
	end
	buffer:reset()
end

function entities.save()
	local data = ""
	for i,entity in ipairs(entities.data) do
		entity.init()
	end
	buffer:reset()
	return data
end

function entities.destroy()
	entities.data = {}
end

--function entities.reset()
--	for i = 1, #entities.data do
--		if entities.data[i].destroy then
--			entities.data[i].destroy()
--		end
--	end
--	entities.data = {}
--end


function entities.view(i)
	entities.viewing = i
	for i = 1, #entities.data do
		entities.data[i].view = false
	end
	entities.data[entities.viewing].view = true
end

function entities.update(dt)
	for i = 1, #entities.data do
		entities.data[i].update(dt, i)
	end

	-- Figure out remove later.
	if entities.refresh then
		print("Guess someone is leaving!")
		for i = 1, #entities.remove do
			print("removing entity: "..entities.remove[i])
			table.remove(entities.data, entities.remove[i])
		end
		entities.remove = {}
		entities.refresh = false
	end
end

function entities.draw()
	-- Instead of actually drawing it's being sent to the buffer.
	for i = 1, #entities.data do
		entities.data[i].draw(dt, i)
	end
end



entity_functions = {}

function entity_functions.destroy()
--	physics.destroy()
end

-- Basic functions
function entity_functions.setPosition(xn, yn)
	x, y = xn, yn
end

function entity_functions.getPosition()
	return x, y
end

function entity_functions.getX()
	return math.floor( x + 0.5 )
end
function entity_functions.getY()
	return math.floor( y + 0.5 )
end

function entity_functions.getXvel()
	return xvel
end
function entity_functions.getYvel()
	return yvel
end