
local Mug = script:FindFirstAncestor('Mug')
local clone = require(
	Mug.Shared:FindFirstChild('clone')
)


local function reconcile<a, b>(target: a, template: b, raw: boolean?): a & b
	local target = raw and target or clone(target, true)
	
	for index, value in template do
		-- only reconcile string indexs
		if type(index) == 'string' then
			
			if target[index] == nil then
				if type(value) == 'table' then
					target[index] = clone(value, true)
				else -- non table
					target[index] = value
				end
				
			elseif type(target[index]) == 'table' and type(value) == 'table' then
				reconcile(target[index], value, true)
			end
			
		end
	end
	
	return target
end


return reconcile