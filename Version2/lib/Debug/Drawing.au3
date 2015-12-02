#cs
	File: drawing.au3
	Author: dddddd.clash
	Date: 2015-11-13
	Summary:	These functions draw on a transparent window and are used for debugging screen cordinates.
#ce

#include-once
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>
#include <GuiImageList.au3>


Global $private_DebugGUI = 0
Global $private_Debug_Drawing_Enabled = False


Func DebugDrawingEnable()
	$private_Debug_Drawing_Enabled = True
EndFunc

Func DebugDrawingDisable()
	$private_Debug_Drawing_Enabled = False
EndFunc


; _DrawGui() has been replaced by _DebugCreateCanvas
Func DebugCreateCanvas()
	If Not $private_Debug_Drawing_Enabled Then Return
	$private_DebugGUI = GuiCreate("",@DesktopWidth,@DesktopHeight,0, 0,$WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($private_DebugGUI,0x123456,255,0x01)
	WinSetOnTop($private_DebugGUI, "", 1)
	GuiSetState()
EndFunc

; shouldn't be necessary any more because of debugDraw Pixel.Confirm before deleting
; commented out on 11/19/2015
#cs
Func DebugIsPresent($var_name)
	If StringInStr($var_name,"Color") Then
		$x= Execute($var_name&"[0]")
		$y= Execute($var_name&"[1]")
	ElseIf StringInStr($var_name,"Button") Then
		$x= Execute($var_name&"[4]")
		$y= Execute($var_name&"[5]")
	Else
		Return -1 ;Error
	EndIf
	DebugDrawPointLabel($x,$y,StringMid($var_name,3))
EndFunc
#ce

Func DebugToFront()
	WinActivate ($private_DebugGUI)
EndFunc


Func DebugDrawTextArea($textBox,$label)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
	Local $c = GetClientPos()
	DebugDrawRectangle($textBox[0]+$c[0],$textBox[1]+$c[1],$textBox[2]+$c[0],$textBox[3]+$c[1])
	DebugDrawPoint($textBox[6]+$c[0],$textBox[7]+$c[1])
	DebugDrawLabel($label, $textBox[0]+$c[0], $textBox[1]+$c[1]-25)
	DebugDrawColor($textBox[4],$textBox[0]+$c[0], $c[1]+$textBox[3]+5)
	DebugDrawColor($textBox[8],$textBox[0]+$c[0]+30, $c[1]+$textBox[3]+5)
EndFunc	;==>DebugDrawTextArea

Func DebugDrawButton($button,$label)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
	Local $c = GetClientPos()
	DebugDrawRectangle($button[0]+$c[0],$button[1]+$c[1],$button[2]+$c[0],$button[3]+$c[1])
	DebugDrawPoint($button[4]+$c[0],$button[5]+$c[1])
	DebugDrawLabel($label, $button[0]+$c[0], $button[1]+$c[1]-25)
	DebugDrawColor($button[6],$button[0]+$c[0], $c[1]+$button[3]+5)
EndFunc	;==>DebugDrawButton

Func DebugDrawPixel($pixel,$label)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
	Local $c = GetClientPos()
	DebugDrawPointLabel($pixel[0],$pixel[1],$label)
	DebugDrawColor($pixel[3],$c[0]+$pixel[0], $c[1]+ $pixel[1]+15)
EndFunc	;==>DebugDrawPixel



; draws color rectangle relative to screen
Func DebugDrawColor($color,$x,$y)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
	Local $hColors = _GUIImageList_Create(25,25)
	 _GUIImageList_Add($hColors,_WinAPI_CreateSolidBitmap($private_DebugGUI,$color,25,25))
	Local $hDC = _WinAPI_GetDC($private_DebugGUI)
	_GUIImageList_Draw($hColors, 0, $hDC, $x, $y)
	_WinAPI_ReleaseDC($private_DebugGUI, $hDC)
EndFunc ;==>DebugDrawColor

; draws point relative to client window
Func DebugDrawPointLabel($x,$y,$label)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
	Local $cpos = GetClientPos()
	$x = $cpos[0] + $x
	$y = $cpos[1] + $y
	DebugDrawLabel($label, $x+10, $y)
	DebugDrawPoint($x,$y)
EndFunc	;==>DebugDrawPointLabel

;draws point relative to screen cordinates.
Func DebugDrawLabel($text,$x,$y)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
	GUISwitch($private_DebugGUI)
	GUICtrlCreateLabel($text, $x, $y)
	GUICtrlSetBkColor(-1, 0xffffff)
EndFunc	;==>DebugDrawLabel

;draws rectangle relative to screen
Func DebugDrawRectangle($LeftValue, $TopValue, $RightValue, $BottomValue, $RectWidth = 1, $RectColour = 0x000)
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
    Local $hDC = _WinAPI_GetWindowDC($private_DebugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, $RectWidth, $RectColour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $LeftValue, $TopValue, $RightValue, $TopValue) ; horizontal top
	_WinAPI_DrawLine($hDC, $LeftValue, $BottomValue,$RightValue , $BottomValue) ; horizontal bottom
	_WinAPI_DrawLine($hDC, $LeftValue, $TopValue, $LeftValue, $BottomValue) ; vertical left
	_WinAPI_DrawLine($hDC, $RightValue, $TopValue, $RightValue, $BottomValue) ; vertical right

	_WinAPI_ReleaseDC($private_DebugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawRectangle

;draws point relative to screen
Func DebugDrawPoint($x, $y, $colour = 0x000) ; Cross hairs
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
    Local $hDC = _WinAPI_GetWindowDC($private_DebugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $colour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x-6, $y-1, $x-1, $y-1)
	_WinAPI_DrawLine($hDC, $x, $y-1, $x+5, $y-1)
	_WinAPI_DrawLine($hDC, $x-1, $y-6, $x-1, $y-1)
	_WinAPI_DrawLine($hDC, $x-1, $y, $x-1, $y+5)

	_WinAPI_ReleaseDC($private_DebugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawPoint

Func DebugDrawArrow($x, $y, $colour =0x000) ; arrow head pointing to cordinates.
	If Not $private_Debug_Drawing_Enabled or $private_DebugGUI = 0 Then Return
    Local $hDC = _WinAPI_GetWindowDC($private_DebugGUI)
    Local $hPen = _WinAPI_CreatePen($PS_SOLID, 1, $colour)
    Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x, $y, $x+5, $y+1)
	_WinAPI_DrawLine($hDC, $x, $y, $x+1, $y+5)


	_WinAPI_ReleaseDC($private_DebugGUI, $hDC)
	_WinAPI_DeleteObject($hPen)

EndFunc   ;==>DebugDrawArrow


Func DebugDestroyCanvas()
	If $private_DebugGUI = 0 Then Return
	GUIDelete($private_DebugGUI)
	$private_DebugGUI = 0
EndFunc ;==>DebugDestroyCanvas

