--!nocheck

local retain_same_value = '*'
local wallyConfigFormat = [[
[package]
name = "%s"
description = "%s"
version = "%s"
authors = ["%s"]

registry = "https://github.com/UpliftGames/wally-index"
realm = "%s"
license = "%s"

[dependencies]
]]


local function waitForInput(prompt, label)
    io.write(prompt)
    return {label, io.read()}
end


local function isFileExist(path)
    local file = io.open(path, 'r')
    if file then
        file:close()
        return true
    end
    return false
end


local function makeWallyConfig()
    local file = io.open('wally.toml', 'w')
    file:write(
        string.format(wallyConfigFormat,
            'unknown', 'unknown', '0.0.1', 'unknown', 'shared', 'MIT'
        )
    )
    file:close()
end


local function updateWallyConfig(...)
    local file = io.open('wally.toml', 'r')
    local content = file:read('*a')
    file:close()

    local total_fields = select('#', ...)
    for index = 1, total_fields do
        local field = select(index, ...)
        if field[2] ~= retain_same_value then
            if field[1] == 'authors' then
                local targetLine = field[1] .. '%s*=%s*%b[]'
                content = content:gsub(targetLine,
                    field[1] .. ' = ["' .. field[2] .. '"]'
                )
            else -- normal stuffs without brackets
                local targetLine = field[1] .. '%s*=%s*".-"'
                content = content:gsub(targetLine,
                    field[1] .. ' = "' .. field[2] .. '"'
                )
            end
        end
    end

    local edit = io.open('wally.toml', 'w')
    edit:write(content)
    edit:close()
end


local initial do
    local hasWallyConfig = isFileExist('wally.toml')

	print('==== Wally Package CLI Setup ====')

	print('')
	local confirm = waitForInput('Proceed? (y/n) > ', '')
	if confirm[2] ~= 'y' then
		return
	end

    -- warn me about wally.toml
    if not hasWallyConfig then
		print('wally.toml not found')
        print('Generating wally.toml')
        makeWallyConfig()
	else
		print('wally.toml found')
    end
	print('')
    print('==== Editing existing wally.toml ====')
    print('(use * to skip editing current field)')
	print('')
    local name = waitForInput('Name > ', 'name')
    local description = waitForInput('Description > ', 'description')
    local version = waitForInput('Version > ', 'version')
    local authors = waitForInput('Author > ', 'authors')
    local realm = waitForInput('Realm > ', 'realm')
    local license = waitForInput('License > ', 'license')

    updateWallyConfig(name, description, version, authors, realm, license)
	print('')

    local doPublish = waitForInput('run "wally publish" ? (y/n) > ', 'nil')
    if doPublish[2] == 'y' then
        print('Publishing an edit')
        os.execute('wally publish')
		print('')
    end


	 local doPublish = waitForInput('run "git push" ? (y/n) > ', 'nil')
    if doPublish[2] == 'y' then
        print('Pushing to git')
        os.execute('git add .')
		os.execute(
			string.format('git commit -m "%s"', doPublish[2])
		)
		os.execute('git push')
		print('')
    end

	waitForInput('Done, press Enter to leave setup > ', 'description')
end
