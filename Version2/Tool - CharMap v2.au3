#include <Array.au3>

#include "settings/Constants.au3"
#include "settings/Globals.au3"
;#include "settings/Settings.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"
#include "lib/Util/info.au3"
#include "lib/CR/OCR.au3"

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



; this is important and should be included in the final version.
while WinGetState($BS_WIN) = 0
	if MsgBox($MB_OKCANCEL, "", "BlueStacks is not open! Please open Bluestacks then click ok") = $IDCANCEL Then Exit
	$BS_WIN = WinGetHandle($BS_TITLE)
WEnd

#Region - test Gui
Local $gw = 815
Local $gh = 438
Local $p = WinGetPos($BS_WIN)


WinActivate ($BS_WIN)

Global $hGUI = GUICreate("Tool - CharMap v2",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))
GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

;Menu - Main
Global $idMenu_Main = GUICtrlCreateMenu("Main")
Global $idMenu_ClearBoxes = GUICtrlCreateMenuItem("Clear Boxes", $idMenu_Main)
GUICtrlSetOnEvent($idMenu_ClearBoxes, "menu_ClearBoxes")
Global $idMenu_Save = GUICtrlCreateMenuItem("Save", $idMenu_Main)
GUICtrlSetOnEvent($idMenu_Save, "menu_Save")
;Menu - Char Map
Global $idMenu_CharMap = GUICtrlCreateMenu("Char Map")
Global $idMenu_NewMap = GUICtrlCreateMenuItem("New Map", $idMenu_CharMap)
GUICtrlSetOnEvent($idMenu_NewMap, "menu_NewMap")
Global $idMenu_MapWidth = GUICtrlCreateMenuItem("Set Width", $idMenu_CharMap)
GUICtrlSetOnEvent($idMenu_MapWidth, "menu_MapWidth")
Global $idMenu_MapHeight = GUICtrlCreateMenuItem("Set Height", $idMenu_CharMap)
GUICtrlSetOnEvent($idMenu_MapHeight, "menu_MapHeight")
Global $idMenu_MapShow = GUICtrlCreateMenuItem("Show Map Array", $idMenu_CharMap)
GUICtrlSetOnEvent($idMenu_MapShow, "menu_MapShow")
Global $idMenu_MapShowAll = GUICtrlCreateMenuItem("Show All Maps", $idMenu_CharMap)
GUICtrlSetOnEvent($idMenu_MapShowAll, "menu_MapShowAll")
;Menu - Tools
Global $idMenu_Tools = GUICtrlCreateMenu("Tools")
Global $idMenu_GetColor = GUICtrlCreateMenuItem("Get Color", $idMenu_Tools)
GUICtrlSetOnEvent($idMenu_GetColor, "menu_GetColor")
Global $idMenu_MarkTextBox= GUICtrlCreateMenuItem("Mark Text Box", $idMenu_Tools)
GUICtrlSetOnEvent($idMenu_MarkTextBox, "menu_MarkTextBox")
Global $idMenu_ColorDiff = GUICtrlCreateMenuItem("Color Difference", $idMenu_Tools)
GUICtrlSetOnEvent($idMenu_ColorDiff, "menu_ColorDiff")

;Gui Body

Global $comb_Map = GUICtrlCreateCombo("Select Character Map", 18, 8, 289, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($comb_Map,$g_CharMapsAll,"Select Character Map" )
GUICtrlSetOnEvent($comb_Map,"comb_ChangMap")

GUICtrlCreateLabel("Color: 0x", 10, 38, 45, 17)
Global $inp_Color = GUICtrlCreateInput("",  10, 56, 97, 21)
GUICtrlCreateLabel("Color Radius:", 132, 38, 67, 17)
Global $inp_ColorRadius = GUICtrlCreateInput("", 130, 56, 65, 21)
Global $inp_MaxWidth = GUICtrlCreateInput("", 224, 56, 81, 21)
GUICtrlCreateLabel("Max Width:", 224, 38, 58, 17)
GUICtrlCreateLabel("Text Box:", 54, 97, 49, 17)
Global $inp_TextBox = GUICtrlCreateInput("", 106, 92, 201, 21)
Global $btn_show = GUICtrlCreateButton("Show", 232, 120, 75, 25)
GUICtrlSetOnEvent($btn_show, "btnGo_Show")

Global $inp_CharMapString = GUICtrlCreateInput("", 2, 150, 305, 21)
Global $btn_AddMap = GUICtrlCreateButton("Add", 272, 176, 35, 25)
GUICtrlSetOnEvent($btn_AddMap, "btnGo_AddMap")

GUICtrlCreateLabel("Text Result:", 328, 8, 61, 17)
GUICtrlCreateLabel("Recent Settings", 328, 64, 80, 17)
Global $inp_TextResult = GUICtrlCreateInput("", 328, 32, 273, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
Global $edit_settings = GUICtrlCreateEdit("", 328, 88, 273, 113, BitOR($ES_READONLY,$WS_VSCROLL))
Global $edit_debug = GUICtrlCreateEdit("", 8, 208, 801, 201, BitOR($ES_READONLY,$WS_VSCROLL))
GUICtrlSetFont($edit_debug, 9, 400, 0, "Courier New")



GUISetState(@SW_SHOW)
#EndRegion - test gui


Global $g_aCharMapNames = StringSplit($g_CharMapsAll,"|",2)
Global $map_array[0][4]
Global $map_idx = 0
Global $map_default = [[".",1,1]]

For $i = 0 to UBound($g_aCharMapNames)-1
	ReDim $map_array[$i+1 ][4]
	$map_array [$i][0] = $g_aCharMapNames[$i]
	$map_array [$i][1] = Execute($g_aCharMapNames[$i]&"MaxWidth")
	$map_array [$i][2] = Execute($g_aCharMapNames[$i]&"MaxHeight")
	$map_array [$i][3] = Execute($g_aCharMapNames[$i])
Next

DebugSetOutput($edit_debug)
OcrEnableDebug()
InitScraper()



While 1
	Sleep(10)
WEnd

Func Die()
	ExitScraper()
	GUIDelete($hGUI)
	Exit
EndFunc


Func menu_ClearBoxes()
	GUICtrlSetData($edit_debug,"")
	GUICtrlSetData($inp_TextResult,"")
	GUICtrlSetData($edit_settings,"")
EndFunc

Func menu_Save()
EndFunc

Func menu_NewMap()
	$map_idx = UBound($map_array)
	ReDim $map_array[$map_idx+1 ][4]
	Local $str = InputBox("New Char Map", "Enter the name of the charmap")
	$map_array[$map_idx][0]= $str
	$map_array[$map_idx][1]= 10
	$map_array[$map_idx][2]= 0
	$map_array[$map_idx][3]= $map_default
	$g_CharMapsAll &= "|"&$str
	$g_aCharMapNames = StringSplit($g_CharMapsAll,"|",2)
	GUICtrlSetData($comb_Map,"|Select Character Map|"&$g_CharMapsAll,$str )
EndFunc

Func menu_MapWidth()
	Local $w = InputBox("Set Char Width", "Enter the Max Width")
	if StringIsInt($w) Then
		$map_array[$map_idx][1] = $w
	Else
		MsgBox(-1,"Warning","Width must be an integer")
	EndIf
EndFunc

Func menu_MapHeight()
	Local $h = InputBox("Set Char Height", "Enter the Max Height")
	if StringIsInt($h) Then
		$map_array[$map_idx][2] = $h
	Else
		MsgBox(-1,"Warning","Height must be an integer")
	EndIf
EndFunc

Func menu_MapShow()
	_ArrayDisplay($map_array[$map_idx][3])
EndFunc
Func menu_MapShowAll()
	_ArrayDisplay($map_array)
EndFunc


Func menu_GetColor()
	Local $pix = GetPixelPosAndColor($BS_WIN,2,True)
	GUICtrlSetData($inp_Color,"0x"&hex($pix[2],6))
EndFunc

Func menu_MarkTextBox()
	Local $rect = MarkRectangle($BS_WIN,2)
	GUICtrlSetData($inp_TextBox,_ArrayToString($rect))
EndFunc

Func menu_ColorDiff()
	Local $pix1 = GetPixelPosAndColor($BS_WIN,1,True)
	Local $pix2 = GetPixelPosAndColor($BS_WIN,1,True)
	Local $diff = GetColorDiff($pix1[2],$pix2[2])
	Local $tempS = "[0x"&hex($pix1[2],6)&", 0x"&hex($pix2[2],6)&", "&Int($diff)&"]"&@CRLF
	GUICtrlSetData($edit_settings,$temps,1)
EndFunc

Func comb_ChangMap()
	$map_idx = _ArraySearch($g_aCharMapNames,GUICtrlRead($comb_Map))
	GUICtrlSetData($inp_MaxWidth,$map_array[$map_idx][1])
EndFunc

Func btnGo_AddMap()
	Local $tempMap = StringSplit(GUICtrlRead($inp_CharMapString),"|",2)
	GUICtrlSetData($inp_CharMapString,"")
	for $i = 1 to UBound($tempMap)-1
		$tempMap[$i] = Number($tempMap[$i])
	Next
	Local $cmap = $map_array[$map_idx][3]
	_ArrayCombine($cmap,$tempMap)
	$map_array[$map_idx][3] = $cmap

EndFunc

Func btnGo_Show()
	menu_ClearBoxes()
	Local $color = GUICtrlRead($inp_Color)
	Local $radius = GUICtrlRead($inp_ColorRadius)
	Local $rect = StringSplit(GUICtrlRead($inp_TextBox),"|",2)
	Local $width = GUICtrlRead($inp_MaxWidth)
	Local $cmap = $map_array[$map_idx][3]
	Local $tb = [$rect[0],$rect[1],$rect[2],$rect[3],$color,$radius,0,0,0,0]	;80
	Local $temps = "["&$tb[0]&","&$tb[1]&","&$tb[2]&","&$tb[3]&",0x"&hex($tb[4],6)&","&$tb[5]&","&$tb[6]&","&$tb[7]& _
		","&$tb[8]&","&$tb[9]&"]"&@CRLF
	GUICtrlSetData($edit_settings,$temps,1)
	Local $T1 = TimerInit()
	GUICtrlSetData($inp_TextResult,OcrGetText($cmap,$tb,$width,$eScrapeDropSpaces))
	ConsoleWrite("T1: " & TimerDiff($T1)/1000 & @CRLF)

EndFunc


Func _ArrayCombine(ByRef $array1, ByRef $array2)    ; Adds a row to a 2d array.
    Local $r1 = UBound($array1,1)
	Local $c1 = UBound($array1,2)
    Local $c2 = Ubound($array2)
	Local $cmax = $c1 >= $c2 ? $c1 : $c2

    ReDim $array1[$r1+1][$cmax]

    For $i=0 To $c2 -1
		$array1[$r1][$i] = $array2[$i]
    Next
EndFunc


;M|7|126|120|12|7|24|120|127
;a|4|21|1|21|15


