--[[
    Script Name: gus-lan_Select (n) numbers of items on selected track and add incrementing take markers (settings inside).lua
    Description: Selects n numbers of items on selected track and adds incrementing take markers. Useful for sfx library development.
    
    Version: 1.0.0
    Author: Gustav Landerholm
    
    Changelog:
        Initial Release       
]]--
------------------------------------------------------------------------------------------

function main()
    GetTrack()
    
    if is_track_selected == false then do return end -- If no track is selected, break the script.

    else
        SelectAndCountAllItemsOnSelectedTrack() --Count all items on the selected track
    end

    PositionItemOnSelectedTrack() --Print the position of the selected items on the selected track.

end

------ START OF FUNCTIONS ----------------------------------------------------------------

------ GET TRACK -------------------------------------------------------------------------

function GetTrack()
    sel_track = reaper.GetSelectedTrack(0, 0)

    if sel_track then
        retval, buf = reaper.GetTrackName(sel_track)
        sel_track_name = buf

        reaper.ShowConsoleMsg("Selected track: " .. sel_track_name.."\n")
    else 
        reaper.ShowMessageBox("Please select a track!", "Error", 0)
        is_track_selected = false
    end
end

------ COUNT ITEMS ON SELECTED TRACK -----------------------------------------------------

function SelectAndCountAllItemsOnSelectedTrack()
    reaper.Main_OnCommandEx(40421,0,0) --Select all items on selected track.
    item_count = reaper.CountSelectedMediaItems(0)

    reaper.ShowConsoleMsg("Amount of items on selected track = "..item_count.."\n")
end

------ POSITION ITEM ON SELECTED TRACK ----------------------------------------------------

function PositionItemOnSelectedTrack()
    for i = 0, item_count -1 do 
        local sel_item = reaper.GetSelectedMediaItem(0,i) -- Get selected media item in loop.
        local i_pos = reaper.GetMediaItemInfo_Value( sel_item, "D_POSITION" ) -- Get the position of current selected item in loop.

        local j = i+1 -- convert 0 based to 1 based.
        reaper.ShowConsoleMsg("Item "..j..": "..i_pos.."\n") --print the position of current selected item.
    end
end

------ INSERT TAKE MARKER AT STORED ITEM POSITION ----------------------------------------

--function AddTakeMarkerAtItemPositions()
--    for 
--end
------ END OF FUNCTIONS ------------------------------------------------------------------
main()

