;----------------------------------------------------------------------------------
; Author : dddddd.clash
; Date: 2015/11/13
; Notes: Gui tool to resize Bluestacks.  Currently doesn't work.
; Use the .bat file in the BlueStacks dir instead
; 11/13/2015 18:18:00 Process - HD-Agent.exe: Exists attempting to close.
; Error killing BlueStacks process: HD-UpdaterService.exe Return Value: 0 Error Code: 2
;
;----------------------------------------------------------------------------------


#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region - Debug
Global Const $gc_LOG_DIR = "resizelog"
Global Const $gc_DEBUG = True
Global Const $gc_LOG = True
#include "lib/Debug/Debug.au3"
#EndRegion

Global $gBlueStacksWidth = 860, $gBlueStacksHeight = 720
Global $gTitle = "BlueStacks App Player"
#include "lib/CodeSlinger69/BlueStacks.au3"


Global $g_SizeInstall[2] = [966,628]	; Size at install
Global $g_SizeSmall[2] = [860,720]		; Size for my Screen Reader and BrokenBot
Global $g_SizeLarge[2] = [1024,600]		; Size for CodeSlinger69
;Global $g_bs_width, $g_bs_height
Global $hGui


Opt("GUIOnEventMode", 1)

HotKeySet ("{esc}", "Die")

#Region - GUI
$hGui = GUICreate("BS - Resize", 277, 255, 450, 238)
GUISetOnEvent($GUI_EVENT_CLOSE, "Die")

$btnInstall = GUICtrlCreateButton("Install Size", 72, 8, 140, 25)
GUICtrlSetOnEvent(-1, "BtnClickInstall")
$btnSmall = GUICtrlCreateButton("Clash Recorder Size", 72, 72, 140, 25)
GUICtrlSetOnEvent(-1, "BtnClickSmall")
$btnLarge = GUICtrlCreateButton("CodeSlinger69 Size", 72, 40, 140, 25)
GUICtrlSetOnEvent(-1, "BtnClickLarge")


GUICtrlCreateLabel("Width:", 48, 136, 35, 17)
$input_width = GUICtrlCreateInput("", 93, 134, 30, 21)
GUICtrlCreateLabel("Height:", 139, 136, 38, 17)
$input_height = GUICtrlCreateInput("", 184, 134, 30, 21)

$Group1 = GUICtrlCreateGroup("Custom", 32, 112, 217, 129)
$btnApply = GUICtrlCreateButton("Apply", 96, 176, 75, 25)
GUICtrlSetOnEvent(-1, "BtnApplyClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion - GUI

While 1
	Sleep(100)
WEnd

#Region - Event Functions
Func BtnClickInstall()
	GUICtrlSetData($input_width,$g_SizeInstall[0])
	GUICtrlSetData($input_height,$g_SizeInstall[1])
EndFunc

Func BtnClickSmall()
	GUICtrlSetData($input_width,$g_SizeSmall[0])
	GUICtrlSetData($input_height,$g_SizeSmall[1])
EndFunc

Func BtnClickLarge()
	GUICtrlSetData($input_width,$g_SizeLarge[0])
	GUICtrlSetData($input_height,$g_SizeLarge[1])
EndFunc

Func BtnApplyClick()
	$gBlueStacksWidth = GUICtrlRead($input_width)
	$gBlueStacksHeight = GUICtrlRead($input_height)
	StartBlueStacks()
	ConsoleWrite("Apply")
EndFunc


#EndRegion - Event Functions


Func Die()
	Exit
EndFunc
