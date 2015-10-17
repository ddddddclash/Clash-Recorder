#include "WinHTTP/WinHttp.au3"
#include <Crypt.au3>


Global Const $sFile = @ScriptDir &"\screenshots\4.jpg"
Global Const $sURL = "localhost"
Global Const $sPageURL = "coctrack/upload-image.php"

Global $hOpen = _WinHttpOpen()
Global $hConnect = _WinHttpConnect($hOpen, $sURL)
Global $hRequest = _WinHttpOpenRequest($hConnect, "POST", $sPageURL)

;#######################################################
; To open an image file and then return it as a string
; Necessary other versions all return the wrong size
;
; This version has no error tracking
;
;#######################################################
Func getImageFileAsString ($sImageFile)
	Local $hFileOpen = FileOpen($sFile, $FO_BINARY)
	$sReturn = BinaryToString(FileRead($hFileOpen))
	FileClose($hFileOpen)
    return $sReturn
EndFunc


;Global $sFileRead =  getImageFileAsString($sFile);


Global $sData = ""
$sData &= '----------unique' & @CRLF
$sData &= 'Content-Disposition: form-data; name="fileToUpload"; filename="'&$sFile&'"' & @CRLF
$sData &= 'Content-Type: image/png' & @CRLF & @CRLF
$sData &= getImageFileAsString($sFile) & @CRLF
$sData &= '----------unique'


_WinHttpSendRequest($hRequest, "Content-Type: multipart/form-data; boundary=--------unique", $sData)
_WinHttpReceiveResponse($hRequest)

$sResult = _WinHttpReadData($hRequest)
ConsoleWrite($sResult & @CRLF)

_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)


Func _GetStringSize($sString, $fOutput = Default)
    Local Const $aOutput[9] = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
    Local Const $iUBound = UBound($aOutput)
    Local $iFileGetSize = StringLen($sString), $iCount = 0
    If $fOutput Then
        While $iFileGetSize > 1023
            $iCount += 1
            $iFileGetSize /= 1024
        WEnd
        $iFileGetSize = Round($iFileGetSize, 2) & $aOutput[$iCount]
    EndIf
    Return $iFileGetSize
EndFunc   ;==>_GetStringSize