
local function clone<T>(t: T, deep: boolean?): T
	local copy = table.clone(t)
	
	if not deep then
		return copy
	end
	
	for index, value in t do
		if type(value) == 'table' then
			copy[index] = clone(value, true)
		end
	end
	
	return copy
end



return clone