
;Menu Globals
Global $idMenu_File, $idMenu_Save, $idMenu_Exit
Global $idMenu_Testing, $idMenu_Draw_Rectangle, $idMenu_Mouse_Home
Global $idMenu_Go, $idMenu_Clan, $idMenu_WarStats
;Clan Tab Items
Global $Tabs, $TabSheet_Clan
Global $btn_clan_snapshot, $btn_clan_save, $pic_clan, $inp_clan_clan_name, $inp_clan_total_points , $inp_clan_wars_won, $inp_clan_num_members
Global $inp_clan_type, $inp_clan_required_trophies, $inp_clan_war_frequency, $inp_clan_clan_location, $inp_clan_clan_tag, $inp_clan_badge_level
Global $inp_clan_clan_xp, $inp_clan_clan_xp_goal, $Label17
;Profile Tab Items
Global $TabSheet_Profile
Global $btn_profile_goProfile, $btn_profile_snapshot, $btn_profile_save, $btn_profile_reset

Func initGUI()
	Local $p = WinGetPos($BS_WIN)
	$GUI = GUICreate("Clash Recorder",$GUI_WIDTH, $GUI_HEIGHT, $p[0] + $p[2] + 8, $p[1] + ($p[3]/2) - ($GUI_HEIGHT / 2))
	GUISetOnEvent($GUI_EVENT_CLOSE, "eventMenuExit")

	drawMenu()

	$Tabs = GUICtrlCreateTab(10, 32, 857, 505)

	DrawClanTab()
	DrawProfileTab()

	GUICtrlCreateTabItem("")
	GUISetState(@SW_SHOW)

EndFunc  ;==>InitGUI

Func destroyGUI()
	GUIDelete()
EndFunc ;==>destroyGUI

Func drawMenu()

	$idMenu_File = GUICtrlCreateMenu("File")
	$idMenu_Save = GUICtrlCreateMenuItem('Save', $idMenu_File)
	GUICtrlSetOnEvent($idMenu_Save, "eventMenuSave")
	$idMenu_Exit = GUICtrlCreateMenuItem('Exit', $idMenu_File)
	GUICtrlSetOnEvent($idMenu_Exit, "eventMenuExit")
	$idMenu_Testing = GUICtrlCreateMenu("Testing")
	$idMenu_Draw_Rectangle = GUICtrlCreateMenuItem('Draw Rectangle', $idMenu_Testing)
	GUICtrlSetOnEvent($idMenu_Draw_Rectangle, "eventMenuDrawRectangle")
	$idMenu_Mouse_Home = GUICtrlCreateMenuItem('Mouse Home', $idMenu_Testing)
	GUICtrlSetOnEvent($idMenu_Mouse_Home, "eventMenuMouseHome")
	$idMenu_Go = GUICtrlCreateMenu("Go")
	$idMenu_Clan = GUICtrlCreateMenuItem('Clan', $idMenu_Go)
	GUICtrlSetOnEvent($idMenu_Clan, "goClan")
	$idMenu_WarStats = GUICtrlCreateMenuItem('War Stats', $idMenu_Go)
	GUICtrlSetOnEvent($idMenu_WarStats, "goWarStats")


EndFunc ;==>drawMenu


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	Clan Tab Functions
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Func drawClanTab()

	$TabSheet_Clan = GUICtrlCreateTabItem("Clan")

	$pic_clan = GUICtrlCreatePic($IMG_PATH_CLAN, 15, 104, 835, 198)  ;error when trying to show .png files.
	;look at sample -ShowPNG in GUICtrlCreatePic
	GUICtrlSetState(-1, $GUI_DISABLE) ;disables the image

	$btn_clan_save = GUICtrlCreateButton("Save to Database", 640, 68, 101, 25)
	GUICtrlSetOnEvent($btn_clan_save, "eventBtnClanSave")
	$btn_clan_snapshot = GUICtrlCreateButton("Take Snapshot", 750, 68, 91, 25)
	GUICtrlSetOnEvent($btn_clan_snapshot, "eventBtnClanSnapshot")

	$inp_clan_clan_name = 			GUICtrlCreateInput("", 256, 109, 121, 19)
	; ------------------------
	$inp_clan_total_points = 		GUICtrlCreateInput("", 568, 133, 100, 18)
	$inp_clan_wars_won = 			GUICtrlCreateInput("", 568, 152, 100, 18)
	$inp_clan_num_members = 		GUICtrlCreateInput("", 568, 172, 100, 18)
	$inp_clan_type = 				GUICtrlCreateInput("", 568, 191, 100, 18)
	$inp_clan_required_trophies = 	GUICtrlCreateInput("", 568, 209, 100, 18)
	$inp_clan_war_frequency = 		GUICtrlCreateInput("", 568, 231, 100, 18)
	$inp_clan_clan_location = 		GUICtrlCreateInput("", 568, 252, 100, 18)
	$inp_clan_clan_tag = 			GUICtrlCreateInput("", 568, 271, 100, 18)

	$inp_clan_badge_level = 		GUICtrlCreateInput("", 112, 120, 25, 21)
	$inp_clan_clan_xp = 			GUICtrlCreateInput("", 56, 208, 41, 21)
	$Label17 = GUICtrlCreateLabel("/", 104, 210, 9, 17)
	$inp_clan_clan_xp_goal = 		GUICtrlCreateInput("", 120, 208, 49, 21)

EndFunc  ;==>drawClanTab

Func updateClanImage()
	GUICtrlSetImage($pic_clan,$IMG_PATH_CLAN)
EndFunc ;==>updateClanImage


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	Profile Tab Functions
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Func DrawProfileTab()

	$TabSheet_Profile = GUICtrlCreateTabItem("Profile")
	$btn_profile_reset = GUICtrlCreateButton("Reset", 440, 68, 91, 25)
	GUICtrlSetOnEvent($btn_profile_reset, "eventBtnProfileReset")
	$btn_profile_goProfile = GUICtrlCreateButton("Next Profile", 540, 68, 91, 25)
	GUICtrlSetOnEvent($btn_profile_goProfile, "eventBtnProfileGo")
	$btn_profile_snapshot = GUICtrlCreateButton("Take Snapshot", 640, 68, 91, 25)
	GUICtrlSetOnEvent($btn_profile_snapshot, "eventBtnProfileSnapshot")
	$btn_profile_save = GUICtrlCreateButton("Save to Database", 740, 68, 101, 25)
	GUICtrlSetOnEvent($btn_profile_save, "eventBtnProfileSave")

EndFunc ;==>DrawProfileTab

