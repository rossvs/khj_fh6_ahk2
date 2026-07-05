#Requires AutoHotkey v2.0
#HotIf WinActive("Forza Horizon 6")
#SingleInstance Force

; (c) [KJI]Fenix, 2026
;
; NB! This scripts provided only for educational purposes. Using them could violate FH6 EULA.
; Script only press buttons without any feedback from screen, which is very "fragile" technique.
; Tested on version 379.939 (July 2026). Further game updates could break these button sequences.
;
; THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
; INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
; PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
; FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
; ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

; If you want to thank me, try some of my shared events:
; 341 756 168 Small Honda C-class rally
; 136 347 490 Total AWD S1 31 miles rally with jumps (East)
; 834 176 178 Total AWD S1 39 miles rally with jumps (West)
; 153 510 921 Tokyo D-class low speed leisure trip, 16 miles
; 860 068 697 Classic muscle car rally with hill climb, 11 miles


F1:: { ; Show help

HelpGui := Gui("-MinimizeBox -MaximizeBox", "Quick Help")
    HelpGui.Add("Text",, "Available Hotkeys:")
    HelpGui.Add("Text",, "F1: Show this help")
    HelpGui.Add("Text",, "F2: Stop")
    HelpGui.Add("Text",, "F3: SP farm event")
    HelpGui.Add("Text",, "F4: CR rivals colossus farm")
    HelpGui.Add("Text",, "F5: Auto spend 990 SP wheelspeen")
    HelpGui.Add("Text",, "F6: Send all duplicated cars as gift")
    HelpGui.Add("Text",, "F7: Photo shoot all your cars")
    HelpGui.Add("Text",, "F8: Anti idle")
    HelpGui.Add("Text",, "F12: Close application")
    HelpGui.Add("Button", "Default w80", "OK").OnEvent("Click", (*) => HelpGui.Hide())
    HelpGui.Show()
}


F2:: { ; Stop F3-F7
    Global StopLoop := true
    ToolTip "Wait for stop"
    SetTimer () => ToolTip(), -5000
}

F3:: { ; Farm SP: Start community event with a lot of destructable objects (e.g. 175 868 012). Use Subaru Impreza 22B with 9x multiplier.
    Global StopLoop := false
    currentLoop := 1
    static KeySleep := 1200 ; Tune delay for your PC if necessary
    Loop 100 {
        ; ToolTip "Farming Skill Points`nLoop #" . currentLoop
        currentLoop++
        if StopLoop
            break
            
        ; 1. Press Enter to confirm race start
        Send("{Enter}")
        Sleep(KeySleep*6)

        ; 2. Hold "W" to drive (adjust duration to match your event length)
        Send("{w down}")
        Sleep(24000) ; <========= Tune race time for your track. P.S. Even if set wrong, script will probably work.
        Send("{w up}")
        ; ToolTip "Race ended"
        Sleep(KeySleep*6)

        ; 3. Press Enter/X to skip post-race animations and restart
        ; ToolTip "Go to next race"
        Send("x")
        Sleep(KeySleep*2)
        Send("{Enter}")
        Sleep(KeySleep*6) ; Load start screen
    }
    
    ; ToolTip "Farming Skill Points finished"
}

; Note: disable Settings > HUD & Gameplay > HUD > What's Next = Off
F4:: { ; Farm CR in Rivals, The Colossus, R998 - Use car with CR boost like Wuling Sunshine FE. Start when driving in the freeroam.
    Global StopLoop := false
    static KeySleep := 1200 ; Tune delay for your PC if necessary
    currentLoop := 1
    Loop {
        ; ToolTip "Farming credits`nLoop #" . currentLoop
        currentLoop++
        If StopLoop
                break

        ; Enter the menu
        Send "{Esc}"
        Sleep(KeySleep)
        ; Enter the Rivals
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{Down}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        ; Colossus R998
        Sleep(KeySleep*3) ; Wait for track list
        Send "{Left}"
        Sleep(KeySleep)
        Send "{Left}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Left}"
        Sleep(KeySleep*3) ; Wait for details
        Send "{Enter}"
        Sleep(KeySleep*3) ; Wait for car list
        Send "Y"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Esc}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep*25) ; Race loading
        Send "{Enter}"
        Sleep(KeySleep*5)
        
        ; ToolTip "Turn on radio`nMay be skill points song is playing?"
        
        Loop 111 { ; 3 laps for Wuling Sunshine FE (~18 min 30 sec)
            If StopLoop
                break
            
            Send "{w down}"
            Sleep(10000)
            Send "{w up}"
            Send "x"
            Sleep(200)
            ; ToolTip()
        }
        
        ; Exit
        ; ToolTip "Restarting race..."
        Send "{Esc}"
        Sleep(KeySleep*3)
        Send "{Right}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep*3)
        Send "{Enter}"    
        Sleep(KeySleep*40) ; Exit to the street could take long due to season change
        Send("{w down}")
        Sleep(5000) 
        Send("{w up}")
        ; ToolTip()
    }
}

F5:: { ; Spend 990 SP farmed with F3. Start when driving in the freeroam.
    Global StopLoop := false
    static KeySleep := 1200 ; Tune delay for your PC if necessary
    SetKeyDelay 40, 40  ; Adds a 40ms press duration and delay
    currentLoop := 1
    Loop 33 {
        ; ToolTip "Spending Skill Points`nLoop #" . currentLoop
        currentLoop++
        If StopLoop
            break
        
        ; Enter the menu
        Send "{Esc}"
        Sleep(KeySleep)
        ; Enter the Autoshow
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{Left}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        ; ToolTip "Teleporting..."
        Sleep(KeySleep*10) ; Teleporting to the fest site
        Send "{Enter}"
        Sleep(KeySleep*3)
        ; Find Subaru 22B
        FilterTick := 0
        WinterOffset := 0
        if (GetForzaSeason() = "Winter") {
            WinterOffset += 2
        }

        ; ToolTip "Finding Subaru 22B..."
        Send "Y"
        Sleep(KeySleep)
        Loop 59 {
            ; Affordable + B + Retro Rally + Lenendary
            If (FilterTick = 0 || FilterTick = 6 + WinterOffset || FilterTick = 35 + WinterOffset || FilterTick = 55 + WinterOffset) {
                Send "{Enter}"
                Sleep(KeySleep/6)
            }

            FilterTick++
            Send "{Down}"
            Sleep(KeySleep/6)
        }
        
        ; Buy Subaru 22B
        Sleep(KeySleep)
        Send "{Esc}"
        Sleep(KeySleep)
        Send "{Enter}"
        ; ToolTip "Choosing livery"
        Sleep(KeySleep*10) ; Load designs

        ; Choose random livery (could be commented out)
        Loop Random(0, 6) {
            Send "{Right}"
            Sleep(KeySleep/6)
        }
        
        Loop Random(0, 2) {
            Send "{Down}"
            Sleep(KeySleep/6)
        }
        
        Loop Random(0, 6) {
            Send "{Left}"
            Sleep(KeySleep/6)
        }

        ; Purchase
        ; ToolTip "Purchase"
        Send "{Enter}"
        Send("{NumLock}")
        Sleep(KeySleep*15) ; Load design
        Send("{NumLock}")
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep*15) ; Saving content
        Send "{Esc}"
        Sleep(KeySleep)
        Send "{Esc}"
        Sleep(KeySleep)
        Sleep(KeySleep*5)
        
        ; ToolTip "Spend skill points"
        ; Enter the menu
        Send "{Esc}"
        Sleep(KeySleep)

        ; Spend Skill points
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{Down}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Right}"
        Sleep(KeySleep)
        Send "{Enter}"
        Loop 4 {
            Sleep(KeySleep)
            Send "{Up}"
            Sleep(KeySleep)
            Send "{Enter}"
        }
        
        Sleep(KeySleep)
        Send "{Left}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)

        ; Super Wheelspin
        Send "{Enter}"
        Sleep(KeySleep*3)
        Send "{Enter}"
        Sleep(KeySleep*6)
        Send "{Enter}" ; Additional ENTERs in case of winning duplicate car(s)
        Sleep(KeySleep*2)
        Send "{Enter}"
        Sleep(KeySleep*5)
        
        ; Return to the road
        Send "{Esc}"
        Sleep(KeySleep)
        Send "{Esc}"
        Sleep(KeySleep*7)
        Send("{NumLock}")
    }
}

F6:: { ; Send duplicated cars as a gift. Start near any barn.
    Global StopLoop := false
    static KeySleep := 1200 ; Tune delay for your PC if necessary
    SetKeyDelay 40, 40  ; Adds a 40ms press duration and delay
    currentLoop := 1

    duplicatedCars := 0 ; <=== Set how many duplicated cars do you have

    Loop duplicatedCars {
        ; ToolTip "Sending duplicates as a gift`nLoop #" . currentLoop
        currentLoop++
        If StopLoop
            break
        
        Send "{Enter}"
        Sleep(KeySleep)
        ; Find duplicates
        FilterTick := 0
        Send "Y"
        Sleep(KeySleep)

        WinterOffset := 0
        if (GetForzaSeason() = "Winter") {
            WinterOffset += 2
        }

        Loop 2 + WinterOffset {
            Send "{Down}"
            Sleep(KeySleep/6)
        }

        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Esc}"        
        Sleep(KeySleep)
        ; Send gift
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep*2)
        Send "{Enter}"
        Sleep(KeySleep*3)
        Send "{Enter}"
        Sleep(KeySleep*2)
        Send "{Esc}" ; We need to exit back to the street, otherwise we could sell last owned car
        Sleep(KeySleep*2)
    }
}

F7:: { ; Take photo of every your car. Start when driving in the freeroam.
    Global StopLoop := false
    static KeySleep := 1200 ; Tune delay for your PC if necessary
    SetKeyDelay 40, 40  ; Adds a 40ms press duration and delay

    cars := 620 ; Inputbox is not reliable - just set you car amount manually

    ;IB := InputBox("How many cars do you have?", "620", "w320 h240")
    ;if IB.Result = "Cancel"
    ;    Return
    ;else
    ;    cars := IB.value + 8
    ;Send "{Esc}"
    ;Sleep(5000)
        
    cars += 8 ; Safety margin 

    CurrentCol := 0
    CurrentRow := 0

    currentLoop := 1
    Loop cars { ; Change value
        ; ToolTip "Photoshoot`nLoop #" . currentLoop
        currentLoop++
        If StopLoop
            break
        
        ; Enter the menu
        Send "{Esc}"
        Sleep(KeySleep)
        ; Enter Cars list
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{Enter}"        
        Sleep(KeySleep)
        Send "X"
        Sleep(KeySleep)
        Send "{Down}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send("{PgUp down}")
        Sleep(3000) 
        Send("{PgUp up}")

        Loop CurrentCol {
            Send "{Right}"
            Sleep(KeySleep/6)
        }

        Loop CurrentRow {
            Send "{Down}"
            Sleep(KeySleep/6)
        }
        
        CurrentRow++
        if (CurrentRow >= 2) { ; 3 cars in every column
            CurrentRow := 0
            CurrentCol++
        }

        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep*10) ; Load street
        ; ToolTip "Say cheeeese"
        Send "P"
        Sleep(KeySleep*3) ; Load photo mode
        Send "P"
        Sleep(KeySleep*3)
        ; ToolTip()
        Send "{Esc}"        
        Sleep(KeySleep)
        Send "{Esc}"        
        Sleep(KeySleep)
        Send "{Enter}"        
        Sleep(KeySleep*10) ; Load street
        
        ; Uncomment if you want to spend SP on the first XP perk
        ; Farm maximum SP before you do this
        Send "{Esc}"
        Sleep(KeySleep)
        Send "{PgDn}"
        Sleep(KeySleep)
        Send "{Down}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}"
        Sleep(KeySleep)
        Send "{Enter}" ; Extra ENTER for unlock perk dialog
        ; ToolTip "Spent SP"
        Sleep(KeySleep)
        Send "{Esc}"
        Sleep(KeySleep)
        Send "{Esc}"
        Sleep(KeySleep*5)

        Send("{NumLock}")
    }
}

F8:: { ; Simple anti idle for Anna (C -> 2)
    SetTimer(SendAntiIdle, 60000)
}

F9:: {
    MsgBox("Season: " GetForzaSeason(), "Forza Horizon Season")
}

F11:: { ; Extended help
    Run "https://github.com/rossvs/khj_fh6_ahk2#hotkeys"
}

F12::ExitApp  ; Press F12 to abort the script


SendAntiIdle() {
    Send("=hhh")
    Send("{NumLock}")
}

GetForzaSeason() {
    AnchorTime := "20260702143000" ; Winter started
    Seasons := ["Winter", "Spring", "Summer", "Autumn"]
    CurrentTimeUTC := FormatTime(A_NowUTC, "yyyyMMddHHmmss")
    CurrentTimeUTC := DateAdd(CurrentTimeUTC, 0, "Seconds") ; init
    HoursDiff := DateDiff(CurrentTimeUTC, AnchorTime, "Hours")
    TotalWeeks := Floor(HoursDiff / 168) ; 168 hours in a week
    SeasonIndex := Mod(TotalWeeks, 4)

    return Seasons[SeasonIndex + 1]
}
