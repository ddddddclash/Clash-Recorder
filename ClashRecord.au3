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

;Opt("MustDeclareVars",1)
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
#include "lib/CR_GUI.au3"

HotKeySet ("{esc}", "Die")



Global $Full = WinGetTitle ($BS_title)
Global $HWnD = WinGetHandle ($Full)
WinActivate ($HWnD)

;MsgBox (0, "", "$Full = " & $Full & @CRLF & "$HWnD = " & $HWnD & @CRLF )




Local $hGui = GUICreate("Clash Recorder", 320, 360)
Local $btn_select = GUICtrlCreateButton("Select Text", 5, 5, 80, 29)
Local $btn_read = GUICtrlCreateButton("Read Text", 90, 5, 80, 29)
Local $btn_go = GUICtrlCreateButton("GO", 175, 5,80,29)
Local $txtLog = _GUICtrlRichEdit_Create($hGui, "", 10, 40, 300, 310, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912), $WS_EX_STATICEDGE)


;_GUICtrlRichEdit_SetFont($txtLog, 6, "Lucida Console")
;_GUICtrlRichEdit_AppendText($txtLog, " This is some text" & @CRLF)



GUISetState(@SW_SHOW )


; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
			Case $btn_go
				Go_clan($HWnD)
			case $btn_select
				;GUISetState(@SW_HIDE, $hGui)
				Local $aLTRB = Mark_Rect($HWnD)
				;Make_Image($HWnD, $aLTRB)
				Draw_Rectangle($HWnD,$aLTRB[0],$aLTRB[1],$aLTRB[2],$aLTRB[3])
				;MsgBox($MB_SYSTEMMODAL, "Coords", "Left: " & $aLTRB[0] & @CRLF & "Top: " & $aLTRB[1] & @CRLF & "Right: " & $aLTRB[2] & @CRLF & "Bottom: " & $aLTRB[3])

			case $btn_read
				;Local $check = _TesseractWinCapture($HWnD,"",0,"",1,2,$aLTRB[0],$aLTRB[1],$aLTRB[2],$aLTRB[3],1)
				;_GUICtrlRichEdit_AppendText($txtLog, "*" & $check & @CRLF)
            Case $GUI_EVENT_CLOSE
                ;ExitLoop
				Die()

        EndSwitch
		;Sleep(10)
    WEnd

