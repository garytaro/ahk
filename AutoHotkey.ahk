; vim: set fdm=marker ts=2 sw=2 sts=0:
;--------------------------------{{{
;キー配置変更スクリプト
;正直ahkの文法はよく分かっていないがノリで書く
;
;**環境設定**
;KeySwap等で下記キーを置換しておく。ahkのcapslock置換はバグあり、対応不可
;LCtrl    -> RCtrl
;CapsLock -> LCtrl
;
;従来のキー配置で可能な限り従来通りの動作をするよう設定する
;新たに定義するキーは、普段使用しないキー（無変換、CapsLock）を利用する
;e.g)従来のC-m→C-m、新しいC-m(CapsLockに相当)→CR
;--------------------------------}}}
#Include IME.ahk
#InstallKeybdHook
#UseHook

;実験中
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!{{{
LCtrl & e::Send {WheelDown}
LCtrl & y::Send {WheelUp}
LCtrl & d::Send {PgDn}
LCtrl & u::Send {PgUp}
vk1Dsc07B & f::Send #t
vk1Dsc07B & F4::Send !{F4}
Ctrl & q::
  if (GetKeyState("Shift", "P") || GetKeyState("Alt", "P") ) {
    Send !{F4}
  }

vk1Dsc07B & up::MouseMove, 0, -10, 1, R
vk1Dsc07B & left::MouseMove, -10, 0, 1, R
vk1Dsc07B & right::MouseMove, 10, 0, 1, R
vk1Dsc07B & down::MouseMove, 0, 10, 1, R
; vk1Dsc07B & c::MouseClick, left
vk1Dsc07B & c::Send {Click}
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}}}

;--------------------------------
;ランチャ{{{
;--------------------------------
^!f::Run, gvim -c VimFiler
^!s::Run, gvim -c VimShell
^!g::Run, gvim
^!t::Run, cmd /k prompt $g
^!r::Run, mstsc
^!c::Run, C:\Program Files\ConEmu\ConEmu64
^!d::Run, %USERPROFILE%\Dropbox\BackUp\Software\sleepdisplay_vista\SleepDisplay.exe
;}}}

;--------------------------------
;全般設定{{{
;--------------------------------
;backspace,enter,escの設定
;Ctrl + H → BackSpace
LCtrl & h::Send {Backspace}
;Ctrl + M → Enter
LCtrl & m::Send {Enter}
;Ctrl + q → ESC
LCtrl & q::Send {ESC}
LCtrl & `;::Send {ESC}
LCtrl & vkBAsc028::Send {ESC}

vk1Dsc07B & `;::Send {ESC}
vk1Dsc07B & t::Send !t
vk1Dsc07B & vkBAsc028::Send {ESC}

;無変換とスペースを右クリック"キー"
vk1Dsc07B & vk20sc039::Send {vk5Dsc15D}  
;無変換＋<戻る、>で進む
vk1Dsc07B & >::Send !{Right}
vk1Dsc07B & <::Send !{Left}
;無変換＋iで上の階層へ
vk1Dsc07B & i::Send !{Up}
;変換+無変換でF2
vk1Dsc07B & vk1Csc079::Send {F2}
;Alt+Tabと同様の動作
;なぜか効かない環境も(win8の問題？)…
vk1Dsc07B & Tab::Send !{Tab}

;window操作。win+lによる画面ロックを無効にする必要あり
;http://www.sssg.org/blogs/naoya/archives/2567
LWin & j::Send #{Down}
LWin & k::Send #{Up}
LWin & h::Send #{Left}
LWin & l::Send #{Right}
vk1Dsc07B & 1::Send #1
vk1Dsc07B & 2::Send #2
vk1Dsc07B & 3::Send #3
vk1Dsc07B & 4::Send #4
vk1Dsc07B & 5::Send #5
vk1Dsc07B & 6::Send #6
vk1Dsc07B & 7::Send #7
vk1Dsc07B & 8::Send #8
vk1Dsc07B & 9::Send #9

;カーソル・編集操作
vk1Dsc07B & a::
  If GetKeyState("Shift", "P") {
    If GetKeyState("Ctrl", "P") {
      Send ^+{HOME}
    }
    else Send +{HOME}
  }
  else if GetKeyState("Ctrl", "P"){
      Send ^{HOME}
  }
    else Send {HOME}
Return
vk1Dsc07B & e::
  If GetKeyState("Shift", "P") {
    If GetKeyState("Ctrl", "P") {
      Send ^+{END}
    }
    else Send +{END}
  }
  else if GetKeyState("Ctrl", "P"){
      Send ^{END}
  }
    else Send {END}
Return
vk1Dsc07B & m::
  If GetKeyState("Ctrl", "P") {
    Send ^{Enter}
  }
    else Send {Enter}
Return

;各種編集操作
vk1Dsc07B & u::Send,+{Home}{Delete}
vk1Dsc07B & d::Send {Delete}
vk1Dsc07B & s::Send {BackSpace}
vk1Dsc07B & w::Send,^+{Left}{Delete}
vk1Dsc07B & n::Send,+{End}{Delete}

vk1Dsc07B & o::
  if GetKeyState("SHIFT", "P") {
    Send ,{Home}{Enter}{Up}
  }
  else Send,{End}{Enter}
Return


;無変換 + H → 左カーソル
vk1Dsc07B & h::
  if GetKeyState("LCtrl", "P") {
    if GetKeyState("SHIFT", "P") {
      Send ^+{Left}
    }
    else Send ^{Left}
  }
  else if GetKeyState("SHIFT", "P") {
    Send +{Left}
  }
  else if GetKeyState("RCtrl", "P") {
    MouseMove, -100, 0, 1, R
  }
  else Send {Left}
Return

;無変換 + J → 下カーソル
vk1Dsc07B & j::
  if GetKeyState("LCtrl", "P") {
    if GetKeyState("SHIFT", "P") {
      Send +{Down}+{Down}+{Down}
    }
    else Send {Down}{Down}{Down}
  }
  else if GetKeyState("SHIFT", "P") {
    Send +{Down}
  }
  else if GetKeyState("RCtrl", "P") {
    MouseMove, 0, 100, 1, R
  }
  else Send {Down}
Return

;}}}
;--------------------------------

;--------------------------------
;アプリ毎の設定。既存の設定を上書きする{{{
;--------------------------------
;エクスプローラ
#IfWinActive ahk_class CabinetWClass
  vk1Dsc07B & i::Send, !{Up}
  LCtrl & l::Send, !d
  LCtrl & k::Send, ^+n
  ;エクスプローラで開いているパスを起点にプログラムを開く
  ^!f::
    IME_SET(0)
    Send !d
    PasteString("gvim -c VimFiler")
    Send {Enter}
    Return
  ^!s::
    IME_SET(0)
    Send !d
    PasteString("gvim -c VimShell")
    Send {Enter}
    Return
  ^!g::
    IME_SET(0)
    Send !d
    PasteString("gvim")
    Send {Enter}
    Return
  ^!t::
    IME_SET(0)
    Send !d
    PasteString("cmd /k prompt $g")
    Send {Enter}
    Send !{Tab}
    Return
  ^!c::
    IME_SET(0)
    Send !d
    PasteString("C:\Program Files\ConEmu\ConEmu64")
    Send {Enter}
    Return
  ^b::
    IME_SET(0)
    Send !d
    PasteString("%USERPROFILE%\Dropbox\BackUp\scripts\mdbk.bat")
    Send {Enter}
    Return
  Return
#IfWinActive

;各アプリから展開されるエクスプローラ
#IfWinActive ahk_class #32770
  vk1Dsc07B & i::Send, !{Up}
  LCtrl & l::Send, !d
  LCtrl & k::Send, ^+n
  Return
#IfWinActive

;コマンドプロンプト
#IfWinActive ahk_class ConsoleWindowClass
  ^v::Send !{Space}ep
  ^f::Send !{Space}ef
  ^p::Send {Up}
  ^n::Send {Down}
  ^l::Send {ESC}cls{ENTER}
  LCtrl & l::Send {ESC}cls{ENTER} ;なぜか↑ではダメ
  RCtrl & q::Send !{Space}c
  LCtrl & u::Send ^{HOME}
  LCtrl & k::Send ^{END}
  vk1Dsc07B & u::Send ^{HOME}
  vk1Dsc07B & n::Send ^{END}
  Return
#IfWinActive

;wordのスクロール等
; #IfWinActive ahk_class OpusApp
;   LCtrl & e::Send {WheelDown}
;   LCtrl & y::Send {WheelUp}
;   LCtrl & d::Send {PgDn}
;   LCtrl & u::Send {PgUp}
; #IfWinActive

;TODO:なぜかここで定義しないと動かない。スクリプトのバグ
;無変換 + K → 上カーソル
vk1Dsc07B & k::
  if GetKeyState("LCtrl", "P") {
    if GetKeyState("SHIFT", "P") {
      Send +{Up}+{Up}+{Up}
    }
    else Send {Up}{Up}{Up}
  }
  else if GetKeyState("SHIFT", "P") {
    Send +{Up}
  }
  else if GetKeyState("RCtrl", "P") {
    MouseMove, 0, -100, 1, R
  }
  else Send {Up}
Return

;無変換 + L → 右カーソル
vk1Dsc07B & l::
  if GetKeyState("LCtrl", "P") {
    if GetKeyState("SHIFT", "P") {
      Send ^+{Right}
      ;Send +{Right}+{Right}+{Right}+{Right}+{Right}
    }
    else Send ^{Right}
  }
  else if GetKeyState("SHIFT", "P") {
    Send +{Right}
  }
  else if GetKeyState("RCtrl", "P") {
    MouseMove, 100, 0, 1, R
  }
  else Send {Right}
Return

;ConEmu
#IfWinActive ahk_class VirtualConsoleClass
  RCtrl & q::Send ^q
  ^p::Send {Up}
  ^n::Send {Down}
  ^l::Send {ESC}cls{ENTER}
  LCtrl & u::Send ^{HOME}
  LCtrl & k::Send ^{END}
  vk1Dsc07B & u::Send ^{HOME}
  vk1Dsc07B & n::Send ^{END}
  vk1Dsc07B & k::Send {Up}
  vk1Dsc07B & j::Send {Down}
  Return
#IfWinActive

;エクセルのjkカーソル操作
#IfWinActive ahk_class XLMAIN
  ;無変換 + J → 下カーソル
  vk1Dsc07B & j::
    if GetKeyState("Ctrl", "P") {
      if GetKeyState("SHIFT", "P") {
        Send ^+{Down}
      }
      else Send ^{Down}
    }
    else if GetKeyState("SHIFT", "P") {
      Send +{Down}
    }
      else Send {Down}
  Return
  ;無変換 + K → 上カーソル
  vk1Dsc07B & k::
    if GetKeyState("Ctrl", "P") {
      if GetKeyState("SHIFT", "P") {
        Send ^+{Up}
      }
      else Send ^{Up}
    }
    else if GetKeyState("SHIFT", "P") {
      Send +{Up}
    }
      else Send {Up}
  Return
#IfWinActive

#IfWinActive ahk_class mintty
  LCtrl & h::Send ^h
  LCtrl & u::Send ^u
  LCtrl & k::Send ^k
  LCtrl & w::Send ^w
  LCtrl & e::Send ^e
  LCtrl & y::Send ^y
  LCtrl & d::Send ^d
#IfWinActive

;Vim
#IfWinActive ahk_class Vim
;潰されたキーを上書き
;vimrcとの二重管理になるが、対応は後で考える
  LCtrl & h::Send ^h
  LCtrl & u::Send ^u
  LCtrl & k::Send ^k
  LCtrl & w::Send ^w
  LCtrl & e::Send ^e
  LCtrl & y::Send ^y
  LCtrl & d::Send ^d
  ^1::send 1gt
  ^2::send 2gt
  ^3::send 3gt
  ^4::send 4gt
  ^5::send 5gt
  ^6::send 6gt
  ^7::send 7gt
  ^8::send 8gt
  ^9::send 9gt
  !h::Send !h
  vk1Dsc07B & u::Send, ^u
  vk1Dsc07B & s::Send, ^h
  vk1Dsc07B & w::Send, ^w
  vk1Dsc07B & m::Send, ^m
  vk1Dsc07B & n::Send, ^k
  ;vk1Dsc07B & n::Send, {ESC}{Right}+c
  ;vk1Dsc07B & o::Send, ^o
Return
#IfWinActive
;}}}
;--------------------------------

;scriptのリロード
LWin & z::Reload

;変換→IME ON、無変換→IME OFF
;これでIMEの設定はいじらなくておｋ
;一応キーバインドはATOKにしておく
vk1Dsc07B::  
  getIMEMode := IME_Get()  
  IME_SET(0)
  Return  
vk1Csc079::  
  getIMEMode := IME_Get()  
  IME_SET(1)  
  Return  
;カタカナキーをIME ONに
; vkF2sc070::MouseClick,right
vkF2sc070::
  getIMEMode := IME_Get()  
  IME_SET(1)  
  Return  

; >+Space::  
; getIMEMode := IME_Get()  
; if (%getIMEMode% = 0)  
; {  
;     IME_SET(1)  
;     return  
; }  
; else  
; {  
;     IME_SET(0)  
;     return  
; }  

; クリップボードに文字列をためて一度にペースト
PasteString(String){
    Backup := ClipboardAll
    Clipboard := String
    Send,^v
    Sleep,50
    Clipboard := Backup
}
