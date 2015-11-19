;#Include <File.au3>
#Include <Array.au3>

#cs
$Folders = "C:\" & "|" & @MyDocumentsDir & "|" & @ScriptDir
$ArrayFolders = StringSplit($Folders, "|")
;_ArrayDisplay($ArrayFolders)

Local $FileList[$ArrayFolders[0]]

For $i = 1 To $ArrayFolders[0]
    $FileList[($i - 1)] = _FileListToArray($ArrayFolders[$i])
Next
	_ArrayDisplay($FileList)
#ce

Local $this_is_array[2] = ["one","two"]
Local $varname = "$this_is_array"
Local $tempA = Execute($varname)
consolewrite("$tempA[0] = "&$tempA[0]&", $tempA[1] = "&$tempA[1]&@CRLF)