#include "Table.au3"

;----- GUI (Double Buffered) -----
$GUI = GUICreate("", 450, 450, -1, -1, -1, 0x2000000)

;----- Make sure GUI exists BEFORE creating Tables -----
GUISetState()

;----- Lock GUI until tables drawn -----
GUISetState(@SW_LOCK)

;----- Table Example 1 -----
GUICtrlCreateLabel(" Example 1 ", 25, 7, 100, 13)
$Table1 = _GUICtrlTableEdit_Create(25, 27, 55, 13, 4, 4, 1)
_GUICtrlTable_Set_ColumnWidth($Table1, 2, 20)
_GUICtrlTable_Set_Justify_All($Table1, 1, 1)
_GUICtrlTable_Set_TextFont_Row($Table1, 1, 8.5, 800)
_GUICtrlTable_Set_CellColor_Row($Table1, 1, 0xEEEEEE)
_GUICtrlTable_Set_Text_Row($Table1, 1, "Control|ID|Window|Staus")
_GUICtrlTable_Set_Text_Row($Table1, 2, "CheckBox|2|Main|disabled")
_GUICtrlTable_Set_Text_Row($Table1, 3, "ListView|3|Child|active")
_GUICtrlTable_Set_Text_Row($Table1, 4, "UpDown|4|Child|disabled")

;----- Table Example 2 -----
GUICtrlCreateLabel(" Example 2 ", 260, 7, 100, 13)
$Table2 = _GUICtrlTableEdit_Create(260, 27, 80, 18, 7, 2, 0)
_GUICtrlTable_Set_Justify_All($Table2, 1, 1)
_GUICtrlTable_Set_TextFont_All($Table2, 8.5, 400, 2, "Century Gothic")
_GUICtrlTable_Set_TextFont_Column($Table2, 1, 8.5, 800, 0, "Century Gothic")
_GUICtrlTable_Set_CellColor_Column($Table2, 1, 0xffd700)
_GUICtrlTable_Set_Text_Row($Table2, 1, "Surname|Biochem")
_GUICtrlTable_Set_Text_Row($Table2, 2, "Forename|Andy")
_GUICtrlTable_Set_Text_Row($Table2, 3, "Age|30")
_GUICtrlTable_Set_Text_Row($Table2, 4, "Height|5'8''")
_GUICtrlTable_Set_Text_Row($Table2, 5, "Weight|75kg")
_GUICtrlTable_Set_Text_Row($Table2, 6, "Eyes|Brown")
_GUICtrlTable_Set_Text_Row($Table2, 7, "M/F|M")
_GUICtrlTable_Set_Border_Table($Table2)

;----- Table Example 3 -----
GUICtrlCreateLabel(" Example 3 ", 25, 100, 100, 13)
$Table3 = _GUICtrlTableEdit_Create(25, 120, 62, 18, 6, 3, 0)
_GUICtrlTable_Set_ColumnWidth($Table3, 1, 70)
_GUICtrlTable_Set_Justify_Column($Table3, 1, 1, 1)
_GUICtrlTable_Set_Justify_Column($Table3, 2, 2, 1)
_GUICtrlTable_Set_Justify_Column($Table3, 3, 1, 1)
_GUICtrlTable_Set_Justify_Row($Table3, 1, 1, 1)
_GUICtrlTable_Set_Border_Row($Table3, 1, 8)
_GUICtrlTable_Set_Border_Row($Table3, 5, 8)
_GUICtrlTable_Set_Text_Row($Table3, 1, "Transaction|In|Out")
_GUICtrlTable_Set_Text_Row($Table3, 6, "Total|£51.01   |-£157.30   ")
_GUICtrlTable_Set_Text_Row($Table3, 2, "Petrol||-£35.00 ")
_GUICtrlTable_Set_Text_Row($Table3, 3, "Groceries||-£42.30 ")
_GUICtrlTable_Set_Text_Row($Table3, 4, "Interest|£51.01   ")
_GUICtrlTable_Set_Text_Row($Table3, 5, "Section 5||-£80.00 ")
For $row = 2 To 6
    For $col = 2 To 3
        _GUICtrlTable_Set_TextFont_Cell($Table3, $row, $col, 9, 400, 2)
    Next
Next
_GUICtrlTable_Set_TextFont_All($Table3, 8.5, 400, 2, "Tahoma")
_GUICtrlTable_Set_TextFont_Row($Table3, 1, 8.5, 600, 0, "Tahoma")

;----- Table Example 4 -----
GUICtrlCreateLabel(" Example 4 ", 25, 250, 100, 13)
$Table4 = _GUICtrlTableEdit_Create(35, 268, 62, 18, 100, 6, 0)
_GUICtrlTable_Set_RowHeight($Table4, 1, 35)
_GUICtrlTable_Set_Justify_All($Table4, 1, 1)
_GUICtrlTable_Set_TextFont_All($Table4, 8.5, 800, 0, "Tahoma")
_GUICtrlTable_Set_CellColor_Row($Table4, 1, 0x555555)
_GUICtrlTable_Set_TextColor_All($Table4, 0x555555)
_GUICtrlTable_Set_TextColor_Row($Table4, 1, 0xFFFFFF)
For $row = 3 To 10 Step 2
    _GUICtrlTable_Set_CellColor_Row($Table4, $row, 0xDDDDDD)
Next
_GUICtrlTable_Set_Text_Row($Table4, 1, "Fixing|Size|Weight|Net|Gross|Order")
_GUICtrlTable_Set_Text_Row($Table4, 2, "Block|20.0|0.01|300|340|No")
_GUICtrlTable_Set_Text_Row($Table4, 3, "Screw|8.5|0.3|50|100|No")
_GUICtrlTable_Set_Text_Row($Table4, 4, "Rivet|0.1|0.4|10|11|Yes")
_GUICtrlTable_Set_Text_Row($Table4, 5, "Rope|300.0|100.0|2|10|No")
_GUICtrlTable_Set_Text_Row($Table4, 6, "Tack|10.6|0.3|1000|1011|Yes")
_GUICtrlTable_Set_Text_Row($Table4, 7, "Nail|30.3|0.4|400|600|No")
_GUICtrlTable_Set_Text_Row($Table4, 8, "Staple|0.3|0.05|10000|12000|No")
_GUICtrlTable_Set_Border_Table($Table4, 0x555555)

;----- Table Example 5 -----
GUICtrlCreateLabel(" Example 5 ", 260, 165, 100, 13)
$Table5 = _GUICtrlTableEdit_Create(260, 182, 30, 20, 3, 3, 0)
_GUICtrlTable_Set_ColumnWidth($Table5, 1, 200)
_GUICtrlTable_Set_Text_Row($Table5, 1, "Attribute|x|y")
_GUICtrlTable_Set_CellColor_Row($Table5, 1, 0xEEEEEE)
_GUICtrlTable_Set_Justify_All($Table5, 1, 1)
_GUICtrlTable_Set_TextFont_All($Table5, 8.5, 200)
_GUICtrlTable_Set_TextFont_Row($Table5, 1, 9, 800)
_GUICtrlTable_Set_Border_Column($Table5, 2, 1, 0xEEEEEE)
_GUICtrlTable_Set_Border_Column($Table5, 3, 1, 0xEEEEEE)
_GUICtrlTable_Set_Border_Row($Table5, 1, 11)
_GUICtrlTable_Set_Border_Table($Table5)
_GUICtrlTable_Set_ColumnWidth($Table5, 1, 100)

;----- Unlock GUI to show tables -----
GUISetState(@SW_UNLOCK)

;----- Loop -----
Do
    Sleep(10)
    $m = MouseGetPos()
    _GUICtrlTable_Set_Text_Row($Table5, 2, "Mouse Position|" & $m[0] & "|" & $m[1])

    $w = WinGetPos("")
    _GUICtrlTable_Set_Text_Row($Table5, 3, "Window Position|" & $w[0] & "|" & $w[1])
Until GUIGetMsg() = -3