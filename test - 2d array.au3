#cs
#Include <Array.au3>
#Include <File.au3>

$Folders = "C:|" & @MyDocumentsDir & "|" & @ScriptDir
$ArrayFolders = StringSplit($Folders, "|")
Dim $FileList[1]
$iNumFiles = 0
$iFileIndex = 0
$iFile = 0
$i = 0
Do
    $i += 1
        $TempArray = _FileListToArray($ArrayFolders[$i])
        If IsArray($TempArray) Then
            $iNumFiles += $TempArray[0]
            ReDim $FileList[$iNumFiles]
            For $iFile = 1 To UBound($TempArray) - 1
                $FileList[$iFileIndex] = $ArrayFolders[$i] & "\" & $TempArray[$iFile]
                $iFileIndex += 1
            Next
        EndIf
Until $ArrayFolders[0] = $i
_ArrayDisplay($FileList)
#ce


#Include <File.au3>
#Include <Array.au3>

$Folders = "C:\" & "|" & @MyDocumentsDir & "|" & @ScriptDir
$ArrayFolders = StringSplit($Folders, "|")
_ArrayDisplay($ArrayFolders)

Local $FileList[$ArrayFolders[0]]

For $i = 1 To $ArrayFolders[0]
    $FileList[($i - 1)] = _FileListToArray($ArrayFolders[$i])
    _ArrayDisplay($FileList[($i - 1)])
Next