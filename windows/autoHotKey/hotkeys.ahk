+Capslock::Capslock ; make shift+Caps-Lock the Caps Lock toggle
Capslock::Control   ; make Caps Lock the control button

; Umlaute
^!a::Send, {U+00e4}
^!+a::Send, {U+00c4}
^!o::Send, {U+00f6}
^!+o::Send, {U+00d6}
^!u::Send, {U+00fc}
^!+u::Send, {U+00dc}
^!s::Send, {U+00df}


#IfWinActive ahk_exe chrome.exe
^h::Send, {Backspace}

#IfWinActive ahk_exe WINWORD.exe
^h::Send, {Backspace}
