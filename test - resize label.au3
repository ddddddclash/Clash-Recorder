#include <GuiConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $label1, $label2, $label3, $label4
$Gui = GUICreate("resize label to text width")

CreateLabels(0)


$btn = GUICtrlCreateButton("Do it!", 175, 200)

GUISetState()



While 1
    $msg = GUIGetMsg()

    Switch $msg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $btn;change the fonts in the labels
            CreateLabels()
    EndSwitch


WEnd


Func CreateLabels($setfonts = 1)

        GUICtrlDelete($label1)
        GUICtrlDelete($label2)
        GUICtrlDelete($label3)
        GUICtrlDelete($label4)

    If $setfonts Then GUISetFont(10, 400, 2, "Times New Roman")
    $label1 = GUICtrlCreateLabel("A label", 5, 5);, 350, 15)
    GUICtrlSetBkColor(-1, 0x00ff00)

    If $setfonts Then GUISetFont(12, 600, 2, "Arial")
    $label2 = GUICtrlCreateLabel("A big font label", 5, 30);, 350)
    GUICtrlSetBkColor(-1, 0x00ff00)

    If $setfonts Then GUISetFont(9, 400, 2, "Times New Roman")
    $label3 = GUICtrlCreateLabel("A label that will be padded", 5, 60);, 350, 15)
    GUICtrlSetBkColor(-1, 0x00ff00)

    If $setfonts Then GUISetFont(12, 600, 2, "Arial")
    $label4 = GUICtrlCreateLabel("A big label that will be padded", 5, 90);, 350)
    GUICtrlSetBkColor(-1, 0x00ff00)
EndFunc  ;==>CreateLabels