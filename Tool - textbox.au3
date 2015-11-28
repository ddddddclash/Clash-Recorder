; Old replaced by Tool - find regions.au3

#include <Array.au3>

#include "settings/Constants.au3"
#include "settings/Globals.au3"
#include "settings/Settings.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"

;Includes for Gui
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
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

Global $hGUI = GUICreate("Text Box? Tool",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))

GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

Global $inp_ss_name = GUICtrlCreateInput("",16,8,185,21)
Global $btn_Screen_Shot = GUICtrlCreateButton("Screen Shot", 208, 6, 75, 25)
Global $comb_varlist = GUICtrlCreateCombo("Select Variable", 16, 42, 225, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($comb_varlist, "$rGoldTextBox|$rElixTextBox|$rDarkTextBox|$rCupsTextBox1|$rCupsTextBox2|$rMyGoldTextBox|"& _
		"$rMyElixTextBox|$rMyDarkTextBox|$rMyGemsTextBox|$rMyCupsTextBox|$rBarracksWindowTextBox|$rBarracksTroopCountTextBox|"& _
		"$rEndBattleGoldTextBox|$rEndBattleElixTextBox|$rEndBattleDarkTextBox|$rEndBattleCups1TextBox|$rEndBattleCups2TextBox|"& _
		"$rEndBattleBonusGoldTextBox|$rEndBattleBonusElixTextBox|$rEndBattleBonusDarkTextBox|$rChatTextBox","Select Variable" )
GUICtrlSetOnEvent($btn_Screen_Shot, "btnGo_ScreenShot")
Global $btn_go = GUICtrlCreateButton("go", 248, 40, 35, 25)
GUICtrlSetOnEvent($btn_go, "btnGo_Go")

Global $Edit1 = GUICtrlCreateEdit("", 34, 96, 233, 161, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY))

GUISetState(@SW_SHOW)
#EndRegion - test gui




HotKeySet("^f", "DebugToFront")
HotKeySet("^n", "NewCanvas") ; New debug canvas
InitScraper()
DebugCreateCanvas()

While 1
	Sleep(10)
WEnd

Func NewCanvas()
	DebugDestroyCanvas()
	DebugCreateCanvas()
EndFunc


Func btnGo_ScreenShot()
	Local $fname = GUICtrlRead($inp_ss_name)
	Local $isValid = StringRegExp($fname, "^[A-Za-z0-9_ -\.]+$", 0)
	If (@error <> 0) or (Not $isValid) Then
		MsgBox(64, "Error", "Invalid File name")
		Return
	EndIf
	GrabFrameToFile(@ScriptDir&"/conversion/"&$fname)
	GUICtrlSetData($inp_ss_name,"")
EndFunc

Func btnGo_Go()
	NewCanvas()
	Local $varname = GUICtrlRead($comb_varlist)
	if $varname = "Select Variable" Then Return
	GUICtrlSetData($Edit1,$varname&@CRLF,1)
	Local $A = Execute($varname)
	; Text boxes - left, top, right, bottom, Text Color - center, radius,
	; Present indicator x, y, color, radius
	Local $tempS = "left = "&$A[0]&" top = "&$A[1]&" right = "&$A[2]&" bottom = "&$A[3]&@CRLF& _
		"Text Color = 0x"&Hex($A[4])&" Radius = "&$A[5]&@CRLF& _
		"x = "&$A[6]&" y = "&$A[7]&" color = 0x"&hex($A[8])&" r2 = "&$A[9]&@CRLF
	GUICtrlSetData($Edit1,$tempS&@CRLF,1)
	GUICtrlSetData($inp_ss_name,StringMid($varname,3)&".bmp")
	GUICtrlSetData($Edit1,"Small = "&ScrapeFuzzyText($gSmallCharMaps,$A,$gSmallCharMapsMaxWidth,$eScrapeDropSpaces)&@CRLF,1)
	;GUICtrlSetData($Edit1,"Small = "&ScrapeFuzzyText($gSmallCharacterMaps,$A,$gSmallCharMapsMaxWidth,$eScrapeDropSpaces)&@CRLF,1)
	DebugDrawTextArea($A,$varname)

EndFunc

Func Die()
	ExitScraper()
	DebugDestroyCanvas()
	GUIDelete($hGUI)
	Exit
EndFunc