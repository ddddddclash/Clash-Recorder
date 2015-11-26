#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

#include "settings/Constants.au3"
#include "lib/Debug/Debug.au3"
#include "lib/Debug/Drawing.au3"


Opt("MustDeclareVars",1)
Opt("GUIOnEventMode",1)

HotKeySet ("{esc}", "Die")


;Globals that need to be converted for CodeSlinger68
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
Local $gw = 297
Local $gh = 331
Local $p = WinGetPos($BS_WIN)


WinActivate ($BS_WIN)

Global $hGUI = GUICreate("Tool - find regions",$gw, $gh, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($gh / 2))

GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

Global $inp_ss_name = GUICtrlCreateInput("",16,8,185,21)
Global $btn_Screen_Shot = GUICtrlCreateButton("Screen Shot", 208, 6, 75, 25)
GUICtrlSetOnEvent($btn_Screen_Shot, "btnGo_ScreenShot")

;Text Box - combo box and button group
Global $comb_text = GUICtrlCreateCombo("Select Text Box", 16, 42, 225, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($comb_text,$g_sTextBoxRegions,"Select Text Box" )
Global $btn_go_text = GUICtrlCreateButton("go", 248, 40, 35, 25)
GUICtrlSetOnEvent($btn_go_text, "btnGo_Text")

;Buttons - combo box and button group
Global $comb_button = GUICtrlCreateCombo("Select Button", 16, 78, 225, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($comb_button,$g_sButtonRegions,"Select Button" )
Global $btn_go_button = GUICtrlCreateButton("go", 248, 76, 35, 25)
GUICtrlSetOnEvent($btn_go_button, "btnGo_Button")

;Pixel - combo box and button group
Global $comb_pixel = GUICtrlCreateCombo("Select Pixel", 16, 110, 225, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($comb_pixel,$g_sPixelRegions,"Select Pixel" )
Global $btn_go_pixel = GUICtrlCreateButton("go", 248, 108, 35, 25)
GUICtrlSetOnEvent($btn_go_pixel, "btnGo_Pixel")



Global $Edit1 = GUICtrlCreateEdit("", 18, 152, 265, 161, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY))

GUISetState(@SW_SHOW)
#EndRegion - test gui




HotKeySet("^f", "DebugToFront")
HotKeySet("^n", "NewCanvas") ; New debug canvas

InitScraper()
DebugDrawingEnable()
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

Func btnGo_Text()
	NewCanvas()
	Local $varname = GUICtrlRead($comb_text)
	if $varname = "Select Text Box" Then Return
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
	DebugDrawTextArea($A,$varname)

EndFunc

Func btnGo_Button()
	NewCanvas()
	Local $varname = GUICtrlRead($comb_button)
	if $varname = "Select Button" Then Return
	GUICtrlSetData($Edit1,$varname&@CRLF,1)
	Local $A = Execute($varname)
	; Buttons-  Left, Top, Right, Bottom,
	; 	Button Present Pixel Loc - x, y,
	; 	Button Present Color - center, radius
	Local $tempS = "left = "&$A[0]&" top = "&$A[1]&" right = "&$A[2]&" bottom = "&$A[3]&@CRLF& _
		"x = "&$A[4]&" y = "&$A[5]&" color = 0x"&hex($A[6])&" radius = "&$A[7]&@CRLF
	GUICtrlSetData($Edit1,$tempS&@CRLF,1)
	GUICtrlSetData($inp_ss_name,StringMid($varname,3)&".bmp")
	DebugDrawButton($A,$varname)

EndFunc
Func btnGo_Pixel()
	NewCanvas()
	Local $varname = GUICtrlRead($comb_pixel)
	if $varname = "Select Pixel" Then Return
	GUICtrlSetData($Edit1,$varname&@CRLF,1)
	Local $A = Execute($varname)
	; Pixel - x, y, color, radius
	Local $tempS = "x = "&$A[0]&" y = "&$A[1]&" color = "&$A[2]&" radius = "&$A[3]&@CRLF
	GUICtrlSetData($Edit1,$tempS&@CRLF,1)
	GUICtrlSetData($inp_ss_name,StringMid($varname,3)&".bmp")
	DebugDrawPixel($A,$varname)

EndFunc

Func Die()
	ExitScraper()
	DebugDestroyCanvas()
	GUIDelete($hGUI)
	Exit
EndFunc



