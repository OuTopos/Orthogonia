local socket = require "socket"

-- the address and port of the server
local address, port = "localhost", 12345

--local entity -- entity is what we'll be controlling
local updaterate = 0.1 -- how long to wait, in seconds, before requesting an update

local world = {} -- the empty world-state
local t

client = {}

function client.load()

    udp = socket.udp()
    udp:settimeout(0)
    udp:setpeername(address, port)
    
    local dg = string.format("%s %s %d %d", ACTIVE_PLAYER, 'move', players.list[ACTIVE_PLAYER].x, players.list[ACTIVE_PLAYER].y)
    udp:send(dg) -- the magic line in question.

    t = 0
end

function client.update(dt)
   -- t = t + dt
    
   -- if t > updaterate then

        local dg = string.format("%s %s %f %f", ACTIVE_PLAYER, 'move', players.list[ACTIVE_PLAYER].x, players.list[ACTIVE_PLAYER].y)
        udp:send(dg)    

    --    t = t - updaterate
   -- end

    
    -- there could well be more than one message waiting for us, so we'll
    -- loop until we run out!
    repeat
        -- and here is something new, the much anticipated other end of udp:send!
        -- receive return a waiting packet (or nil, and an error message).
        -- data is a string, the payload of the far-end's send. we can deal with it
        -- the same ways we could deal with any other string in lua (needless to 
        -- say, getting familiar with lua's string handling functions is a must.
        data, msg = udp:receive()
        if data then -- you remember, right? that all values in lua evaluate as true, save nil and false?
            print(data)
            -- match is our freind here, its part of string.*, and data is
            -- (or should be!) a string. that funky set of characters bares some 
            -- explanation, though.
            -- (need summary of patterns, and link to section 5.4.1)
            ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
            if cmd == 'at' then
                -- more patterns, this time with sets, and more length selectors!
                local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
                assert(x and y) -- validation is better, but asserts will serve.
            
                -- don't forget, even if you matched a "number", the result is still a string!
                -- thankfully conversion is easy in lua.
                ent, x, y = tonumber(ent), tonumber(x), tonumber(y)
                -- and finally we stash it away
                
                if not players.list[ent] then
					players.new("soldier", ent)
                    print("player "..ent.." does not exist")
                end

                if ent ~= ACTIVE_PLAYER then
                    players.list[ent].x = x
                    players.list[ent].y = y

                    players.list[ent]:move(dt)
                end
            else
                -- this case shouldn't trigger often, but its always a good idea
                -- to check (and log!) any unexpected messages and events.
                -- it can help you find bugs in your code...or people trying to hack the server.
                -- never forget, you can not trust the client!
                print("unrecognised command:", cmd)
            end
        
        -- if data was nil, then msg will contain a short description of the
        -- problem (which are also error id...).
        -- the most common will be 'timeout', since we settimeout() to zero,
        -- anytime there isn't data *waiting* for us, it'll timeout.
        --
        -- but we should check to see if its a *different* error, and act accordingly.
        -- in this case we don't even try to save ourselves, we just error out.
        elseif msg ~= 'timeout' then 
            error("Network error: "..tostring(msg))
        end
    until not data
end