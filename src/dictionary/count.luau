
local function count<T>(t: T): number
	local count = 0
	
	for index, value in t do
		count += 1
	end
	
	return count
end


return count