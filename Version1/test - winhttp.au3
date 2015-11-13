#include "lib/WinHTTP/WinHttp.au3"

Global $sFile = @ScriptDir & "\images\clan.bmp"

Global Const $sURL = "http://localhost/"

; Session
Global $hOpen = _WinHttpOpen()
; Connection
Global $hConnect = _WinHttpConnect($hOpen, $sURL)

If @error Then
    MsgBox(48, "Error", "Error getting connection handle." & @CRLF & "Error number is " & @error)
Else
    ConsoleWrite("+ Connection handle $hConnect = " & $hConnect & @CRLF)
EndIf

; Upload image
;Global $sRead = _WinHttpSimpleFormFill($hConnect, "coctrack/upload.html", Default, _
;		"xmlOutput", 1, _
;		"testMode", 1, _
;		"name:fileToUpload", $sFile)
Global $sRead = _WinHttpSimpleFormFill($hConnect, "coctrack/upload.html", Default, _
		"name:fileToUpload", $sFile)


If @error Then
	MsgBox(4096, "Error", "Error number = " & @error)
Else
	ConsoleWrite("no error:" & $sRead & @CRLF)
EndIf



; Close connection handle
_WinHttpCloseHandle($hConnect)
; Close session handle
_WinHttpCloseHandle($hOpen)



