#include "lib/CR_Global_Const.au3"
#include "lib/CR_Global.au3"
#include "lib/Debug/drawing.au3"

HotKeySet("{ESC}", "_Exit")
HotKeySet("h", "Hide")
HotKeySet("d", "DebugCreateCanvas")
HotKeySet("r", "rectangle")
HotKeySet("p", "point")
HotKeySet("c", "clientRectangle")
HotKeySet("w", "winRectangle")


DebugCreateCanvas()
rectangle()



While 1
    Sleep(10)
Wend


Func _Exit()
	DebugDestroyCanvas()
	Exit
EndFunc

Func rectangle()
	DebugDrawRectangle(@DesktopWidth/2-50, @DesktopHeight/2-50, @DesktopWidth/2+50, @DesktopHeight/2+50)
EndFunc

Func point()
	DebugDrawPoint(@DesktopWidth/2,@DesktopHeight/2, 0x000)
EndFunc

Func Hide()
	DebugDestroyCanvas()
EndFunc

Func clientRectangle()
	Local $p = WinGetClientPos()
	ConsoleWrite("Con: "&$p[0]&", "&$p[1]&", "&$p[2]&", "&$p[3]&", "&$p[4]&", "&$p[5]&@CRLF)
	DebugDrawRectangle($p[0],$p[1],$p[0]+$p[2],$p[1]+$p[3],1,0xccc)
EndFunc

Func winRectangle()
	WinActivate ($BS_WIN)
	Local $p = WinGetPos($BS_WIN)
	ConsoleWrite("win: "&$p[0]&", "&$p[1]&", "&$p[2]&", "&$p[3]&@CRLF)
	DebugDrawRectangle($p[0],$p[1],$p[0]+$p[2],$p[1]+$p[3],1,0x000)
EndFunc



;---------------------------------------------------
Func WinGetClientPos($hwind = $BS_WIN)
	WinActivate ($BS_WIN)
	local $w = WinGetPos($hwind)
	Local $c = WinGetClientSize($hwind)
	Local $padding = ($w[2] - $c[0]) /2
	Local $header = $w[3] - $c[1] - $padding

	Local $cPos[6]
	$cPos[0] = $w[0] + $padding
	$cPos[1] = $w[1] + $header
	$cPos[2] = $c[0]
	$cPos[3] = $c[1]
	$cPos[4] = $padding
	$cPos[5] = $header

	Return $cPos ; [x,y,width,height]
EndFunc
