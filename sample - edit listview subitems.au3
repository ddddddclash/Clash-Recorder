#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiEdit.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <WinAPI.au3>

Opt("GuiCloseOnESC", 0)

Global $hEdit, $Item = -1, $SubItem = 0

Global $Style = BitOR($WS_CHILD, $WS_VISIBLE, $WS_BORDER, $ES_AUTOHSCROLL, $ES_LEFT)

$hGUI = GUICreate("ListView Subitems edit in place", 300, 200)

$hListView = _GUICtrlListView_Create($hGUI, "Items|SubItems", 2, 2, 296, 196, BitOR($LVS_EDITLABELS, $LVS_REPORT))
_GUICtrlListView_SetExtendedListViewStyle($hListView, $LVS_EX_GRIDLINES)

For $i = 1 To 10
    _GUICtrlListView_AddItem($hListView, "Item " & $i)
    _GUICtrlListView_AddSubItem($hListView, $i - 1, "SubItem " & $i, 1)
Next

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $tNMHDR, $hWndFrom, $iCode

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")

    Switch $hWndFrom
        Case $hListView
            Switch $iCode
                Case $NM_DBLCLK
                    Local $aHit = _GUICtrlListView_SubItemHitTest($hListView)
                    If ($aHit[0] <> -1) And ($aHit[1] > 0) Then
                        $Item = $aHit[0]
                        $SubItem = $aHit[1]
                        Local $iSubItemText = _GUICtrlListView_GetItemText($hListView, $Item, $SubItem)
                        Local $aRect = _GUICtrlListView_GetSubItemRect($hListView, $Item, $SubItem)
                        $hEdit = _GUICtrlEdit_Create($hGUI, $iSubItemText, $aRect[0] + 1, $aRect[1] - 4, $aRect[2] - $aRect[0], 20, $Style)
                        _WinAPI_SetFocus($hEdit)
                    EndIf
            EndSwitch
    EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc

Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
    Local $iCode = BitShift($wParam, 16)

    Switch $lParam
        Case $hEdit
            Switch $iCode
                Case $EN_KILLFOCUS
                    Local $iText = _GUICtrlEdit_GetText($hEdit)
                    _GUICtrlListView_SetItemText($hListView, $Item, $iText, $SubItem)
                    _WinAPI_DestroyWindow($hEdit)
                    $Item = -1
                    $SubItem = 0
            EndSwitch
    EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc