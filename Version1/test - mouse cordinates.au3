#include "lib/CR_Global_Const.au3"
#include "lib/CR_Global.au3"
;#include <GUIConstantsEx.au3>
;#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>
#Include <Misc.au3>
#Include <WinAPI.au3>

Opt ("MouseCoordMode", 0)
HotKeySet ("{esc}", "Die")


Global $hTrans_GUI
Global $hDC, $hPen, $hWnd ; Needded to Dispose later

main()

Func main()
	WinActivate ($BS_WIN)
	Local $p = GetClientPos();WinGetClientPos()
	Local $w = WinGetPos($BS_WIN)
	Draw_Rectangle($p[0],$p[1],$p[2],$p[3],0x000)
	Draw_Rectangle($w[0],$w[1],$w[2],$w[3],0xccc)


	mainApplicationLoop()

EndFunc ;==>main

Func mainApplicationLoop()
	While 1
		Sleep(10)
	WEnd
EndFunc

Func GetClientPos()
   Local $cPos[4]
   Local $gTitle = $BS_TITLE
   ; Get absolute coordinates of client area
   Local $hWnd = WinGetHandle($gTitle)
   Local $cSize = WinGetClientSize($gTitle)

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


Func WinGetClientPos($hwind = $BS_WIN)
	WinActivate ($BS_WIN)
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

Func Draw_Rectangle($left,$top,$right,$bottom,$color)
	Local $hwind = $BS_WIN
	local $aWin_Pos = WinGetPos($hwind)
	$hTrans_GUI = GUICreate("Test", $aWin_Pos[2], $aWin_Pos[3] ,$aWin_Pos[0] , $aWin_Pos[1] , $WS_POPUP, bitor($WS_EX_LAYERED,$WS_EX_TRANSPARENT,$WS_EX_TOPMOST))

	GuiSetBkColor(0x123456)
	_WinAPI_SetLayeredWindowAttributes($hTrans_GUI,0x123456,255,0x01)
	;WinSetOnTop($hTrans_GUI, "", 1)
	GuiSetState()
	_DrawRectEx($hTrans_GUI, $left, $top, $right, $bottom, 1, $color)
	;_ScreenCapture_CaptureWnd(uniqueFilename(@ScriptDir & "\screenshots\"&$fName), $hTrans_GUI, $left, $top, $right, $bottom,False)

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

Func Die()
	Exit
EndFunc