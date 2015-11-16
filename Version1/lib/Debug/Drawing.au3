#cs
	File: drawing.au3
	Author: dddddd.clash
	Date: 2015-11-04
	Summary:	These functions draw on a transparent window and are used for debugging screen cordinates.
#ce


#include-once
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>


;Global $hDC, $hPen, $hWnd ; Needded to Dispose later
Global $debugGUI = 0



; _DrawGui() has been replaced by _DebugCreateCanvas
Func DebugCreateCanvas()
;Func DebugCreateCanvas($width = @DesktopWidth, $height = @DesktopHeight, $left = 0, $top = 0)
	;$debugGUI = GuiCreate("",$width,$height,$left, $top, $WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
	$debugGUI = GuiCreate("",@DesktopWidth,@DesktopHeight,0, 0,$WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($debugGUI,0x123456,255,0x01)
	WinSetOnTop($debugGUI, "", 1)
	GuiSetState()
EndFunc





Func DebugDrawRectangle($LeftValue, $TopValue, $RightValue, $BottomValue, $RectWidth = 1, $RectColour = 0x000)
    Local $hDC = _WinAPI_GetWindowDC($debugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, $RectWidth, $RectColour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $LeftValue, $TopValue, $RightValue, $TopValue) ; horizontal top
	_WinAPI_DrawLine($hDC, $LeftValue, $BottomValue,$RightValue , $BottomValue) ; horizontal bottom
	_WinAPI_DrawLine($hDC, $LeftValue, $TopValue, $LeftValue, $BottomValue) ; vertical left
	_WinAPI_DrawLine($hDC, $RightValue, $TopValue, $RightValue, $BottomValue) ; vertical right

	_WinAPI_ReleaseDC($debugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawRectangle

Func DebugDrawPoint($x, $y, $colour = 0x000) ; Cross hairs
    Local $hDC = _WinAPI_GetWindowDC($debugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $colour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x-6, $y-1, $x-1, $y-1)
	_WinAPI_DrawLine($hDC, $x, $y-1, $x+5, $y-1)
	_WinAPI_DrawLine($hDC, $x-1, $y-6, $x-1, $y-1)
	_WinAPI_DrawLine($hDC, $x-1, $y, $x-1, $y+5)


	_WinAPI_ReleaseDC($debugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawPoint

Func DebugDrawArrow($x, $y, $colour =0x000) ; arrow head pointing to cordinates.
    Local $hDC = _WinAPI_GetWindowDC($debugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $colour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x, $y, $x+5, $y+1)
	_WinAPI_DrawLine($hDC, $x, $y, $x+1, $y+5)


	_WinAPI_ReleaseDC($debugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawArrow


Func DebugDestroyCanvas()
	GUIDelete($debugGUI)
EndFunc ;==>DebugDestroyCanvas

