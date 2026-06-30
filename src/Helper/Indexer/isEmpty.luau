
local function isEmpty<T>(t: T): boolean
	return next(t) == nil
end


return isEmpty