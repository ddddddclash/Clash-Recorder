#include "WinHTTP/WinHttp.au3"

Global $sFile = "C:\_Programming\Local - autoit\Clash Recorder\screenshots\4.jpg"

Global Const $sURL = "localhost"

; Session
Global $hOpen = _WinHttpOpen()
; Connection
Global $hConnect = _WinHttpConnect($hOpen, $sURL)

if $hConnect Then
  ConsoleWrite ("Good" & @CRLF )
Else
	ConsoleWrite ("bad" & @CRLF )
EndIf

; Upload image
Global $sRead = _WinHttpSimpleFormFill($hConnect, "upload.html", Default, _
        "xmlOutput", 1, _
        "testMode", 1, _
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



