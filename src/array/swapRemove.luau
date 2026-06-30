
local function swapRemove<V>(t: {V}, pos: number): V?
	local value = t[pos]
	t[pos] = t[#t]
	return value
end


return swapRemove