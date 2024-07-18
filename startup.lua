function download(url, dest)
    file, err = http.get(url)

    if file == nil then
        print("Error downloading " .. url .. ": " .. err)
        return false
    end

    handle, err = fs.open(dest, "w")

    if handle == nil then
        print("Error opening " .. dest .. ": " .. err)
        return false
    end

    handle.write(file.readAll())
    file.close()
    handle.close()
    return true
end

print("Updating firmware...")

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

    if not download(filePath, file) then
        print("Error downloading " .. file)
        return
    end
end

for _, file in ipairs(config.config_files) do
    local filePath = url .. file

    if not fs.exists(file) then
        if not download(filePath, file) then
            print("Error downloading " .. file)
            return
        end
    end
end

print("Updated!")

if not os.run({}, config.entrypoint) then
    print("Error running " .. config.entrypoint)
    return
end
