#cs
	File: drawing.au3
	Author: dddddd.clash
	Date: 2015-11-13
	Summary:	These functions draw on a transparent window and are used for debugging screen cordinates.
#ce


#include-once
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>


;Global $hDC, $hPen, $hWnd ; Needded to Dispose later
Global $debugGUI = 0



; _DrawGui() has been replaced by _DebugCreateCanvas

Func DebugCreateCanvas($width = @DesktopWidth, $height = @DesktopHeight, $left = 0, $top = 0)
	If Not $gc_DEBUG_CANVAS Then Return
	$debugGUI = GuiCreate("",$width,$height,$left, $top, $WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($debugGUI,0x123456,255,0x01)
	WinSetOnTop($debugGUI, "", 1)
	GuiSetState()
EndFunc


Func DebugDrawLabel($text, $x, $y, $width, $height)
	If Not $gc_DEBUG_CANVAS Then Return
	GuiSetState(@SW_SHOW,$debugGUI)
	;GUICtrlCreateLabel("Width:", $x+20, $y-4, 35, 17)

	Local $hDC = _WinAPI_GetWindowDC($debugGUI)
	Local $g_tRECT = DllStructCreate($tagRect)

	DllStructSetData($g_tRECT, "Left", $x)
	DllStructSetData($g_tRECT, "Top", $y)
	DllStructSetData($g_tRECT, "Right", $x + $width)
	DllStructSetData($g_tRECT, "Bottom", $y + $height)

	_WinAPI_DrawText($hDC, $text, $g_tRECT, $DT_Left)
	_WinAPI_ReleaseDC($debugGUI, $hDC)

EndFunc




Func DebugDrawRectangle($LeftValue, $TopValue, $RightValue, $BottomValue, $RectWidth = 1, $RectColour = 0x000)
	If Not $gc_DEBUG_CANVAS Then Return
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
	If Not $gc_DEBUG_CANVAS Then Return
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
	If Not $gc_DEBUG_CANVAS Then Return
    Local $hDC = _WinAPI_GetWindowDC($debugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $colour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x, $y, $x+5, $y+1)
	_WinAPI_DrawLine($hDC, $x, $y, $x+1, $y+5)


	_WinAPI_ReleaseDC($debugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawArrow


Func DebugDestroyCanvas()
	If Not $gc_DEBUG_CANVAS Then Return
	GUIDelete($debugGUI)
EndFunc ;==>DebugDestroyCanvas

