
local function accumulate<a>(duration: number, handler: a): a
	local lastusageId = 0
	
	return function (...)
		lastusageId += 1
		
		local taskId = lastusageId
		
		task.delay(duration, function(...)
			if lastusageId == taskId then
				handler(...)
			end
		end, ...)
		
	end
end


return accumulate