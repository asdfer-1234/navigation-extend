#NoEnv
;#Warn
;SendMode Input
SetCapsLockState, AlwaysOff


UpdateModifiers(){
	if(GetKeyState("Shift", "P") or (GetKeyState("CapsLock", "P") and GetKeyState("A", "P"))){
		if(!GetKeyState("Shift")){
			Send, {Blind}{ShiftDown}
		}
	}
	else{
		if(GetKeyState("Shift")){
			Send, {Blind}{ShiftUp}
		}
	}
	if(GetKeyState("Ctrl", "P") or (GetKeyState("CapsLock", "P") and GetKeyState("S", "P"))){
		if(!GetKeyState("Ctrl")){
			Send, {Blind}{CtrlDown}
		}
	}
	else{
		if(GetKeyState("Ctrl")){
			Send, {Blind}{CtrlUp}
		}
	}
	if(GetKeyState("Alt", "P") or (GetKeyState("CapsLock", "P") and GetKeyState("D", "P"))){
		if(!GetKeyState("Alt")){
			Send, {Blind}{AltDown}
		}
	}
	else{
		if(GetKeyState("Alt")){
			Send, {Blind}{AltUp}
		}
	}
}

CapsLock & A::
~*A Up::
~*Shift::
Shift Up::
CapsLock & S::
~*S Up::
~*Ctrl::
Ctrl Up::
CapsLock & D::
~*D Up::
~*Alt::
Alt Up::
*CapsLock Up::
	UpdateModifiers()
Return

CapsLock & I::Send, {Blind}{Up}
CapsLock & J::Send, {Blind}{Left}
CapsLock & K::Send, {Blind}{Down}
CapsLock & L::Send, {Blind}{Right}
CapsLock & U::Send, {Blind}{Home}
CapsLock & O::Send, {Blind}{End}
CapsLock & `;::Send, {Blind}{BackSpace}
CapsLock & P::Send, {Blind}{Delete}
CapsLock & Space::Send, {Blind}{AltDown}{Tab}
CapsLock & Space Up::
	if(!GetKeyState("CapsLock", "P")){
		UpdateModifiers()
	}
Return
CapsLock & F::Send, {Blind}{Tab}
CapsLock & Q::Send, {Blind}{Esc}
CapsLock & Z::Send, {Blind}^z
CapsLock & X::Send, {Blind}^x
CapsLock & C::Send, {Blind}^c
CapsLock & V::Send, {Blind}^v
CapsLock & W::Send, {Blind}^s
CapsLock & E::Send, {Blind}{Browser_Back}
CapsLock & R::Send, {Blind}{Browser_Forward}

CapsLock & Esc::
	if(GetKeyState("CapsLock", "T")){
		SetCapsLockState, AlwaysOff
	}
	else{
		SetCapsLockState, AlwaysOn
	}
Return

CapsLock & G::Volume_Down
CapsLock & T::Volume_Up

CapsLock & 1::
	list := ""
	numberOfwindows := ""
	wins := ""
	WinGet, id, list, ahk_class CabinetWClass ahk_exe explorer.exe
	Loop, %id%
	{
		numberOfwindows := A_Index
		this_ID := id%A_Index%
		WinGetTitle, title, ahk_id %this_ID%
		if (A_Index = 1) {
			win = %title% ; store the title in " win "
		}
		wins .= A_Index A_Space title ?½½ A_Index A_Space title "`n" : "" 
	}

	IfWinNotExist ahk_class CabinetWClass
	{
	Run C:\Windows\explorer.exe
	win := File Explorer
	WinWait, %win% ahk_class CabinetWClass
	WinActivate 
	} 

	WinWait, %win% ahk_class CabinetWClass
	WinActivate
Return



CapsLock & 2::FetchProcess("Code.exe", "C:\Program Files\Microsoft VS Code\Code.exe")
CapsLock & F2::FetchProcess("devenv.exe", "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe")
CapsLock & 3::FetchProcess("firefox.exe", "C:\Program Files\Mozilla Firefox\firefox.exe")
CapsLock & 4::FetchProcess("Discord.exe", "C:\Users\lsh\AppData\Local\Discord\app-1.0.9007\Discord.exe")
CapsLock & 5::FetchProcess("KakaoTalk.exe", "C:\Program Files\KakaoTalk\KakaoTalk.exe")
CapsLock & 6::Send, ^+{Esc}

CapsLock & Numpad0::
	TrayTip Navigation 2, Reloading
	Reload
Return


FetchProcess(ProcessName, Directory){
	If ProcessExist(ProcessName){
		WinGetTitle, fetch, ahk_exe %ProcessName%
		WinActivate, %fetch%
	}
	Else{
		Run, %Directory%
	}
	Return
}

ProcessExist(Name){
	Process, Exist, %Name%
	Return ErrorLevel
}