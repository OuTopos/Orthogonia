entities = {}
entities.data = {}
entities.remove = {}
entities.refresh = false

-- All the types of entities
require	"entities_player"
require	"entities_eyeball"
require	"entities_snake"

function entities.new(type, view, control, x, y)
	local entity = _G["entities_"..type].new(view, control, x, y)
	table.insert(entities.data, entity)
end

function entities.reset()
	for i = 1, #entities.data do
		if entities.data[i].destroy then
			entities.data[i].destroy()
		end
	end
	entities.data = {}
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

function entities.draw()
	-- Instead of actually drawing it's being sent to the buffer.
	for i = 1, #entities.data do
		entities.data[i].draw(dt, i)
	end
end
