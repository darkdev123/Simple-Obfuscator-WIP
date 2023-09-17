local function stringToHex(str)
  local hex = ''
  for i = 1, #str do
    hex = hex .. string.format('%02X', string.byte(str, i))
  end
  return hex
end

local function stringToAscii(input)
	local ascii = ""
	for i = 1, #input do
		local charCode = string.byte(input, i)
		ascii = ascii .. "\\" .. tostring(charCode)
		if i < #input then
			ascii = ascii .. ""
		end
	end
	return ascii
end

local function extractPrintStatements(input)
	local printStatements = {}

	local pattern = 'print%(%s*"(.-)"%s*%)'

	for match in input:gmatch(pattern) do
		table.insert(printStatements, {"print", match})
	end

	return printStatements
end

local function extractMacroStatements(input)
	local macroStatements = {}

	local pattern = '--betterobfuscate'

	if input:gmatch(input, pattern) then
        table.insert(macroStatements, pattern)
    end

	return macroStatements
end

local code = [[--betterobfuscate print("kjigdrdsiefdsyrtf8edy6ithdg74")]]

local instructions = unpack(extractPrintStatements(code))
local macros = extractMacroStatements(code)

local file = io.open("vm.lua", "r")
if file then
    local vmcode = file:read("*a")
    file:close()
    vmcode = string.gsub(vmcode, "print_code", stringToAscii(instructions[1]))
    vmcode = string.gsub(vmcode, "value_str", stringToAscii(instructions[2]))
    print(vmcode)
end