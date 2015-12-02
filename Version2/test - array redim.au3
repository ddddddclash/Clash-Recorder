#include <Array.au3>

Dim $a1 = [[1,2]]
Dim $a2 = [3,22,11,33]

_ArrayCombine($a1,$a2)
_ArrayDisplay($a1)

Func _ArrayCombine(ByRef $array1, ByRef $array2)    ; Adds a row to a 2d array.
    Local $r1 = UBound($array1,1)
	Local $c1 = UBound($array1,2)
    Local $c2 = Ubound($array2)
	Local $cmax = $c1 >= $c2 ? $c1 : $c2

    ReDim $array1[$r1+1][$cmax]

    For $i=0 To $c2 -1
		$array1[$r1][$i] = $array2[$i]
    Next
EndFunc


