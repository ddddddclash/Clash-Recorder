#include "settings/Constants.au3"
#include "settings/Globals.au3"
#include "settings/Settings.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"

;Includes for Gui
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt("MustDeclareVars",1)
Opt("GUIOnEventMode",1)

HotKeySet ("{esc}", "Die")


;Globals that need to be converted.
Global $gTitle = $BS_TITLE


#include "lib/CodeSlinger69/CharMaps.au3"
#include "lib/CodeSlinger69/RegionDefs.au3"
#include "lib/CodeSlinger69/FileNames.au3"

#include "lib/CodeSlinger69/KeepOnline.au3"
#include "lib/CodeSlinger69/Mouse.au3"
#include "lib/CodeSlinger69/Scraper.au3"
#include "lib/CodeSlinger69/Screen.au3"
#include "lib/CodeSlinger69/TownHall.au3"


; this is important and should be included in the final version.
while WinGetState($BS_WIN) = 0
	if MsgBox($MB_OKCANCEL, "", "BlueStacks is not open! Please open Bluestacks then click ok") = $IDCANCEL Then Exit
	$BS_WIN = WinGetHandle($BS_TITLE)
WEnd

#Region - test Gui
Local $gw = 297
Local $gh = 273
Local $p = WinGetPos($BS_WIN)


WinActivate ($BS_WIN)

Global $hGUI = GUICreate("Where Am I? Tool",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))

GUISetOnEvent($GUI_EVENT_CLOSE, "Die")


Global $btn_Screen_Shot = GUICtrlCreateButton("Screen Shot",10, 5, 75, 25)
GUICtrlSetOnEvent($btn_Screen_Shot, "btnGo_ScreenShot")
Global $inp_ss_name = GUICtrlCreateInput("",100,5,100,21)
Global $btn_where_am_i = GUICtrlCreateButton("Where Am I?", 104, 35, 75, 25)
GUICtrlSetOnEvent($btn_where_am_i, "btnGo_WhereAmI")

Global $Edit1 = GUICtrlCreateEdit("", 40, 72, 233, 161, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY))

GUISetState(@SW_SHOW)
#EndRegion - test gui

HotKeySet("^h", "Hide")
HotKeySet("^f", "DebugToFront")
HotKeySet("^r", "rectangle")
HotKeySet("^c", "DebugCreateCanvas")
DebugCreateCanvas()

While 1
	Sleep(10)
WEnd

Func Hide()
	DebugDestroyCanvas()
EndFunc

Func rectangle()
	DebugDrawRectangle(@DesktopWidth/2-50, @DesktopHeight/2-50, @DesktopWidth/2+50, @DesktopHeight/2+50)
EndFunc

Func btnGo_ScreenShot()
	Local $fname = GUICtrlRead($inp_ss_name)
	Local $isValid = StringRegExp($fname, "^[A-Za-z0-9_ -\.]+$", 0)
	If (@error <> 0) or (Not $isValid) Then
		MsgBox(64, "Error", "Invalid File name")
		Return
	EndIf
	GrabFrameToFile2(@ScriptDir&"/conversion/"&$fname)
	GUICtrlSetData($inp_ss_name,"")
EndFunc

Func btnGo_WhereAmI()
	Local $s = WhereAmI()
	GUICtrlSetData($Edit1,$gc_aScreens[$s]&@CRLF,1)
EndFunc

Func Die()
	DebugDestroyCanvas()
	GUIDelete($hGUI)
	Exit
EndFunc