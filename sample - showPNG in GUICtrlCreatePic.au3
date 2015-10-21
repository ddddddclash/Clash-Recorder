;This does pretty close to what I want, but sebdubg the message this way puts the image behind the controls
;not sure how to fix it so add latter.



;coded by UEZ 2011
#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

;Global Const $IMAGE_BITMAP = 0
Global Const $STM_SETIMAGE = 0x0172
Global $msg
Global Const $hGUI = GUICreate("Display PNG Image in picture control", 900, 250)
Global Const $idPic = GUICtrlCreatePic("", 0, 0)
_GDIPlus_Startup()
;Global Const $png = StringReplace(@AutoItExe, "autoit3.exe", "ExamplesGUITorus.png")
Global Const $hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\images\clan.png")
Global Const $Bmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
_WinAPI_DeleteObject(GUICtrlSendMsg($idPic, $STM_SETIMAGE, $IMAGE_BITMAP, $Bmp))


GUISetState()

While True
    $msg = GUIGetMsg()
    Switch $msg
        Case $idPic
            MsgBox(0, "Information", "PNG image was clicked")
        Case $GUI_EVENT_CLOSE
            _WinAPI_DeleteObject($Bmp)
            _GDIPlus_ImageDispose($hImage)
            _GDIPlus_Shutdown()
            GUIDelete($hGUI)
            Exit
    EndSwitch
WEnd