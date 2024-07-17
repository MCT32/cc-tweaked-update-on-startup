local config, err = fs.open("config.json", "r")

if config == nil then
    print("Error opening config.json: " .. err)
    return
end

config, err = textutils.unserialiseJSON(config.readAll())

if config == nil then
    print("Error parsing config.json: " .. err)
    return
end

local url = config.url .. config.branch .. "/"

for _, file in ipairs(config.files) do
    local filePath = url .. file

    if not os.run({}, "/rom/programs/wget.lua", filePath, file) then
        print("Error downloading " .. file)
        return
    end
end

for _, file in ipairs(config.config_files) do
    local filePath = url .. file

    if not exists(file) then
        if not os.run({}, "/rom/programs/wget.lua", filePath, file) then
            print("Error downloading " .. file)
            return
        end
    end
end

if not os.run({}, config.entrypoint) then
    print("Error running " .. config.entrypoint)
    return
end
