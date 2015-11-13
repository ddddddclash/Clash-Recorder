; Unknown counter
Global $n = 0 ; Counter for repeating file names.
Global $profile_n = 0 ;profile screen index

;BlueStacks windows info. These should be updated whenever the window is moved.
; alternatively could do away with this and simpy call WinGetPos() every time.
;Global $bs_x, $bs_y, $bs_width, $bs_height

;Mouse Variables
Global $gMouseClickMethod = $MOUSE_CLICK_METHOD

;GUI Variables
Global $GUI

;ss - Screen Shot
Global $cords_clan_ss[4] = [16,109,851,307]	; Cordinates relative to window.
Global $cords_clan_1_pos1 = [38,380,55,401]