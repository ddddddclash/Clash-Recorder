#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GuiToolbar.au3>
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
#Region ### START Koda GUI section ### Form=gui v 0.kxf
$Form1_1 = GUICreate("Form1", 692, 632, 388, 195)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1_1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1_1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1_1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1_1Restore")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1)
;$ToolBar1 = _GUICtrlToolbar_Create($Form1_1, 0)

#Region MENU
Local $idMenu1 = GUICtrlCreateMenu("Menu &One")
Local $idMenu2 = GUICtrlCreateMenu("Menu &Two")
GUICtrlCreateMenu("Menu Th&ree")
GUICtrlCreateMenu("Menu &Four")
GUICtrlCreateMenuItem('SubMenu One &A', $idMenu1)
GUICtrlCreateMenuItem('SubMenu One &B', $idMenu1)
#EndRegion MENU

$Tabs = GUICtrlCreateTab(0, 32, 689, 617)
GUICtrlSetOnEvent($Tabs, "TabsChange")
$TabSheet1 = GUICtrlCreateTabItem("Clan")
$clan_name = GUICtrlCreateInput("clan_name", 128, 101, 121, 21)
GUICtrlSetOnEvent($clan_name, "clan_nameChange")
$Label1 = GUICtrlCreateLabel("Clan Name", 30, 104, 56, 17)
GUICtrlSetOnEvent($Label1, "Label1Click")
$Label2 = GUICtrlCreateLabel("Clan ID Tag", 30, 133, 61, 17)
GUICtrlSetOnEvent($Label2, "Label2Click")
$clan_tag = GUICtrlCreateInput("clan_tag", 128, 128, 121, 21)
GUICtrlSetOnEvent($clan_tag, "clan_tagChange")
$Button1 = GUICtrlCreateButton("Take Snapshot", 496, 72, 91, 25)
GUICtrlSetOnEvent($Button1, "Button1Click")
$Label15 = GUICtrlCreateLabel("Badge Level", 30, 163, 64, 17)
GUICtrlSetOnEvent($Label15, "Label15Click")
$badge_level = GUICtrlCreateInput("badge_level", 128, 160, 121, 21)
GUICtrlSetOnEvent($badge_level, "badge_levelChange")
$Label16 = GUICtrlCreateLabel("Clan Experience", 30, 192, 81, 17)
GUICtrlSetOnEvent($Label16, "Label16Click")
$Label17 = GUICtrlCreateLabel("/", 184, 194, 9, 17)
GUICtrlSetOnEvent($Label17, "Label17Click")
$clan_experience = GUICtrlCreateInput("clan_experience", 128, 192, 41, 21)
GUICtrlSetOnEvent($clan_experience, "clan_experienceChange")
$clan_experience_goal = GUICtrlCreateInput("clan_experience_goal", 200, 192, 49, 21)
GUICtrlSetOnEvent($clan_experience_goal, "clan_experience_goalChange")
$Label18 = GUICtrlCreateLabel("Total Points:", 30, 248, 63, 17)
GUICtrlSetOnEvent($Label18, "Label18Click")
$Label19 = GUICtrlCreateLabel("Wars Won:", 30, 273, 58, 17)
GUICtrlSetOnEvent($Label19, "Label19Click")
$Label20 = GUICtrlCreateLabel("Members:", 30, 298, 50, 17)
GUICtrlSetOnEvent($Label20, "Label20Click")
$Label21 = GUICtrlCreateLabel("Type:", 30, 323, 31, 17)
GUICtrlSetOnEvent($Label21, "Label21Click")
$Label22 = GUICtrlCreateLabel("Required trophies:", 30, 349, 90, 17)
GUICtrlSetOnEvent($Label22, "Label22Click")
$Label23 = GUICtrlCreateLabel("War Frequency:", 30, 374, 80, 17)
GUICtrlSetOnEvent($Label23, "Label23Click")
$Label24 = GUICtrlCreateLabel("Clan Location:", 30, 399, 72, 17)
GUICtrlSetOnEvent($Label24, "Label24Click")
$total_points = GUICtrlCreateInput("total_points", 144, 248, 121, 21)
GUICtrlSetOnEvent($total_points, "total_pointsChange")
$wars_won = GUICtrlCreateInput("wars_won", 144, 273, 121, 21)
GUICtrlSetOnEvent($wars_won, "wars_wonChange")
$num_members = GUICtrlCreateInput("num_members", 144, 298, 121, 21)
GUICtrlSetOnEvent($num_members, "num_membersChange")
$type = GUICtrlCreateInput("type", 144, 323, 121, 21)
GUICtrlSetOnEvent($type, "typeChange")
$required_trophies = GUICtrlCreateInput("required_trophies", 144, 349, 121, 21)
GUICtrlSetOnEvent($required_trophies, "required_trophiesChange")
$war_frequency = GUICtrlCreateInput("war_frequency", 144, 374, 121, 21)
GUICtrlSetOnEvent($war_frequency, "war_frequencyChange")
$clan_location = GUICtrlCreateInput("clan_location", 144, 399, 121, 21)
GUICtrlSetOnEvent($clan_location, "clan_locationChange")
$TabSheet2 = GUICtrlCreateTabItem("Profile")
$Button2 = GUICtrlCreateButton("Take Snapshot", 296, 248, 91, 25)
GUICtrlSetOnEvent($Button2, "Button2Click")
$Label3 = GUICtrlCreateLabel("Player Name", 24, 80, 64, 17)
GUICtrlSetOnEvent($Label3, "Label3Click")
$Pic1 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\barb_king.jpg", 56, 256, 43, 42)
GUICtrlSetOnEvent($Pic1, "Pic1Click")
$Pic2 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\arch_queen.jpg", 104, 256, 43, 42)
GUICtrlSetOnEvent($Pic2, "Pic2Click")
$Pic3 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\barbarian.jpg", 56, 328, 43, 40)
GUICtrlSetOnEvent($Pic3, "Pic3Click")
$Pic4 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\archer.jpg", 104, 328, 43, 40)
GUICtrlSetOnEvent($Pic4, "Pic4Click")
$Pic5 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\giant.jpg", 152, 328, 44, 40)
GUICtrlSetOnEvent($Pic5, "Pic5Click")
$Pic6 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\goblin.jpg", 200, 328, 43, 40)
GUICtrlSetOnEvent($Pic6, "Pic6Click")
$Pic7 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\wallbreaker.jpg", 248, 328, 43, 40)
GUICtrlSetOnEvent($Pic7, "Pic7Click")
$Pic8 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\balloon.jpg", 296, 328, 43, 40)
GUICtrlSetOnEvent($Pic8, "Pic8Click")
$Pic9 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\wizard.jpg", 344, 328, 44, 40)
GUICtrlSetOnEvent($Pic9, "Pic9Click")
$Pic10 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\healer.jpg", 392, 328, 42, 40)
GUICtrlSetOnEvent($Pic10, "Pic10Click")
$Pic11 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\dragon.jpg", 440, 328, 43, 40)
GUICtrlSetOnEvent($Pic11, "Pic11Click")
$Pic12 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\pekka.jpg", 488, 328, 44, 40)
GUICtrlSetOnEvent($Pic12, "Pic12Click")
$Pic13 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\minon.jpg", 56, 408, 43, 40)
GUICtrlSetOnEvent($Pic13, "Pic13Click")
$Pic14 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\hogridder.jpg", 104, 408, 44, 40)
GUICtrlSetOnEvent($Pic14, "Pic14Click")
$Pic15 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\golem.jpg", 200, 408, 43, 40)
GUICtrlSetOnEvent($Pic15, "Pic15Click")
$Pic16 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\valk.jpg", 152, 408, 43, 40)
GUICtrlSetOnEvent($Pic16, "Pic16Click")
$Pic17 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\witch.jpg", 248, 408, 43, 40)
GUICtrlSetOnEvent($Pic17, "Pic17Click")
$Pic18 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\lavahound.jpg", 296, 408, 44, 40)
GUICtrlSetOnEvent($Pic18, "Pic18Click")
$Pic19 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\lightning.jpg", 56, 488, 43, 42)
GUICtrlSetOnEvent($Pic19, "Pic19Click")
$Pic20 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\heal.jpg", 104, 488, 43, 42)
GUICtrlSetOnEvent($Pic20, "Pic20Click")
$Pic21 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\rage.jpg", 152, 488, 43, 42)
GUICtrlSetOnEvent($Pic21, "Pic21Click")
$Pic22 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\jump.jpg", 200, 488, 44, 42)
GUICtrlSetOnEvent($Pic22, "Pic22Click")
$Pic23 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\freeze.jpg", 248, 488, 42, 42)
GUICtrlSetOnEvent($Pic23, "Pic23Click")
$Pic24 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\poison.jpg", 381, 488, 43, 42)
GUICtrlSetOnEvent($Pic24, "Pic24Click")
$Pic25 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\earthquake.jpg", 424, 488, 44, 42)
GUICtrlSetOnEvent($Pic25, "Pic25Click")
$Pic26 = GUICtrlCreatePic("C:\_Programming\Local - autoit\Clash Recorder\images\haste.jpg", 468, 488, 43, 42)
GUICtrlSetOnEvent($Pic26, "Pic26Click")
$nbarb_king = GUICtrlCreateInput("nbarb_king", 56, 304, 41, 21)
GUICtrlSetOnEvent($nbarb_king, "nbarb_kingChange")
$narch_queen = GUICtrlCreateInput("narch_queen", 104, 304, 41, 21)
GUICtrlSetOnEvent($narch_queen, "narch_queenChange")
$nbarbarian = GUICtrlCreateInput("nbarbarian", 56, 376, 41, 21)
GUICtrlSetOnEvent($nbarbarian, "nbarbarianChange")
$narcher = GUICtrlCreateInput("narcher", 104, 376, 41, 21)
GUICtrlSetOnEvent($narcher, "narcherChange")
$ngiant = GUICtrlCreateInput("ngiant", 152, 376, 41, 21)
GUICtrlSetOnEvent($ngiant, "ngiantChange")
$ngoblin = GUICtrlCreateInput("ngoblin", 200, 376, 41, 21)
GUICtrlSetOnEvent($ngoblin, "ngoblinChange")
$nwallbreaker = GUICtrlCreateInput("nwallbreaker", 248, 376, 41, 21)
GUICtrlSetOnEvent($nwallbreaker, "nwallbreakerChange")
$nballoon = GUICtrlCreateInput("nballoon", 296, 376, 41, 21)
GUICtrlSetOnEvent($nballoon, "nballoonChange")
$nwizard = GUICtrlCreateInput("nwizard", 344, 376, 41, 21)
GUICtrlSetOnEvent($nwizard, "nwizardChange")
$nhealer = GUICtrlCreateInput("nhealer", 392, 376, 41, 21)
GUICtrlSetOnEvent($nhealer, "nhealerChange")
$ndragon = GUICtrlCreateInput("ndragon", 440, 376, 41, 21)
GUICtrlSetOnEvent($ndragon, "ndragonChange")
$npekka = GUICtrlCreateInput("npekka", 488, 376, 41, 21)
GUICtrlSetOnEvent($npekka, "npekkaChange")
$nminion = GUICtrlCreateInput("nminion", 56, 456, 41, 21)
GUICtrlSetOnEvent($nminion, "nminionChange")
$nhog = GUICtrlCreateInput("nhog", 104, 456, 41, 21)
GUICtrlSetOnEvent($nhog, "nhogChange")
$nvalk = GUICtrlCreateInput("nvalk", 152, 456, 41, 21)
GUICtrlSetOnEvent($nvalk, "nvalkChange")
$ngolem = GUICtrlCreateInput("ngolem", 200, 456, 41, 21)
GUICtrlSetOnEvent($ngolem, "ngolemChange")
$nwitch = GUICtrlCreateInput("nwitch", 248, 456, 41, 21)
GUICtrlSetOnEvent($nwitch, "nwitchChange")
$nlavahound = GUICtrlCreateInput("nlavahound", 296, 456, 41, 21)
GUICtrlSetOnEvent($nlavahound, "nlavahoundChange")
$nlightning = GUICtrlCreateInput("nlightning", 56, 536, 41, 21)
GUICtrlSetOnEvent($nlightning, "nlightningChange")
$nheal = GUICtrlCreateInput("nheal", 104, 536, 41, 21)
GUICtrlSetOnEvent($nheal, "nhealChange")
$Input1 = GUICtrlCreateInput("nrage", 152, 536, 41, 21)
GUICtrlSetOnEvent($Input1, "Input1Change")
$njump = GUICtrlCreateInput("njump", 200, 536, 41, 21)
GUICtrlSetOnEvent($njump, "njumpChange")
$nfreeze = GUICtrlCreateInput("nfreeze", 248, 536, 41, 21)
GUICtrlSetOnEvent($nfreeze, "nfreezeChange")
$npoison = GUICtrlCreateInput("npoison", 376, 536, 41, 21)
GUICtrlSetOnEvent($npoison, "npoisonChange")
$nearthquake = GUICtrlCreateInput("nearthquake", 424, 536, 41, 21)
GUICtrlSetOnEvent($nearthquake, "nearthquakeChange")
$nhaste = GUICtrlCreateInput("nhaste", 472, 536, 41, 21)
GUICtrlSetOnEvent($nhaste, "nhasteChange")
$player_name = GUICtrlCreateInput("player_name", 96, 78, 121, 21)
GUICtrlSetOnEvent($player_name, "player_nameChange")
$Label4 = GUICtrlCreateLabel("Player Tag", 32, 112, 55, 17)
GUICtrlSetOnEvent($Label4, "Label4Click")
$player_tag = GUICtrlCreateInput("player_tag", 96, 110, 121, 21)
GUICtrlSetOnEvent($player_tag, "player_tagChange")
$Label5 = GUICtrlCreateLabel("Clan Position", 24, 144, 65, 17)
GUICtrlSetOnEvent($Label5, "Label5Click")
$clan_position = GUICtrlCreateCombo("clan_position", 96, 144, 121, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($clan_position, "Member|Elder|Co-Leader|Leader")
GUICtrlSetOnEvent($clan_position, "clan_positionChange")
$Label6 = GUICtrlCreateLabel("Experience", 32, 176, 57, 17)
GUICtrlSetOnEvent($Label6, "Label6Click")
$player_xp = GUICtrlCreateInput("player_xp", 96, 176, 121, 21)
GUICtrlSetOnEvent($player_xp, "player_xpChange")
$trophees = GUICtrlCreateInput("trophees", 320, 80, 121, 21)
GUICtrlSetOnEvent($trophees, "tropheesChange")
$Label7 = GUICtrlCreateLabel("Trophees:", 256, 80, 52, 17)
GUICtrlSetOnEvent($Label7, "Label7Click")
$Label8 = GUICtrlCreateLabel("War Stars Won", 232, 144, 77, 17)
GUICtrlSetOnEvent($Label8, "Label8Click")
$war_stars_won = GUICtrlCreateInput("war_stars_won", 320, 136, 121, 21)
GUICtrlSetOnEvent($war_stars_won, "war_stars_wonChange")
$Label9 = GUICtrlCreateLabel("All time best:", 248, 112, 63, 17)
GUICtrlSetOnEvent($Label9, "Label9Click")
$all_time_best = GUICtrlCreateInput("all_time_best", 320, 112, 121, 21)
GUICtrlSetOnEvent($all_time_best, "all_time_bestChange")
$Label10 = GUICtrlCreateLabel("Town Hall", 256, 176, 52, 17)
GUICtrlSetOnEvent($Label10, "Label10Click")
$town_hall = GUICtrlCreateCombo("town_hall", 320, 176, 49, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($town_hall, "4|5|6|7|8|9|10")
GUICtrlSetOnEvent($town_hall, "town_hallChange")
$Label11 = GUICtrlCreateLabel("Troops Donated", 472, 88, 81, 17)
GUICtrlSetOnEvent($Label11, "Label11Click")
$Label12 = GUICtrlCreateLabel("Troops Recieved", 467, 117, 86, 17)
GUICtrlSetOnEvent($Label12, "Label12Click")
$Label13 = GUICtrlCreateLabel("Attacks Won:", 484, 147, 69, 17)
GUICtrlSetOnEvent($Label13, "Label13Click")
$Label14 = GUICtrlCreateLabel("Defenses Won:", 475, 176, 78, 17)
GUICtrlSetOnEvent($Label14, "Label14Click")
$troops_donated = GUICtrlCreateInput("troops_donated", 560, 80, 121, 21)
GUICtrlSetOnEvent($troops_donated, "troops_donatedChange")
$troops_recieved = GUICtrlCreateInput("troops_recieved", 560, 112, 121, 21)
GUICtrlSetOnEvent($troops_recieved, "troops_recievedChange")
$attacks_won = GUICtrlCreateInput("attacks_won", 560, 144, 121, 21)
GUICtrlSetOnEvent($attacks_won, "attacks_wonChange")
$defenses_won = GUICtrlCreateInput("defenses_won", 560, 176, 121, 21)
GUICtrlSetOnEvent($defenses_won, "defenses_wonChange")
$TabSheet3 = GUICtrlCreateTabItem("Members")
$TabSheet4 = GUICtrlCreateTabItem("War Players")
GUICtrlSetState($TabSheet4,$GUI_SHOW)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	sleep(10)
WEnd

Func all_time_bestChange()

EndFunc
Func attacks_wonChange()

EndFunc
Func badge_levelChange()

EndFunc
Func Button1Click()

EndFunc
Func Button2Click()

EndFunc
Func clan_experience_goalChange()

EndFunc
Func clan_experienceChange()

EndFunc
Func clan_locationChange()

EndFunc
Func clan_nameChange()

EndFunc
Func clan_positionChange()

EndFunc
Func clan_tagChange()

EndFunc
Func defenses_wonChange()

EndFunc
Func Form1_1Close()
	Exit
EndFunc
Func Form1_1Maximize()

EndFunc
Func Form1_1Minimize()

EndFunc
Func Form1_1Restore()

EndFunc
Func Input1Change()

EndFunc
Func Label10Click()

EndFunc
Func Label11Click()

EndFunc
Func Label12Click()

EndFunc
Func Label13Click()

EndFunc
Func Label14Click()

EndFunc
Func Label15Click()

EndFunc
Func Label16Click()

EndFunc
Func Label17Click()

EndFunc
Func Label18Click()

EndFunc
Func Label19Click()

EndFunc
Func Label1Click()

EndFunc
Func Label20Click()

EndFunc
Func Label21Click()

EndFunc
Func Label22Click()

EndFunc
Func Label23Click()

EndFunc
Func Label24Click()

EndFunc
Func Label2Click()

EndFunc
Func Label3Click()

EndFunc
Func Label4Click()

EndFunc
Func Label5Click()

EndFunc
Func Label6Click()

EndFunc
Func Label7Click()

EndFunc
Func Label8Click()

EndFunc
Func Label9Click()

EndFunc
Func narch_queenChange()

EndFunc
Func narcherChange()

EndFunc
Func nballoonChange()

EndFunc
Func nbarb_kingChange()

EndFunc
Func nbarbarianChange()

EndFunc
Func ndragonChange()

EndFunc
Func nearthquakeChange()

EndFunc
Func nfreezeChange()

EndFunc
Func ngiantChange()

EndFunc
Func ngoblinChange()

EndFunc
Func ngolemChange()

EndFunc
Func nhasteChange()

EndFunc
Func nhealChange()

EndFunc
Func nhealerChange()

EndFunc
Func nhogChange()

EndFunc
Func njumpChange()

EndFunc
Func nlavahoundChange()

EndFunc
Func nlightningChange()

EndFunc
Func nminionChange()

EndFunc
Func npekkaChange()

EndFunc
Func npoisonChange()

EndFunc
Func num_membersChange()

EndFunc
Func nvalkChange()

EndFunc
Func nwallbreakerChange()

EndFunc
Func nwitchChange()

EndFunc
Func nwizardChange()

EndFunc
Func Pic10Click()

EndFunc
Func Pic11Click()

EndFunc
Func Pic12Click()

EndFunc
Func Pic13Click()

EndFunc
Func Pic14Click()

EndFunc
Func Pic15Click()

EndFunc
Func Pic16Click()

EndFunc
Func Pic17Click()

EndFunc
Func Pic18Click()

EndFunc
Func Pic19Click()

EndFunc
Func Pic1Click()

EndFunc
Func Pic20Click()

EndFunc
Func Pic21Click()

EndFunc
Func Pic22Click()

EndFunc
Func Pic23Click()

EndFunc
Func Pic24Click()

EndFunc
Func Pic25Click()

EndFunc
Func Pic26Click()

EndFunc
Func Pic2Click()

EndFunc
Func Pic3Click()

EndFunc
Func Pic4Click()

EndFunc
Func Pic5Click()

EndFunc
Func Pic6Click()

EndFunc
Func Pic7Click()

EndFunc
Func Pic8Click()

EndFunc
Func Pic9Click()

EndFunc
Func player_nameChange()

EndFunc
Func player_tagChange()

EndFunc
Func player_xpChange()

EndFunc
Func required_trophiesChange()

EndFunc
Func TabsChange()

EndFunc
Func total_pointsChange()

EndFunc
Func town_hallChange()

EndFunc
Func troops_donatedChange()

EndFunc
Func troops_recievedChange()

EndFunc
Func tropheesChange()

EndFunc
Func typeChange()

EndFunc
Func war_frequencyChange()

EndFunc
Func war_stars_wonChange()

EndFunc
Func wars_wonChange()

EndFunc
