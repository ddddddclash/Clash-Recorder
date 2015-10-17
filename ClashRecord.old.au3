;This is my work in progress for the clash recording tool.
; functions.au3 - written by me and used in this project
; Tesseract.au3 - Written by someone else and doesn't work right.
;
; test - winhttp.au3 - sends an image to php - Fills in an existing html form.
; test - winhttp.au3 - sends an image to php - Creates the post without a form.
; WinHTTP/WinHttp.au3 - written by someone else - required for the above two examples to work.
;
; There is an interface in progress being created with Koda it will require a table that can't be designed there since it will be created with loop.
; table.au3 - written by someone else and creates a table of labels - I need to creat a new one that creates a table of input boxes.








;#include <GUIConstantsEx.au3>
;#include <GuiRichEdit.au3>
;#include <WindowsConstants.au3>
;#Include <ScreenCapture.au3>
;#Include <Misc.au3>
Global $n = 0
#include "Functions.au3"
#include "Tesseract.au3"

Opt ("MouseClickDelay", 10)
Opt ("MouseClickDownDelay", 10)
Opt ("MouseCoordMode", 0)

HotKeySet ("{esc}", "Die")

$Title = "BlueStacks App Player"
$Full = WinGetTitle ($Title)
$HWnD = WinGetHandle ($Full)
WinActivate ($HWnD)




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
				Go($HWnD)
			case $btn_select
				;GUISetState(@SW_HIDE, $hGui)
				$aLTRB = Mark_Rect($HWnD)
				Make_Image($HWnD, $aLTRB)
				;MsgBox($MB_SYSTEMMODAL, "Coords", "Left: " & $aLRTB[0] & @CRLF & "Top: " & $aLRTB[1] & @CRLF & "Right: " & $aLRTB[2] & @CRLF & "Bottom: " & $aLRTB[3])

			case $btn_read
				$check = _TesseractWinCapture($HWnD,"",0,"",1,2,$aLTRB[0],$aLTRB[1],$aLTRB[2],$aLTRB[3],1)
				_GUICtrlRichEdit_AppendText($txtLog, "*" & $check & @CRLF)
            Case $GUI_EVENT_CLOSE
                ;ExitLoop
				Die()

        EndSwitch
		Sleep(10)
    WEnd

