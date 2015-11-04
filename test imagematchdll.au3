; Method = 0: CV_TM_SQDIFF, 1: CV_TM_SQDIFF_NORMED 2: CV_TM_CCORR 3: CV_TM_CCORR_NORMED 4: CV_TM_CCOEFF 5: CV_TM_CCOEFF_NORMED
;	DLL FindMatch ( char *haystack, char *needle, int match_method )


Local $haystack = @ScriptDir & "\screenshots\clan(19).jpg"
Local $needle = @ScriptDir & "\screenshots\number1.jpg"  ;without the border 90% accurate.  Why am i getting a border?
Local $matchMethod = 3

Local $res
Local $split

$res = DllCall("ImageMatch.dll", "str", "FindMatch", "str", $haystack, "str", $needle, "int", $matchMethod)
if ($res <> 0 ) Then
	$split = StringSplit($res[0], "|", 2)
	ConsoleWrite("BestX = "&$split[0]&", BestY= "&$split[1]& ", BestConfidence = "& $split[2] & @CRLF)
EndIf



#cs

Func ScanFrameForBestBMP(Const $filename, Const ByRef $bmpArray, Const $threshold, ByRef $bestMatch, ByRef $bestConfidence, ByRef $bestX, ByRef $bestY)
   $bestMatch = -1
   $bestConfidence = 0
   $bestX = -1
   $bestY = -1

   For $i = 0 to UBound($bmpArray)-1
	  Local $res = DllCall("ImageMatch.dll", "str", "FindMatch", "str", $filename, "str", "Images\"&$bmpArray[$i], "int", 3)

	  ;DebugWrite($bmpArray[$i] & ": " & $res[0])

	  Local $split = StringSplit($res[0], "|", 2)
	  If $split[2] > $threshold And $split[2] > $bestConfidence Then
		 $bestX = $split[0]
		 $bestY = $split[1]
		 $bestConfidence = $split[2]
		 $bestMatch = $i
	  EndIf
   Next
EndFunc


Func LocateBuildings(Const $frame, Const ByRef $buildingBMPs, Const $buildingConfidence, ByRef $matchX, ByRef $matchY)
   DebugWrite("LocateBuildings()")

   ; Find all the buildings of the specified type
   Local $matchCount = 0

   For $i = 0 To UBound($buildingBMPs)-1
	  ; Get matches for this resource
	  Local $res = DllCall("ImageMatch.dll", "str", "FindAllMatches", "str", $frame, _
			   "str", "Images\"&$buildingBMPs[$i], "int", 3, "int", 6, "double", $buildingConfidence)
	  Local $split = StringSplit($res[0], "|", 2)
	  ;DebugWrite("Num matches " & $buildingBMPs[$i] & ": " & $split[0])

	  For $j = 0 To $split[0]-1
		 ; Loop through all captured points so far, if this one is within 8 pix of an existing one,
		 ; then skip it.
		 Local $alreadyFound = False
		 For $k = 0 To $matchCount-1
			If DistBetweenTwoPoints($split[$j*3+1], $split[$j*3+2], $matchX[$k], $matchY[$k]) < 8 Then
			   $alreadyFound = True
			   ;DebugWrite("    Already found " & $j & ": " & $split[$j*3+1] & "," & $split[$j*3+2] & "  " & $split[$j*3+3])
			   ExitLoop
			EndIf
		 Next

		 ; Otherwise add it to the growing list of matches, if it is $buildingConfidence % or greater confidence
		 If $alreadyFound = False Then
			If $split[$j*3+3] > $buildingConfidence Then
			   ;DebugWrite("    Adding " & $j & ": " & $split[$j*3+1] & "," & $split[$j*3+2] & "  " & $split[$j*3+3])
			   $matchCount += 1
			   ReDim $matchX[$matchCount]
			   ReDim $matchY[$matchCount]
			   $matchX[$matchCount-1] = $split[$j*3+1]
			   $matchY[$matchCount-1] = $split[$j*3+2]
			EndIf
		 EndIf
	  Next
   Next

   Return $matchCount
EndFunc
#ce
