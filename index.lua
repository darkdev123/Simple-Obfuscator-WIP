local function decrypt_number(hex)
	local str="";
	for i=1,#hex,2 do
		local byte=tonumber(hex:sub(i,i+1),16);
		str=str..string.char(byte);
	end
	return tonumber(str);
end

local function VMCall(chunk, vmenv)
	if type(chunk)=="table" then
	else
		error("\99\104\117\110\107\32\105\115\32\110\111\116\32\97\32\116\97\98\108\101");
	end
	local function Wrap(Env)
		local IP=1;
		local Stk={};
		local instr=chunk[1];
		local enum;
		local inst;
		while(IP<=#chunk[1])do
			inst=instr[IP];
			enum=inst[1];
			if(enum==1)then
				Stk[1]=Env[inst[3]];
			elseif(enum==2)then
				Stk[2]=inst[3];
			elseif(enum==3)then
				Stk[3]=Env[inst[3]];
				Stk[1](Stk[2]);
				break;
			else
				error("\67\111\117\108\100\32\110\111\116\32\101\120\101\99\117\116\101\32\102\111\114\32\115\111\109\101\32\114\101\97\115\111\110\46");
			end
			IP=IP+1;
		end
	end
	return Wrap(vmenv);
end

(function()VMCall({{{decrypt_number("\51\49"),decrypt_number("\51\48"),"\112\114\105\110\116"},{decrypt_number("\51\50"),decrypt_number("\51\48"),"\104\101\108\108\111"},{decrypt_number("\51\51"),decrypt_number("\51\48"),"\67\65\76\76"}}},getfenv());end)();
