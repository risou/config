on run argv
	set option to item 1 of argv
	if option = "get" then
		getMeeting()
	else if option = "join" then
		joinMeeting()
	end if
end run

on getMeeting()
	tell application "System Events" to tell application process "MeetingBar"
		set label to name of menu bar item 1 of menu bar 2
                if label is missing value then
                        return "(no event)"
                else
                        return label
                end if
	end tell
end getMeeting

on joinMeeting()
	openMenu()
	tell application "System Events" to tell application process "MeetingBar"
		tell menu 1 of menu bar item 1 of menu bar 2
			if menu item "Join current event meeting" exists then
				click menu item "Join current event meeting"
			else if menu item "Join next event meeting" exists then
				click menu item "Join next event meeting"
			else
				error "No meetings found"
			end if
		end tell
	end tell
end joinMeeting

on menuIsOpen()
	tell application "System Events" to tell application process "MeetingBar"
		return menu 1 of menu bar item 1 of menu bar 2 exists
	end tell
end menuIsOpen

on openMenu()
	set killDelay to 0
	repeat
		tell application "System Events" to tell application process "MeetingBar"
			if my menuIsOpen() then return
			ignoring application responses
				click menu bar item 1 of menu bar 2
			end ignoring
		end tell
		set killDelay to killDelay + 0.5
		delay killDelay
		do shell script "killall System\\ Events"
	end repeat
end openMenu

on closeMenu()
	if menuIsOpen() then tell application "System Events" to key code 53
end closeMenu
