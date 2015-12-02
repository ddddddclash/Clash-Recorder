;https://www.autoitscript.com/forum/topic/131447-reading-lines-in-a-csv-file/

#include <file.au3>
#include <array.au3>

Dim $a_lines, $i, $a_temp
$s_path = 1
$rc = _FileReadToArray("C:\test.csv", $a_lines)
If $rc <> 0 Then
    For $i = 1 To $a_lines[0]
        $a_temp = StringSplit($a_lines[0], ",")
        If IsArray($a_temp) And $a_temp[0] > 0 Then
            If $a_temp[1] = $path Then
                MsgBox(0, "Values", _ArrayToString($a_temp, " - ", 1)
            EndIf
        EndIf
    Next
EndIf