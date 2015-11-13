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


Func goProfile()
	Local $i  = 0
	Local $btnMenu[2]
	Local $btnProf[2]
	Local $btnReturn[2] = [45,45]
	if $profile_n = 0 Then
		;_ScreenCapture_Capture($IMG_PATH_CLAN, $p[0] + $cords_clan_ss[0], $p[1] +  $cords_clan_ss[1], $p[0] + $cords_clan_ss[2], $p[1] + $cords_clan_ss[3],False)
		_ClickDrag(354,364,321,120)	;Select profile 1 and move to top.
		;Detect position if not at top of screen then less than 10 players
		;when at position 1 it doesn't move
	EndIf

	;for all cases
	; set screen pointer at correct index
	$profile_n +=1
	$i = Mod($profile_n,10)
	$i = ($i = 0) ? 10 : $i

	if $profile_n > 1 Then
		If $gMouseClickMethod = "MouseClick" Then
			$btnReturn = ConvertCordinates($btnReturn[0],$btnReturn[1],$__CLIENT,$__SCREEN)
			MouseClick("left", $btnReturn[0],$btnReturn[1])
		Else
			ControlClick ($BS_WIN, "","", "left", "1", $btnReturn[0],$btnReturn[1] ) ;Player Menu
		EndIf
		Sleep(500)
	EndIf

	if ($i = 1 And $profile_n  > 10) Then
		_ClickDrag(354,630,321,110)
		;if profile id incrment of 10
		;Select profile and move to top
		;Set screen pointer at top
		;Detect position of last selected. (capture image - search for image)
		;if position not at top then it is the last screen.
			;Adjust screen pointer to detected position.
	EndIf

	ConsoleWrite("$profile_n = "&$profile_n&", $i = "&$i&@CRLF)
	$btnMenu[0] = 445
	$btnMenu[1] =67+($i*51)
	$btnProf[0] = 525
	$btnProf[1] = 59+($i*52)
	If $gMouseClickMethod = "MouseClick" Then
		$btnMenu = ConvertCordinates($btnMenu[0],$btnMenu[1],$__CLIENT,$__SCREEN)
		$btnProf = ConvertCordinates($btnProf[0],$btnProf[1],$__CLIENT,$__SCREEN)
		MouseClick("left", $btnMenu[0],$btnMenu[1])
		Sleep(500)
		MouseClick("left", $btnProf[0],$btnProf[1])
		Sleep(500)
	Else

		ControlClick ($BS_WIN, "","", "left", "1", $btnMenu[0],$btnMenu[1] ) ;Player Menu
		Sleep(500)
		ControlClick ($BS_WIN, "","", "left", "1", $btnProf[0],$btnProf[1] ) ; Profile Button
		Sleep(500)
	EndIf


EndFunc

Func goExitProfile()
	; Global profile_n = 0;
	;ControlClick ($BS_WIN, "","", "left", "1", 289,54 ) ; Green Back Arrow
	;Sleep(500)
EndFunc
