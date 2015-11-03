
#include-once
#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>
#Include <ScreenCapture.au3>
#Include <Misc.au3>
#Include <WinAPI.au3>


Func Die()
   GUIDelete()
   Exit
EndFunc

Func GetClientPos()
	return WinGetClientPos()
EndFunc

Func WinGetClientPos($hwind = $BS_WIN)
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

;Func updateBSWinPosition($hwind = $BS_WIN)
;	Local $p = WinGetPos($hwind)
;	$bs_x = $p[0]
;	$bs_y = $p[1]
;	$bs_width = $p[2]
;	$bs_height = $p[3]
;EndFunc

;============================================================
; Function Mark_Rect
; Author: Unknown
; Draws a black rectangle and gets the left, top, bottom and right cordinates.
; Returns an array of 4 cordinages. [x1,y1,x2,y2]
;============================================================

Func Mark_Rect($hwind)
    Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
	Local $hRectangle_GUI, $hCross_GUI
	Local $aWin_Pos = WinGetPos($hwind)
    Local $UserDLL = DllOpen("user32.dll")
	Local $aLTRB[4]
	Local $showTransparent = False
	Local $iX1, $iX2, $iY1, $iY2

    ; Create transparent GUI with Cross cursor
	$hCross_GUI = GUICreate("", $aWin_Pos[2], $aWin_Pos[3] ,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, $WS_EX_TOPMOST)

	If $showTransparent Then
		GUISetBkColor(0x000000)
		WinSetTrans($hCross_GUI, "", 200)
	Else
		WinSetTrans($hCross_GUI, "", 8)
	EndIf

    GUISetState(@SW_SHOW, $hCross_GUI)
    GUISetCursor(3, 1, $hCross_GUI)

    $hRectangle_GUI = GUICreate("",  $aWin_Pos[2], $aWin_Pos[3], $aWin_Pos[0], $aWin_Pos[1], $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
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
	$aLTRB[0] = $iX1 ;+ $r_padding
	$aLTRB[1] = $iY1 ;+ $r_padding;+2
	$aLTRB[2] = $iX2 ;+ $r_padding
	$aLTRB[3] = $iY2 ;+ $r_padding;+2


   GUIDelete($hRectangle_GUI)
   GUIDelete($hCross_GUI)
   DllClose($UserDLL)

	Return $aLTRB

EndFunc   ;==>Mark_Rect

;============================================================
; Function Draw_Rectangle
; Author: dddddd.clash
; Function:
;============================================================
Func Draw_Rectangle($hwind, $left,$top,$right,$bottom,$fName = "clan.jpg")
	local $aWin_Pos = WinGetPos($hwind)
	Global $hTrans_GUI = GUICreate("Test", $aWin_Pos[2], $aWin_Pos[3] ,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT,$WS_EX_TOPMOST))
	Global $hDC, $hPen, $hWnd ; Needded to Dispose later
	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($hTrans_GUI,0x123456,255,0x01)
	;WinSetOnTop($hTrans_GUI, "", 1)
	GuiSetState()
	_DrawRectEx($hTrans_GUI, $left, $top, $right, $bottom, 1, 0x000)
	_ScreenCapture_CaptureWnd(uniqueFilename(@ScriptDir & "\screenshots\$fName"), $hTrans_GUI, $left, $top, $right, $bottom,False)

	Destroy_Rectangle()
EndFunc   ;==>Draw_Rectangle

;============================================================
; Function Draw_Rectangle
; My function that calls Draw Rectangle and saves the image as a unique file name
; Returns an array of 4 cordinates. [x1,y1,x2,y2]
;============================================================
Func _DrawRectEx($hGUI, $LeftValue, $TopValue, $RightValue, $BottomValue, $RectWidth, $RectColour)
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
    Return $hDC
EndFunc


Func Destroy_Rectangle()
_WinAPI_DeleteObject($hPen)
_WinAPI_ReleaseDC($hWnd, $hDC)
EndFunc   ;==Destroy_Rectangle


Func Make_Image($hwind, $aLTRB)
	$n+=1;
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






