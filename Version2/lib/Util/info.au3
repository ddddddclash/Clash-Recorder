
#include-once
#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>
#Include <Misc.au3>
#include <ScreenCapture.au3>
;#Include <WinAPI.au3>
#include <Array.au3>


Global $private_info_hWin

;Func InfoInitialize($hwind=0,$boundArea=1,$showTransparent = False)
;EndFunc
;Func InfoDestroy()
;EndFunc

Func InfoSetHWin($hwind)
	$private_info_hWin = $hwind
EndFunc


; Returns [x,y,width,height]
Func WinGetClientPos($hwind = $private_info_hWin)
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

Func MarkRectangle($hwind=0,$boundArea=1,$showTransparent=False)
    Local $tempMouseMode = opt("MouseCoordMode")
	opt("MouseCoordMode",1)

	Local $aMouse_Pos, $aWin_Pos, $hMask, $hMaster_Mask
	Local $hRectangle_GUI, $hCross_GUI
    Local $UserDLL = DllOpen("user32.dll")
	Local $iX1, $iX2, $iY1, $iY2, $aLTRB[4], $iTemp
	Local $aScreen_Pos[4] = [0, 0, @DesktopWidth, @DesktopHeight]

	; If no window handle then don't look for one.
	if $hwind = 0 then
		$boundArea = 1
	Else
		WinActivate($hwind)
	EndIf

	Switch $boundArea
		Case 0
			$aWin_Pos = WinGetPos($hwind)
		Case 1
			$aWin_Pos = $aScreen_Pos
		Case 2
			$aWin_Pos = WinGetClientPos($hwind)
	EndSwitch

    ; Create transparent GUI with Cross cursor
	$hCross_GUI = GUICreate("", $aWin_Pos[2], $aWin_Pos[3] - 20,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, $WS_EX_TOPMOST)

	If $showTransparent Then
		GUISetBkColor(0x000000)
		WinSetTrans($hCross_GUI, "", 200)
	Else
		WinSetTrans($hCross_GUI, "", 8)
	EndIf

    GUISetState(@SW_SHOW, $hCross_GUI)
    GUISetCursor(3, 1, $hCross_GUI)

	$hRectangle_GUI = GUICreate("",  $aScreen_Pos[2], $aScreen_Pos[3], $aScreen_Pos[0], $aScreen_Pos[1], $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
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
	$aLTRB[0] = $iX1 - $aWin_Pos[0]
	$aLTRB[1] = $iY1 - $aWin_Pos[1]
	$aLTRB[2] = $iX2 - $aWin_Pos[0]
	$aLTRB[3] = $iY2 - $aWin_Pos[1]


	GUIDelete($hRectangle_GUI)
	GUIDelete($hCross_GUI)
	DllClose($UserDLL)

	opt("MouseCoordMode",$tempMouseMode) ;reset to original chordinate mode.
	Return $aLTRB

EndFunc   ;==>Mark_Rect


Func GetPixelPosAndColor($hwind=0,$boundArea=1,$showTip=False)
	;Insure that MouseChordMode is default.
	Local $tempMouseMode = opt("MouseCoordMode")
	opt("MouseCoordMode",1)

	;Define variables
	Local $aPixelColor[3], $aMousePos, $color, $hCross_GUI, $aWin_Pos
	Local $UserDLL = DllOpen("user32.dll")
	Local $aScreen_Pos[4] = [0, 0, @DesktopWidth, @DesktopHeight]

	if $hwind = 0 then	$boundArea = 1

	Switch $boundArea
		Case 0
			$aWin_Pos = WinGetPos($hwind)
		Case 1
			$aWin_Pos = $aScreen_Pos
		Case 2
			$aWin_Pos = WinGetClientPos($hwind)
	EndSwitch

	; Create transparent GUI with Cross cursor
	$hCross_GUI = GUICreate("", $aWin_Pos[2], $aWin_Pos[3] - 20,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, $WS_EX_TOPMOST)
	WinSetTrans($hCross_GUI, "", 8)
    GUISetState(@SW_SHOW, $hCross_GUI)
    GUISetCursor(3, 1, $hCross_GUI)


	While Not _IsPressed("01", $UserDLL)
		if $showTip Then
			$aMousePos= MouseGetPos()
			$color= PixelGetColor($aMousePos[0], $aMousePos[1])
			ToolTip("Pos: x = " & $aMousePos[0]-$aWin_Pos[0] & ", y = " & $aMousePos[1]-$aWin_Pos[1] & @CRLF & _
				"Color = 0x" & Hex($Color, 6))
		EndIf
        Sleep(10)
    WEnd

	if $showTip Then ToolTip("")

	$aMousePos = MouseGetPos()
	$color = PixelGetColor($aMousePos[0],$aMousePos[1])

	While _IsPressed("01", $UserDLL)
        Sleep(10)
    WEnd



	$aPixelColor[0] = $aMousePos[0] - $aWin_Pos[0]
	$aPixelColor[1] = $aMousePos[1] - $aWin_Pos[1]
	$aPixelColor[2] = $color

	;clean up
	GUIDelete($hCross_GUI)
	DllClose($UserDLL)
	opt("MouseCoordMode",$tempMouseMode)

	Return $aPixelColor

EndFunc   ;==>GetPixelPosAndColor



Func GetColorDiff(Const $color, Const $center)
   Local $r = BitShift(BitAND($color, 0x00FF0000), 16)
   Local $g = BitShift(BitAND($color, 0x0000FF00), 8)
   Local $b = BitAND($color, 0x000000FF)

   Local $rC = BitShift(BitAND($center, 0x00FF0000), 16)
   Local $gC = BitShift(BitAND($center, 0x0000FF00), 8)
   Local $bC = BitAND($center, 0x000000FF)

   return Sqrt( ($rC-$r)^2 + ($gC-$g)^2 + ($bC-$b)^2 )

EndFunc





;This is my version that does not require _GDIPlus
Func GrabFrameToFile2(Const $filename, $x1=-1, $y1=-1, $x2=-1, $y2=-1)
   Local $cPos = WinGetClientPos()
   $cPos[2] += $cPos[0]-1
   $cPos[3] += $cPos[1]-1
   If $x1 = -1 Then
		_ScreenCapture_Capture($filename, $cPos[0], $cPos[1], $cPos[2], $cPos[3], False)
   Else
		_ScreenCapture_Capture($filename, $cPos[0]+$x1, $cPos[1]+$y1, $cPos[0]+$x2, $cPos[1]+$y2, False)
   EndIf

EndFunc

Func Make_Image($hwind, $aLTRB)
	Local Static $n
	$n+=1
	_ScreenCapture_CaptureWnd(uniqueFilename(@ScriptDir & "\capFile"&$n&".jpg"), $hwind, $aLTRB[0], $aLTRB[1], $aLTRB[2], $aLTRB[3],False)
	;_ScreenCapture_Capture(@ScriptDir & "\capFile"&$n&".jpg", $aLTRB[0], $aLTRB[1], $aLTRB[2], $aLTRB[3], False)


EndFunc ;==> Make_Image

Func uniqueFilename($filename)
	Local $temp = $filename
	Local $iPosition = StringInStr($filename, ".", 0, -1)
	Local $file_path_and_name = StringMid($filename,1,$iPosition-1)
	Local $file_extention = StringMid($filename,$iPosition)
	Local $i=1
	while FileExists($temp)
		$temp = $file_path_and_name &"("&$i&")"&$file_extention
		$i+=1
	WEnd
	Return $temp
EndFunc







