#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <DateTimeConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <GUIListView.au3>
#include <GuiStatusBar.au3>
#include <GuiToolbar.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <ToolbarConstants.au3>
#include <WindowsConstants.au3>




HotKeySet ("{esc}", "Die")
Func Die()
   GUIDelete()
   Exit
EndFunc

Opt("GUIOnEventMode",1) ; 0 - disabled; 1 -enable OnEvent function notifications

#Region ### START Koda GUI section ### Form=c:\_programming\autoit\clash recorder\gui v 0.kxf

$Form1_1 = GUICreate("Clan Recorder", 690, 614, 279, 277)

GUISetOnEvent($GUI_EVENT_CLOSE, "menu_exit")

#Region MENU
Local $idMenu_File = GUICtrlCreateMenu("File")
$idMenu_Save = GUICtrlCreateMenuItem('Save', $idMenu_File)
GUICtrlSetOnEvent($idMenu_Save, "menu_save")
$idMenu_Save = GUICtrlCreateMenuItem('Exit', $idMenu_File)
GUICtrlSetOnEvent($idMenu_Save, "menu_exit")
#EndRegion MENU

$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1)

$Tabs = GUICtrlCreateTab(0, 32, 689, 561)

#Region Tab 1
$TabSheet1 = GUICtrlCreateTabItem("Clan")

$Label1 = GUICtrlCreateLabel("Clan Name", 30, 104, 56, 17)
$clan_name = GUICtrlCreateInput("clan_name", 128, 101, 121, 21)
$Label2 = GUICtrlCreateLabel("Clan ID Tag", 30, 133, 61, 17)
$clan_tag = GUICtrlCreateInput("clan_tag", 128, 128, 121, 21)
$Button1 = GUICtrlCreateButton("Take Snapshot", 496, 72, 91, 25)
$Label15 = GUICtrlCreateLabel("Badge Level", 30, 163, 64, 17)
$badge_level = GUICtrlCreateInput("badge_level", 128, 160, 121, 21)
$Label16 = GUICtrlCreateLabel("Clan Experience", 30, 192, 81, 17)
$Label17 = GUICtrlCreateLabel("/", 184, 194, 9, 17)
$clan_experience = GUICtrlCreateInput("clan_experience", 128, 192, 41, 21)
$clan_experience_goal = GUICtrlCreateInput("clan_experience_goal", 200, 192, 49, 21)
$Label18 = GUICtrlCreateLabel("Total Points:", 30, 248, 63, 17)
$Label19 = GUICtrlCreateLabel("Wars Won:", 30, 273, 58, 17)
$Label20 = GUICtrlCreateLabel("Members:", 30, 298, 50, 17)
$Label21 = GUICtrlCreateLabel("Type:", 30, 323, 31, 17)
$Label22 = GUICtrlCreateLabel("Required trophies:", 30, 349, 90, 17)
$Label23 = GUICtrlCreateLabel("War Frequency:", 30, 374, 80, 17)
$Label24 = GUICtrlCreateLabel("Clan Location:", 30, 399, 72, 17)
$total_points = GUICtrlCreateInput("total_points", 144, 248, 121, 21)
$wars_won = GUICtrlCreateInput("wars_won", 144, 273, 121, 21)
$num_members = GUICtrlCreateInput("num_members", 144, 298, 121, 21)
$type = GUICtrlCreateInput("type", 144, 323, 121, 21)
$required_trophies = GUICtrlCreateInput("required_trophies", 144, 349, 121, 21)
$war_frequency = GUICtrlCreateInput("war_frequency", 144, 374, 121, 21)
$clan_location = GUICtrlCreateInput("clan_location", 144, 399, 121, 21)
#EndRegion
#Region
$TabSheet2 = GUICtrlCreateTabItem("Profile")
$Button2 = GUICtrlCreateButton("Take Snapshot", 296, 248, 91, 25)
$Label3 = GUICtrlCreateLabel("Player Name", 24, 80, 64, 17)
$Pic1 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\barb_king.jpg", 56, 256, 43, 42)
$Pic2 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\arch_queen.jpg", 104, 256, 43, 42)
$Pic3 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\barbarian.jpg", 56, 328, 43, 40)
$Pic4 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\archer.jpg", 104, 328, 43, 40)
$Pic5 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\giant.jpg", 152, 328, 44, 40)
$Pic6 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\goblin.jpg", 200, 328, 43, 40)
$Pic7 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\wallbreaker.jpg", 248, 328, 43, 40)
$Pic8 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\balloon.jpg", 296, 328, 43, 40)
$Pic9 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\wizard.jpg", 344, 328, 44, 40)
$Pic10 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\healer.jpg", 392, 328, 42, 40)
$Pic11 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\dragon.jpg", 440, 328, 43, 40)
$Pic12 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\pekka.jpg", 488, 328, 44, 40)
$Pic13 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\minon.jpg", 56, 408, 43, 40)
$Pic14 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\hogridder.jpg", 104, 408, 44, 40)
$Pic15 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\golem.jpg", 200, 408, 43, 40)
$Pic16 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\valk.jpg", 152, 408, 43, 40)
$Pic17 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\witch.jpg", 248, 408, 43, 40)
$Pic18 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\lavahound.jpg", 296, 408, 44, 40)
$Pic19 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\lightning.jpg", 56, 488, 43, 42)
$Pic20 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\heal.jpg", 104, 488, 43, 42)
$Pic21 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\rage.jpg", 152, 488, 43, 42)
$Pic22 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\jump.jpg", 200, 488, 44, 42)
$Pic23 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\freeze.jpg", 248, 488, 42, 42)
$Pic24 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\poison.jpg", 381, 488, 43, 42)
$Pic25 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\earthquake.jpg", 424, 488, 44, 42)
$Pic26 = GUICtrlCreatePic("C:\_Programming\Autoit\Clash Recorder\images\haste.jpg", 468, 488, 43, 42)
$nbarb_king = GUICtrlCreateInput("", 56, 304, 41, 21)
$narch_queen = GUICtrlCreateInput("", 104, 304, 41, 21)
$nbarbarian = GUICtrlCreateInput("", 56, 376, 41, 21)
$narcher = GUICtrlCreateInput("", 104, 376, 41, 21)
$ngiant = GUICtrlCreateInput("", 152, 376, 41, 21)
$ngoblin = GUICtrlCreateInput("", 200, 376, 41, 21)
$nwallbreaker = GUICtrlCreateInput("", 248, 376, 41, 21)
$nballoon = GUICtrlCreateInput("", 296, 376, 41, 21)
$nwizard = GUICtrlCreateInput("", 344, 376, 41, 21)
$nhealer = GUICtrlCreateInput("", 392, 376, 41, 21)
$ndragon = GUICtrlCreateInput("", 440, 376, 41, 21)
$npekka = GUICtrlCreateInput("", 488, 376, 41, 21)
$nminion = GUICtrlCreateInput("", 56, 456, 41, 21)
$nhog = GUICtrlCreateInput("", 104, 456, 41, 21)
$nvalk = GUICtrlCreateInput("", 152, 456, 41, 21)
$ngolem = GUICtrlCreateInput("", 200, 456, 41, 21)
$nwitch = GUICtrlCreateInput("", 248, 456, 41, 21)
$nlavahound = GUICtrlCreateInput("", 296, 456, 41, 21)
$nlightning = GUICtrlCreateInput("", 56, 536, 41, 21)
$nheal = GUICtrlCreateInput("", 104, 536, 41, 21)
$Input1 = GUICtrlCreateInput("", 152, 536, 41, 21)
$njump = GUICtrlCreateInput("", 200, 536, 41, 21)
$nfreeze = GUICtrlCreateInput("", 248, 536, 41, 21)
$npoison = GUICtrlCreateInput("", 376, 536, 41, 21)
$nearthquake = GUICtrlCreateInput("", 424, 536, 41, 21)
$nhaste = GUICtrlCreateInput("", 472, 536, 41, 21)
$player_name = GUICtrlCreateInput("player_name", 96, 78, 121, 21)
$Label4 = GUICtrlCreateLabel("Player Tag", 32, 112, 55, 17)
$player_tag = GUICtrlCreateInput("player_tag", 96, 110, 121, 21)
$Label5 = GUICtrlCreateLabel("Clan Position", 24, 144, 65, 17)
$clan_position = GUICtrlCreateCombo("clan_position", 96, 144, 121, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Member|Elder|Co-Leader|Leader")
$Label6 = GUICtrlCreateLabel("Experience", 32, 176, 57, 17)
$player_xp = GUICtrlCreateInput("player_xp", 96, 176, 121, 21)
$trophees = GUICtrlCreateInput("trophees", 320, 80, 121, 21)
$Label7 = GUICtrlCreateLabel("Trophees:", 256, 80, 52, 17)
$Label8 = GUICtrlCreateLabel("War Stars Won", 232, 144, 77, 17)
$war_stars_won = GUICtrlCreateInput("war_stars_won", 320, 136, 121, 21)
$Label9 = GUICtrlCreateLabel("All time best:", 248, 112, 63, 17)
$all_time_best = GUICtrlCreateInput("all_time_best", 320, 112, 121, 21)
$Label10 = GUICtrlCreateLabel("Town Hall", 256, 176, 52, 17)
$town_hall = GUICtrlCreateCombo("town_hall", 320, 176, 49, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "4|5|6|7|8|9|10")
$Label11 = GUICtrlCreateLabel("Troops Donated", 472, 88, 81, 17)
$Label12 = GUICtrlCreateLabel("Troops Recieved", 467, 117, 86, 17)
$Label13 = GUICtrlCreateLabel("Attacks Won:", 484, 147, 69, 17)
$Label14 = GUICtrlCreateLabel("Defenses Won:", 475, 176, 78, 17)
$troops_donated = GUICtrlCreateInput("troops_donated", 560, 80, 121, 21)
$troops_recieved = GUICtrlCreateInput("troops_recieved", 560, 112, 121, 21)
$attacks_won = GUICtrlCreateInput("attacks_won", 560, 144, 121, 21)
$defenses_won = GUICtrlCreateInput("defenses_won", 560, 176, 121, 21)
$TabSheet3 = GUICtrlCreateTabItem("Members")
$ListView1 = GUICtrlCreateListView("Rank|Name|Position|War|Experience|Donated|Recieved|Trophees", 104, 120, 465, 409)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 40)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 70)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 40)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 70)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 6, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 7, 60)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 4, 1)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 5, 1)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 6, 1)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 7, 1)
$TabSheet4 = GUICtrlCreateTabItem("War")
$Label25 = GUICtrlCreateLabel("War Date", 56, 96, 50, 17)
$war_date = GUICtrlCreateDate("2015/10/07 20:44:55", 120, 96, 186, 21)
$Label26 = GUICtrlCreateLabel("War Participants", 24, 120, 82, 17)
$war_participants = GUICtrlCreateInput("war_participants", 120, 120, 89, 21)
$Label27 = GUICtrlCreateLabel("Home Level", 48, 168, 61, 17)
$Label28 = GUICtrlCreateLabel("Visitor Level", 48, 192, 61, 17)
$home_level = GUICtrlCreateInput("home_level", 120, 168, 65, 21)
$visitor_level = GUICtrlCreateInput("visitor_level", 120, 192, 65, 21)
$Label29 = GUICtrlCreateLabel("Home Stars", 232, 168, 59, 17)
$Label30 = GUICtrlCreateLabel("Visitor Stars", 232, 192, 59, 17)
$home_stars = GUICtrlCreateInput("home_stars", 304, 168, 57, 21)
$visitor_stars = GUICtrlCreateInput("visitor_stars", 304, 192, 57, 21)
$Label31 = GUICtrlCreateLabel("Defeat enamy War Bases", 48, 232, 125, 17)
$Label32 = GUICtrlCreateLabel("Score 40% Stars", 48, 256, 82, 17)
$Label33 = GUICtrlCreateLabel("Score 60% Stars", 48, 280, 82, 17)
$Label34 = GUICtrlCreateLabel("War Win", 48, 304, 46, 17)
$Label35 = GUICtrlCreateLabel("Total", 48, 328, 28, 17)
$Label36 = GUICtrlCreateLabel("/", 324, 234, 9, 17)
$Label37 = GUICtrlCreateLabel("/", 328, 322, 9, 17)
$xp_base = GUICtrlCreateInput("xp_base", 288, 232, 33, 21)
$xp_base_possible = GUICtrlCreateInput("xp_base_possible", 336, 232, 33, 21)
$xp_40p = GUICtrlCreateCheckbox("+ 10", 288, 256, 97, 17)
$xp_60p = GUICtrlCreateCheckbox("+ 25", 288, 280, 97, 17)
$xp_warwin = GUICtrlCreateCheckbox("+ 50", 288, 304, 97, 17)
$xp_gain = GUICtrlCreateInput("xp_gain", 288, 320, 33, 21)
$xp_possible = GUICtrlCreateInput("xp_possible", 344, 320, 33, 21)
$TabSheet5 = GUICtrlCreateTabItem("My Team")
$List1 = GUICtrlCreateList("", 56, 136, 233, 357)
$List2 = GUICtrlCreateList("", 391, 136, 233, 357)
$Label38 = GUICtrlCreateLabel("Clan Members", 112, 112, 71, 17)
$Label39 = GUICtrlCreateLabel("Team Players", 464, 112, 68, 17)
$TabSheet6 = GUICtrlCreateTabItem("Enemy Team")
$Label40 = GUICtrlCreateLabel("Copy from My Team", 128, 120, 98, 17)
$TabSheet7 = GUICtrlCreateTabItem("War Events")
GUICtrlSetState(-1,$GUI_SHOW)
$ListView2 = GUICtrlCreateListView("Attacker|Defender|Destruction|Stars|New Stars|XP|Time Till War Ends", 72, 112, 553, 449)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 60)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 70)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 70)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 6, 120)
$TabSheet8 = GUICtrlCreateTabItem("Enemy Clan")
$Label41 = GUICtrlCreateLabel("Copy from Clan", 224, 192, 75, 17)
$TabSheet9 = GUICtrlCreateTabItem("Enemy Profile")
$Label42 = GUICtrlCreateLabel("Copy from Profile", 192, 168, 83, 17)
$TabSheet10 = GUICtrlCreateTabItem("Enemy Members")
$Label43 = GUICtrlCreateLabel("Copy from Members", 192, 160, 97, 17)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Label3
	EndSwitch
WEnd

Func menu_save()
	MsgBox(0,"","Hi")
EndFunc
Func menu_exit()
	Exit
EndFunc
