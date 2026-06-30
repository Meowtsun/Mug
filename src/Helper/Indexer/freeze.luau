
local function freeze<T>(t: T, deep: boolean?): T
	table.freeze(t)
	
	if not deep then
		return t
	end
	
	for index, value in t do
		if type(value) == 'table' then
			freeze(value, true)
		end
	end
	
	return t
end


return freeze