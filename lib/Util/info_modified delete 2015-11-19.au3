
#include-once
#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>
#Include <Misc.au3>
;#Include <WinAPI.au3>


Global $private_info_hWin = 0
Global $private_info_WinPos
Global $hCross_GUI

Func InfoInitialize($hwind=0,$boundArea=1,$showTransparent = False)
	; If no window handle then don't look for one.
	$private_info_hWin = $hwind
	if $hwind = 0 then $boundArea = 1
	Local $aScreen_Pos[4] = [0, 0, @DesktopWidth, @DesktopHeight]
	Switch $boundArea
		Case 0
			$private_info_WinPos = WinGetPos($private_info_hWin)
		Case 1
			$private_info_WinPos = $aScreen_Pos
		Case 2
			$private_info_WinPos = WinGetClientPos()
	EndSwitch

    ; Create transparent GUI with Cross cursor
	$hCross_GUI = GUICreate("", $private_info_WinPos[2], $private_info_WinPos[3] - 20,$private_info_WinPos[0] , $private_info_WinPos[1] , $WS_POPUP, $WS_EX_TOPMOST)

	If $showTransparent Then
		GUISetBkColor(0x000000)
		WinSetTrans($hCross_GUI, "", 200)
	Else
		WinSetTrans($hCross_GUI, "", 8)
	EndIf

    GUISetState(@SW_SHOW, $hCross_GUI)
    GUISetCursor(3, 1, $hCross_GUI)
EndFunc

Func InfoDestroy()
	GUIDelete($hCross_GUI)
EndFunc



;used by Codeslinger69 code.
Func GetClientPos()
	Return WinGetClientPos()
EndFunc

Func WinGetClientPos()
	if $private_info_hWin = 0 Then Return ;Doesn't work if no client defined
	$hwind = $private_info_hWin
	WinActivate ($hwind)
	local $aWin_Pos = WinGetPos($hwind)
	Local $cSize = WinGetClientSize($hwind)
	Local $padding = ($aWin_Pos[2] - $cSize[0]) /2
	Local $header = $aWin_Pos[3] - $cSize[1] - $padding

	Local $cPos[4]
	$cPos[0] = $aWin_Pos[0] + $padding
	$cPos[1] = $aWin_Pos[1] + $header
	$cPos[2] =$cSize[0]
	$cPos[3] =$cSize[1]

	Return $cPos
EndFunc




;============================================================
; Function MarkRectangle
; Author: dddddd.clash
; Date:
; Description:
; 	Draws a black rectangle and gets the left, top, bottom and right cordinates.
; Returns:
;	an array of 4 coordinates [left,top,right,bottom]
;	Values are relative or absolute as set in $size
; Setting:
;	$boundArea  0 = Active Window, 1 = Screen, 2 = client area of active window.
;============================================================

Func MarkRectangle()
    Local $aMouse_Pos, $hMask, $hMaster_Mask
	Local $hRectangle_GUI
    Local $UserDLL = DllOpen("user32.dll")
	Local $iX1, $iX2, $iY1, $iY2, $aLTRB[4], $iTemp

	Local $tempMouseMode = opt("MouseCoordMode")
	opt("MouseCoordMode",1)


	$hRectangle_GUI = GUICreate("",  @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
    GUISetBkColor(0x000000) ;Selection box color.

    ; Wait until mouse button pressed
    While Not _IsPressed("01", $UserDLL)
        Sleep(10)
    WEnd

    ; Get first mouse position
    $aMouse_Pos = MouseGetPos()
    $iX1 = $aMouse_Pos[0]
    $iY1 = $aMouse_Pos[1]

    ; Draw rectangle while mouse button pressed
    While _IsPressed("01", $UserDLL)

        $aMouse_Pos = MouseGetPos()

        $hMaster_Mask = _WinAPI_CreateRectRgn(0, 0, 0, 0)
        $hMask = _WinAPI_CreateRectRgn($iX1,  $aMouse_Pos[1], $aMouse_Pos[0],  $aMouse_Pos[1] + 1) ; Bottom of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        $hMask = _WinAPI_CreateRectRgn($iX1, $iY1, $iX1 + 1, $aMouse_Pos[1]) ; Left of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        $hMask = _WinAPI_CreateRectRgn($iX1 + 1, $iY1 + 1, $aMouse_Pos[0], $iY1) ; Top of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        $hMask = _WinAPI_CreateRectRgn($aMouse_Pos[0], $iY1, $aMouse_Pos[0] + 1,  $aMouse_Pos[1]) ; Right of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        ; Set overall region
        _WinAPI_SetWindowRgn($hRectangle_GUI, $hMaster_Mask)

        If WinGetState($hRectangle_GUI) < 15 Then GUISetState()
        Sleep(10)

    WEnd

    ; Get second mouse position
    $iX2 = $aMouse_Pos[0]
    $iY2 = $aMouse_Pos[1]

    ; Set in correct order if required
    If $iX2 < $iX1 Then
        $iTemp = $iX1
        $iX1 = $iX2
        $iX2 = $iTemp
    EndIf
    If $iY2 < $iY1 Then
        $iTemp = $iY1
        $iY1 = $iY2
        $iY2 = $iTemp
    EndIf

	; set return array
	$aLTRB[0] = $iX1 - $private_info_WinPos[0]
	$aLTRB[1] = $iY1 - $private_info_WinPos[1]
	$aLTRB[2] = $iX2 - $private_info_WinPos[0]
	$aLTRB[3] = $iY2 - $private_info_WinPos[1]

	GUIDelete($hRectangle_GUI)
	DllClose($UserDLL)
	opt("MouseCoordMode",$tempMouseMode) ;reset to original chordinate mode.

	Return $aLTRB

EndFunc   ;==>Mark_Rect


Func GetPixelPosAndColor()


EndFunc   ;==>Mark_Rect



