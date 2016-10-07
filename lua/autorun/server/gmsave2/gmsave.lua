
gmsave2 = {}

if ( CLIENT ) then return end

include( "gmsave/entity_filters.lua" )

local g_WavSound = 1

function gmsave2.LoadMap( strMapContents, ply )
	-- Strip off any crap before the start char..
	local startchar = string.find( strMapContents, '' )
	if ( startchar != nil ) then
		strMapContents = string.sub( strMapContents, startchar )
	end

	-- Stip off any crap after the end char..
	strMapContents = strMapContents:reverse()
	local startchar = string.find( strMapContents, '' )
	if ( startchar != nil ) then
		strMapContents = string.sub( strMapContents, startchar )
	end
	strMapContents = strMapContents:reverse()

	-- END TODO

	local tab = util.JSONToTable( strMapContents )

	if ( !istable( tab ) ) then
		-- Error loading save!
		MsgN( "gm_load: Couldn't decode from json!" )
		return false
	end
	
	game.CleanUpMap()
	
	duplicator.RemoveMapCreatedEntities()
	duplicator.Paste( ply, tab.Entities, tab.Constraints )

end

function gmsave2.SaveMap( ply )

	local Ents = ents.GetAll()

	for k, v in pairs( Ents ) do

		if ( !gmsave2.ShouldSaveEntity( v, v:GetSaveTable() ) || v:IsConstraint()  ) then
			Ents[ k ] = nil
		end

	end

	local tab = duplicator.CopyEnts( Ents )
	if ( !tab ) then 
		return 
	end
	
	return util.TableToJSON( tab )

end
