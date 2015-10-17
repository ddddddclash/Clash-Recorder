#cs--------------------------------------------------------------------------------------
;
;		This is the simplest cleanest rectangle drawing script I have found.
;		The three lines commented out are for drawing diaganal lines.
;		I have left them in for reference and a reminder that the pen has to be moved before drawing.
;
#CE--------------------------------------------------------------------------------------


#Include <WinAPI.au3>
#Include <WindowsConstants.au3>
Global $hDC, $hPen, $hWnd ; Needded to Dispose later
HotKeySet("{ESC}", "_Exit")


$GUI = GuiCreate("",@DesktopWidth,@DesktopHeight,0, 0,$WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
GuiSetBkColor(0x123456)
_WinAPI_SetLayeredWindowAttributes($GUI,0x123456,255,0x01)
WinSetOnTop($GUI, "", 1)
GuiSetState()
_DrawRectEx($GUI, @DesktopWidth/2-50, @DesktopHeight/2-50, @DesktopWidth/2+50, @DesktopHeight/2+50, 2, 0x000)
While 1
    Sleep(10)
Wend
Func _DrawRectEx($hGUI, $LeftValue, $TopValue, $RightValue, $BottomValue, $RectWidth, $RectColour)
    ; Draws a rectangle around the given area, crossed out.
    Local $obj_orig
    $hWnd = $hGUI
    $hDC = _WinAPI_GetWindowDC($hWnd)
    $hPen = _WinAPI_CreatePen($PS_SOLID, $RectWidth, $RectColour)
    $obj_orig = _WinAPI_SelectObject($hDC, $hPen)
    _WinAPI_MoveTo($hDC, $LeftValue, $TopValue)  ; move pen to the top-left
    _WinAPI_LineTo($hDC, $LeftValue, $BottomValue) ; draw line to the bottom left
    _WinAPI_LineTo($hDC, $RightValue, $BottomValue) ; draw line to the bottom right
    _WinAPI_LineTo($hDC, $RightValue, $TopValue) ; draw line to the top right
    _WinAPI_LineTo($hDC, $LeftValue, $TopValue) ; draw line to the top left
    ;_WinAPI_LineTo($hDC, $RightValue, $BottomValue) ; draw line to the bottom right (diagonal)
	;_WinAPI_MoveTo($hDC, $RightValue, $TopValue)  ; move pen to the top right
    ;_WinAPI_LineTo($hDC, $LeftValue, $BottomValue) ; draw line to the bottom left (diagonal)
    Return $hDC
EndFunc   ;==>DrawRectEx
Func _Exit()
; You Forgot to releace resources... read the help file about it in the remarks
; section of _winapi_penCreate and _WinApi_GetWindowDC
_WinAPI_DeleteObject($hPen)
_WinAPI_ReleaseDC($hWnd, $hDC)
Exit
EndFunc