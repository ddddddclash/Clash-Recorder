#Include <File.au3>
#Include <Array.au3>

$Folders = "C:\" & "|" & @MyDocumentsDir & "|" & @ScriptDir
$ArrayFolders = StringSplit($Folders, "|")
;_ArrayDisplay($ArrayFolders)

Local $FileList[$ArrayFolders[0]]

For $i = 1 To $ArrayFolders[0]
    $FileList[($i - 1)] = _FileListToArray($ArrayFolders[$i])
Next
	_ArrayDisplay($FileList)