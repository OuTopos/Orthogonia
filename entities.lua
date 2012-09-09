entities = {}
entities.data = {}
entities.remove = {}
entities.refresh = false

-- All the types of entities
require	"entities_player"
require	"entities_eyeball"
require	"entities_snake"

function entities.new(type, view, control)
	local entity = _G["entities_"..type].new(view, control)
	table.insert(entities.data, entity)
end

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
