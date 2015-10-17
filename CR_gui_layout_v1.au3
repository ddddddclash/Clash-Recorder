#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <ToolbarConstants.au3>
#include <WindowsConstants.au3>

HotKeySet ("{esc}", "menu_exit")


Opt("GUIOnEventMode",1) ; 0 - disabled; 1 -enable OnEvent function notifications

$Form1_1 = GUICreate("Form1", 877, 593, 388, 195)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1)

GUISetOnEvent($GUI_EVENT_CLOSE, "menu_exit")

#Region MENU
Local $idMenu_File = GUICtrlCreateMenu("File")
$idMenu_Save = GUICtrlCreateMenuItem('Save', $idMenu_File)
GUICtrlSetOnEvent($idMenu_Save, "menu_save")
$idMenu_Save = GUICtrlCreateMenuItem('Exit', $idMenu_File)
GUICtrlSetOnEvent($idMenu_Save, "menu_exit")
#EndRegion MENU



$Tabs = GUICtrlCreateTab(10, 32, 857, 505)

#Region Tab1 - Clan
$TabSheet1 = GUICtrlCreateTabItem("Clan")
$Btn_clan_shapshot = GUICtrlCreateButton("Take Snapshot", 750, 68, 91, 25)
;GUICtrlSetOnEvent($Btn_clan_shapshot, "take_clan_snapshot")

$Pic28 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\clan.jpg", 15, 104, 835, 197)
GUICtrlSetState(-1, $GUI_DISABLE)
$clan_name = 			GUICtrlCreateInput("", 256, 109, 121, 19)
; ------------------------
$total_points = 		GUICtrlCreateInput("", 568, 133, 100, 18)
$wars_won = 			GUICtrlCreateInput("", 568, 152, 100, 18)
$num_members = 			GUICtrlCreateInput("", 568, 172, 100, 18)
$type = 				GUICtrlCreateInput("", 568, 191, 100, 18)
$required_trophies = 	GUICtrlCreateInput("", 568, 209, 100, 18)
$war_frequency = 		GUICtrlCreateInput("", 568, 231, 100, 18)
$clan_location = 		GUICtrlCreateInput("", 568, 252, 100, 18)
$clan_tag = 			GUICtrlCreateInput("", 568, 271, 100, 18)

$badge_level = GUICtrlCreateInput("", 112, 120, 25, 21)
$clan_experience = GUICtrlCreateInput("", 56, 208, 41, 21)
$Label17 = GUICtrlCreateLabel("/", 104, 210, 9, 17)
$clan_experience_goal = GUICtrlCreateInput("", 120, 208, 49, 21)
#EndRegion Tab1 - Clan





GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)

While 1
	sleep(10)
WEnd


Func menu_save()
	MsgBox(0,"","Hi")
EndFunc
Func menu_exit()
	GUIDelete()
	Exit
EndFunc

#Region - Clan Tab Functions

#EndRegion - Clan Tab Functions