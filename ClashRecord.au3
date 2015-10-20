;------------------------------------------------------------------------------------------
;	This is my work in progress for the clash recording tool.
;
;	Date:	10/9/2015
;	Author:	dddddd.clash
;   Current:	ClashRecord.au3
;	Original:	ClashRecord.old.au3
;	Version:	1
;	changes:
;   	- Clean up of currently functioning parts.
;		- Move Personal functions and UDFs to lib
;		- Move Gui to Lib
;------------------------------------------------------------------------------------------

Opt("MustDeclareVars",1)
Opt("GUIOnEventMode",1)
Opt ("MouseClickDelay", 10)
Opt ("MouseClickDownDelay", 10)
Opt ("MouseCoordMode", 0)

; AutoIt Includes
;#include <Date.au3>


; CR Includes
#include "lib/CR_Global_Const.au3"
#include "lib/CR_Global.au3"
#include "lib/CR_functions.au3"
#include "lib/CR_Events.au3"
#include "lib/CR_GUI.au3"


HotKeySet ("{esc}", "Die")

main()

Func main()

	WinActivate ($BS_WIN)
	updateBSWinPosition()

	initGUI()

	mainApplicationLoop()

EndFunc ;==>main

Func mainApplicationLoop()
	While 1
		Sleep(10)
	WEnd
EndFunc ;==> MainApplicationLoop

