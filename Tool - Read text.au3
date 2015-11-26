#include <Array.au3>

#include "settings/Constants.au3"
#include "settings/Globals.au3"
;#include "settings/Settings.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"
#include "lib/Util/info.au3"

;Includes for Gui
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>


Opt("MustDeclareVars",1)
Opt("GUIOnEventMode",1)

HotKeySet ("{esc}", "Die")


;Globals that need to be converted for CodeSlinger69
Global $gTitle = $BS_TITLE
Global $gc_ScraperDebug = True

#include "lib/CodeSlinger69/CharMaps.au3"
#include "lib/CodeSlinger69/RegionDefs.au3"
;#include "lib/CodeSlinger69/FileNames.au3"

;#include "lib/CodeSlinger69/KeepOnline.au3"
;#include "lib/CodeSlinger69/Mouse.au3"
#include "lib/CodeSlinger69/Scraper.au3"
;#include "lib/CodeSlinger69/Screen.au3"
;#include "lib/CodeSlinger69/TownHall.au3"


; this is important and should be included in the final version.
while WinGetState($BS_WIN) = 0
	if MsgBox($MB_OKCANCEL, "", "BlueStacks is not open! Please open Bluestacks then click ok") = $IDCANCEL Then Exit
	$BS_WIN = WinGetHandle($BS_TITLE)
WEnd

#Region - test Gui
Local $gw = 694
Local $gh = 294
Local $p = WinGetPos($BS_WIN)


WinActivate ($BS_WIN)

Global $hGUI = GUICreate("Tool - Read Text",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))
GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

Global $inp_TextResult = GUICtrlCreateInput("", 8, 56, 265, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
Global $btn_Start = GUICtrlCreateButton("Start", 8, 16, 75, 25)
GUICtrlSetOnEvent($btn_Start, "btnGo_Start")
Global $btn_ColorDiff = GUICtrlCreateButton("Color Difference", 176, 16, 91, 25)
GUICtrlSetOnEvent($btn_ColorDiff, "btnGo_ColorDiff")
Global $btn_clear = GUICtrlCreateButton("Clear", 608, 56, 75, 25)
GUICtrlSetOnEvent($btn_clear, "btnGo_Clear")
Global $edit_settings = GUICtrlCreateEdit("", 288, 8, 305, 73, BitOR($WS_VSCROLL,$ES_READONLY))
Global $edit_debug = GUICtrlCreateEdit("", 8, 88, 673, 193, BitOR($WS_VSCROLL,$ES_READONLY))
GUICtrlSetFont($edit_debug, 9, 400, 0, "Courier New")


GUISetState(@SW_SHOW)
#EndRegion - test gui

DebugSetOutput($edit_debug)

InitScraper()



While 1
	Sleep(10)
WEnd

Func Die()
	ExitScraper()
	GUIDelete($hGUI)
	Exit
EndFunc

Func btnGo_Clear()
	GUICtrlSetData($edit_debug,"")
	GUICtrlSetData($inp_TextResult,"")
	GUICtrlSetData($edit_settings,"")
EndFunc

Func btnGo_Start()
	;if first time message
	Local $pix = GetPixelPosAndColor($BS_WIN,2,True)
	Local $rect = MarkRectangle($BS_WIN,2)
	Local $tb = [$rect[0],$rect[1],$rect[2],$rect[3],$pix[2],28,0,0,0,0]	;80
	Local $temps = "["&$tb[0]&","&$tb[1]&","&$tb[2]&","&$tb[3]&",0x"&hex($tb[4],6)&","&$tb[5]&","&$tb[6]&","&$tb[7]& _
		","&$tb[8]&","&$tb[9]&"]"&@CRLF
	GUICtrlSetData($edit_settings,$temps,1)
	GUICtrlSetData($inp_TextResult,ScrapeFuzzyText($gSmallCharMaps,$tb,$gSmallCharMapsMaxWidth,$eScrapeDropSpaces))

EndFunc

Func btnGo_ColorDiff()
	Local $pix1 = GetPixelPosAndColor($BS_WIN,1,True)
	Local $pix2 = GetPixelPosAndColor($BS_WIN,1,True)
	Local $diff = GetColorDiff($pix1[2],$pix2[2])
	Local $tempS = "[0x"&hex($pix1[2],6)&",0x"&hex($pix2[2],6)&","&Int($diff)&"]"&@CRLF
	GUICtrlSetData($edit_settings,$temps,1)

EndFunc




