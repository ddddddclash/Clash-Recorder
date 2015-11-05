#cs
	File: drawing.au3
	Author: dddddd.clash
	Date: 2015-11-04
	Summary:	These functions draw on a transparent window and are used for debugging screen cordinates.
#ce


#include-once
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>


Global $hDC, $hPen, $hWnd ; Needded to Dispose later
Global $GUI

Func _DrawGui()
	$GUI = GuiCreate("",@DesktopWidth,@DesktopHeight,0, 0,$WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($GUI,0x123456,255,0x01)
	WinSetOnTop($GUI, "", 1)
	GuiSetState()

EndFunc

Func _DrawRectEx($LeftValue, $TopValue, $RightValue, $BottomValue, $RectWidth, $RectColour, $hWnd = $GUI)
    Local $obj_orig
    $hDC = _WinAPI_GetWindowDC($hWnd)
    $hPen = _WinAPI_CreatePen($PS_SOLID, $RectWidth, $RectColour)
    $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $LeftValue, $TopValue, $RightValue, $TopValue) ; horizontal top
	_WinAPI_DrawLine($hDC, $LeftValue, $BottomValue,$RightValue , $BottomValue) ; horizontal bottom
	_WinAPI_DrawLine($hDC, $LeftValue, $TopValue, $LeftValue, $BottomValue) ; vertical left
	_WinAPI_DrawLine($hDC, $RightValue, $TopValue, $RightValue, $BottomValue) ; vertical right

	_WinAPI_ReleaseDC($hWnd, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DrawRectEx

Func _DrawPoint($x, $y, $colour, $hWnd = $GUI) ; arrow head pointing to cordinates.
    Local $obj_orig
    $hDC = _WinAPI_GetWindowDC($hWnd)
    $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $colour)
    $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x, $y, $x+5, $y+1)
	_WinAPI_DrawLine($hDC, $x, $y, $x+1, $y+5)


	_WinAPI_ReleaseDC($hWnd, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DrawRectEx


Func _DeleteGUI()
	GUIDelete($GUI)
EndFunc

