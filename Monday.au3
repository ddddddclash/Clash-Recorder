
for $i = 1 to 100 step 1
	$str = ""
	Select
		Case Mod($i,3) = 0
			$str &= "Fiz"
			ContinueCase
		Case Mod($i,5) = 0   ; Stupid language doesn't process case statement with continue.
			if Mod($i,5) = 0 Then $str &= "Buz"  ;need this to have it function the way I expect.
		case Else
			$str = $i
	EndSelect
	ConsoleWrite($str & @CRLF)
Next

	ConsoleWrite("Version 2" & @CRLF)
	;alternative
	;Could just as easily be written with if elseif else
for $i = 1 to 100 step 1
	Select
		Case Mod($i,3) = 0
			ConsoleWrite("Fiz")
		Case Mod($i,5) = 0
			ConsoleWrite("Buz")
		Case (Mod($i,5) = 0) And (Mod($i,3) = 0)
			ConsoleWrite("FizBuz")
		case Else
			ConsoleWrite($i)
	EndSelect
	if $i < 100 Then ConsoleWrite(", ")
Next
ConsoleWrite(@CRLF)