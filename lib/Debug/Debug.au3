#cs
	File: Debug.au3
	Author: dddddd.clash
	Date: 2015-11-12
	Summary:	These are the Main debug functions
	Functions:
		DebugWrite()
		DebugLog()
		DebugMsg()
		InitLogDir()

#ce
#include-once
#include <Date.au3>

Func DebugWrite($text)
	Local $sDebug = _NowDate() & " " & _NowTime(5) & " " & $text & @CRLF
	If $gc_DEBUG Then ConsoleWrite($sDebug)
	If $gc_LOG Then DebugLog($sDebug)
EndFunc

Func DebugLog($text)
	Local Static $sLogDir
	Local Static $sLogFile
	if Not $sLogDir Then $sLogDir = InitLogDir()
	if Not $sLogFile Then
		$sLogFile = TimeStampFilename()&".log"
	EndIf
	FileWrite( $sLogDir&'\'&$sLogFile, $text)
EndFunc ; ==>DebugLog

Func InitLogDir()
	Local $logDir = $gc_LOG_DIR
    If StringInStr($gc_LOG_DIR,":") = 0 Then
		$logDir = @ScriptDir&"\"&$gc_LOG_DIR
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $logDir = ' & $logDir & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	EndIf
	If DirGetSize($logDir) = -1 Then
		DirCreate($logDir)
	EndIf
	Return $gc_LOG_DIR
EndFunc ; ==>DebugLog

Func TimeStampFilename()
   Return StringReplace(_NowDate(),"/","-") & " (" & StringReplace(_NowTime(5),":","-") & ")"
EndFunc