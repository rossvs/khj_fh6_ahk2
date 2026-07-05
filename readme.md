# Forza Horizon 6 AutoHotKey v2 script

## Warnings

+ Using automation scripts could violate game's EULA
+ The script only simulates button presses without screen feedback. This is a highly fragile method.
+ Tested on version 379.939 (July 2026). Future game updates may break these button sequences.
+ No support is provided - feel free to copy and edit it to suit your needs.
+  If the script behaves unexpectedly in-game, press F12 to exit immediately.

## Installation

This script is for [AutoHotKey](https://www.autohotkey.com/) software. You need to download the v2.0 version.\
Once AutoHotkey is installed, launch the script by double-clicking the file.

## Hotkeys

**F1** Show brief help

**F11** Show this help

**F12** Exit

**F2** Stop actions F3-F7 (after current cycle finishes)

**F3 Farm Skill Points**
+ Start community event with a lot of destructible objects: `Creative Hub > Event Lab > Play Event`
+ Event `175 868 012` is recommended; use `Backspace (Search)` and enter the code
+ Choose Solo
+ Use _Subaru Impreza 22B_ with previously  opened 9x multiplier
+ (For some other events, you may need to enable _Auto-Steering_ in Difficulty settings)
+ When the screen with _Start Race Event_ button is loaded, move your mouse cursor to a corner of the screen (so it does not interfere with UI buttons)
+ Press F3
+ AHK will play and restart the race 100 times, which earns 999 SP in ~1.5 hours

Note: if you use some other event, edit race time to match race duration.

**F4 Farm Credits**
+ Disable _What's Next_, if it is enabled: `Settings > HUD & Gameplay > HUD > What's Next = Off`
+ Set difficulty: `Settings > Difficulty`
  + `Braking: Assisted` 
  + `Steering: Auto-Steering` 
  + `Shifting: Automatic`
  + `Traction Control` and `Stability Control` could be set to `Off` to earn more CR
+ Script uses the first listed favourite R998 car in your possession. A car with CR boost like _Wuling Sunshine FE_ is recommended. Mark it as favourite.
+ Start while you are driving in the freeroam (any location)
+ Move your mouse cursor to a corner of the screen (so it does not interfere with UI buttons)
+ Press F4
+ AHK will automatically choose `Rivals > Colossus > R998`, drive 3 loops and then restart race - which earns ~450000 CR per hour + some SP
+ Procedure is looping indefinetely

**F5 Spend Skill Points on Super Wheel Spin**
+ Start while you are driving in the freeroam (any location)
+ Though generally Super Wheel Spin gives CR too, you need some spare cash to buy Impreza - make sure you have 500k at least
+ Move your mouse cursor to a corner of the screen (so it does not interfere with UI buttons)
+ Press F5
+ AHK will automatically buy _Subaru Impreza 22B_ and open _Super Wheel Spin_ perk
+ Process repeats 33 times to spend 990 SP

**F6 Send duplicated cars as a gift**
+ Set `duplicatedCars` variable to the amount you want send
+ Start while you are driving near any barn: when `[Enter] Send gift` shows up
+ You must drive the car that is <ins>not</ins> a duplicate
+ Press F6
+ AHK will automatically send your duplicated car as a gift to anyone
+ Process repeats 50 times

**F7 Photoshoot all your cars** to earn Horizon (H) points
+ Start while you are driving in the freeroam (any location)
+ Move your mouse cursor to a corner of the screen (so it does not interfere with UI buttons)
+ Press F7
+ AHK will automatically loop through your cars and take a picture in photo mode
+ By default, Process repeats 620 times and takes a while. It is recommended to set `cars` variable to match your car quantity.

**F8** Anti-idle for Anna autopilot (switches radio station every minute)


## Debugging

This script was tested on a mid-range PC (Intel Core i7, DDR4, RTX 4070). If you have an older PC with longer loading times, you might experience instability.

If script behaves erratically, try the following:
+ Increase `KeySleep` variable value - it controls the baseline delay between actions.\
+ Uncomment the `ToolTip` commands in the code to display real-time status updates on your screen.


## Compiling to Exe

Optionally, you can complile a portable exe-version with [Ahk2Exe](https://github.com/AutoHotkey/Ahk2Exe/releases).\
Choose your AutoHotkey32.exe or AutoHotkey64.exe in _Base File_ input, kji_fh6_farm.ahk in _Source_ and press _Convert_.

## My shared events

If you want to thank the author, try some of my shared events:

+ `341 756 168` Small Honda C-class rally
+ `136 347 490` Total AWD S1 31 miles rally with jumps (East)
+ `834 176 178` Total AWD S1 39 miles rally with jumps (West)
+ `153 510 921` Tokyo D-class low-speed leisure trip, 16 miles
+ `860 068 697` Classic muscle car rally with hill climb, 11 miles