; These are the Settings that are used for Debug and everything else.
; This should be included first along with Globals.au3 and Constants.au3
; These are listed as Global constants becasue they should remain the same between instances of the program.
; A user would likely never change these and they can be declared as simple constants becasue Constants.au3 is
; easy enough to change. In fact it seems to reduce the chance of errors.
;
;Oh it becomes useful if the program is compiled. But in that case it is possible that they will not work as
;Global Const but need to be changed to Global.  That will need to be determined with time.


; Debug
Global $gc_ScraperDebug = _Boolean(IniRead($gc_INI_FILE, "Debug", "Scraper Debug", False))
Global $gc_DEBUG = _Boolean(IniRead($gc_INI_FILE, "Debug", "Global Debug", True))
Global $gc_DEBUG_CANVAS = _Boolean(IniRead($gc_INI_FILE, "Debug", "Debug Drawing Canvas", False))
Global $gc_LOG =  _Boolean(IniRead($gc_INI_FILE, "Debug", "Log Debug", True))

; Files
Global Const $gc_LOG_DIR = IniRead($gc_INI_FILE, "Files", "Log Dir","log")

; Mouse
; Clicking method; use "MouseClick" for old way, or "ControlClick" for new way
Global Const $gMouseClickMethod = IniRead($gc_INI_FILE, "Mouse", "Click Method", "MouseClick")
Global Const $gMouseClickDelay = IniRead($gc_INI_FILE, "Mouse", "MouseClick Delay", 60) ; Delay between mouse clicks

; Confidence Levels
Global Const $gConfidenceTownHall = IniRead($gc_INI_FILE, "Confidence", "Town Hall", 0.95)



Func _Boolean($fValue)
   If IsBool($fValue) Then Return $fValue
   If IsString($fValue) Then Return $fValue="True"
   Return Number($fValue) >= 1
EndFunc
