Func eventMenuSave()
	MsgBox(0,"","This could save setting or something.")
EndFunc
Func eventMenuExit()
	GUIDelete()
	Exit
EndFunc
Func eventMenuDrawRectangle()
	Local $aLTRB = Mark_Rect($BS_WIN)
	Draw_Rectangle($BS_WIN,$aLTRB[0],$aLTRB[1],$aLTRB[2],$aLTRB[3])
	if $SHOW_CORDINATES Then
		MsgBox($MB_SYSTEMMODAL, "Coords", "Left: " & $aLTRB[0] & @CRLF & "Top: " & $aLTRB[1] & @CRLF & "Right: " & $aLTRB[2] & @CRLF & "Bottom: " & $aLTRB[3])
	EndIf
EndFunc

Func eventBtnClanSnapshot()
	WinActivate ($BS_WIN)
	Local $p = WinGetPos($BS_WIN)
	_ScreenCapture_SetBMPFormat(4)
	_ScreenCapture_Capture($IMG_PATH_CLAN, $p[0] + $cords_clan_ss[0], $p[1] +  $cords_clan_ss[1], $p[0] + $cords_clan_ss[2], $p[1] + $cords_clan_ss[3],False)
	updateClanImage()
EndFunc