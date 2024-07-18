msg, err = fs.open("config/msg.txt", "r")

if msg == nil then
    print("Error opening msg.txt: " .. err)
    return
end

msg2, err = fs.open("config/msg2.txt", "r")

if msg2 == nil then
    print("Error opening msg2.txt: " .. err)
    return
end

print(msg.readAll())
print(msg2.readAll())
