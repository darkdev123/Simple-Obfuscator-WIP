local function decrypt_number(hex)
	local str = ""
	for i = 1, #hex, 2 do
		local byte = tonumber(hex:sub(i, i + 1), 16)
		str = str .. string.char(byte)
	end
	return tonumber(str)
end

local function VMCall(chunk, vmenv)
	if type(chunk) == "table" then
	else
		error("\99\104\117\110\107\32\105\115\32\110\111\116\32\97\32\116\97\98\108\101");
	end
	local function Wrap(Env)
		local IP = 1;
		local Stk = {};
		local instr = chunk[1];
		local enum;
		local inst;
		while IP <= #chunk[1] do
			inst = instr[IP];
			enum = inst[1];
			if (enum == 1) then
				table.insert(Stk, Env[inst[3]])
			elseif (enum == 2) then
				table.insert(Stk, inst[3])
				Stk[1](Stk[2])
				break
			end
			IP = IP + 1
		end
	end
	return Wrap(vmenv);
end

(function()VMCall({{{decrypt_number("\51\49"),decrypt_number("\51\48"),"\112\114\105\110\116"},{decrypt_number("\51\50"),decrypt_number("\51\48"),"\104\101\108\108\111"}}}, getfenv());end)()
