--[[
Assume the graph representation of the previous exercise, where the label of each arc represents the distance between its end nodes.  Write a function to find the shortest path between two given nodes.  (Hint: use Dijkstra's algorithm.)
]]

table.empty = function(table)
  return next(table) == nil
end

local function name2node(graph, name)
  local node = graph[name]
  if not node then
    node = {name = name, adj = {}}
    graph[name] = node
  end

  return node
end

function readgraph()
  local graph = {}

  for line in io.lines() do
    local namefrom, nameto, label = string.match(line, "(%S+)%s+(%S+)%s+(%d+)")
    local from = name2node(graph, namefrom)
    local to = name2node(graph, nameto)
    from.adj[{node = to, distance = tonumber(label)}] = true
  end

  return graph
end

function findshortestpath(graph, start, destination)
  state = {distance = {}, unvisited = {}, path = {}}

  current = start

  for _, node in pairs(graph) do
    if node == current then
      state.distance[node] = 0
    else
      state.distance[node] = math.huge
    end

    state.unvisited[node] = true
    state.path[node] = {node}
  end

  while not table.empty(state.unvisited) do
    -- Update the distance and path to each neighbor if arriving from the current
    -- node is shorter than the previous best
    for arc in pairs(current.adj) do
      if state.unvisited[arc.node] then
        local tentative = arc.distance + state.distance[current]

        if tentative < state.distance[arc.node] then
          state.distance[arc.node] = tentative

          state.path[arc.node] = {table.unpack(state.path[current])}
          state.path[arc.node][#state.path[arc.node] + 1] = arc.node
        end
      end
    end

    -- We're done with this node, mark it visited
    state.unvisited[current] = nil

    -- If we've visited the destination then we're done; we have the shortest path
    if state.unvisited[destination] == nil then
      break
    end

    -- Choose the unvisited node with the smallest distance and go again
    local smallestdistance = math.huge
    for node in pairs(state.unvisited) do
      if state.distance[node] <= smallestdistance then
        current = node
        smallestdistance = state.distance[node]
      end
    end
  end

  return state.path[destination]
end

function printpath(path)
  local sb = {}
  for i = 1, #path do
    sb[#sb + 1] = path[i].name
  end

  print(table.concat(sb, " => "))
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
p = findshortestpath(g, a, b)
if p then printpath(p) end

--[[
lua e11_4.lua < graph
=>
a => e => c => b
]]
