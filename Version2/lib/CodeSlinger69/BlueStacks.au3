;----------------------------------------------------------------------------------
; Author : CodeSlinger69
; Modified by: dddddd.clash
; Date: 2015/11/13
; Notes: Modified to be used as a stand alone library called by BlueStacks_resize
;----------------------------------------------------------------------------------

#include <File.au3>



Func StartBlueStacks()
	Local $cSize
	If Not CheckIfBlueStacksIsRunning() Then Return
	$cSize = WinGetClientSize($gTi tle)
	If ($cSize[0] <> $gBlueStacksWidth) Or ($cSize[1] <> $gBlueStacksHeight) Then
		Local $res = MsgBox(BitOr($MB_OKCANCEL, $MB_ICONQUESTION), "", "BlueStacks window is the wrong size." &@CRLF& "Click OK to quit BlueStacks and resize.")
		If $res = $IDCANCEL Then
			Return
		EndIf

		FixBlueStacksSize()

		If Not CheckIfBlueStacksIsRunning() Then Return

		$cSize = WinGetClientSize($gTitle)

		If ($cSize[0] <> $gBlueStacksWidth) Or ($cSize[1] <> $gBlueStacksHeight) Then
			MsgBox(BitOr($MB_OK, $MB_ICONERROR), "BlueStacks Wrong Size", "BlueStacks window is still the wrong size." & @CRLF & "Please correct manually.")
			Return
		EndIf
	EndIf

EndFunc

Func CheckIfBlueStacksIsRunning()
   ; Restore if minimized/maximized
   If BitAnd(WinGetState($gTitle), 16) Or BitAnd(WinGetState($gTitle), 32) Then
	  WinSetState($gTitle, "", @SW_RESTORE)
   EndIf

   ; Activate
   WinActivate($gTitle)
   Local $isActive = WinWaitActive($gTitle, "", 2)

   If $isActive Then
	  WinMove($gTitle, "", 4, 4)
   Else
	  MsgBox(BitOr($MB_OK, $MB_ICONERROR), "BlueStacks Not Running", "Cannot find or activate BlueStacks window." )
	  Return False
   EndIf
   Return True
EndFunc

Func FixBlueStacksSize()
   Local $res

   ; Stop service
   DebugWrite("Stopping BlueStacks process: BstHdAndroidSvc")
   RunWait(@ComSpec & " /c " & 'net stop BstHdAndroidSvc', "", @SW_HIDE)

   ; Kill processes
   Local $bsProcesses[7] = ["HD-Service.exe", "HD-FrontEnd.exe", "HD-Agent.exe", "HD-BlockDevice.exe", "HD-Network.exe", _
						    "HD-SharedFolder.exe", "HD-UpdaterService.exe"]


   For $i = 0 To UBound($bsProcesses)-1

	  If ProcessExists($bsProcesses[$i]) Then
		 DebugWrite("Process - "&$bsProcesses[$i]&": Exists attempting to close.")
		 $res = ProcessClose($bsProcesses[$i])
		 ;$res = ProcessWaitClose($bsProcesses[$i])
		 If $res<>1 Then
			DebugWrite("Error killing BlueStacks process: " & $bsProcesses[$i] & " Return Value: " & $res & " Error Code: "&@error)
			MsgBox(BitOr($MB_OK, $MB_ICONERROR), "Error killing process", "Error killing BlueStacks process: " & $bsProcesses[$i] & @CRLF & _
			   "Please correct manually.")
			Exit
		 Else
			DebugWrite("Killed BlueStacks process: " & $bsProcesses[$i])
		 EndIf
	  Else
		 DebugWrite("Process - "&$bsProcesses[$i]&": Does not exist!")
	  EndIf

   Next

   ; Write correct registry entries
   Local $bsKeys[6] = ["Width", "Height", "WindowWidth", "WindowHeight", "GuestWidth", "GuestHeight"]
   Local $bsValues[6] = [$gBlueStacksWidth, $gBlueStacksHeight, $gBlueStacksWidth, $gBlueStacksHeight, $gBlueStacksWidth, $gBlueStacksHeight]
   Local $regError = False

   For $i = 0 To UBound($bsKeys)-1
	  $res = RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0", $bsKeys[$i], "REG_DWORD", $bsValues[$i])
	  If $res=1 Then
		 DebugWrite("Wrote registry entry: HKEY_LOCAL_MACHINE\SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0\" & $bsKeys[$i] & " = " & $bsValues[$i])
	  Else
		 DebugWrite("ERROR writing registry entry: HKEY_LOCAL_MACHINE\SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0\" & $bsKeys[$i] & " = " & $bsValues[$i] & " Code: " & $res)
		 $regError = True
	  EndIf
   Next

   If $regError = True Then
	  DebugWrite("Error writing BlueStacks registry value(s)")
	  MsgBox(BitOr($MB_OK, $MB_ICONERROR), "Error writing registry", "Error writing BlueStacks registry value(s)" & @CRLF & _
		 "Please correct manually.")
	  Exit
   EndIf

   ; Locate BS Launcher
   DebugWrite("Restarting BlueStacks.")
   Local $blueStacksLauncherPath = _FileListToArrayRec(@ProgramFilesDir, "HD-StartLauncher.exe", $FLTAR_FILES, _
													   $FLTAR_RECUR, $FLTAR_NOSORT, $FLTAR_FULLPATH)

   If $blueStacksLauncherPath[0] = 0 Then
	  DebugWrite("Unable to locate BlueStacks launcher in " & @ProgramFilesDir)
	  MsgBox($MB_OK, "BlueStacks Launcher Not Found", "Restarting BlueStacks" & @CRLF & @CRLF & _
		 "Cannot locate BlueStacks launcher in " & @ProgramFilesDir & @CRLF & _
		 "Please manually start BlueStacks, then click OK.")
	  Return

   ElseIf $blueStacksLauncherPath[0] > 1 Then
	  DebugWrite("Found multiple BlueStacks launchers in " & @ProgramFilesDir)
	  MsgBox($MB_OK, "Multiple BlueStacks Launchers Found", "Restarting BlueStacks" & @CRLF & @CRLF & _
		 "Found multiple BlueStacks launchers in " & @ProgramFilesDir & @CRLF & _
		 "Please manually start BlueStacks, then click OK.")
	  Return
   EndIf

   ; Found a single BlueStacks launcher, start it up
   Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
   Local $aPathSplit = _PathSplit($blueStacksLauncherPath[1], $sDrive, $sDir, $sFilename, $sExtension)

   Local $blueStacksPID = Run($blueStacksLauncherPath[1], $sDrive & $sDir)
   If $blueStacksPID = 0 Then
	  DebugWrite("Error launching BlueStacks, @error=" & @error)
	  MsgBox($MB_OK, "BlueStacks Launch Error", "Error starting BlueStacks" & @CRLF & _
		 "Please manually start BlueStacks, then click OK.")
	  Return
   Else
	  DebugWrite("Launched BlueStacks, pid=" & $blueStacksPID)
   EndIf

   ; Wait 10 seconds for BlueStacks window
   $res = WinWait($gTitle, "", 10)

   If $res = 0 Then
	  DebugWrite("Time out launching BlueStacks")
	  MsgBox($MB_OK, "BlueStacks Launch Error", "Time out starting BlueStacks" & @CRLF & @CRLF & _
		 "Please manually start BlueStacks, then click OK.")
	  Return
   EndIf

   DebugWrite("BlueStacks started successfully.")

   Sleep(1000)
EndFunc

; Returns the absolute position of the client window
; Added from Scraper.au3
Func GetClientPos()
   Local $cPos[4]

   ; Get absolute coordinates of client area
   Local $hWnd = WinGetHandle($gTitle)
   Local $cSize = WinGetClientSize($gTitle)

   Local $tPoint = DllStructCreate("int X;int Y")
   DllStructSetData($tPoint, "X", 0)
   DllStructSetData($tPoint, "Y", 0)

   _WinAPI_ClientToScreen($hWnd, $tPoint)
   $cPos[0] = DllStructGetData($tPoint, "X")
   $cPos[1] = DllStructGetData($tPoint, "Y")
   $cPos[2] = $cPos[0]+$cSize[0]-1
   $cPos[3] = $cPos[1]+$cSize[1]-1

   Return $cPos
EndFunc
