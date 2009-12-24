enumTypes = {
	"chat",
	"ads",
	"adminchat",
	"admincmds",
	"moneytransfers",
	"faction",
	"meactions",
	"pms",
	"vehicles",
	"san-photo",
	"kills",
	"anticheat",
	"itemspawn",
	"tow",
	"setfaction",
	"changelock",
	"moveitems",
	"news",
	"do",
	"tv",
	"adminlock",
	"weaponspawn",
	"moneyspawn"
}


function logMessage(message, type)
	local filename = nil
	local r = getRealTime()
	local partialname = enumTypes[type]
	
	if (partialname == nil) then return end
	
	filename = "/logs/" .. partialname .. ".log"
	local file = createFileIfNotExists(filename)
	local size = fileGetSize(file)
	fileSetPos(file, size)
	fileWrite(file, "[" .. ("%04d-%02d-%02d %02d:%02d"):format(r.year+1900, r.month + 1, r.monthday, r.hour,r.minute) .. "] " .. message .. "\r\n")
	fileFlush(file)
	fileClose(file)
end

function createFileIfNotExists(filename)
	local file = fileOpen(filename)
	
	if not (file) then
		file = fileCreate(filename)
	end
	
	return file
end