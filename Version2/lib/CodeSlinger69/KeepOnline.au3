Func CheckForAndroidMessageBox()

   ; Check for Android message boxes
   If IsButtonPresent($rAndroidMessageButton) Then
	  DebugWrite("Online check: Clicking Android Msg Box")

	  WinActivate($gTitle)
	  WinWaitActive($gTitle)

	  RandomWeightedClick($rAndroidMessageButton)
	  Sleep(2000)

	  ; Wait for main screen
	  Local $failCount = 15

	  Local $s = WhereAmI()
	  While $s <> $eScreenMain And $failCount>0
		 Sleep(1000)
		 $failCount -= 1
		 $s = WhereAmI()
	  WEnd

	  If $failCount>0 Then ZoomOut(False)
   EndIf
EndFunc

Func AttackingIsDisabled()
   Return IsColorPresent($rAttackingDisabledPoint1Color) And _
		  IsColorPresent($rAttackingDisabledPoint2Color) And _
		  IsColorPresent($rAttackingDisabledPoint3Color)
EndFunc
