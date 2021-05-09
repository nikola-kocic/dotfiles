-- Fix positioning of subtitle text for some files.
-- Unfortunately, this can be fixed only before file is loaded (at least in mpv version 0.30).

function on_start_file()
    local filename = mp.get_property("filename", "")
    if string.find(filename, "%[HorribleSubs%]") then
        print("Detected HorribleSubs")
        -- HorribleSubs sets wrong PlayResX and PlayResY properties
        -- (PlayResX=848,PlayResY=480) in relation to coordinates used for positioning.
        mp.set_property("sub-ass-force-style", "PlayResX=640,PlayResY=360")
        mp.set_property("sub-scale", "0.75")  -- scale back subtitles for difference between 360 and 480
    end
end

mp.register_event("start-file", on_start_file)
