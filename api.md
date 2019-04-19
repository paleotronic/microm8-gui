## API calls... 

## POST /api/control/window/position
* **Handler**: HandlePositionRequest
* **Purpose**:
  Set Window position and size.
* **Payload**:
  JSON:
  ``` 
  { 
      "x": number, 
      "y": number, 
      "w": number, 
      "h": number 
  }
  ```

## POST /api/control/input/keyevent
* **Handler**: HandleKeyRequest
* **Purpose**: Notify a keypress/release event.
* **Payload**:
  JSON:
  ``` 
  {
      "key": number,                // microM8 keycode
      "scancode": number,           // scancode (reserved)
      "action": number,             // 1 = Press, 0 = Release
      "modifier": number            // 1 = Shift, 2 = Ctrl, 4 = Alt
  }
  ```

## GET /api/control/window/hide
* **Handler**: HandleHideRequest
* **Purpose**: Hide microM8 window and suspend execution.
* **Payload**: _(none)_

## GET /api/control/window/show
* **Handler**: HandleShowRequest
* **Purpose**: Show microM8 window and resume execution.
* **Payload**: _(none)_

## GET /api/control/system/reboot
* **Handler**: HandleRebootRequest
* **Purpose**: Reboot the current VM.
* **Payload**: _(none)_

## POST /api/control/window/screen
* **Handler**: HandleScreenRequest
* **Purpose**: Write current screen in PNG to supplied filename.
* **Payload**:
  JSON:
  ``` 
  {
      "path": string,              // png file path
  }
  ```

## GET /api/control/window/focused
* **Handler**: HandleFocusedRequest
* **Purpose**: Return main window focus state.
* **Payload**: _(none)_
* **Returns**: 1 if focussed, 0 if not focussed.

## POST /api/control/hardware/disk/insert
* **Handler**: HandleDiskInsertRequest
* **Purpose**: Insert a disk image.
* **Payload**:
  JSON:
  ``` 
  {
      "path": string,              // disk image file path
      "drive": number              // drive number (0/1 = Disk II, 2 = SmartPort)
  }
  ```

## GET /api/control/hardware/disk/eject/{drive}
* **Handler**: HandleDiskEjectRequest
* **Purpose**: Eject disk in drive _{drive}_
* **Payload**: _(none)_

## GET /api/control/hardware/disk/blank/{drive}
* **Handler**: HandleDiskBlankRequest
* **Purpose**: Insert blank unformatted disk in drive _{drive}_ (0/1 only)
* **Payload**: _(none)_

## GET /api/control/system/catalog
* **Handler**: HandleCatalogRequest
* **Purpose**: Launch microM8 catalog function.
* **Payload**: _(none)_

## GET /api/control/interpreter/{name}
* **Handler**: HandleInterpRequest
* **Purpose**: Start microM8 interpreter _{name}_ in this VM.
* **Payload**: _(none)_

## GET /api/control/input/meta/key/{key}/value/{value}
* **Handler**: HandleMetaKeyRequest
* **Purpose**: Simulate a meta key combination (Eg. Ctrl+Shift+_{key}_, then _{value}_) 
* **Payload**: _(none)_

## POST /api/control/settings/update
* **Handler**: HandleSettingsUpdateRequest
* **Purpose**: Update (and optionally persist) a runtime setting.
* **Payload**:
  JSON:
  ``` 
  {
      "path": string,              // settings path: Eg. "current.fullscreen"
      "scope": string,             // settings scope: Eg. "video"
      "value": string,             // value
      "persist": number            // 0 = false, 1 = true (save to defaults)
  }
  ```

## POST /api/control/settings/get
* **Handler**: HandleSettingsFetchRequest
* **Purpose**: Get value of runtime setting.
* **Returns**: _value_.
* **Payload**:
  JSON:
  ``` 
  {
      "path": string,              // settings path: Eg. "current.fullscreen"
      "scope": string,             // settings scope: Eg. "video"
  }
  ```

## POST /api/control/input/mouseevent
* **Handler**: HandleMouseRequest
* **Purpose**: Update mouse position within window.
* **Payload**: 
  JSON:
  ``` 
  {
      "x": number,                  // x mouse position (relative to window)
      "y": number,                  // y mouse position (relative to window)
  }
  ```

## GET /api/control/hardware/disk/swap
* **Handler**: HandleDiskSwapRequest
* **Purpose**: Swap disks in drive 0 and drive 1.
* **Payload**: _(none)_

## GET /api/control/system/profile/set/{profile}
* **Handler**: HandleProfileSetRequest
* **Purpose**: Reboot VM into the specified system profile.
* **Payload**: _(none)_

## GET /api/control/system/profile/get
* **Handler**: HandleProfileGetRequest
* **Purpose**: Return current system profile.
* **Returns**: _profilename_
* **Payload**: _(none)_

## POST /api/control/system/freeze/restore
* **Handler**: HandleFreezeRestoreRequest
* **Purpose**: Restore VM state from a freeze state.
* **Payload**: 
  JSON:
  ``` 
  {
      "path": string,                  // freeze path
  }
  ```

## POST /api/control/system/freeze/save
* **Handler**: HandleFreezeSaveRequest
* **Purpose**: Save VM state to a freeze state.
* **Payload**:
  JSON:
  ``` 
  {
      "path": string,                  // freeze path
  }
  ```

## GET /api/control/recorder/{action}
* **Handler**: HandleRecordingRequest
* **Purpose**: Perform recorder _{action}_:-
```
start-file-recording  Begin file based recording.
start-live-recording  Begin memory based recording.
stop-recording        Stop recording.
rewind                Rewind recording.
play                  Forward recording.
resume                Resume execution.
```
* **Payload**: _(none)_

## GET /api/control/recorder
* **Handler**: HandleRecordingRequest
* **Purpose**: Return recorder state.
* **Returns**: 0 if not recording, 1 if live rewind enabled, 2 if file recording.
* **Payload**: _(none)_

## POST /api/control/system/launch
* **Handler**: HandleLaunchRequest
* **Purpose**: Launch a program or action.
* **Payload**:
  JSON:
  ``` 
  {
 	workingDir: string,     // Eg. /local
	disks      []string,    // floppy disks
	pakfile    string,      // microPak file
	smartport  string,      // smartport volume
	runfile    string,      // basic, shell or logo file
	runcommand string,      // basic, shell or logo command
	dialect    string       // dialect for runfile/runcommand
  }
  ```

## GET /api/control/quit
* **Handler**: HandleQuit
* **Purpose**: Stop microM8.
* **Payload**: _(none)_

## GET /api/control/health
* **Handler**: HandleAlive
* **Purpose**: Returns "ok" if microM8 responsive.
* **Payload**: _(none)_

## GET /api/control/audio/{channel}/{action}
* **Handler**: HandleAudioRequest
* **Purpose**: Perform _{action}_ on audio channel _{channel}_.
```
channel    One of "master" or "speaker". 
action     One of "up" or "down".
```
* **Payload**: _(none)_

## GET /api/control/cpu/warp/{action}
* **Handler**: HandleCPURequest
* **Purpose**: Perform _{action}_ on CPU warp level.
```
action     One of "up" or "down".
```
* **Payload**: _(none)_

## GET /api/control/pause
* **Handler**: HandlePauseRequest
* **Purpose**: Toggle VM Paused state.
* **Payload**: _(none)_

## GET /api/control/mouse/buttonstate
* **Handler**: HandleMBRequest
* **Purpose**: Read mousebutton state.
* **Returns**: 0 = none, 1 = left, 2 = right, 4 = middle
* **Payload**: _(none)_

## GET /api/control/mouse/buttonstate/{state}
* **Handler**: HandleMBRequest
* **Purpose**: Set mouse button state to _{state}_.
```
0 = none
1 = left
2 = right
4 = middle
```
* **Payload**: _(none)_

## GET /api/control/vm
* **Handler**: HandleVMRequest
* **Purpose**: Get the current vm number (1-8).
* **Returns**: 1-8
* **Payload**: _(none)_

## GET /api/control/vm/{vm}
* **Handler**: HandleVMRequest
* **Purpose**: Set the current VM number (1-8)
* **Payload**: _(none)_

## GET /api/control/system/help
* **Handler**: HandleHelpRequest
* **Purpose**: Launch help system.
* **Payload**: _(none)_

## GET /api/control/window/screenshot
* **Handler**: HandleShotRequest
* **Purpose**: Take a screenshot.
* **Payload**: _(none)_

## GET /api/control/hardware/disk/wp/{drive}
* **Handler**: HandleDiskWPRequest
* **Purpose**: Read write protect state of _{drive}_.
* **Returns**: 0 = not write protected, 1 = write protected
* **Payload**: _(none)_

## GET /api/control/hardware/disk/wp/{drive}/{verb}
* **Handler**: HandleDiskWPRequest
* **Purpose**: Perform _{verb}_ on drives write protect state.
```
toggle    Toggles write protect.
```
* **Returns**: 0 = not write protected, 1 = write protected
* **Payload**: _(none)_

## POST /api/control/paste
* **Handler**: HandlePasteRequest
* **Purpose**: Paste text into VM.
* **Payload**: TEXT

## GET /api/control/memory/read/{address}
* **Handler**: HandleMemoryReadRequest
* **Purpose**: Read value from VM memory _{address}_
* **Returns**: _value_
* **Payload**: _(none)_

## GET /api/control/memory/write/{address}/{value}
* **Handler**: HandleMemoryWriteRequest
* **Purpose**: Write _{value}_ to VM memory _{address}_
* **Payload**: _(none)_

## GET /api/control/memory/screen/text
* **Handler**: HandleTextScreenRequest
* **Purpose**: Returns content of active text screen.
* **Payload**: _(none)_

## POST /api/control/osd/send
* **Handler**: HandleOSDRequest
* **Purpose**: Send OSD message.
* **Payload**: TEXT

## GET /api/control/system/camera/{action}
* **Handler**: HandleCameraRequest
* **Purpose**: Perform action _{action}_ on camera.
```
reset   Reset camera to defaults.
```
* **Payload**: _(none)_

## GET /api/control/mouse/buttonclick
* **Handler**: HandleButtonClickRequest
* **Purpose**: Simulate a left mouse button press and release.
* **Payload**: _(none)_


