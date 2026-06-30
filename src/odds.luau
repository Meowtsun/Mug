
type odds = ((odds: number) -> (boolean, number)) & ((successes: number, total: number) -> (boolean, number))
-- I think this would be really useful for quick and dirty usage, idk - Meo


local function odds(wins: number, total: number?): (boolean, number)
	local total = total or wins
	local roll = math.random(total)
	
	local success = roll < wins
	if not total then
		success = roll == 1
	end
	
	return success, roll 
end


return odds :: odds