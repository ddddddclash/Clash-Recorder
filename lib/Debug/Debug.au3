#cs
	File: Debug.au3
	Author: dddddd.clash
	Date: 2015-11-12
	Summary:	These are the Main debug functions
	Functions:
		DebugSetOutput()		; - Added 2015-11-20
		DebugEnableConsole()	; - Added 2015-11-20
		DebugDisableConsole()	; - Added 2015-11-20
		DebugEnableLog()		; - Added 2015-11-20
		DebugDisableLog()		; - Added 2015-11-20
		DebugWrite()
		DebugLog()
		InitLogDir()
		TimeStampFilename()

#ce
#include-once
#include <Date.au3>

;Not truely private but marked as such to show intention
Global $private_Debug_hEdit
Global $private_Debug_console = False
Global $private_Debug_Log = False
Global $private_Debug_Log_Dir = "log"

Func DebugSetOutput($hEdit)
	$private_Debug_hEdit = $hEdit
EndFunc

Func DebugEnableConsole()
	$private_Debug_console = True
EndFunc

Func DebugDisableConsole()
	$private_Debug_console = False
EndFunc

Func DebugEnableLog($dir = $private_Debug_Log_Dir)
	$private_Debug_Log = True
	$private_Debug_Log_Dir = $dir
EndFunc

Func DebugDisableLog()
	$private_Debug_Log = False
EndFunc



Func DebugWritePlain($text)
	If $private_Debug_console Then ConsoleWrite($text)
	If $private_Debug_hEdit Then GUICtrlSetData($private_Debug_hEdit,$text,1)
	If $private_Debug_Log Then DebugLog($text)
EndFunc


Func DebugWrite($text)
	Local $sDebug = _NowDate() & " " & _NowTime(5) & " " & $text & @CRLF
	If $private_Debug_console Then ConsoleWrite($sDebug)
	If $private_Debug_hEdit Then GUICtrlSetData($private_Debug_hEdit,$sDebug,1)
	If $private_Debug_Log Then DebugLog($sDebug)
EndFunc

Func DebugLog($text)
	Local Static $sLogDir
	Local Static $sLogFile ; one file per session.
	if Not $sLogDir Then $sLogDir = InitLogDir()
	if Not $sLogFile Then
		$sLogFile = TimeStampFilename()&".log"
	EndIf
	FileWrite( $sLogDir&'\'&$sLogFile, $text)
EndFunc ; ==>DebugLog

Func InitLogDir()
	Local $logDir = $private_Debug_Log_Dir
    If StringInStr($private_Debug_Log_Dir,":") = 0 Then
		$logDir = @ScriptDir&"\"&$private_Debug_Log_Dir
	EndIf
	If DirGetSize($logDir) = -1 Then
		DirCreate($logDir)
	EndIf
	Return $private_Debug_Log_Dir
EndFunc ; ==>DebugLog

Func TimeStampFilename()
   Return StringReplace(_NowDate(),"/","-") & " (" & StringReplace(_NowTime(5),":","-") & ")"
EndFunc