function on_playback_start()
    seekable = mp.get_property("seekable")
    print("seekable = ", seekable)
    if (seekable == "yes") then
        print("pausing")
        mp.set_property("pause", "yes")
    end
end
mp.register_event("file-loaded", on_playback_start)
