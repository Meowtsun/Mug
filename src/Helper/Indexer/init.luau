
local Indexer = {}
local sharing = {
	clone = require(script:FindFirstChild('clone')),
	freeze = require(script.freeze),
	isEmpty = require(script.isEmpty),
}


function Indexer:__index(index)
	return sharing[index] or table[index]
end


type indexer = typeof(sharing) & typeof(table)
return Indexer :: indexer