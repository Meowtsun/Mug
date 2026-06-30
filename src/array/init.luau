
local Mug = script:FindFirstAncestor('Mug')
local indexer = require(Mug.Helper.Indexer)

local array = {
	swapRemove = require(script.swapRemove),
	pop = require(script.pop),
	peek = require(script.peek),
}


type array = typeof(array) & typeof(indexer)
return setmetatable(array, indexer) :: array