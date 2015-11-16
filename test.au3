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
HotKeySet("h", "Hide")
HotKeySet("d", "DebugCreateCanvas")

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


#Region - test Gui
;Local $gw = 297
;Local $gh = 273
;Local $p = WinGetPos($BS_WIN)
;WinActivate ($BS_WIN)
;Global $hGUI = GUICreate("Where Am I? Tool",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))
;Global $hGUI = GUICreate("Where Am I? Tool", $gw, $gh, @DesktopWidth - $gw -20 , 20)

Global $hGUI = GUICreate("Where Am I? Tool", 297, 273, 192, 124)

GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

Global $btn_where_am_i = GUICtrlCreateButton("Where Am I?", 104, 32, 75, 25)
GUICtrlSetOnEvent($btn_where_am_i, "btnGo_WhereAmI")
Global $Edit1 = GUICtrlCreateEdit("", 40, 72, 233, 161, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY))

GUISetState(@SW_SHOW)
#EndRegion - test gui

DebugCreateCanvas()

While 1
	Sleep(10)
WEnd

Func Hide()
	DebugDestroyCanvas()
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