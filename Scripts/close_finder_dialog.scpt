tell application "System Events"
    log "Executing AppleScript to close file dialog."
    keystroke "g" using {command down, shift down}
    keystroke "q"
end tell