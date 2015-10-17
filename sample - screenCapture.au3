#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <ScreenCapture.au3>

;Global Const $WM_LBUTTONDOWN = 0x0201
Global $hDLL = DllOpen("User32.dll")

Global $Drag = False
Global $aCoord_Start
Global $aCoord_End
Global $iLeft, $iTop, $iRight, $iBottom
Global $sCapture = False

HotKeySet("{Esc}", "_Exit")

Global $pStub_MouseProc = DllCallbackRegister ("_Mouse_Handler", "int", "int;ptr;ptr")

Global $hHookMouse = _WinAPI_SetWindowsHookEx($WH_MOUSE_LL, DllCallbackGetPtr($pStub_MouseProc), _WinAPI_GetModuleHandle(0), 0)

While 1
    If $sCapture Then
        $sCapture = False
        _ScreenCapture_Capture(@ScriptDir & "\Capture.jpg", $iLeft, $iTop, $iRight, $iBottom)
    EndIf
    Sleep(100)
WEnd

Func _Mouse_Handler($nCode, $wParam, $lParam)
    If $nCode < 0 Then Return _WinAPI_CallNextHookEx($hHookMouse, $nCode, $wParam, $lParam)

    Switch $wParam
        Case $WM_LBUTTONDOWN
            $aCoord_Start = MouseGetPos()
        Case $WM_MOUSEMOVE
            If _IsPressed("01", $hDLL) Then $Drag = True
        Case $WM_LBUTTONUP
            $aCoord_End = MouseGetPos()

            If $Drag = True Then
                $Drag = False

                If $aCoord_Start[0] < $aCoord_End[0] Then
                    $iLeft = $aCoord_Start[0]
                    $iRight = $aCoord_End[0]
                Else
                    $iLeft = $aCoord_End[0]
                    $iRight = $aCoord_Start[0]
                EndIf

                If $aCoord_Start[1] < $aCoord_End[1] Then
                    $iTop = $aCoord_Start[1]
                    $iBottom = $aCoord_End[1]
                Else
                    $iTop = $aCoord_End[1]
                    $iBottom = $aCoord_Start[1]
                EndIf

                $sCapture = True
                Return 0
            EndIf
    EndSwitch

    Return _WinAPI_CallNextHookEx($hHookMouse, $nCode, $wParam, $lParam)
EndFunc

Func _Exit()
    DllCallbackFree($pStub_MouseProc)
    _WinAPI_UnhookWindowsHookEx($hHookMouse)
    DllClose($hDLL)

    Exit
EndFunc