
local function debounce<a>(duration: number, handler: a): a
	local lastusage = tick()
	
	return function (...)
		local now = tick()
		if now - lastusage > duration then
			handler(...)
			lastusage = now
		end
	end
end


return debounce