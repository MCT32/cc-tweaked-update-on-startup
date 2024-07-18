import json
import fnmatch

with open('file_list.txt', 'r') as f:
    file_list = f.read().splitlines()

with open('config.json', 'r') as f:
    config = json.load(f)

with open('.configignore', 'r') as f:
    ignore_list = f.read().splitlines()

files = []
config_files = []

for file in file_list:
    if fnmatch.fnmatch(file, 'config/*'):
        print("Added config file: " + file)
        config_files.append(file)
    else:
        for ignore in ignore_list:
            if fnmatch.fnmatch(file, ignore):
                break
        else:
            print("Added file: " + file)
            files.append(file)
            
config['files'] = files
config['config_files'] = config_files
with open('config.json', 'w') as f:
    f.write(json.dumps(config, indent=4))
