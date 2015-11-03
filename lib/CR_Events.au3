Func eventMenuSave()
	MsgBox(0,"","This could save setting or something.")
EndFunc

Func eventMenuExit()
	destroyGUI()
	Exit
EndFunc

Func eventMenuDrawRectangle()
	Local $aLTRB = Mark_Rect($BS_WIN)
	Draw_Rectangle($BS_WIN,$aLTRB[0],$aLTRB[1],$aLTRB[2],$aLTRB[3])
	if $SHOW_CORDINATES Then
		MsgBox($MB_SYSTEMMODAL, "Coords", "Left: " & $aLTRB[0] & @CRLF & "Top: " & $aLTRB[1] & @CRLF & "Right: " & $aLTRB[2] & @CRLF & "Bottom: " & $aLTRB[3])
	EndIf
EndFunc ;==>eventMenuDrawRectangle

Func eventBtnClanSnapshot()
	WinActivate ($BS_WIN)
	Local $p = WinGetPos($BS_WIN)
	_ScreenCapture_SetBMPFormat(4)
	_ScreenCapture_Capture($IMG_PATH_CLAN, $p[0] + $cords_clan_ss[0], $p[1] +  $cords_clan_ss[1], $p[0] + $cords_clan_ss[2], $p[1] + $cords_clan_ss[3],False)
	updateClanImage()
EndFunc ;==>eventBtnClanSnapshot


Func eventBtnClanSave()
	Local $hOpen = _WinHttpOpen()
	Local $hConnect = _WinHttpConnect($hOpen, $BASE_URL)

	If @error Then
		ConsoleWrite("Error getting connection handle." & @CRLF & "Error number is " & @error)
	EndIf


   Local $sRead = _WinHttpSimpleFormFill($hConnect, $PHP_CLAN, Default, _
		"name:fileToUpload", $IMG_PATH_CLAN, _
		"name:clan_name", GUICtrlRead($inp_clan_clan_name), _
		"name:total_points", GUICtrlRead($inp_clan_total_points), _
		"name:wars_won", GUICtrlRead($inp_clan_wars_won), _
		"name:num_members", GUICtrlRead($inp_clan_num_members), _
		"name:clan_type", GUICtrlRead($inp_clan_type), _
		"name:required_trophies", GUICtrlRead($inp_clan_required_trophies), _
		"name:war_frequency", GUICtrlRead($inp_clan_war_frequency), _
		"name:clan_location", GUICtrlRead($inp_clan_clan_location), _
		"name:clan_tag", GUICtrlRead($inp_clan_clan_tag), _
		"name:badge_level", GUICtrlRead($inp_clan_badge_level), _
		"name:clan_xp", GUICtrlRead($inp_clan_clan_xp), _
		"name:clan_xp_goal", GUICtrlRead($inp_clan_clan_xp_goal) _
		)


	If @error Then
		ConsoleWrite("Error number = " & @error)
	Else
		ConsoleWrite("no error:" & $sRead & @CRLF)
	EndIf


	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)


EndFunc ;==> eventBtnClanSave

Func eventBtnProfileReset()
	$profile_n = 0
EndFunc

Func eventBtnProfileSnapshot()
	;WinActivate ($BS_WIN)
	;Local $p = WinGetPos($BS_WIN)
	;_ScreenCapture_SetBMPFormat(4)
	;_ScreenCapture_Capture($IMG_PATH_CLAN, $p[0] + $cords_clan_ss[0], $p[1] +  $cords_clan_ss[1], $p[0] + $cords_clan_ss[2], $p[1] + $cords_clan_ss[3],False)
	;updateClanImage()
EndFunc ;==>eventBtnProfileSnapshot

Func eventBtnProfileGo()
	goProfile()
EndFunc ;==>eventBtnProfileGo

Func eventBtnProfileSave()

#CS
Local $hOpen = _WinHttpOpen()
	Local $hConnect = _WinHttpConnect($hOpen, $BASE_URL)

	If @error Then
		ConsoleWrite("Error getting connection handle." & @CRLF & "Error number is " & @error)
	EndIf


   Local $sRead = _WinHttpSimpleFormFill($hConnect, $PHP_CLAN, Default, _
		"name:fileToUpload", $IMG_PATH_CLAN, _
		"name:clan_name", GUICtrlRead($inp_clan_clan_name), _
		"name:total_points", GUICtrlRead($inp_clan_total_points), _
		"name:wars_won", GUICtrlRead($inp_clan_wars_won), _
		"name:num_members", GUICtrlRead($inp_clan_num_members), _
		"name:clan_type", GUICtrlRead($inp_clan_type), _
		"name:required_trophies", GUICtrlRead($inp_clan_required_trophies), _
		"name:war_frequency", GUICtrlRead($inp_clan_war_frequency), _
		"name:clan_location", GUICtrlRead($inp_clan_clan_location), _
		"name:clan_tag", GUICtrlRead($inp_clan_clan_tag), _
		"name:badge_level", GUICtrlRead($inp_clan_badge_level), _
		"name:clan_xp", GUICtrlRead($inp_clan_clan_xp), _
		"name:clan_xp_goal", GUICtrlRead($inp_clan_clan_xp_goal) _
		)


	If @error Then
		ConsoleWrite("Error number = " & @error)
	Else
		ConsoleWrite("no error:" & $sRead & @CRLF)
	EndIf


	_WinHttpCloseHandle($hConnect)
	_WinHttpCloseHandle($hOpen)
#CE
EndFunc ;==>eventBtnProfileSave
