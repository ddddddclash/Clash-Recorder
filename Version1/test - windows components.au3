;Gui drumrun
#include <GUIConstants.au3>
#include <Array.au3>
HotKeySet("{ESC}", "_end")

Global $title = 'Unbenannt - Editor' ; German!

$PID = Run(@WindowsDir & "\notepad.exe", "", @SW_SHOW)
WinWait($title, '', 2)
$handle = WinGetHandle($title)
WinMove($handle, '', 100, 200, 400, 200)

Global $start = WinGetPos($handle)
$gui = GUICreate("GUI", $start[2] + 50, $start[3] + 50, $start[0] - 25, $start[1] - 55, Default)
$exit_B = GUICtrlCreateButton('Exit', 5, 1, 100, 20)
GUISetBkColor(0x00FF00)

WinSetTitle($handle, '', 'Megas Notepad :-)')

_GUICreateInvRect($gui, 20, 50, $start[2] + 10, $start[3] + 10)
GUISetState(@SW_SHOW)       ; will display an empty dialog box

; UnComment this line and see the difference!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;DllCall("user32.dll", "int", "SetParent", "hwnd", WinGetHandle($handle), "hwnd", WinGetHandle($gui))

;Variables

Global $saveGuipos = WinGetPos('GUI')

; Run the GUI until the dialog is closed
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            WinClose($handle)
            ExitLoop
        Case $exit_B
            WinClose($handle)
            ExitLoop
    EndSwitch
    ;_checkWin()
WEnd

Func _checkWin()
    $newGUIpos = WinGetPos('GUI')
    $p1 = _ArrayToString($saveGuipos, ',')
    $p2 = _ArrayToString($newGUIpos, ',')
    If $p1 <> $p2 Then
        ConsoleWrite(1 & @CRLF)
        WinMove($handle, '', $newGUIpos[0] + 25, $newGUIpos[1] + 55)
        $saveGuipos = $newGUIpos
    EndIf
EndFunc   ;==>_checkWin


Func _GUICreateInvRect($hwnd, $l, $t, $w, $h)
    $pos = WinGetPos($hwnd)
    $1 = 0
    $2 = 0
    $3 = $pos[2]
    $4 = $t
    $ret = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", $1, "long", $2, "long", $3, "long", $4)
    $1 = 0
    $2 = 0
    $3 = $l
    $4 = $pos[3]
    $ret2 = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", $1, "long", $2, "long", $3, "long", $4)
    $1 = $l + $w
    $2 = 0
    $3 = $pos[2]
    $4 = $pos[3]
    $ret3 = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", $1, "long", $2, "long", $3, "long", $4)
    $1 = 0
    $2 = $t + $h
    $3 = $pos[2]
    $4 = $pos[3]
    $ret4 = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", $1, "long", $2, "long", $3, "long", $4)

    DllCall("gdi32.dll", "long", "CombineRgn", "long", $ret[0], "long", $ret[0], "long", $ret2[0], "int", 2)
    DllCall("gdi32.dll", "long", "CombineRgn", "long", $ret[0], "long", $ret[0], "long", $ret3[0], "int", 2)
    DllCall("gdi32.dll", "long", "CombineRgn", "long", $ret[0], "long", $ret[0], "long", $ret4[0], "int", 2)

    DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $hwnd, "long", $ret[0], "int", 1)
EndFunc   ;==>_GUICreateInvRect

Func _end()
    Exit (0)
EndFunc   ;==>_end