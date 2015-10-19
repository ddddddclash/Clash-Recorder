
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


;============================================================
; Function Group
;  Go_... moves the mouse and clicks inside of Clash of clans
;
;  Go_clan - Goes to the clan roster screen.
;  Go_War_Stats - Goes to the war stats screen.
;============================================================

Func Go_clan($hwind)
	ConsoleWrite("go_clan")
	;WinActivate ($hwind)
	ControlClick ($hwind, "","", "left", "1", 18,348 ) ; Chat Arrow (out)
	Sleep(500)
	ControlClick ($hwind, "","", "left", "1", 289,54 ) ; blue 'i'
	Sleep(500)
EndFunc


Func Go_War_Stats($hwind)
	;WinActivate ($hwind)
	ControlClick ($hwind, "","", "left", "1", 18,348 ) ; Chat Arrow (out)
	Sleep(1000)
	ControlClick ($hwind, "","", "left", "1", 289,54 ) ; blue 'i'
	Sleep(1000)
	ControlClick ($hwind, "","", "left", "1", 94,309 ) ; war log
	Sleep(1000)
	ControlClick ($hwind, "","", "left", "1", 779,107 ) ; Details
	Sleep(1000)
	ControlClick ($hwind, "","", "left", "1", 332,347 ) ; Chat Arrow (in)
	Sleep(1000)
	ControlClick ($hwind, "","", "left", "1", 436,584 ) ; View Map
	Sleep(1000)
	ControlClick ($hwind, "","", "left", "1", 682,43 ) ; blue star
	Sleep(1000)
EndFunc


; Returns the absolute position of the client window
Func GetClientPos()
   Local $cPos[4]

   ; Get absolute coordinates of client area
   Local $hWnd = WinGetHandle($BS_title)
   Local $cSize = WinGetClientSize($BS_title)

   Local $tPoint = DllStructCreate("int X;int Y")
   DllStructSetData($tPoint, "X", 0)
   DllStructSetData($tPoint, "Y", 0)

   _WinAPI_ClientToScreen($hWnd, $tPoint)
   $cPos[0] = DllStructGetData($tPoint, "X")
   $cPos[1] = DllStructGetData($tPoint, "Y")
   $cPos[2] = $cPos[0]+$cSize[0]-1
   $cPos[3] = $cPos[1]+$cSize[1]-1

   Return $cPos
EndFunc


;============================================================
; Function Mark_Rect
; Returns an array of 4 cordinages. [x1,y1,x2,y2]
;============================================================



Func Mark_Rect($hwind)



    local $aWin_Pos = WinGetPos($hwind)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $aWin_Pos = ' & $aWin_Pos & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	local $aWin_Pos2 = GetClientPos()
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $aWin_Pos2 = ' & $aWin_Pos2 & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	local $aControl_Pos = ControlGetPos($hwind,"","[CLASS:BlueStacksApp; INSTANCE:1]")

    Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
    Local $UserDLL = DllOpen("user32.dll")

	Local $aLTRB[4]
	Local $r_padding = ($aWin_Pos[2] - $aControl_Pos[2]) /2
	Local $r_left = $aWin_Pos[0] + $r_padding
	Local $r_header = $aWin_Pos[3] - $aControl_Pos[3] - $r_padding
	Local $r_top = $aWin_Pos[1] + $r_header


    ; Create transparent GUI with Cross cursor
	;$hCross_GUI = GUICreate("Test", $aControl_Pos[2], $aControl_Pos[3] ,$r_left , $r_top , $WS_POPUP, $WS_EX_TOPMOST)
	Local $hCross_GUI = GUICreate("Test", $aWin_Pos[2], $aWin_Pos[3] ,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, $WS_EX_TOPMOST)
    WinSetTrans($hCross_GUI, "", 8)
    GUISetState(@SW_SHOW, $hCross_GUI)
    GUISetCursor(3, 1, $hCross_GUI)

   ; Global $hRectangle_GUI = GUICreate("",  $aControl_Pos[2], $aControl_Pos[3] ,$r_left , $r_top, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
    Global $hRectangle_GUI = GUICreate("",  $aWin_Pos[2], $aWin_Pos[3] ,$aWin_Pos[0] , $aWin_Pos[1], $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
    GUISetBkColor(0x000000)

    ; Wait until mouse button pressed
    While Not _IsPressed("01", $UserDLL)
        Sleep(10)
    WEnd

    ; Get first mouse position
    $aMouse_Pos = MouseGetPos()
    Local $iX1 = $aMouse_Pos[0]
    Local $iY1 = $aMouse_Pos[1]

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
    Local $iX2 = $aMouse_Pos[0]
    Local $iY2 = $aMouse_Pos[1]

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


Func Draw_Rectangle($hwind, $left,$top,$right,$bottom)
	local $aWin_Pos = WinGetPos($hwind)
	Global $hTrans_GUI = GUICreate("Test", $aWin_Pos[2], $aWin_Pos[3] ,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT,$WS_EX_TOPMOST))
	Global $hDC, $hPen, $hWnd ; Needded to Dispose later
	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($hTrans_GUI,0x123456,255,0x01)
	;WinSetOnTop($hTrans_GUI, "", 1)
	GuiSetState()
	_DrawRectEx($hTrans_GUI, $left, $top, $right, $bottom, 1, 0x000)
	Local $success = _ScreenCapture_CaptureWnd(Unique_Filename(@ScriptDir & "\screenshots\clan.jpg"), $hTrans_GUI, $left, $top, $right, $bottom,False)
	If not $success Then
		ConsoleWrite('>Error code: ' & @error & @CRLF)
	EndIf
	Destroy_Rectangle()
EndFunc   ;==>Draw_Rectangle

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
	_ScreenCapture_CaptureWnd(Unique_Filename(@ScriptDir & "\capFile"&$n&".jpg"), $hwind, $aLTRB[0], $aLTRB[1], $aLTRB[2], $aLTRB[3],False)
	;_ScreenCapture_Capture(@ScriptDir & "\capFile"&$n&".jpg", $aLTRB[0], $aLTRB[1], $aLTRB[2], $aLTRB[3], False)


EndFunc ;==> Make_Image

Func Unique_Filename($filename)
	Local $temp = $filename
	Local $iPosition = StringInStr($filename, ".", 0, -1)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $iPosition = ' & $iPosition & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Local $file_path_and_name = StringMid($filename,1,$iPosition-1)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $file_path_and_name = ' & $file_path_and_name & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Local $file_extention = StringMid($filename,$iPosition)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $file_extention = ' & $file_extention & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Local $i=1
	while FileExists($temp)
		$temp = $file_path_and_name &"("&$i&")"&$file_extention
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $temp = ' & $temp & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
		$i+=1
	WEnd
	Return $temp
EndFunc
#cs
function unique_filename($filename){
	$temp = $filename;
	$tpi =  pathinfo($temp); //target file path info
	$i = 1;
	while (file_exists($temp)) {
		$temp = $tpi['dirname'] .'/'. $tpi['filename'] . ' ('.$i.').'.$tpi['extension'];
		$i++;
	}
	return $temp;
}
#ce
