#include <GDIPlus.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>

; Modified from http://www.autoitscript.com/forum/index.php?s=&showtopic=97126&view=findpost&p=698489
Opt("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode", 1) ;1=absolute, 0=relative, 2=client

Main()

Func Main()
    Local $hBitmap, $hGui, $hGraphic, $hImage2, $GuiSizeX = @DesktopWidth, $GuiSizeY = @DesktopHeight
    Local $GuiSize = 70, $hWnd, $hDC, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
    Local $iX1 = 0, $iY1 = 0, $tPoint, $pPoint, $hBMPBuff, $hGraphicGUI, $hPen, $aMPos, $aMPosNew
    Local $iOpacity = 255, $dll = DllOpen("user32.dll")

    $hGui = GUICreate("L1", $GuiSizeX, $GuiSizeY, -1, -1, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST))
    GUISetState()

    _GDIPlus_Startup()
    $hWnd = _WinAPI_GetDC(0)
    $hDC = _WinAPI_CreateCompatibleDC($hWnd)
    $hBitmap = _WinAPI_CreateCompatibleBitmap($hWnd, $GuiSizeX, $GuiSizeY)
    _WinAPI_SelectObject($hDC, $hBitmap)
    $hGraphic = _GDIPlus_GraphicsCreateFromHDC($hDC)
    $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($GuiSizeX, $GuiSizeY, $hGraphic)
    $hGraphicGUI = _GDIPlus_ImageGetGraphicsContext($hBMPBuff)

    _GDIPlus_GraphicsClear($hGraphic); Add ,0x01000000) to disable underling desktop
    $hPen = _GDIPlus_PenCreate(0xffff0000, 3)

    $tSize = DllStructCreate($tagSIZE)
    $pSize = DllStructGetPtr($tSize)
    DllStructSetData($tSize, "X", $GuiSizeX);$iWidth )
    DllStructSetData($tSize, "Y", $GuiSizeY);$iHeight)
    $tSource = DllStructCreate($tagPOINT)
    $pSource = DllStructGetPtr($tSource)
    $tBlend = DllStructCreate($tagBLENDFUNCTION)
    $pBlend = DllStructGetPtr($tBlend)
    DllStructSetData($tBlend, "Alpha", $iOpacity)
    DllStructSetData($tBlend, "Format", 1)
    $tPoint = DllStructCreate($tagPOINT); Create point destination structure here
    $pPoint = DllStructGetPtr($tPoint); Create pointer to this dll data structure, $pPTDest parameter
    DllStructSetData($tPoint, "X", $iX1)
    DllStructSetData($tPoint, "Y", $iY1)
    _WinAPI_UpdateLayeredWindow($hGui, $hWnd, $pPoint, $pSize, $hDC, $pSource, 0, $pBlend, $ULW_ALPHA)

    Do
        Select

            Case _IsPressed("01", $dll); Ctrl  mouse button to move
                $aMPos = MouseGetPos()
                Do
                    Sleep(10)
                Until Not _IsPressed("01", $dll)
                $aMPosNew = MouseGetPos()
                ;_GDIPlus_GraphicsDrawLine($hGraphic, $aMPosNew[0], $aMPosNew[1], $aMPos[0], $aMPos[1], $hPen)

                ; I used _Iif() from Misc.au3 instead using of _Min() from Math.au3.
                _GDIPlus_GraphicsDrawRect($hGraphic, _Iif($aMPos[0] < $aMPosNew[0], $aMPos[0], $aMPosNew[0]), _Iif($aMPos[1] < $aMPosNew[1], $aMPos[1], $aMPosNew[1]), Abs($aMPosNew[0] - $aMPos[0]), Abs($aMPosNew[1] - $aMPos[1]), $hPen)
                _WinAPI_UpdateLayeredWindow($hGui, $hWnd, 0, $pSize, $hDC, $pSource, 0, $pBlend, $ULW_ALPHA)

            Case _IsPressed("04", $dll) Or _IsPressed("11", $dll) ; Middle mouse button 0r Ctrl key <=======  Clear screen of rectangles.
                _GDIPlus_GraphicsClear($hGraphic)
                _WinAPI_UpdateLayeredWindow($hGui, $hWnd, 0, $pSize, $hDC, $pSource, 0, $pBlend, $ULW_ALPHA)
        EndSelect
        Sleep(50)
    Until _IsPressed("1B", $dll); ESC key

    DllClose($dll)
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_GraphicsDispose($hGraphicGUI)
    _GDIPlus_GraphicsDispose($hGraphic)
    _WinAPI_ReleaseDC(0, $hWnd)
    _WinAPI_DeleteObject($hBitmap)
    _WinAPI_DeleteDC($hDC)
    _GDIPlus_Shutdown()
EndFunc   ;==>Main

Func _Iif($bCondition, $vTrue, $vFalse)
    Return ($bCondition ? $vTrue : $vFalse)
EndFunc