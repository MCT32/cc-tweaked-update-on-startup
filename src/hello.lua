msg, err = fs.open("config/msg.txt", "r")

if msg == nil then
    print("Error opening msg.txt: " .. err)
    return
end

print(msg.readAll())
