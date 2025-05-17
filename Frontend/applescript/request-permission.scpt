tell application "Notes"
    -- Simply get the list of notes to trigger permission request
    try
        get name of every note
        display dialog "Permission to access Notes has been granted." buttons {"OK"} default button "OK"
    on error
        display dialog "Please grant permission for the script to access Notes." buttons {"OK"} default button "OK"
    end try
end tell
