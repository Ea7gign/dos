-- some ideas jacked off the database resource
-- remade for vg's most used functions

-- connection settings
local hostname = "localhost"
local username = "root"
local password = "rewt"
local database = "mta"
local port = 3306

-- global things.
local MySQLConnection = nil
local resultPool = { }

-- connectToDatabase - Internal function, to spawn a DB connection
function connectToDatabase(res)
	-- make sum love to the database
	MySQLConnection = mysql_connect(hostname, username, password, database, port)
	
	if (not MySQLConnection) then
		-- sql server doesnt want to make love

		if (res == getThisResource()) then
			cancelEvent(true, "Cannot connect to the database.")
		end
		return nil
	end
	
	return nil
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), connectToDatabase, false)

-- destroyDatabaseConnection - Internal function, kill the connection if theres one.
function destroyDatabaseConnection()
	if (not MySQLConnection) then
		return nil
	end
	mysql_close(MySQLConnection)
	return nil
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), destroyDatabaseConnection, false)

-- do something usefull here
function logSQLError(str)
	local message = str or 'N/A'
	outputDebugString("MYSQL ERROR "..mysql_errno(MySQLConnection) .. ": " .. mysql_errorMySQLConnection)")
end

function getFreeResultPoolID()
	local size = #resultPool
	if (size == 0) then 
		return 1 
	end
	for index, query in ipairs(resultPool) do
		if (query == nil) then
			return index
		end
	end
	return (size + 1)
end

------------ EXPORTED FUNCTIONS ---------------

-- ping()
-- escape_string(str)
-- query(str)			returns handle
-- query_free(str)
-- fetch_assoc(handle)
-- rows_assoc(handle)
-- free_result(handle)
-- result(handle, row_offset, field_offset)
-- num_rows(handle)

function ping()
	if (mysql_ping(MySQLConnection) == false) then
		-- FUU, NO MOAR CONNECTION
		destroyDatabaseConnection()
		connectToDatabase(nil) -- need to pass an argument cus else it starts Q_Qing
		
		-- can has connection noa?
		if (mysql_ping(MySQLConnection) == false) then
			-- FUUUU
			logSQLError()
			return false
		end
		return true
	end

	return true
end

function escape_string(str)
	if (ping()) then
		return mysql_escape_string(MySQLConnection, str)
	end
	return false
end

function query(str)
	if (ping()) then
		local result = mysql_query(MySQLConnection, str)
		if (not result) then
			logSQLError()
			return false
		end

		local resultid = getFreeResultPoolID()
		resultPool[resultid] = result
		return resultid
	end
	return false
end

function query_free(str)
	if (ping()) then
		local result = mysql_query(MySQLConnection, str)
		if (not result) then
			logSQLError()
		end
		mysql_free_result(result)
	end
end

function rows_assoc(resultid)
	if (not resultPool[resultid]) then
		return false
	end
	return mysql_rows_assoc(resultPool[resultid])
end

function fetch_assoc(resultid)
	if (not resultPool[resultid]) then
		return false
	end
	return mysql_fetch_assoc(resultPool[resultid])
end

function free_result(resultid)
	if (not resultPool[resultid]) then
		return false
	end
	mysql_free_result(resultPool[resultid])
	table.remove(resultPool, resultid)
	return nil
end

-- incase a nub wants to use it, FINE
function result(resultid, row_offset, field_offset)
	if (not resultPool[resultid]) then
		return false
	end
	return mysql_result(resultPool[resultid], row_offset, field_offset)
end

function num_rows(resultid)
	if (not resultPool[resultid]) then
		return false
	end
	return mysql_num_rows(resultPool[resultid])
	
end