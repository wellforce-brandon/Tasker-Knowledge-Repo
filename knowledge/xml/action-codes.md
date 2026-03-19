# Action Codes
> Numeric action codes used in Tasker XML and their corresponding actions.

## Key Facts
- Every `<Action>` element in Tasker XML has a `<code>` child that identifies the action type
- There are **373 task action codes**, **82 profile event codes**, and **50 profile state codes**
- Using an incorrect code causes import failure: `"missing action of type <code>"`
- Plugin actions all use code **1000** with a `<Bundle>` for configuration
- Code table sourced from Tasker v5.15.5-beta (Taskomater/Tasker-XML-Info) -- newer actions may have higher codes

## Details

### Common Task Action Codes (Quick Reference)

| Code | Action | Code | Action |
|------|--------|------|--------|
| 20 | Launch App | 123 | Run Shell |
| 25 | Go Home | 126 | Return |
| 30 | Wait | 129 | JavaScriptlet |
| 37 | If | 130 | Perform Task |
| 38 | End If | 131 | JavaScript |
| 39 | For | 135 | Goto |
| 40 | End For | 137 | Stop |
| 43 | Else | 235 | Custom Setting |
| 46 | Create Scene | 339 | HTTP Request |
| 47 | Show Scene | 354 | Array Set |
| 59 | Reboot | 361 | Dark Mode |
| 61 | Vibrate | 366 | Get Location v2 |
| 90 | Call | 394 | Parse/Format DateTime |
| 105 | Set Clipboard | 547 | Variable Set |
| 109 | Set Wallpaper | 548 | Flash |
| 116 | HTTP Post | 549 | Variable Clear |
| 118 | HTTP Get | 559 | Say |
| 523 | Notify | 664 | Java Function |
| 877 | Send Intent | 1000 | Plugin |

### Full Task Action Codes (373 total)

| Code | Action | Code | Action | Code | Action |
|------|--------|------|--------|------|--------|
| 15 | Airplane Mode | 16 | Airplane Radios | 17 | Alarm Volume |
| 18 | Auto-Brightness | 19 | Auto-Sync | 20 | Launch App |
| 21 | Bluetooth | 22 | BT Voice Volume | 23 | Call Volume |
| 24 | Display Timeout | 25 | Go Home | 26 | Kill App |
| 27 | Media Volume | 28 | Notification Volume | 29 | Ringer Volume |
| 30 | Wait | 31 | WiFi | 32 | Silent Mode |
| 33 | WiFi Sleep Policy | 34 | System Volume | 35 | GPS |
| 36 | Notification Pulse | 37 | If | 38 | End If |
| 39 | For | 40 | End For | 41 | Mobile Data |
| 42 | Screen Brightness | 43 | Else | 44 | Stay On |
| 45 | Haptic Feedback | 46 | Create Scene | 47 | Show Scene |
| 48 | Hide Scene | 49 | Destroy Scene | 50 | Scene Element State |
| 51 | Element Size | 52 | Element Position | 53 | Element Visibility |
| 54 | Element Text | 55 | Element Image | 56 | Element Web Control |
| 57 | Element Value | 58 | Element Focus | 59 | Reboot |
| 60 | Accelerometer | 61 | Vibrate | 62 | Else If |
| 63 | Status Bar | 64 | Vibrate Pattern | 65 | Screen Rotation |
| 66 | Keyguard | 67 | Immersive Mode | 68 | Car Mode |
| 69 | Close System Dialogs | 70 | Keyboard | 71 | Keyguard Pattern |
| 72 | NFC | 73 | USB Tether | 74 | WiFi Tether |
| 75 | BT Tether | 76 | Set Alarm | 77 | Timer Widget |
| 78 | Torch | 79 | Do Not Disturb | 80 | Night Mode |
| 81 | Navigation Bar | 82 | Power Mode | 83 | Volume UI |
| 84 | Show Battery Info | 85 | Media Button Events | 86 | App Install |
| 87 | Pin App | 88 | Screen Off | 89 | WebView |
| 90 | Call | 91 | Call Block | 92 | Call Divert |
| 93 | Call Log | 94 | Call Revert | 95 | Compose Email |
| 96 | Compose MMS | 97 | Compose SMS | 98 | Contacts |
| 99 | End Call | 100 | Answer Call | 101 | Music Play |
| 102 | Music Play Dir | 103 | Music Stop | 104 | Music Back |
| 105 | Set Clipboard | 106 | Get Clipboard | 107 | Music Next |
| 108 | Music Track Info | 109 | Set Wallpaper | 110 | Read File |
| 111 | Write File | 112 | Read Line | 113 | List Files |
| 114 | Delete File | 115 | Browse URL | 116 | HTTP Post |
| 117 | Take Photo | 118 | HTTP Get | 119 | Load Image |
| 120 | Save Image | 121 | Crop Image | 122 | Resize Image |
| 123 | Run Shell | 124 | Rotate Image | 125 | Flip Image |
| 126 | Return | 127 | Wait Until | 128 | Copy File |
| 129 | JavaScriptlet | 130 | Perform Task | 131 | JavaScript |
| 132 | Create Dir | 133 | Delete Dir | 134 | Move |
| 135 | Goto | 136 | Profile Status | 137 | Stop |
| 138 | Encrypt File | 139 | Decrypt File | 140 | Read Paragraph |
| 141 | Zip | 142 | Unzip | 143 | GZip |
| 144 | GUnzip | 145 | Read Binary | 146 | Write Binary |
| 147 | Browse Files | 148 | Copy Dir | 149 | Send Data |
| 150 | Get Voice | 151 | ~~Deprecated~~ | 152 | Music Play State |
| 153 | Test File | 154 | Input Dialog | 155 | Lock |
| 156 | Variable Section | 157 | SQL Query | 158 | Open File |
| 159 | Test Element | 160 | Element Text Colour | 161 | Test Net |
| 162 | Array Pop | 163 | Array Push | 164 | Array Process |
| 165 | Alarm Sound | 166 | Notification Sound | 167 | Ringtone |
| 168 | Set Widget Icon | 169 | Set Widget Label | 170 | Settings |
| 200 | Accessibility Settings | 201 | App Info Settings | 202 | APN Settings |
| 203 | Bluetooth Settings | 204 | Date Settings | 205 | Development Settings |
| 206 | Display Settings | 207 | Input Settings | 208 | Locale Settings |
| 209 | Location Settings | 210 | Privacy Settings | 211 | Search Settings |
| 212 | Security Settings | 213 | Sound Settings | 214 | Storage Settings |
| 215 | WiFi Settings | 216 | Wireless Settings | 217 | Application Settings |
| 218 | Battery Settings | 219 | Quick Settings Panel | 220 | Sync Settings |
| 221 | WiFi IP Settings | 222 | NFC Settings | 223 | Memory Settings |
| 224 | Notification Settings | 225 | Usage Settings | 226 | Data Usage Settings |
| 227 | Do Not Disturb Settings | 228 | VPN Settings | 229 | Print Settings |
| 230 | Cast Settings | 231 | App Notification Settings | 232 | Assist Settings |
| 233 | Device Admin Settings | 234 | Ignore Battery Optimization | 235 | Custom Setting |
| 236 | Default Apps Settings | 237 | Developer Options | 238 | Channel Settings |
| 250 | Send SMS | 251 | Receive SMS | 252 | Audio Record |
| 253 | Audio Record Stop | 254 | Voice Call | 255 | DTMF Volume |
| 260 | Media Control | 261 | BT Connect | 262 | BT Disconnect |
| 263 | BT ID | 264 | BT Voice | 265 | BT Scan |
| 270 | Remount | 271 | Shell Command | 272 | Logcat Entry |
| 280 | Alarm Manager | 281 | Content Provider | 282 | Query Provider |
| 290 | Sound | 291 | Beep | 292 | Sound Pool |
| 293 | Sound File | 294 | Mic Mute | 295 | Speaker |
| 300 | Test App | 301 | Test Display | 302 | Test Phone |
| 303 | Test Scene | 304 | Test System | 305 | Test Variable |
| 306 | Test Tasker | 307 | Test Sensor | 308 | Test BT |
| 309 | Test Media | 310 | Test Network | 311 | Test Task |
| 330 | Permission Request | 331 | Open Map | 332 | Open Map Coords |
| 333 | Get Directions | 334 | Street View | 339 | HTTP Request |
| 340 | HTTP Auth | 341 | HTTP Head | 342 | MQTT |
| 350 | Array Set | 351 | Variable Add | 352 | Variable Subtract |
| 353 | Variable Multiply | 354 | Array Set | 355 | Variable Randomize |
| 356 | Variable Convert | 357 | Variable Search Replace | 358 | Variable Split |
| 359 | Variable Join | 360 | Variable Section | 361 | Dark Mode |
| 362 | Variable Query | 363 | Array Clear | 364 | Array Merge |
| 365 | Test Array | 366 | Get Location v2 | 367 | Get Sunrise/Sunset |
| 368 | Light Level | 369 | Magnetic Field | 370 | Proximity |
| 371 | Pressure | 372 | Humidity | 373 | Temperature |
| 374 | Step Counter | 375 | Significant Motion | 376 | Heart Rate |
| 380 | Dialog | 381 | Dialog List | 382 | Dialog Progress |
| 383 | Dialog Date/Time | 384 | Dialog Color | 385 | Dialog File |
| 386 | Dialog Slider | 387 | Dialog HTML | 388 | Dialog Text |
| 389 | Dialog Dismiss | 390 | Dialog Info | 391 | Pick Input Method |
| 392 | Text To Speech | 393 | Input Method Select | 394 | Parse/Format DateTime |
| 395 | Calendar Insert | 396 | Calendar Update | 397 | Calendar Delete |
| 398 | Calendar Query | 399 | Open Calendar | 400 | Read Settings |
| 401 | Write Settings | 410 | Tasker App Factory | 411 | ~~Deprecated~~ |
| 420 | File Observe | 421 | File Observe Stop | 430 | Content Changed |
| 440 | Close App | 441 | Force Stop | 442 | App Settings |
| 443 | Launch Activity | 444 | Launch Shortcut | 445 | Clear App Cache |
| 446 | Clear App Data | 450 | WiFi Scan | 451 | WiFi Forget |
| 460 | Mobile Data DUN | 461 | Data Connection | 462 | Data Roaming |
| 470 | Secure Setting | 471 | Global Setting | 472 | System Setting |
| 473 | ADB WiFi | 474 | Wireless ADB | 475 | USB Debugging |
| 476 | Mock Location | 490 | Torch Toggle | 491 | Torch On |
| 492 | Torch Off | 500 | ~~Deprecated~~ | 510 | ~~Deprecated~~ |
| 520 | ~~Deprecated~~ | 523 | Notify | 524 | Notify Cancel |
| 525 | Notify LED | 526 | Persistent Notification | 530 | ~~Deprecated~~ |
| 540 | ~~Deprecated~~ | 547 | Variable Set | 548 | Flash |
| 549 | Variable Clear | 550 | Popup | 551 | Menu |
| 552 | Popup Task Buttons | 553 | Pick Date | 554 | Pick Time |
| 555 | Pick Color | 556 | Pick File | 557 | ~~Deprecated~~ |
| 558 | Notify Vibrate | 559 | Say | 560 | Calendar |
| 570 | Media Scan | 571 | Scan Card | 580 | Take Screenshot |
| 590 | Tasker Info | 591 | Contact Info | 592 | Call Info |
| 593 | SMS Info | 594 | ~~Deprecated~~ | 595 | Battery Info |
| 596 | Device Info | 597 | App Info | 598 | Display Info |
| 599 | Network Info | 600 | Audio Info | 601 | Cell Info |
| 610 | Video Record | 611 | Video Record Stop | 620 | Screen Capture |
| 630 | Screen Filter | 640 | Scene Create | 641 | Scene Show |
| 642 | Scene Hide | 643 | Scene Destroy | 644 | Scene Snapshot |
| 660 | Java Object | 661 | Java Object (New) | 662 | Java Field (Get) |
| 663 | Java Field (Set) | 664 | Java Function | 665 | Java Function (Static) |
| 666 | Java Object (Array) | 667 | Java Object (Cast) | 668 | Java Object (Class) |
| 680 | SQL Open | 681 | SQL Close | 682 | SQL Execute |
| 690 | Input | 691 | Type | 692 | Button |
| 693 | Swipe | 694 | Long Click | 695 | Zoom |
| 696 | ~~Deprecated~~ | 700 | Display Brightness |
| 710 | Power Brightness | 720 | Wake Lock | 730 | CPU |
| 740 | Font Size | 750 | Animation Scale | 760 | Transition Scale |
| 770 | Window Scale | 777 | ~~Deprecated~~ | 800 | Profile Active |
| 810 | Task Running | 820 | Scene Created | 830 | Scene Showing |
| 840 | Scene Hidden | 850 | Element Created | 860 | Element Showing |
| 870 | Element Value Get | 876 | ~~Deprecated~~ | 877 | Send Intent |
| 878 | Receive Intent | 879 | Intent Actions | 880 | App Info Actions |
| 890 | Pick App | 900 | Location | 901 | Map Location |
| 902 | WiFi Location | 910 | Barcode Scan | 920 | Share |
| 930 | Set Shortcut | 940 | Wait For | 950 | Media Metadata |
| 960 | Set Key | 970 | ~~Does not exist~~ | 980 | Disable |
| 990 | Enable | 1000 | Plugin | | |

### Key Ranges Summary

| Range | General Category |
|-------|-----------------|
| 15-89 | System, Scenes, Toggles, Vibrate, Torch |
| 90-199 | Calls, Media, Files, Images, Settings, Arrays |
| 200-249 | Android Settings screens, Custom Setting |
| 250-340 | SMS, Audio, Bluetooth, Network, Tests, HTTP |
| 341-399 | HTTP, Arrays, Dialogs, Dark Mode, Location, Sensors, Calendar |
| 400-476 | File ops, App mgmt, WiFi, Mobile Data, ADB |
| 490-601 | Torch, Notifications, Variables, Popups, Say, Calendar, Info |
| 610-695 | Video, Screen, Java, SQL, Input |
| 700-990 | Display, Power, Profile/Task/Scene status, Intents, Location |
| 1000 | Plugin (all plugins share this code) |

### Profile Event Codes (82 total)

| Code | Event | Code | Event |
|------|-------|------|-------|
| 200 | Alarm Clock | 201 | Alarm Done |
| 202 | Date Set | 203 | Timezone Changed |
| 205 | Locale Changed | 206 | Screen Locked |
| 207 | Screen Unlocked | 208 | Display On |
| 209 | User Present | 210 | Display Off |
| 211 | Dreaming Started | 212 | Dreaming Stopped |
| 220 | Dock | 221 | Undock |
| 230 | Headset Plugged | 231 | Headset Unplugged |
| 240 | Volume Changed | 250 | Storage Low |
| 251 | Storage OK | 260 | Shutdown |
| 300 | Received Call | 301 | Missed Call |
| 302 | Outgoing Call | 303 | Incoming Call |
| 310 | SMS Received | 311 | MMS Received |
| 400 | Battery Changed | 401 | Power Connected |
| 402 | Power Disconnected | 410 | Boot Completed |
| 411 | Device Boot | 420 | Package Added |
| 421 | Package Removed | 422 | Package Replaced |
| 430 | Camera Button | 440 | Clipboard Changed |
| 450 | New Package | 451 | Package Changed |
| 460 | Wallpaper Changed | 461 | Notification |
| 462 | Notification Removed | 470 | WiFi Connected |
| 471 | WiFi Disconnected | 472 | WiFi Scan Results |
| 480 | BT Connected | 481 | BT Disconnected |
| 490 | NFC Tag | 500 | GPS Status Changed |
| 510 | Sensor Changed | 520 | Media Button |
| 530 | File Events | 540 | Content Changed |
| 550 | UI Mode Changed | 560 | Config Changed |
| 570 | Accessibility Event | 580 | Gesture |
| 590 | Notification Click | 591 | Notification Button |
| 599 | Intent Received | 600 | Logcat Entry |
| 610 | Task Finished | 620 | MQTT Message |
| 2050 | Quick Setting Clicked | 2055 | Quick Setting Long Clicked |
| 2060 | Shortcut | 2070 | App Changed |
| 2078 | App Changed | 2080 | Assist |
| 3000 | Tasker Error | 3050 | Variable Set |
| 3060 | Monitor Start | 3070 | Secondary Launch |

### Profile State Codes (50 total)

| Code | State | Code | State |
|------|-------|------|-------|
| 1 | Application | 2 | Time |
| 3 | BT Connected | 4 | BT Near |
| 5 | Calendar Entry | 6 | Cell Near |
| 7 | Day | 8 | Display State |
| 9 | Orientation | 10 | Power |
| 11 | Headset | 12 | Docked |
| 13 | Missed Call | 14 | Unread Text |
| 15 | Incoming Call | 16 | Outgoing Call |
| 20 | Location | 30 | Signal Strength |
| 40 | USB Connected | 50 | Audio Playing |
| 60 | Heart Rate | 70 | Steps Taken |
| 80 | Light Level | 90 | Proximity |
| 100 | Airplane Mode | 110 | Car Mode |
| 120 | Do Not Disturb | 130 | Dreaming |
| 140 | Battery Level | 150 | Mobile Network |
| 160 | Wifi Connected | 165 | Variable Value |
| 170 | Wifi Near | 175 | NFC Status |
| 180 | Keyboard Out | 185 | Notification |
| 188 | Dark Mode | 190 | Task Running |
| 195 | Profile Active | 200 | Sensor |
| 210 | Net Connected | 220 | Media Session |
| 230 | AutoInput UI State | 240 | Custom State |
| 250 | MQTT Connected | 260 | Logcat Entry |

### How Codes Map to Actions
Inside a task XML, the `<code>` element appears as a direct child of `<Action>`:

```xml
<Action sr="act0" ve="7">
    <code>123</code>
    <!-- action arguments follow -->
</Action>
```

### Discovering New Codes
1. Add the desired action to a task in the Tasker UI
2. Export the task (long-press task > Export > XML to Storage)
3. Open the `.tsk.xml` file and read the `<code>` value
4. Codes for newer actions (6.5+, 6.6+) may not be in the reference table yet

## Gotchas
- **Code 970 does not exist** -- caused import error `"missing action of type 970"` in testing
- **All plugins share code 1000** -- the actual plugin is identified by the `<Bundle>` contents, not the code
- **Deprecated codes exist** (151, 411, 500, 510, 520, 530, 540, 557, 594, 696, 777, 876) -- using them may cause unpredictable behavior
- **Set Wallpaper is code 109** (confirmed from Taskomater reference)
- **Custom Setting is code 235** -- use this instead of Run Shell for `settings put` commands (avoids error 255)

## Related
- [[task-xml-structure.md]] -- where action codes appear in XML
- [[tasks-and-actions.md]] -- what actions do at runtime
- [[import-export.md]] -- how to import/export XML files containing these codes
