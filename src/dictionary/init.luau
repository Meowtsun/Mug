
local Mug = script:FindFirstAncestor('Mug')
local indexer = require(Mug.Helper.Indexer)

local dictionary = {
	reconcile = require(script.reconcile),
	count = require(script.count),
	countIf = require(script.countIf),
}

type dictionary = typeof(dictionary) & typeof(indexer)
return setmetatable(dictionary, indexer) :: dictionary