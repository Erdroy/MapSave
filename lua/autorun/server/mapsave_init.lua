
-- Thanks garry :D
include("gmsave2/gmsave.lua")

function MapSave_Save( ply, cmd, args )
	
	if table.getn(args) == 0 then
		print("You must give save name argument! Eg.: 'mapsave_save save1'")
		return
	end
	
	local savename = args[1]
	
	-- Thanks, again.
	local save = gmsave2.SaveMap( ply )
	
	if !save then 
		print("Failed to save map!")
		return
	end
	
	file.CreateDir( "mapsave" )
	file.Write( "mapsave/"..savename..".txt", save )
	
	print("Saved! Save: "..savename)
	return
end

function MapSave_Load( ply, cmd, args )
	
	if table.getn(args) == 0 then
		print("You must give save name argument! Eg.: 'mapsave_load save1'")
		return
	end
	
	local savename = args[1]
	
	local save = file.Read( "mapsave/"..savename..".txt", "DATA" )
	
	-- Emmm, thanks - again...
	gmsave2.LoadMap(save, nil)
	
	print("Loaded save: "..savename)
	return
end

concommand.Add( "mapsave_save", MapSave_Save )
concommand.Add( "mapsave_load", MapSave_Load )