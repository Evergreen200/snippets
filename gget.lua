--[[
modiefied version of the pastebin script of the computercraft modification by dan200
to utilise my personal github folder for scripts due to several compolications with pastebin
@Evergreen200
--]]

local function print_usage()
    print("Usage:")
    print("gget <code> <filename>")
end

local t_args = { ... }
if #t_args < 2 then
    print_usage()
    return
end

if not http then
    printError("Script requires http API")
    printError("Set http_enable to true in ComputerCraft.cfg")
    return
end

local function get(file)
    write("Connecting to pastebin.com... ")
    local response = http.get(
        "https://raw.githubusercontent.com/Evergreen200/snippets/main/" .. textutils.urlEncode(file)
    )

    if response then
        print("Success.")

        local s_response = response.readAll()
        response.close()
        return s_response
    else
        print("Failed.")
    end
end

-- Download a file from github.com
if #t_args < 2 then
    print_usage()
    return
end

-- Determine file to download
local s_code = t_args[1]
local s_file = t_args[2]
local s_path = shell.resolve(s_file)
if fs.exists(s_path) then
    print("File already exists")
    return
end

-- GET the contents from github
local res = get(s_code)
if res then
    local file = fs.open(s_path, "w")
    file.write(res)
    file.close()

    print("Downloaded as " .. s_file)
end
