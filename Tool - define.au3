;Tool Define pixels and rectangles
;dddddd.clash


#include "settings/Constants.au3"
#include "settings/Globals.au3"
#include "settings/Settings.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"
#include "lib/Util/info.au3"

;Includes for Gui
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>


;Opt("MustDeclareVars",1)
Opt("GUIOnEventMode",1)

HotKeySet ("{esc}", "Die")

Global $PixelMode = True
Global $PPaC



; this is important and should be included in the final version.
while WinGetState($BS_WIN) = 0
	if MsgBox($MB_OKCANCEL, "", "BlueStacks is not open! Please open Bluestacks then click ok") = $IDCANCEL Then Exit
	$BS_WIN = WinGetHandle($BS_TITLE)
WEnd

#Region - Tool Define - Gui
Local $p = WinGetPos($BS_WIN)
Local $c = WinGetClientPos($BS_WIN)
Local $gw = 202
Local $gh = 232



WinActivate ($BS_WIN)

Global $hGUI = GUICreate("Tool - Define",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))
GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

GUICtrlCreateLabel("Note:", 22, 18, 30, 17)
Global $inp_note = GUICtrlCreateInput("", 62, 16, 121, 21)
Global $btnPixel = GUICtrlCreateButton("Pixel", 19, 40, 75, 25)
GUICtrlSetOnEvent($btnPixel, "btnGo_Pixel")
Global $btnRectangle = GUICtrlCreateButton("Rectangle", 107, 40, 75, 25)
GUICtrlSetOnEvent($btnRectangle, "btnGo_Rectangle")
$Edit1 = GUICtrlCreateEdit("", 10, 80, 185, 137, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY))


GUISetState(@SW_SHOW)

#EndRegion - Tool Define - Gui




Local $MainUserDLL
Local $aPos
Local $iColor
While 1
	if $PixelMode Then
		$MainUserDLL = DllOpen("user32.dll")
		$aPos= MouseGetPos()
		$iColor= PixelGetColor($aPos[0], $aPos[1])
		ToolTip("Pos: x = " & $aPos[0] & ", y = " & $aPos[1] & @CRLF & _
            "Color = 0x" & Hex($iColor, 6))
		If _IsPressed("01",$MainUserDLL) Then
			while _IsPressed("01",$MainUserDLL)
				Sleep(100)
			WEnd
			$aPos= MouseGetPos()
			if WinActive($BS_WIN) and $aPos[0] > $c[0] and $apos[0] < $c[0]+$c[2] And  $aPos[1] > $c[1] and $apos[1] < $c[1]+$c[3] Then
				$PPaC = GetPixelPosAndColor(2)
				GUICtrlSetData($Edit1,"Pixel = ["&$PPaC[0]&","&$PPaC[1]&",0x"&Hex($PPaC[2], 6)&","&$PPaC[3]& _
					"] - "&GUICtrlRead($inp_note)&@CRLF,1)
			EndIf
		EndIf
		DllClose($MainUserDLL)
	EndIf
    Sleep(10)
WEnd





Func btnGo_Pixel()
	$PixelMode = True
	WinActivate ($BS_WIN)
EndFunc

;GUICtrlSetData($Edit1,$tempS&@CRLF,1)

Func btnGo_Rectangle()
	$PixelMode = False
	Local $r = MarkRectangle($BS_WIN,2)
	GUICtrlSetData($Edit1,"Rectangle = ["&$r[0]&","&$r[1]&","&$r[2]&","&$r[3]&"] - "&GUICtrlRead($inp_note)&@CRLF,1)
EndFunc






Func Die()
	GUIDelete($hGUI)
	Exit
EndFunc