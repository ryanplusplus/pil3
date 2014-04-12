--[[
Kind of an interesting idea, but it muddles up moves with the enter signal.  This exposes "enter" as a possible move which is less than desirable.  Meh.
]]
local function states_as_tables()
  local function enter(state)
    state["enter"]()
  end

  local function transition_to(state)
    return function() enter(state) end
  end

  local function handle_move_from(state)
    return function()
      local move = io.read()

      if state[move] then
        state[move]()
      else
        print("invalid move")
        enter(state)
      end
    end
  end

  local room1, room2, room3, room4 = {}, {}, {}, {}

  room1.enter = handle_move_from(room1)
  room1.south = transition_to(room3)
  room1.east = transition_to(room2)

  room2.enter = handle_move_from(room2)
  room2.south = transition_to(room4)
  room2.west = transition_to(room1)

  room3.enter = handle_move_from(room3)
  room3.north = transition_to(room1)
  room3.east = transition_to(room4)

  room4.enter = function() print("Congratulations, you won!") end

  enter(room1)
end

--[[
More straightforward transformation.  All transitions are tail calls so there's no additional overhead compared to using a goto.
]]
local function states_as_functions()
  local room1, room2, room3, room4

  function room1()
    local move = io.read()
    if move == "south" then room3()
    elseif move == "east" then room2()
    else
      print("invalid move")
      room1()
    end
  end

  function room2()
    local move = io.read()
    if move == "south" then room4()
    elseif move == "west" then room1()
    else
      print("invalid move")
      room2()
    end
  end

  function room3()
    local move = io.read()
    if move == "north" then room1()
    elseif move == "east" then room4()
    else
      print("invalid move")
      room3()
    end
  end

  function room4()
    print("Congratulations, you won!")
  end

  room1()
end

states_as_functions()
