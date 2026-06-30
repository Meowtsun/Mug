
local function pop<V>(t: {V}): V?
	return table.remove(t, #t)
end


return pop