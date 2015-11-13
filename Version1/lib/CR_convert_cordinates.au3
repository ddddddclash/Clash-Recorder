
;============================================================
; Function convertCordinates
; My function that converts screen dimenstions.
; returns an array of 3 cordinates. [x,y]
;	Requires
;		GLOBAL Const $__WINDOW = 0
;		GLOBAL Const $__SCREEN = 1
;		GLOBAL Const $__CLIENT = 2
;
;============================================================

GLOBAL Const $__WINDOW = 0
GLOBAL Const $__SCREEN = 1
GLOBAL Const $__CLIENT = 2

Func ConvertCordinates($x, $y, $from, $to, $hwind = $BS_WIN)
	Local $winPos = WinGetPos($hwind) ; [x,y,width,height]
	Local $cliPos = WinGetClientPos($hwind) ; [x,y,width,height]
	Local $offset = [($cliPos[0] - $winPos[0]),($cliPos[1] - $winPos[1])]
	Local $cord[2] = [$x,$y]

	if $from = $__CLIENT Then
		If $to = $__WINDOW Then
			$cord[0] = $x + $offset[0]
			$cord[1] = $y + $offset[1]
		ElseIf $to = $__SCREEN Then
			$cord[0] = $x + $cliPos[0]
			$cord[1] = $y + $cliPos[1]
		EndIf
	ElseIf $from = $__WINDOW Then
		If $to = $__CLIENT Then
			$cord[0] = $x - $offset[0]
			$cord[1] = $y - $offset[1]
		ElseIf $to = $__SCREEN Then
			$cord[0] = $x + $winPos[0]
			$cord[1] = $y + $winPos[1]
		EndIf
	ElseIf $from = $__SCREEN Then
		If $to = $__WINDOW Then
			$cord[0] = $x - $winPos[0]
			$cord[1] = $y - $winPos[1]
		ElseIf $to = $__CLIENT Then
			$cord[0] = $x + $cliPos[0]
			$cord[1] = $y + $cliPos[1]
		EndIf
	EndIf

	Return $cord

EndFunc



