#cs
Global $aPos, $iColor

Opt("MouseCoordMode", 1) ; Default, screen relative
Opt("PixelCoordMode", 1) ; Default, screen relative

HotKeySet("{ESC}", "_Quit")

While 1
    $aPos = MouseGetPos()
    $iColor = PixelGetColor($aPos[0], $aPos[1])
    ToolTip("Pos: x = " & $aPos[0] & ", y = " & $aPos[1] & @CRLF & _
            "Color = 0x" & Hex($iColor, 6))
    Sleep(500)
WEnd

Func _Quit()
    Exit
EndFunc
#ce

#include <Misc.au3>

While 1
    If _IsPressed("01") Then
        $pos = MouseGetPos()
        MsgBox(0, "Mouse x,y:", $pos[0] & "," & $pos[1])
    EndIf
WEnd