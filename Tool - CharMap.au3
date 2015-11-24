#include <Array.au3>

#include "settings/Constants.au3"
#include "settings/Globals.au3"
;#include "settings/Settings.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"
#include "lib/Util/info.au3"

;Includes for Gui
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>


Opt("MustDeclareVars",1)
Opt("GUIOnEventMode",1)

HotKeySet ("{esc}", "Die")


;Globals that need to be converted for CodeSlinger69
Global $gTitle = $BS_TITLE
Global $gc_ScraperDebug = True

#include "lib/CodeSlinger69/CharMaps.au3"
#include "lib/CodeSlinger69/RegionDefs.au3"
#include "lib/CodeSlinger69/Scraper.au3"


; this is important and should be included in the final version.
while WinGetState($BS_WIN) = 0
	if MsgBox($MB_OKCANCEL, "", "BlueStacks is not open! Please open Bluestacks then click ok") = $IDCANCEL Then Exit
	$BS_WIN = WinGetHandle($BS_TITLE)
WEnd

#Region - test Gui
Local $gw = 615
Local $gh = 438
Local $p = WinGetPos($BS_WIN)


WinActivate ($BS_WIN)

Global $hGUI = GUICreate("Tool - CharMap",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))
GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

;Menu
Global $idMenu_Main = GUICtrlCreateMenu("Main")
Global $idMenu_NewMap = GUICtrlCreateMenuItem(" New Map", $idMenu_Main)
GUICtrlSetOnEvent($idMenu_NewMap, "menu_NewMap")
Global $idMenu_ClearBoxes = GUICtrlCreateMenuItem("Clear Boxes", $idMenu_Main)
GUICtrlSetOnEvent($idMenu_ClearBoxes, "menu_ClearBoxes")
Global $idMenu_Save = GUICtrlCreateMenuItem("Save", $idMenu_Main)
GUICtrlSetOnEvent($idMenu_Save, "menu_Save")
Global $idMenu_Tools = GUICtrlCreateMenu("Tools")
Global $idMenu_GetColor = GUICtrlCreateMenuItem("Get Color", $idMenu_Tools)
GUICtrlSetOnEvent($idMenu_Save, "menu_GetColor")
Global $idMenu_GetRectangle = GUICtrlCreateMenuItem("Get Rectangle", $idMenu_Tools)
GUICtrlSetOnEvent($idMenu_GetRectangle, "menu_GetRectangle")
Global $idMenu_ColorDiff = GUICtrlCreateMenuItem("Color Difference", $idMenu_Tools)
GUICtrlSetOnEvent($idMenu_ColorDiff, "menu_ColorDiff")

;Gui Body

Global $comb_Map = GUICtrlCreateCombo("Select Character Map", 18, 8, 289, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($comb_Map,$g_CharMapsAll,"Select Character Map" )

GUICtrlCreateLabel("Color: 0x", 58, 38, 45, 17)
Global $inp_Color = GUICtrlCreateInput("", 106, 36, 201, 21)
GUICtrlCreateLabel("Color Radius:", 36, 68, 67, 17)
Global $inp_ColorRadius = GUICtrlCreateInput("", 106, 64, 201, 21)
GUICtrlCreateLabel("Text Box:", 54, 97, 49, 17)
Global $inp_TextBox = GUICtrlCreateInput("", 106, 92, 201, 21)
Global $btn_show = GUICtrlCreateButton("Show", 232, 120, 75, 25)

Global $inp_CharMapString = GUICtrlCreateInput("", 2, 150, 305, 21)
Global $btn_AddMap = GUICtrlCreateButton("Add", 272, 176, 35, 25)

GUICtrlCreateLabel("Text Result:", 328, 8, 61, 17)
GUICtrlCreateLabel("Recent Settings", 328, 64, 80, 17)
Global $inp_TextResult = GUICtrlCreateInput("", 328, 32, 273, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
Global $edit_settings = GUICtrlCreateEdit("", 328, 88, 273, 113, BitOR($ES_READONLY,$WS_VSCROLL))
Global $edit_debug = GUICtrlCreateEdit("", 8, 208, 601, 201, BitOR($ES_READONLY,$WS_VSCROLL))
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


Func menu_NewMap()
EndFunc

Func menu_ClearBoxes()
	GUICtrlSetData($edit_debug,"")
	GUICtrlSetData($inp_TextResult,"")
	GUICtrlSetData($edit_settings,"")
EndFunc

Func menu_Save()
EndFunc
Func menu_GetColor()
EndFunc
Func menu_GetRectangle()
EndFunc
Func menu_ColorDiff()
	Local $pix1 = GetPixelPosAndColor($BS_WIN,1,True)
	Local $pix2 = GetPixelPosAndColor($BS_WIN,1,True)
	Local $diff = GetColorDiff($pix1[2],$pix2[2])
	Local $tempS = "[0x"&hex($pix1[2],6)&", 0x"&hex($pix2[2],6)&", "&Int($diff)&"]"&@CRLF
	GUICtrlSetData($edit_settings,$temps,1)
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






