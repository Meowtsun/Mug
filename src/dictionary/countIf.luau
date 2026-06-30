
local Mug = script:FindFirstAncestor('Mug')
local builtIn = require(Mug.buitIn)

type predicate<i, v> = (value: v, key: i) -> (boolean)


local function countIf<K, V>(t: {[K]: V}, predicate: predicate<K, V>?): number
	local predicate = predicate or builtIn.valid
	local count = 0
	
	for index, value in t do
		if predicate(value, index) then
			count += 1
		end
	end
	
	return count
end


return countIf