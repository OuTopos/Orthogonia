entities = {}
entities.data = {}
entities.remove = {}
entities.refresh = false

-- All the types of entities
require	"entities_eyeball"
require	"entities_snake"

function entities.new(type)
	local entity = _G[type].new()
	table.insert(entities.data, entity)

	
	--local eye1 = eyeball.new()
	--local eye2 = eyeball.new()

	--eye1.setPosition(333, 123)
	--eye2.setPosition(45, 64)

	--print("Eye1: "..eye1.getX()..":"..eye1.getY())
	--print("Eye2: "..eye2.getX()..":"..eye2.getY())
end

function entities.update(dt)
	for i = 1, #entities.data do
		entities.data[i].update()
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
