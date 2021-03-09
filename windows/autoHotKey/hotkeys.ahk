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

^'::
{
    Input, PressedKey, L1 T1C

    if (PressedKey == "a")
        Send, {U+00e4}
    if (PressedKey == "A")
        Send, {U+00c4}
    else if (PressedKey == "o")
        Send, {U+00f6}
    else if (PressedKey == "O")
        Send, {U+00d6}
    else if (PressedKey == "u")
        Send, {U+00fc}
    else if (PressedKey == "U")
        Send, {U+00dc}
    else if (PressedKey == "s")
        Send, {U+00df}
    else if (PressedKey == "t")
        Send, tail -f /var/log/messages
    else if (PressedKey == "g")
        Send, tail -f /var/log/messages | grep "
        
    return
}

#IfWinActive ahk_exe chrome.exe
^h::Send, {Backspace}

#IfWinActive ahk_exe WINWORD.exe
^h::Send, {Backspace}
