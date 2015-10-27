;============================================================
; Function Group
;  Go_... moves the mouse and clicks inside of Clash of clans
;
;  Go_clan - Goes to the clan roster screen.
;  Go_War_Stats - Goes to the war stats screen.
;============================================================

Func goClan()

	ControlClick ($BS_WIN, "","", "left", "1", 18,348 ) ; Chat Arrow (out)
	Sleep(500)
	ControlClick ($BS_WIN, "","", "left", "1", 289,54 ) ; blue 'i'
	Sleep(500)
EndFunc


Func goProfile()
	if $profile_n = 0 Then
		_ClickDrag(354,364,321,116)	;Select profile 1 and move to top.
		;Detect position if not at top of screen then less than 10 players
			;if 1 it doesn't move
	EndIf

	;if profile id incrment of 10
		;Select profile and move to top
		;Set screen pointer at top
		;Detect position of last selected. (capture image - search for image)
		;if position not at top then it is the last screen.
			;Adjust screen pointer to detected position.
	; else
		; set screen pointer at correct index
	;ControlClick ($BS_WIN, "","", "left", "1", 18,348 ) ;Player Menu
	;Sleep(500)
	;ControlClick ($BS_WIN, "","", "left", "1", 289,54 ) ; Profile Button
	;Sleep(500)
EndFunc

Func goExitProfile()
	; Global profile_n = 0;
	;ControlClick ($BS_WIN, "","", "left", "1", 289,54 ) ; Green Back Arrow
	;Sleep(500)
EndFunc

Func goWarStats()
	ControlClick ($BS_WIN, "","", "left", "1", 18,348 ) ; Chat Arrow (out)
	Sleep(1000)
	ControlClick ($BS_WIN, "","", "left", "1", 289,54 ) ; blue 'i'
	Sleep(1000)
	ControlClick ($BS_WIN, "","", "left", "1", 94,309 ) ; war log
	Sleep(1000)
	ControlClick ($BS_WIN, "","", "left", "1", 779,107 ) ; Details
	Sleep(1000)
	ControlClick ($BS_WIN, "","", "left", "1", 332,347 ) ; Chat Arrow (in)
	Sleep(1000)
	ControlClick ($BS_WIN, "","", "left", "1", 436,584 ) ; View Map
	Sleep(1000)
	ControlClick ($BS_WIN, "","", "left", "1", 682,43 ) ; blue star
	Sleep(1000)
EndFunc