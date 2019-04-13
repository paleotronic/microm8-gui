unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, StdCtrls, fphttpclient, LCLType, Buttons, AsyncProcess, DateUtils,
{$IFDEF WINDOWS}
  Windows,
{$ENDIF}
  Sockets, StrUtils
  ;

type

  TMouseBtnType = (mbtLeft, mbtMiddle, mbtRight);


  { TGUIForm }

  TGUIForm = class(TForm)
    MenuItem14: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    miVideoScreenshot: TMenuItem;
    N10: TMenuItem;
    miPMApple2plus: TMenuItem;
    miPMApple2e: TMenuItem;
    miPMApple2eEnhCPM: TMenuItem;
    miPMApple2eEnh: TMenuItem;
    miStartLiveRewindRecord: TMenuItem;
    miStartDiskRec: TMenuItem;
    miMMHelp: TMenuItem;
    miHelp: TMenuItem;
    miVM8: TMenuItem;
    miVM7: TMenuItem;
    miVM6: TMenuItem;
    miVM5: TMenuItem;
    miVM4: TMenuItem;
    miVM3: TMenuItem;
    miVM2: TMenuItem;
    miVM1: TMenuItem;
    miVM: TMenuItem;
    miApps816Paint: TMenuItem;
    miAppsPrintShop: TMenuItem;
    miAppsTerminal: TMenuItem;
    miToolsWebDebugger: TMenuItem;
    miToolsTracker: TMenuItem;
    miTools: TMenuItem;
    miApps: TMenuItem;
    miRECDisableSlowRew: TMenuItem;
    miRECAutoLiveRewind: TMenuItem;
    N9: TMenuItem;
    miRECResume: TMenuItem;
    miRECPlay: TMenuItem;
    miRECRewind: TMenuItem;
    N8: TMenuItem;
    miRECLiveRewind: TMenuItem;
    miRECStop: TMenuItem;
    miRECStartFile: TMenuItem;
    miVCR: TMenuItem;
    miSaveFreeze: TMenuItem;
    miOpenFreeze: TMenuItem;
    N7: TMenuItem;
    N6: TMenuItem;
    miPRFIIplus: TMenuItem;
    miPRFIIe: TMenuItem;
    miPRFIIeEnhancedSoftcard: TMenuItem;
    miPRFIIeEnhanced: TMenuItem;
    miProfiles: TMenuItem;
    N5: TMenuItem;
    MicroM8Process: TAsyncProcess;
    backdrop: TImage;
    Image1: TImage;
    odFreezeFiles: TOpenDialog;
    pnlContainer: TPanel;
    ProfileMenu: TPopupMenu;
    RecordingMenu: TPopupMenu;
    sdFreezeFiles: TSaveDialog;
    SideImages: TImageList;
    miWarp400: TMenuItem;
    miWarp200: TMenuItem;
    miWarp100: TMenuItem;
    miWarp50: TMenuItem;
    miWarp25: TMenuItem;
    miCPU65c02: TMenuItem;
    miCPU6502: TMenuItem;
    miDisksSwap: TMenuItem;
    miDisksDisableWarp: TMenuItem;
    miDisksConvertWOZ: TMenuItem;
    miPDFTO60s: TMenuItem;
    miPDFTO45s: TMenuItem;
    miPDFTO30s: TMenuItem;
    miPDFTO15s: TMenuItem;
    miPDFTO5s: TMenuItem;
    miPrinterPDF: TMenuItem;
    miCPUWarp: TMenuItem;
    miCPUType: TMenuItem;
    miSerialTelnetServer: TMenuItem;
    miSerialVModem: TMenuItem;
    miDisks: TMenuItem;
    miPrinter: TMenuItem;
    miCPU: TMenuItem;
    miSerial: TMenuItem;
    miHardware: TMenuItem;
    miSVOL100: TMenuItem;
    miSVOL090: TMenuItem;
    miSVOL080: TMenuItem;
    miSVOL070: TMenuItem;
    miSVOL060: TMenuItem;
    miSVOL050: TMenuItem;
    miSVOL040: TMenuItem;
    miSVOL030: TMenuItem;
    miSVOL020: TMenuItem;
    miSVOL010: TMenuItem;
    miSVOL000: TMenuItem;
    miMVOL100: TMenuItem;
    miMVOL090: TMenuItem;
    miMVOL080: TMenuItem;
    miMVOL070: TMenuItem;
    miMVOL060: TMenuItem;
    miMVOL050: TMenuItem;
    miMVOL040: TMenuItem;
    miMVOL030: TMenuItem;
    miMVOL020: TMenuItem;
    miMVOL010: TMenuItem;
    miMVOL000: TMenuItem;
    miPSG0p100: TMenuItem;
    miPSG0p75: TMenuItem;
    miPSG0p50: TMenuItem;
    miPSG0p25: TMenuItem;
    miPSG0p0: TMenuItem;
    miPSG0m25: TMenuItem;
    miPSG0m50: TMenuItem;
    miPSG0m75: TMenuItem;
    miPSG0m100: TMenuItem;
    miSNDPSG0: TMenuItem;
    miPSG1p100: TMenuItem;
    miPSG1p75: TMenuItem;
    miPSG1p50: TMenuItem;
    miPSG1p25: TMenuItem;
    miPSG1p0: TMenuItem;
    miPSG1m25: TMenuItem;
    miPSG1m50: TMenuItem;
    miPSG1m75: TMenuItem;
    miPSG1m100: TMenuItem;
    miSNDPSG1: TMenuItem;
    miSNDMockingboard: TMenuItem;
    miSNDSpeaker: TMenuItem;
    miSNDMaster: TMenuItem;
    miSNDMuted: TMenuItem;
    miAudio: TMenuItem;
    miJSYRev: TMenuItem;
    miJSXRev: TMenuItem;
    miJSAxisSwap: TMenuItem;
    miVD9: TMenuItem;
    miVD8: TMenuItem;
    miVD7: TMenuItem;
    miVD6: TMenuItem;
    miVD5: TMenuItem;
    miVD4: TMenuItem;
    miVD3: TMenuItem;
    miVD2: TMenuItem;
    miVD1: TMenuItem;
    miVD: TMenuItem;
    miAR178: TMenuItem;
    miAR162: TMenuItem;
    miAR146: TMenuItem;
    miAR100: TMenuItem;
    miAR133: TMenuItem;
    miAR: TMenuItem;
    miTMAmber: TMenuItem;
    miTMGreen: TMenuItem;
    miTMGrey: TMenuItem;
    miTMNone: TMenuItem;
    miTintMode: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    miTintOff: TMenuItem;
    miTintGrey: TMenuItem;
    miTintGreen: TMenuItem;
    miTintAmber: TMenuItem;
    sidecarPanel: TPanel;
    FSTimer: TTimer;
    tbVolDown: TToolButton;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    tbJoystickAxisSwitch: TToolButton;
    tbCapsMode: TToolButton;
    tbScanlines: TToolButton;
    tbWebDebugger: TToolButton;
    ToolButton15: TToolButton;
    tbSpeedDown: TToolButton;
    tbSpeedUp: TToolButton;
    ToolButton18: TToolButton;
    tbVolUp: TToolButton;
    tbFullscreen: TToolButton;
    ToolButton3: TToolButton;
    tbRECState: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolTimer: TTimer;
    TintMode: TPopupMenu;
    ToolbarIcons: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    miDHGREN: TMenuItem;
    Input: TMenuItem;
    miINPMMOff: TMenuItem;
    miINPMMDDraw: TMenuItem;
    miINPMMGEOS: TMenuItem;
    miINPMMDPAD: TMenuItem;
    miINPMMJoystick: TMenuItem;
    miINPJoystick: TMenuItem;
    miINPAllCaps: TMenuItem;
    miINPMouseMode: TMenuItem;
    miDHREMAuto: TMenuItem;
    miDHREMOn: TMenuItem;
    miDHREMOff: TMenuItem;
    N1: TMenuItem;
    miSHRColorRaster: TMenuItem;
    miSHRColorVoxels: TMenuItem;
    miSHRColorDots: TMenuItem;
    miSHR: TMenuItem;
    miDHRMonoRaster: TMenuItem;
    miDHRMonoVoxels: TMenuItem;
    miDHRMonoDots: TMenuItem;
    miDHRColorRaster: TMenuItem;
    miDHRColorVoxels: TMenuItem;
    miDHRColorDots: TMenuItem;
    miMonoRaster: TMenuItem;
    miMonoVoxels: TMenuItem;
    miMonoDots: TMenuItem;
    miColorRaster: TMenuItem;
    miColorVoxels: TMenuItem;
    miColorDots: TMenuItem;
    miGRVoxels: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    miGRRaster: TMenuItem;
    miGRRenderMode: TMenuItem;
    miSLI9: TMenuItem;
    miSLI8: TMenuItem;
    miSLI7: TMenuItem;
    miSLI6: TMenuItem;
    miSLI5: TMenuItem;
    miSLI4: TMenuItem;
    miSLI3: TMenuItem;
    miSLI2: TMenuItem;
    miSLI1: TMenuItem;
    miSLI0: TMenuItem;
    miScanLineInt: TMenuItem;
    miVideo: TMenuItem;
    miIntLOGO: TMenuItem;
    miIntINT: TMenuItem;
    miIntFP: TMenuItem;
    MenuItem2: TMenuItem;
    embedPanel: TPanel;
    MenuItem3: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    miSPEject: TMenuItem;
    miSPFile: TMenuItem;
    miFileCat: TMenuItem;
    miD2File: TMenuItem;
    miD1File: TMenuItem;
    menuRebootVM: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    miD1Blank: TMenuItem;
    miD2Blank: TMenuItem;
    DiskMenu: TPopupMenu;
    odDiskImages: TOpenDialog;
    StatusBar1: TStatusBar;
    httpc: TFPHttpClient;
    CheckTimer: TTimer;
    MouseTimer: TTimer;
    ToolBar1: TToolBar;
    tbTintMode: TToolButton;
    tbRMVoxels: TToolButton;
    tbRMDots: TToolButton;
    tbRMRaster: TToolButton;
    tbRMColor: TToolButton;
    tbMasterVolume: TTrackBar;
    TrackBar2: TTrackBar;
    procedure backdropClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckTimerTimer(Sender: TObject);
    procedure DiskMenuClose(Sender: TObject);
    procedure DiskMenuPopup(Sender: TObject);
  //  procedure FormActivate(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure FormWindowStateChange(Sender: TObject);
    procedure FSTimerTimer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Image1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InputClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
   // procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Freeze;
    procedure miApps816PaintClick(Sender: TObject);
    procedure miAppsPrintShopClick(Sender: TObject);
    procedure miAppsTerminalClick(Sender: TObject);
    procedure miAR100Click(Sender: TObject);
    procedure miARClick(Sender: TObject);
    procedure miAudioClick(Sender: TObject);
    procedure miColorDotsClick(Sender: TObject);
    procedure miColorRasterClick(Sender: TObject);
    procedure miColorVoxelsClick(Sender: TObject);
    procedure miCPU6502Click(Sender: TObject);
    procedure miCPUTypeClick(Sender: TObject);
    procedure miCPUWarpClick(Sender: TObject);
    procedure miD1BlankClick(Sender: TObject);
    procedure miD1FileClick(Sender: TObject);
    procedure miD2BlankClick(Sender: TObject);
    procedure miD2FileClick(Sender: TObject);
    procedure miDHGRENClick(Sender: TObject);
    procedure miDHRColorDotsClick(Sender: TObject);
    procedure miDHRColorRasterClick(Sender: TObject);
    procedure miDHRColorVoxelsClick(Sender: TObject);
    procedure miDHREMAutoClick(Sender: TObject);
    procedure miDHREMOffClick(Sender: TObject);
    procedure miDHREMOnClick(Sender: TObject);
    procedure miDHRMonoDotsClick(Sender: TObject);
    procedure miDHRMonoRasterClick(Sender: TObject);
    procedure miDHRMonoVoxelsClick(Sender: TObject);
    procedure miDisksClick(Sender: TObject);
    procedure miDisksConvertWOZClick(Sender: TObject);
    procedure miDisksDisableWarpClick(Sender: TObject);
    procedure miDisksSwapClick(Sender: TObject);
    procedure miFileCatClick(Sender: TObject);
    procedure miGRRasterClick(Sender: TObject);
    procedure miGRRenderModeClick(Sender: TObject);
    procedure miGRVoxelsClick(Sender: TObject);
    procedure miINPAllCapsClick(Sender: TObject);
    procedure miINPJoystickClick(Sender: TObject);
    procedure miINPMMDDrawClick(Sender: TObject);
    procedure miINPMMDPADClick(Sender: TObject);
    procedure miINPMMGEOSClick(Sender: TObject);
    procedure miINPMMJoystickClick(Sender: TObject);
    procedure miINPMMOffClick(Sender: TObject);
    procedure miINPMouseModeClick(Sender: TObject);
    procedure miINPMouseModeDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure miIntFPClick(Sender: TObject);
    procedure miIntINTClick(Sender: TObject);
    procedure miIntLOGOClick(Sender: TObject);
    procedure miJSAxisSwapClick(Sender: TObject);
    procedure miJSXRevClick(Sender: TObject);
    procedure miJSYRevClick(Sender: TObject);
    procedure miMMHelpClick(Sender: TObject);
    procedure miMonoDotsClick(Sender: TObject);
    procedure miMonoRasterClick(Sender: TObject);
    procedure miMonoVoxelsClick(Sender: TObject);
    procedure miMVOL000Click(Sender: TObject);
    procedure miOpenFreezeClick(Sender: TObject);
    procedure miPDFTO5sClick(Sender: TObject);
    procedure miPRFIIeClick(Sender: TObject);
    procedure miPRFIIeEnhancedClick(Sender: TObject);
    procedure miPRFIIeEnhancedSoftcardClick(Sender: TObject);
    procedure miPRFIIplusClick(Sender: TObject);
    procedure miPrinterPDFClick(Sender: TObject);
    procedure miProfilesClick(Sender: TObject);
    procedure miPSG0m100Click(Sender: TObject);
    procedure miPSG1m100Click(Sender: TObject);
    procedure miRECAutoLiveRewindClick(Sender: TObject);
    procedure miRECDisableSlowRewClick(Sender: TObject);
    procedure miRECLiveRewindClick(Sender: TObject);
    procedure miRECPlayClick(Sender: TObject);
    procedure miRECResumeClick(Sender: TObject);
    procedure miRECRewindClick(Sender: TObject);
    procedure miRECStartFileClick(Sender: TObject);
    procedure miRECStopClick(Sender: TObject);
    procedure miSaveFreezeClick(Sender: TObject);
    procedure miScanLineIntClick(Sender: TObject);
    procedure miSerialClick(Sender: TObject);
    procedure miSerialVModemClick(Sender: TObject);
    procedure miSHRClick(Sender: TObject);
    procedure miSHRColorDotsClick(Sender: TObject);
    procedure miSHRColorRasterClick(Sender: TObject);
    procedure miSHRColorVoxelsClick(Sender: TObject);
    procedure miSLIClick(Sender: TObject);
    procedure miSNDMasterClick(Sender: TObject);
    procedure miSNDMutedClick(Sender: TObject);
    procedure miSNDPSG0Click(Sender: TObject);
    procedure miSNDPSG1Click(Sender: TObject);
    procedure miSNDSpeakerClick(Sender: TObject);
    procedure miSPEjectClick(Sender: TObject);
    procedure miSPFileClick(Sender: TObject);
    procedure miSVOL000Click(Sender: TObject);
    procedure miTintModeClick(Sender: TObject);
    procedure miTMNoneClick(Sender: TObject);
    procedure miToolsClick(Sender: TObject);
    procedure miToolsTrackerClick(Sender: TObject);
    procedure miToolsWebDebuggerClick(Sender: TObject);
    procedure miVCRClick(Sender: TObject);
    procedure miVD1Click(Sender: TObject);
    procedure miVDClick(Sender: TObject);
    procedure miVideoScreenshotClick(Sender: TObject);
    procedure miVM1Click(Sender: TObject);
    procedure miVMClick(Sender: TObject);
    procedure miWarp25Click(Sender: TObject);
    procedure MouseTimerTimer(Sender: TObject);
    procedure sidecarPanelResize(Sender: TObject);
    procedure tbCapsModeClick(Sender: TObject);
    procedure tbFullscreenClick(Sender: TObject);
    procedure tbJoystickAxisSwitchClick(Sender: TObject);
    procedure tbRMClick(Sender: TObject);
    procedure tbRMColorClick(Sender: TObject);
    procedure tbScanlinesClick(Sender: TObject);
    procedure tbSpeedDownClick(Sender: TObject);
    procedure tbSpeedUpClick(Sender: TObject);
    procedure tbTintModeClick(Sender: TObject);
    procedure tbVolDownClick(Sender: TObject);
    procedure tbVolUpClick(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolTimerTimer(Sender: TObject);
    procedure tbMasterVolumeChange(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure UpdateRenderMode;
    procedure UnFreeze;
    procedure HideM8;
    procedure menuRebootVMClick(Sender: TObject);
    procedure ShowM8;
    procedure RebootVM;
    procedure ReposWindow;
    procedure RepaintWindow;
    procedure UpdateColorMode;
    procedure UpdateTintMode;
    function SimpleGet(url:String): string;
    procedure LaunchDisk(disk: string);
    procedure LaunchCommand(dialect: string; path: string; command: string);
    procedure SimpleFormPost(url: String; body: string; var resp: TStringStream);
    procedure SimpleGetStream(url:string; var S: TMemoryStream);
    function GetTitleOfActiveWindow: string;
    procedure SendKey(key: Integer; ScanCode: Integer; KeyAction: Integer; Mods: Integer);
    procedure tbDisk1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbDisk2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton5Click(Sender: TObject);
    procedure InsertDisk(Filename: string; Drive: integer);
    procedure UpdateConfig(path: string; value: string; persist: boolean);
    function GetConfig(path: string): string;
    procedure SendMouseState(x, y: longint);
    procedure BootFreeze(Filename: string);
    procedure SaveFreeze(Filename: string);
    procedure LaunchSP(disk: string);
    procedure UpdateJoystickAxis;
    procedure UpdateVolSlider;
    procedure UpdateWarpSlider;
    procedure UpdateAllCaps;
    procedure UpdateScanlines;
    procedure UpdateRecordState;
    function  IsMouseBtnDown(const AMouseBtn: TMouseBtnType): Boolean;
    function  IsMouseBtnDown: Boolean;
  private
    lx, ly, lw, lh: integer;
    lastShowTime: TDateTime;
    lastHideTime: TDateTime;
    hidden: boolean;
    lastMouseX, lastMouseY: longint;
    inPopup: boolean;
    isFS: boolean;
  public
    procedure AppActivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    constructor Create(TheOwner: TComponent); override;

  end;

var
  GUIForm: TGUIForm;

implementation

const
  baseUrl: string = 'http://localhost:38911';

{$R *.lfm}

{ TGUIForm }

const
  MOUSE_BTN_VKEYS: Array [TMouseBtnType] of Integer = (VK_LBUTTON, VK_MBUTTON, VK_RBUTTON);

(* This function returns true when the specified mouse button is pressed *)
{$IFDEF WINDOWS}
function TGUIForm.IsMouseBtnDown(const AMouseBtn: TMouseBtnType): Boolean;
begin
  Result := GetAsyncKeyState(MOUSE_BTN_VKEYS[AMouseBtn])
            AND $8000 <> 0;
end;
{$ELSE}
function TGUIForm.IsMouseBtnDown(const AMouseBtn: TMouseBtnType): Boolean;
var
  mstate: integer;
  s: string;
begin
  s := GetConfig( baseUrl+'/api/control/mouse/buttonstate' );
  mstate := StrToInt( s );
  result := (mstate and integer(AMouseBtn)) <> 0;
end;
{$ENDIF}

(* This function returns true when any of the mouse button is pressed *)
{$IFDEF WINDOWS}
function TGUIForm.IsMouseBtnDown: Boolean;
begin
  Result := (GetAsyncKeyState(VK_LBUTTON)
             OR GetAsyncKeyState(VK_MBUTTON)
             OR GetAsyncKeyState(VK_RBUTTON)
             )
            AND $8000 <> 0;
end;
{$ELSE}
function TGUIForm.IsMouseBtnDown: Boolean;
var
  mstate: integer;
begin
  mstate := StrToInt( GetConfig( baseUrl+'/api/control/mouse/buttonstate' ) );
  result := mstate <> 0;
end;
{$ENDIF}

constructor TGUIForm.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  Application.OnDeactivate:=@AppDeactivate;
  Application.OnActivate:=@AppActivate;
end;

procedure TGUIForm.AppActivate(Sender: TObject);
begin
     //StatusBar1.SimpleText := 'App has gained focus!';
     if MillisecondsBetween(Now(), lastHideTime) < 1000 then
      exit;
     ShowM8;
     //Memo1.Lines.Add('app is activating');
end;

procedure TGUIForm.AppDeactivate(Sender: TObject);
begin
     // if we have deactivated because of a click on the main window
     // then sort it...
     if MillisecondsBetween(Now(), lastShowTime) < 1000 then
      exit;

     RepaintWindow;
     if GetTitleOfActiveWindow <> 'microM8' then
        HideM8;
     //StatusBar1.SimpleText := GetTitleOfActiveWindow;
     //Memo1.Lines.Add('app is deactivating');
end;

procedure TGUIForm.RebootVM;
begin
       SimpleGet(baseUrl + '/api/control/system/reboot');
end;

procedure TGUIForm.Image1Click(Sender: TObject);
begin
     //
end;

procedure TGUIForm.Image1DblClick(Sender: TObject);
begin
     //
end;

procedure TGUIForm.Image1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  // cheese biscuits
end;

procedure TGUIForm.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      // nothing much
end;

procedure TGUIForm.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p, q: TPoint;
  py, bi: integer;
begin
     if inPopup then
        exit;

     //p := TPoint.create(0,0);
     //q := sidecarPanel.ClientToScreen(p);
     //py := (Mouse.CursorPos.Y - q.Y);
     if (y >= 0) and (y < sideCarPanel.Height) then
     begin
         bi := y div Round(sideCarPanel.Height / 5);
         //StatusBar1.SimpleText := IntToStr(bi);
         Image1.PopupMenu := nil;
           case bi of
           0: begin
                      if Button = mbRight then
                      begin
                        DiskMenu.Tag := 0;
                        DiskMenu.PopUp;
                      end
                      else
                      begin
                             RepaintWindow;
                             HideM8;
                             if odDiskImages.Execute then
                             begin
                                  InsertDisk( 'local:'+odDiskImages.Filename, 0 );
                             end;
                             ShowM8;
                      end;
           end;
           1: begin
                      if Button = mbRight then
                      begin
                        DiskMenu.Tag := 1;
                        DiskMenu.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
                      end
                        else
                         begin
                                RepaintWindow;
                                HideM8;
                                if odDiskImages.Execute then
                                begin
                                     InsertDisk( 'local:'+odDiskImages.Filename, 1 );
                                end;
                                ShowM8;
                         end;
                      end;
           2: begin
               SimpleGet(baseUrl + '/api/control/hardware/disk/swap');
           end;

           3: begin
                      {smart port}
                      if Button = mbRight then
                      begin
                        DiskMenu.Tag := 2;
                        DiskMenu.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
                      end
                        else
                         begin
                                RepaintWindow;
                                HideM8;
                                if odDiskImages.Execute then
                                begin
                                     InsertDisk( 'local:'+odDiskImages.Filename, 2 );
                                end;
                                ShowM8;
                         end;
           end;

           4: begin

                      if Button = mbRight then
                      begin
                        ProfileMenu.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
                      end
                      else
                      begin
                           SimpleGet(baseUrl + '/api/control/system/reboot');
                      end;

           end;

           end;
     end;
end;

procedure TGUIForm.Freeze;
begin
       SimpleGet(baseUrl + '/api/control/window/freeze');
end;

procedure TGUIForm.miApps816PaintClick(Sender: TObject);
begin
     LaunchSP( '/appleii/disk images/2mg_hdv/816paint.po' );
end;

procedure TGUIForm.miAppsPrintShopClick(Sender: TObject);
begin
     LaunchDisk( '/appleii/disk images/applications/print shop/the print shop (color version).nib' );
end;

procedure TGUIForm.miAppsTerminalClick(Sender: TObject);
begin
    BootFreeze( '/boot/apps/proterm.frz' );
end;

procedure TGUIForm.miAR100Click(Sender: TObject);
begin
   UpdateConfig( 'video/init.aspect', TMenuItem(sender).Caption, true );
end;

procedure TGUIForm.miARClick(Sender: TObject);
var
  aspect: string;
begin
  //
  aspect := GetConfig( 'video/init.aspect' );
  case aspect of
  '1.00': miAR100.Checked := true;
  '1.33': miAR133.Checked := true;
  '1.46': miAR146.Checked := true;
  '1.62': miAR162.Checked := true;
  '1.78': miAR178.Checked := true;
  end;
end;

procedure TGUIForm.miAudioClick(Sender: TObject);
begin
   // muted
   miSNDMuted.Checked := GetConfig('audio/init.master.mute') = '1';
end;

procedure TGUIForm.miColorDotsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.hgrmode',  '0', true );
end;

procedure TGUIForm.miColorRasterClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.hgrmode',  '2', true );
end;

procedure TGUIForm.miColorVoxelsClick(Sender: TObject);
begin
   UpdateConfig( 'video/init.video.hgrmode',  '1', true );
end;

procedure TGUIForm.miCPU6502Click(Sender: TObject);
begin
  UpdateConfig('hardware/current.cpu.model', TMenuItem(sender).Caption, false );
end;

procedure TGUIForm.miCPUTypeClick(Sender: TObject);
begin
  case GetConfig('hardware/current.cpu.model') of
  '6502': miCPU6502.Checked := true;
  '65C02': miCPU65c02.Checked := true;
  end;
end;

procedure TGUIForm.miCPUWarpClick(Sender: TObject);
begin
     case GetConfig('hardware/current.cpu.warp') of
     '0.25': miWarp25.Checked := true;
     '0.50': miWarp50.Checked := true;
     '1.00': miWarp100.Checked := true;
     '2.00': miWarp200.Checked := true;
     '4.00': miWarp400.Checked := true;
     end;
end;

procedure TGUIForm.miD1BlankClick(Sender: TObject);
begin
        SimpleGet(baseUrl + '/api/control/hardware/disk/eject/0');
end;

procedure TGUIForm.miD1FileClick(Sender: TObject);
begin
     RepaintWindow;
     HideM8;
     if odDiskImages.Execute then
     begin
          InsertDisk( 'local:'+odDiskImages.Filename, 0 );
     end;
     ShowM8;
end;

procedure TGUIForm.miD2BlankClick(Sender: TObject);
begin
         SimpleGet(baseUrl + '/api/control/hardware/disk/eject/1');
end;

procedure TGUIForm.miD2FileClick(Sender: TObject);
begin
  RepaintWindow;
  HideM8;
  if odDiskImages.Execute then
  begin
       InsertDisk( 'local:'+odDiskImages.Filename, 1 );
  end;
  ShowM8;
end;

procedure TGUIForm.miDHGRENClick(Sender: TObject);
var
  value: string;
begin
  // DHGR Enhanced menu
  value := GetConfig('video/init.video.dhgrhighbit');
  //.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '0': miDHREMAuto.Checked := true;
       '1': miDHREMOff.Checked := true;
       '2': miDHREMOn.Checked := true;
       end;
  end;
end;

procedure TGUIForm.miDHRColorDotsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.dhgrmode',  '0', true );
end;

procedure TGUIForm.miDHRColorRasterClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.dhgrmode',  '2', true );
end;

procedure TGUIForm.miDHRColorVoxelsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.dhgrmode',  '1', true );
end;

{
DHB_MIXED_AUTO = 0
DHB_MIXED_ON = 1
DHB_MIXED_OFF = 2
}

procedure TGUIForm.miDHREMAutoClick(Sender: TObject);
begin
      UpdateConfig( 'video/init.video.dhgrhighbit',  '0', true );
end;

procedure TGUIForm.miDHREMOffClick(Sender: TObject);
begin
        UpdateConfig( 'video/init.video.dhgrhighbit',  '2', true );
end;

procedure TGUIForm.miDHREMOnClick(Sender: TObject);
begin
   UpdateConfig( 'video/init.video.dhgrhighbit',  '1', true );
end;

procedure TGUIForm.miDHRMonoDotsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.dhgrmode',  '3', true );
end;

procedure TGUIForm.miDHRMonoRasterClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.dhgrmode',  '5', true );
end;

procedure TGUIForm.miDHRMonoVoxelsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.dhgrmode',  '4', true );
end;

procedure TGUIForm.miDisksClick(Sender: TObject);
begin
  { disk menu }
  miDisksDisableWarp.Checked := (GetConfig( 'hardware/init.apple2.disk.nowarp' ) = '1');
  miDisksConvertWOZ.Checked := (GetConfig( 'hardware/init.apple2.disk.nodskwoz' ) = '0');
end;

procedure TGUIForm.miDisksConvertWOZClick(Sender: TObject);
begin
   if TMenuItem(sender).Checked then
      UpdateConfig( 'hardware/init.apple2.disk.nodskwoz', '0', true)
   else
      UpdateConfig( 'hardware/init.apple2.disk.nodskwoz', '1', true);
end;

procedure TGUIForm.miDisksDisableWarpClick(Sender: TObject);
begin
   if TMenuItem(sender).Checked then
      UpdateConfig( 'hardware/init.apple2.disk.nowarp', '1', true)
   else
      UpdateConfig( 'hardware/init.apple2.disk.nowarp', '0', true);
end;

procedure TGUIForm.miDisksSwapClick(Sender: TObject);
begin
     SimpleGet(baseUrl + '/api/control/hardware/disk/swap');
end;

procedure TGUIForm.miFileCatClick(Sender: TObject);
begin
    SimpleGet(baseUrl + '/api/control/system/catalog');
end;

procedure TGUIForm.miGRRasterClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.grmode',  '2', true );
end;

procedure TGUIForm.miGRRenderModeClick(Sender: TObject);
var
  value: string;
begin
  // GR Render Mode menu
  value := GetConfig('video/init.video.grmode');
 // StatusBar1.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '1': miGRVoxels.Checked := true;
       '2': miGRRaster.Checked := true;
       end;
  end;
end;

procedure TGUIForm.miGRVoxelsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.grmode',  '1', true );
end;

procedure TGUIForm.miINPAllCapsClick(Sender: TObject);
var
  mi: TMenuItem;
begin
     mi := TMenuItem(sender);
     mi.Checked := not mi.Checked;
     if mi.Checked then
        UpdateConfig( 'input/init.uppercase', '1', true )
     else
       UpdateConfig( 'input/init.uppercase', '0', true );
end;

procedure TGUIForm.miINPJoystickClick(Sender: TObject);
begin
  // setup joystick menu
  miJSXRev.Checked := GetConfig( 'input/init.joystick.reversex' ) = '1';
  miJSYRev.Checked := GetConfig( 'input/init.joystick.reversey' ) = '1';
  miJSAxisSwap.Checked := GetConfig( 'input/init.joystick.axis0' ) = '1';
end;

procedure TGUIForm.miINPMMJoystickClick(Sender: TObject);
begin
  UpdateConfig('input/init.mouse', '0', true);
end;

procedure TGUIForm.miINPMMDPadClick(Sender: TObject);
begin
  UpdateConfig('input/init.mouse', '1', true);
end;

procedure TGUIForm.miINPMMGEOSClick(Sender: TObject);
begin
  UpdateConfig('input/init.mouse', '2', true);
end;

procedure TGUIForm.miINPMMDDrawClick(Sender: TObject);
begin
  UpdateConfig('input/init.mouse', '3', true);
end;

procedure TGUIForm.miINPMMOffClick(Sender: TObject);
begin
  UpdateConfig('input/init.mouse', '4', true);
end;

procedure TGUIForm.miINPMouseModeClick(Sender: TObject);
var
  value: string;
begin
  {
  	MM_MOUSE_JOYSTICK = 0
	MM_MOUSE_DPAD     = 1
	MM_MOUSE_GEOS     = 2
	MM_MOUSE_DDRAW    = 3
	MM_MOUSE_OFF      = 4
  }
  value := GetConfig('input/init.mouse');
  //StatusBar1.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '0': miINPMMJoystick.Checked := true;
       '1': miINPMMDPAD.Checked := true;
       '2': miINPMMGEOS.Checked := true;
       '3': miINPMMDDraw.Checked := true;
       '4': miINPMMOff.Checked := true;
       end;
  end;
end;

procedure TGUIForm.miINPMouseModeDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
begin

end;


procedure TGUIForm.miIntFPClick(Sender: TObject);
begin
    SimpleGet(baseUrl + '/api/control/interpreter/fp');
end;

procedure TGUIForm.miIntINTClick(Sender: TObject);
begin
    SimpleGet(baseUrl + '/api/control/interpreter/int');
end;

procedure TGUIForm.miIntLOGOClick(Sender: TObject);
begin
    SimpleGet(baseUrl + '/api/control/interpreter/logo');
end;

procedure TGUIForm.miJSAxisSwapClick(Sender: TObject);
var
  p0, p1: string;
begin
  p0 := GetConfig( 'input/init.joystick.axis0' );
  p1 := GetConfig( 'input/init.joystick.axis1' );
  UpdateConfig( 'input/init.joystick.axis0', p1, true );
  UpdateConfig( 'input/init.joystick.axis1', p0, true );
end;

procedure TGUIForm.miJSXRevClick(Sender: TObject);
var
  p0: string;
begin
  p0 := GetConfig( 'input/init.joystick.reversex' );
  if p0 = '1' then
        UpdateConfig( 'input/init.joystick.reversex', '0', true )
  else
       UpdateConfig( 'input/init.joystick.reversex', '1', true );
end;

procedure TGUIForm.miJSYRevClick(Sender: TObject);
var
  p0: string;
begin
  p0 := GetConfig( 'input/init.joystick.reversey' );
  if p0 = '1' then
        UpdateConfig( 'input/init.joystick.reversey', '0', true )
  else
       UpdateConfig( 'input/init.joystick.reversey', '1', true );
end;

procedure TGUIForm.miMMHelpClick(Sender: TObject);
begin
  SimpleGet(baseUrl + '/api/control/system/help');
end;

procedure TGUIForm.miMonoDotsClick(Sender: TObject);
begin
   UpdateConfig( 'video/init.video.hgrmode',  '3', true );
end;

procedure TGUIForm.miMonoRasterClick(Sender: TObject);
begin
   UpdateConfig( 'video/init.video.hgrmode',  '5', true );
end;

procedure TGUIForm.miMonoVoxelsClick(Sender: TObject);
begin
   UpdateConfig( 'video/init.video.hgrmode',  '4', true );
end;

procedure TGUIForm.miMVOL000Click(Sender: TObject);
begin
  case TMenuItem(sender).Caption of
  '0': UpdateConfig( 'audio/init.master.volume', '0.0', true );
  '1': UpdateConfig( 'audio/init.master.volume', '0.1', true );
  '2': UpdateConfig( 'audio/init.master.volume', '0.2', true );
  '3': UpdateConfig( 'audio/init.master.volume', '0.3', true );
  '4': UpdateConfig( 'audio/init.master.volume', '0.4', true );
  '5': UpdateConfig( 'audio/init.master.volume', '0.5', true );
  '6': UpdateConfig( 'audio/init.master.volume', '0.6', true );
  '7': UpdateConfig( 'audio/init.master.volume', '0.7', true );
  '8': UpdateConfig( 'audio/init.master.volume', '0.8', true );
  '9': UpdateConfig( 'audio/init.master.volume', '0.9', true );
  '10': UpdateConfig( 'audio/init.master.volume', '1.0', true );
  end;
end;

procedure TGUIForm.miOpenFreezeClick(Sender: TObject);
var
  d: string;
begin
  { open dialog for freezes }
  odFreezeFiles.InitialDir := ReplaceStr( GetConfig('system/current.freezedir'), '/', DirectorySeparator);
  RepaintWindow;
  HideM8;
  if odFreezeFiles.Execute then
  begin
       { /api/control/system/freeze/restore

         path: ""

       }
       BootFreeze( odFreezeFiles.FileName );
  end;
  ShowM8;
end;

procedure TGUIForm.miPDFTO5sClick(Sender: TObject);
begin
  UpdateConfig( 'hardware/init.printer.timeout', TMenuItem(sender).Caption, true );
end;

procedure TGUIForm.miPRFIIeClick(Sender: TObject);
begin
      SimpleGet( baseUrl+'/api/control/system/profile/set/apple2e' );
end;

procedure TGUIForm.miPRFIIeEnhancedClick(Sender: TObject);
begin
     SimpleGet( baseUrl+'/api/control/system/profile/set/apple2e-en' );
end;

procedure TGUIForm.miPRFIIeEnhancedSoftcardClick(Sender: TObject);
begin
     SimpleGet( baseUrl+'/api/control/system/profile/set/apple2e-en-cpm' );
end;

procedure TGUIForm.miPRFIIplusClick(Sender: TObject);
begin
    SimpleGet( baseUrl+'/api/control/system/profile/set/apple2-plus' );
end;

procedure TGUIForm.miPrinterPDFClick(Sender: TObject);
begin
  case GetConfig( 'hardware/init.printer.timeout' ) of
  '5': miPDFTO5s.Checked := true;
  '15': miPDFTO15s.Checked := true;
  '30': miPDFTO30s.Checked := true;
  '45': miPDFTO45s.Checked := true;
  '60': miPDFTO60s.Checked := true;
  end;
end;

procedure TGUIForm.miProfilesClick(Sender: TObject);
begin
  { get profile }
  case SimpleGet( baseUrl+'/api/control/system/profile/get' ) of
  'apple2e-en': miPRFIIeEnhanced.Checked := true;
  'apple2e-en-cpm': miPRFIIeEnhancedSoftcard.Checked := true;
  'apple2e': miPRFIIe.Checked := true;
  'apple2plus': miPRFIIplus.Checked := true;
  end;
end;

procedure TGUIForm.miPSG0m100Click(Sender: TObject);
begin
     case TMenuItem(sender).Tag of
     -100: UpdateConfig( 'audio/init.mockingboard.psg0balance', '-1.00', true );
     -75: UpdateConfig( 'audio/init.mockingboard.psg0balance', '-0.75', true );
     -50: UpdateConfig( 'audio/init.mockingboard.psg0balance', '-0.50', true );
     -25: UpdateConfig( 'audio/init.mockingboard.psg0balance', '-0.25', true );
     0: UpdateConfig( 'audio/init.mockingboard.psg0balance', '0.00', true );
     25: UpdateConfig( 'audio/init.mockingboard.psg0balance', '0.25', true );
     50: UpdateConfig( 'audio/init.mockingboard.psg0balance', '0.50', true );
     75: UpdateConfig( 'audio/init.mockingboard.psg0balance', '0.75', true );
     100: UpdateConfig( 'audio/init.mockingboard.psg0balance', '1.00', true );
     end;
end;

procedure TGUIForm.miPSG1m100Click(Sender: TObject);
begin
     case TMenuItem(sender).Tag of
     -100: UpdateConfig( 'audio/init.mockingboard.psg1balance', '-1.00', true );
     -75: UpdateConfig( 'audio/init.mockingboard.psg1balance', '-0.75', true );
     -50: UpdateConfig( 'audio/init.mockingboard.psg1balance', '-0.50', true );
     -25: UpdateConfig( 'audio/init.mockingboard.psg1balance', '-0.25', true );
     0: UpdateConfig( 'audio/init.mockingboard.psg1balance', '0.00', true );
     25: UpdateConfig( 'audio/init.mockingboard.psg1balance', '0.25', true );
     50: UpdateConfig( 'audio/init.mockingboard.psg1balance', '0.50', true );
     75: UpdateConfig( 'audio/init.mockingboard.psg1balance', '0.75', true );
     100: UpdateConfig( 'audio/init.mockingboard.psg1balance', '1.00', true );
     end;
end;

procedure TGUIForm.miRECAutoLiveRewindClick(Sender: TObject);
begin
    if GetConfig( 'hardware/init.liverecording' ) = '1' then
       UpdateConfig('hardware/init.liverecording', '0', true)
    else
       UpdateConfig('hardware/init.liverecording', '1', true);
end;

procedure TGUIForm.miRECDisableSlowRewClick(Sender: TObject);
begin
    if GetConfig( 'hardware/init.disablefractionalrewind' ) = '1' then
       UpdateConfig('hardware/init.disablefractionalrewind', '0', true)
    else
       UpdateConfig('hardware/init.disablefractionalrewind', '1', true);
end;

procedure TGUIForm.miRECLiveRewindClick(Sender: TObject);
begin
  SimpleGet( baseUrl+'/api/control/recorder/start-live-recording' );
end;

procedure TGUIForm.miRECPlayClick(Sender: TObject);
begin
   SimpleGet( baseUrl+'/api/control/recorder/play' );
end;

procedure TGUIForm.miRECResumeClick(Sender: TObject);
begin
    SimpleGet( baseUrl+'/api/control/recorder/resume' );
end;

procedure TGUIForm.miRECRewindClick(Sender: TObject);
begin
   SimpleGet( baseUrl+'/api/control/recorder/rewind' );
end;

procedure TGUIForm.miRECStartFileClick(Sender: TObject);
begin
  SimpleGet( baseUrl+'/api/control/recorder/start-file-recording' );
end;

procedure TGUIForm.miRECStopClick(Sender: TObject);
begin
  SimpleGet( baseUrl+'/api/control/recorder/stop-recording' );
end;

procedure TGUIForm.miSaveFreezeClick(Sender: TObject);
var
  d: string;
begin
  { open dialog for freezes }
  sdFreezeFiles.InitialDir := ReplaceStr( GetConfig('system/current.freezedir'), '/', DirectorySeparator);
  RepaintWindow;
  HideM8;
  if sdFreezeFiles.Execute then
  begin
       { /api/control/system/freeze/restore

         path: ""

       }
       SaveFreeze( sdFreezeFiles.FileName );
  end;
  ShowM8;
end;

procedure TGUIForm.miScanLineIntClick(Sender: TObject);
var
  value: string;
begin
  // SHR Render Mode menu
  value := GetConfig('video/init.video.scanline');
  //StatusBar1.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '1.00': miSLI0.Checked := true;
       '0.88': miSLI1.Checked := true;
       '0.77': miSLI2.Checked := true;
       '0.66': miSLI3.Checked := true;
       '0.55': miSLI4.Checked := true;
       '0.44': miSLI5.Checked := true;
       '0.33': miSLI6.Checked := true;
       '0.22': miSLI7.Checked := true;
       '0.11': miSLI8.Checked := true;
       '0.00': miSLI9.Checked := true;
       end;
  end;
end;

procedure TGUIForm.miSerialClick(Sender: TObject);
var
  mode: string;
  ovr: string;
begin
  { get serial card option }
  mode := GetConfig( 'hardware/init.serial.mode' );
  ovr := GetConfig( 'override/ssc.disable.telnet' );
  if ovr = '1' then
  begin
       miSerialVModem.Checked := true;
       miSerialTelnetServer.Visible := false;
  end
  else
  begin
       miSerialVModem.Checked := (mode = '0');
       miSerialTelnetServer.Visible := true;
       miSerialTelnetServer.Checked := (mode = '1');
  end;
end;

procedure TGUIForm.miSerialVModemClick(Sender: TObject);
begin
       UpdateConfig( 'hardware/init.serial.mode', IntToStr(TMenuItem(sender).Tag), true );
end;

procedure TGUIForm.miSHRClick(Sender: TObject);
var
  value: string;
begin
  // SHR Render Mode menu
  value := GetConfig('video/init.video.shrmode');
  //StatusBar1.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '0': miSHRColorDots.Checked := true;
       '1': miSHRColorVoxels.Checked := true;
       '2': miSHRColorRaster.Checked := true;
       end;
  end;
end;

procedure TGUIForm.miSHRColorDotsClick(Sender: TObject);
begin
  UpdateConfig( 'video/init.video.shrmode',  '0', true );
end;

procedure TGUIForm.miSHRColorRasterClick(Sender: TObject);
begin
    UpdateConfig( 'video/init.video.shrmode',  '2', true );

end;

procedure TGUIForm.miSHRColorVoxelsClick(Sender: TObject);
begin
    UpdateConfig( 'video/init.video.shrmode',  '1', true );
end;

procedure TGUIForm.miSLIClick(Sender: TObject);
const
        values: Array[0..9] of string = ('1', '0.88', '0.77', '0.66', '0.55', '0.44', '0.33', '0.22', '0.11', '0');
begin
     // SimpleGet(baseUrl + '/api/control/input/meta/key/i/value/'+TMenuItem(Sender).Caption);
      UpdateConfig( 'video/init.video.scanline',  values[StrToInt(TMenuItem(Sender).Caption)], true );
end;

procedure TGUIForm.miSNDMasterClick(Sender: TObject);
begin
  case GetConfig( 'audio/init.master.volume' ) of
  '0.00': miMVOL000.Checked := true;
  '0.10': miMVOL010.Checked := true;
  '0.20': miMVOL020.Checked := true;
  '0.30': miMVOL030.Checked := true;
  '0.40': miMVOL040.Checked := true;
  '0.50': miMVOL050.Checked := true;
  '0.60': miMVOL060.Checked := true;
  '0.70': miMVOL070.Checked := true;
  '0.80': miMVOL080.Checked := true;
  '0.90': miMVOL090.Checked := true;
  '1.00': miMVOL100.Checked := true;
  end;
end;

procedure TGUIForm.miSNDMutedClick(Sender: TObject);
begin
  if GetConfig('audio/init.master.mute') = '1' then
     UpdateConfig( 'audio/init.master.mute', '0', false )
  else
     UpdateConfig( 'audio/init.master.mute', '1', false );
end;

procedure TGUIForm.miSNDPSG0Click(Sender: TObject);
begin
  // get psg 1 balance ...
  case GetConfig( 'audio/init.mockingboard.psg0balance' ) of
  '-1.00': miPSG0m100.Checked := true;
  '-0.75': miPSG0m75.Checked := true;
  '-0.50': miPSG0m50.Checked := true;
  '-0.25': miPSG0m25.Checked := true;
  '0.00': miPSG0p0.Checked := true;
  '0.25': miPSG0p25.Checked := true;
  '0.50': miPSG0p50.Checked := true;
  '0.75': miPSG0p75.Checked := true;
  '1.00': miPSG0p100.Checked := true;
  end;
end;

procedure TGUIForm.miSNDPSG1Click(Sender: TObject);
begin
  // get psg 1 balance ...
  case GetConfig( 'audio/init.mockingboard.psg1balance' ) of
  '-1.00': miPSG1m100.Checked := true;
  '-0.75': miPSG1m75.Checked := true;
  '-0.50': miPSG1m50.Checked := true;
  '-0.25': miPSG1m25.Checked := true;
  '0.00': miPSG1p0.Checked := true;
  '0.25': miPSG1p25.Checked := true;
  '0.50': miPSG1p50.Checked := true;
  '0.75': miPSG1p75.Checked := true;
  '1.00': miPSG1p100.Checked := true;
  end;
end;

procedure TGUIForm.miSNDSpeakerClick(Sender: TObject);
begin
    case GetConfig( 'audio/init.speaker.volume' ) of
  '0.00': miSVOL000.Checked := true;
  '0.10': miSVOL010.Checked := true;
  '0.20': miSVOL020.Checked := true;
  '0.30': miSVOL030.Checked := true;
  '0.40': miSVOL040.Checked := true;
  '0.50': miSVOL050.Checked := true;
  '0.60': miSVOL060.Checked := true;
  '0.70': miSVOL070.Checked := true;
  '0.80': miSVOL080.Checked := true;
  '0.90': miSVOL090.Checked := true;
  '1.00': miSVOL100.Checked := true;
  end;
end;

procedure TGUIForm.miSPEjectClick(Sender: TObject);
begin
      SimpleGet(baseUrl + '/api/control/hardware/disk/eject/2');
end;

procedure TGUIForm.miSPFileClick(Sender: TObject);
begin
  RepaintWindow;
  HideM8;
  if odDiskImages.Execute then
  begin
       InsertDisk( 'local:'+odDiskImages.Filename, 2 );
  end;
  ShowM8;
end;

procedure TGUIForm.miSVOL000Click(Sender: TObject);
begin
    case TMenuItem(sender).Caption of
  '0': UpdateConfig( 'audio/init.speaker.volume', '0.0', true );
  '1': UpdateConfig( 'audio/init.speaker.volume', '0.1', true );
  '2': UpdateConfig( 'audio/init.speaker.volume', '0.2', true );
  '3': UpdateConfig( 'audio/init.speaker.volume', '0.3', true );
  '4': UpdateConfig( 'audio/init.speaker.volume', '0.4', true );
  '5': UpdateConfig( 'audio/init.speaker.volume', '0.5', true );
  '6': UpdateConfig( 'audio/init.speaker.volume', '0.6', true );
  '7': UpdateConfig( 'audio/init.speaker.volume', '0.7', true );
  '8': UpdateConfig( 'audio/init.speaker.volume', '0.8', true );
  '9': UpdateConfig( 'audio/init.speaker.volume', '0.9', true );
  '10': UpdateConfig( 'audio/init.speaker.volume', '1.0', true );
  end;
end;

procedure TGUIForm.miTintModeClick(Sender: TObject);
var
  t: integer;
begin
      t := StrToInt( GetConfig( 'video/init.video.tintmode') );
      case t of
      0: miTMNone.Checked := true;
      1: miTMGrey.Checked := true;
      2: miTMGreen.Checked := true;
      3: miTMAmber.Checked := true;
      end;
end;

procedure TGUIForm.miTMNoneClick(Sender: TObject);
var
  t: integer;
  s: TMenuItem;
begin
  t := 0;
  s := TMenuItem(sender);
  if s.Caption = 'Grey' then
     t := 1
  else if s.Caption = 'Green' then
     t := 2
  else if s.Caption = 'Amber' then
     t := 3;
  UpdateConfig( 'video/init.video.tintmode', IntToStr(t), true );
  UpdateTintMode;
end;

procedure TGUIForm.miToolsClick(Sender: TObject);
begin

end;

procedure TGUIForm.miToolsTrackerClick(Sender: TObject);
begin
  LaunchCommand( 'fp', '/local', '@music.edit{}' );
end;

procedure TGUIForm.miToolsWebDebuggerClick(Sender: TObject);
begin
  SimpleGet( baseUrl + '/api/control/debug/attach' );
end;

procedure TGUIForm.miVCRClick(Sender: TObject);
begin
   miRECAutoLiveRewind.Checked := (GetConfig( 'hardware/init.liverecording' ) = '1');
   miRECDisableSlowRew.Checked := (GetConfig( 'hardware/init.disablefractionalrewind' ) = '1');
end;

procedure TGUIForm.miVD1Click(Sender: TObject);
var
  i: integer;
begin
     i := StrToInt(Copy( TMenuItem(sender).Caption, 1, 1 )) - 1;
     UpdateConfig( 'video/init.video.voxeldepth', IntToStr(i), true );
end;

procedure TGUIForm.miVDClick(Sender: TObject);
var
  i: integer;
begin
    i := StrToInt( GetConfig('video/init.video.voxeldepth') );
    case i of
    0: miVD1.Checked := true;
    1: miVD2.Checked := true;
    2: miVD3.Checked := true;
    3: miVD4.Checked := true;
    4: miVD5.Checked := true;
    5: miVD6.Checked := true;
    6: miVD7.Checked := true;
    7: miVD8.Checked := true;
    8: miVD9.Checked := true;
    end;
end;

procedure TGUIForm.miVideoScreenshotClick(Sender: TObject);
begin
  SendKey( $e092, $e092, 1, 0 );
end;

procedure TGUIForm.miVM1Click(Sender: TObject);
begin
  SimpleGet(baseUrl+'/api/control/vm/'+TMenuItem(sender).Caption);
end;

procedure TGUIForm.miVMClick(Sender: TObject);
begin
  case SimpleGet( baseUrl+'/api/control/vm' ) of
  '1': miVM1.Checked := true;
  '2': miVM2.Checked := true;
  '3': miVM3.Checked := true;
  '4': miVM4.Checked := true;
  '5': miVM5.Checked := true;
  '6': miVM6.Checked := true;
  '7': miVM7.Checked := true;
  '8': miVM8.Checked := true;
  end;
end;

procedure TGUIForm.miWarp25Click(Sender: TObject);
begin
  UpdateConfig( 'hardware/current.cpu.warp', TMenuItem(sender).Caption, false);
end;

procedure TGUIForm.MouseTimerTimer(Sender: TObject);
var
  x, y: longint;
  p, q: TPoint;
begin
     x := Mouse.CursorPos.x;
     y := Mouse.CursorPos.y;
     if (x <> lastMouseX) or (y <> lastMouseY) then
     begin
          //StatusBar1.SimpleText := 'Global mouse pos is ('+IntToStr(x)+', '+IntToStr(y)+')';
          lastMouseX := x;
          lastMouseY := y;
          q := TPoint.Create(0,0);
          p := embedPanel.ClientToScreen(q);
          if (x >= longint(p.X)) and (x < longint(p.X)+longint(embedPanel.Width)) and
             (y >= longint(p.Y)) and (y < longint(p.Y)+longint(embedPanel.Height)) then
          begin
               //StatusBar1.SimpleText := StatusBar1.SimpleText + ' (in window)';
               SendMouseState( x - longint(p.X), y - longint(p.Y) );
          end;
     end;
end;

procedure TGUIForm.sidecarPanelResize(Sender: TObject);
var
  h: double;
begin
  h := sidecarPanel.Height;
  sidecarPanel.Width := Round(0.34 * h);
end;

procedure TGUIForm.tbCapsModeClick(Sender: TObject);
begin
  miINPAllCapsClick(sender);
  UpdateAllCaps;
end;

procedure TGUIForm.tbFullscreenClick(Sender: TObject);
begin
  UpdateConfig('video/current.fullscreen', '1', false);
  isFS := true;
end;

procedure TGUIForm.UpdateAllCaps;
begin
   case GetConfig( 'input/init.uppercase' ) of
   '0': tbCapsMode.ImageIndex := 17;
   '1': tbCapsMode.ImageIndex := 18;
   end;
end;

procedure TGUIForm.tbJoystickAxisSwitchClick(Sender: TObject);
begin
  miJSAxisSwapClick(sender);
  UpdateJoystickAxis;
end;

procedure TGUIForm.UpdateJoystickAxis;
begin
     case GetConfig( 'input/init.joystick.axis0' ) of
     '0': tbJoystickAxisSwitch.ImageIndex := 21;
     '1': tbJoystickAxisSwitch.ImageIndex := 22;
     end;
end;

procedure TGUIForm.UpdateRenderMode;
var
  t: integer;
begin
      t := StrToInt( GetConfig( 'video/current.rendermode' ) );
      case t of
      0: tbRMDots.Down := true;
      3: tbRMDots.Down := true;
      1: tbRMVoxels.Down := true;
      4: tbRMVoxels.Down := true;
      2: tbRMRaster.Down := true;
      5: tbRMVoxels.Down := true;
      end;
end;


procedure TGUIForm.tbRMClick(Sender: TObject);
var
  t: integer;
begin
      t := StrToInt( GetConfig( 'video/current.rendermode' ) );

    case TToolButton(sender).Tag of
    0:
         if t >= 3 then
            t := 3
         else
           t := 0;
    1:
         if t >= 3 then
            t := 4
         else
           t := 1;
    2:
         if t >= 3 then
            t := 5
         else
           t := 2;
    end;

    UpdateConfig( 'video/current.rendermode', IntToStr(t), false );
    UpdateRenderMode;
end;

procedure TGUIForm.UpdateColorMode;
var
  t: integer;
begin
     t := StrToInt( GetConfig( 'video/current.rendermode' ) );
     tbRMColor.ImageIndex := 7 + (t div 3);
end;

procedure TGUIForm.tbRMColorClick(Sender: TObject);
var
  t: integer;
begin

     { increment video tint }
     t := StrToInt( GetConfig( 'video/current.rendermode' ) );

     if t >= 3 then
        t := t - 3
     else
        t := t + 3;

     UpdateConfig( 'video/current.rendermode', IntToStr(t), false );
     UpdateColorMode;
end;

procedure TGUIForm.tbScanlinesClick(Sender: TObject);
begin
   case GetConfig( 'video/init.video.scanlinedisable' ) of
   '0': UpdateConfig( 'video/init.video.scanlinedisable', '1', false );
   '1': UpdateConfig( 'video/init.video.scanlinedisable', '0', false );
   end;
   UpdateScanlines;
end;

procedure TGUIForm.tbSpeedDownClick(Sender: TObject);
begin
     SimpleGet( baseUrl+'/api/control/cpu/warp/down' );
     UpdateWarpSlider;
end;

procedure TGUIForm.tbSpeedUpClick(Sender: TObject);
begin
     SimpleGet( baseUrl+'/api/control/cpu/warp/up' );
     UpdateWarpSlider;
end;

procedure TGUIForm.UpdateScanlines;
begin
     case GetConfig( 'video/init.video.scanlinedisable' ) of
     '0': tbScanlines.ImageIndex := 20;
     '1': tbScanlines.ImageIndex := 19;
     end;
end;

procedure TGUIForm.UpdateTintMode;
var
  t: integer;
begin
  t := StrToInt( GetConfig( 'video/init.video.tintmode' ) );
  tbTintMode.ImageIndex := t;
end;

procedure TGUIForm.tbTintModeClick(Sender: TObject);
var
  t: integer;
begin

     { increment video tint }
     t := StrToInt( GetConfig( 'video/init.video.tintmode' ) );
     inc(t);
     if t > 3 then
        t := 0;
     UpdateConfig( 'video/init.video.tintmode', IntToStr(t), false );
     UpdateTintMode;

end;

procedure TGUIForm.tbVolDownClick(Sender: TObject);
begin
     SimpleGet( baseUrl+'/api/control/audio/master/down' );
     UpdateVolSlider;
end;

procedure TGUIForm.tbVolUpClick(Sender: TObject);
begin
     SimpleGet( baseUrl+'/api/control/audio/master/up' );
     UpdateVolSlider;
end;

procedure TGUIForm.ToolButton9Click(Sender: TObject);
begin
     SimpleGet(baseUrl+'/api/control/pause');
end;

procedure TGUIForm.UpdateRecordState;
begin
  case SimpleGet(baseUrl+'/api/control/recorder' ) of
  '0': begin
       tbRECState.ImageIndex := 9;
       tbRECState.Caption := 'Start Recording';
      end;
  '1': begin
             tbRECState.ImageIndex := 11;
             tbRECState.Caption := 'Live Rewind Active';
       end;
  '2': begin
             tbRECState.ImageIndex := 10;
             tbRECState.Caption := 'Disk Recording Active';
       end;
  end;
end;

procedure TGUIForm.ToolTimerTimer(Sender: TObject);
begin
  UpdateRenderMode;
  UpdateColorMode;
  UpdateTintMode;
  UpdateJoystickAxis;
  UpdateVolSlider;
  UpdateWarpSlider;
  UpdateAllCaps;
  UpdateScanlines;
  UpdateRecordState;
end;

procedure TGUIForm.tbMasterVolumeChange(Sender: TObject);
begin
  case TTrackBar(sender).Position of
  0: UpdateConfig( 'audio/init.master.volume', '0.0', false );
  1: UpdateConfig( 'audio/init.master.volume', '0.1', false );
  2: UpdateConfig( 'audio/init.master.volume', '0.2', false );
  3: UpdateConfig( 'audio/init.master.volume', '0.3', false );
  4: UpdateConfig( 'audio/init.master.volume', '0.4', false );
  5: UpdateConfig( 'audio/init.master.volume', '0.5', false );
  6: UpdateConfig( 'audio/init.master.volume', '0.6', false );
  7: UpdateConfig( 'audio/init.master.volume', '0.7', false );
  8: UpdateConfig( 'audio/init.master.volume', '0.8', false );
  9: UpdateConfig( 'audio/init.master.volume', '0.9', false );
  10: UpdateConfig( 'audio/init.master.volume', '1.0', false );
  end;
end;

procedure TGUIForm.UpdateWarpSlider;
begin
   case GetConfig('hardware/current.cpu.warp') of
   '0.25': TrackBar2.Position := 0;
   '0.50': TrackBar2.Position := 1;
   '1.00': TrackBar2.Position := 2;
   '2.00': TrackBar2.Position := 3;
   '4.00': TrackBar2.Position := 4;
   end;
end;

procedure TGUIForm.UpdateVolSlider;
begin
  case GetConfig( 'audio/init.master.volume' ) of
  '0.00': tbMasterVolume.Position := 0;
  '0.10': tbMasterVolume.Position := 1;
  '0.20': tbMasterVolume.Position := 2;
  '0.30': tbMasterVolume.Position := 3;
  '0.40': tbMasterVolume.Position := 4;
  '0.50': tbMasterVolume.Position := 5;
  '0.60': tbMasterVolume.Position := 6;
  '0.70': tbMasterVolume.Position := 7;
  '0.80': tbMasterVolume.Position := 8;
  '0.90': tbMasterVolume.Position := 9;
  '1.00': tbMasterVolume.Position := 10;
  end;
end;

procedure TGUIForm.TrackBar2Change(Sender: TObject);
begin
  case TTrackBar(sender).Position of
  0: UpdateConfig( 'hardware/current.cpu.warp', '0.25', false);
  1: UpdateConfig( 'hardware/current.cpu.warp', '0.50', false);
  2: UpdateConfig( 'hardware/current.cpu.warp', '1.00', false);
  3: UpdateConfig( 'hardware/current.cpu.warp', '2.00', false);
  4: UpdateConfig( 'hardware/current.cpu.warp', '4.00', false);
  end;
end;

procedure TGUIForm.UnFreeze;
begin
       SimpleGet(baseUrl + '/api/control/window/unfreeze');
end;

procedure TGUIForm.HideM8;
begin
       if hidden then
         exit;
       //Memo1.Lines.Add('hiding m8 window');
       SimpleGet(baseUrl + '/api/control/window/hide');
       lastHideTime := Now();
       hidden := true;
end;

procedure TGUIForm.menuRebootVMClick(Sender: TObject);
begin
      RebootVM;
end;

procedure TGUIForm.ShowM8;
begin
       if not hidden then
          exit;
       //Memo1.Lines.Add('showing m8 window');
       SimpleGet(baseUrl + '/api/control/window/show');
       lastShowTime := Now();
       hidden := false;
end;

procedure TGUIForm.RepaintWindow;
var
  S: TMemoryStream;
  filename: string;
begin
       S := TMemoryStream.Create();
       SimpleGetStream(baseUrl + '/api/control/window/screen', S);
       if S.Size > 0 then
       begin
            filename := GetUserDir + PathSeparator + 'microm8scrn.png';
            //StatusBar1.SimpleText:='Got '+IntToStr(S.Size)+' bytes of PNG data';
            S.SaveToFile(filename);
            backdrop.Picture.LoadFromFile(filename);
            S.Free;
       end;
end;

procedure TGUIForm.ReposWindow;
var
  x, y, w, h: integer;
  json, S: string;
  Respo: TStringStream;
  p, q: TPoint;
begin
     if isFS then
     exit;

     q.X := 0;
     q.Y := 0;
     p := embedPanel.ClientToScreen(q);
     x := p.X;
     y := p.Y;
     w := embedPanel.Width;
     h := embedPanel.Height;

     if (lx = x) and (ly = y) and (lw = w) and (lh = h) then
        exit;

     lx := x;
     ly := y;
     lw := w;
     lh := h;

     json := '{"x":' + IntToStr(x) +
             ',"y":'+IntToStr(y) +
             ',"w":'+IntToStr(w) +
             ',"h":'+IntToStr(h) +
             '}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/window/position',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
end;

procedure TGUIForm.LaunchSP(disk: string);
var
  json, S: string;
  Respo: TStringStream;
begin
     json := '{"smartport": "' + disk +
             '"}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/system/launch',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
end;

procedure TGUIForm.LaunchCommand(dialect: string; path: string; command: string);
var
  json, S: string;
  Respo: TStringStream;
begin
     json := '{"runcommand": "' + command +
             '","dialect": "'+ dialect +
             '","workingdir": "'+ path +
             '"}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/system/launch',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
end;

procedure TGUIForm.LaunchDisk(disk: string);
var
  json, S: string;
  Respo: TStringStream;
begin
     json := '{"disks": ["' + disk +
             '"]}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/system/launch',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
end;

procedure TGUIForm.SendMouseState(x, y: longint);
var
  json, S: string;
  Respo: TStringStream;
begin
     json := '{"x":' + IntToStr(x) +
             ',"y":'+IntToStr(y) +
             '}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/input/mouseevent',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
end;

function TGUIForm.SimpleGet(url:string): string;
begin
  result := '0';
  try
     result := self.httpc.Get(url)
  except
        on e: Exception do begin
             // nothing much
        end;
  end;
end;

procedure TGUIForm.SimpleGetStream(url:string; var S: TMemoryStream);
begin
  try
     self.httpc.Get(url, S)
  except
        on e: Exception do begin
             // nothing much
        end;
  end;
end;


procedure TGUIForm.SimpleFormPost( url: string; body: string; var resp: TStringStream );
begin
     try
       self.httpc.SimpleFormPost(url,body,resp)
     except
        on e: Exception do begin
             // nothing much
        end;
     end;
end;

procedure TGUIForm.SendKey(key: Integer; ScanCode: Integer; KeyAction: Integer; Mods: Integer);
var
  json, S: string;
  Respo: TStringStream;
begin
     if key = 8 then
        key := 127;

     json := '{"key":' + IntToStr(key) +
             ',"scancode":'+IntToStr(ScanCode) +
             ',"action":'+IntToStr(KeyAction) +
             ',"modifiers":'+IntToStr(Mods) +
             '}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/input/keyevent',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
end;

procedure TGUIForm.InsertDisk(Filename: string; Drive: integer);
var
  json, S: string;
  Respo: TStringStream;
  f: TReplaceFlags;
begin
     f := [rfReplaceAll];
     Filename := StringReplace( Filename, '\', '/', f);

     json := '{"filename":"' + Filename +
             '","drive":'+IntToStr(Drive) +
             '}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/hardware/disk/insert',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=json;
     Respo.Destroy;
end;

procedure TGUIForm.UpdateConfig(path: string; value: string; persist: boolean);
var
  json, S, pval: string;
  Respo: TStringStream;
  f: TReplaceFlags;
begin
     pval := 'false';
     if persist then
         pval := 'true';
     json := '{"path":"' + path +
             '","value":"'+ value +
             '","persist":'+ pval +
             '}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/settings/update',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=json;
     Respo.Destroy;
end;

function TGUIForm.GetConfig(path: string): string;
var
  json, S, pval: string;
  Respo: TStringStream;
  f: TReplaceFlags;
begin
     json := '{"path":"' + path +
             '"}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/settings/get',json,Respo);
     Result := Respo.DataString;
     //self.StatusBar1.SimpleText:=json;
     Respo.Destroy;
end;

procedure TGUIForm.SaveFreeze(Filename: string);
var
  json, S: string;
  Respo: TStringStream;
  f: TReplaceFlags;
begin
     f := [rfReplaceAll];
     Filename := StringReplace( Filename, '\', '/', f);

     if RightStr(Filename, 4) <> '.frz' then
        Filename := Filename + '.frz';

     json := '{"path":"' + Filename +
             '"}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/system/freeze/save',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=json;
     Respo.Destroy;
end;

procedure TGUIForm.BootFreeze(Filename: string);
var
  json, S: string;
  Respo: TStringStream;
  f: TReplaceFlags;
begin
     f := [rfReplaceAll];
     Filename := StringReplace( Filename, '\', '/', f);

     json := '{"path":"' + Filename +
             '"}';
     Respo := TStringStream.Create('');
     SimpleFormPost(baseUrl + '/api/control/system/freeze/restore',json,Respo);
     S := Respo.DataString;
     //self.StatusBar1.SimpleText:=json;
     Respo.Destroy;
end;

procedure TGUIForm.tbDisk1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   DiskMenu.Tag := TToolButton(Sender).Tag;
   //StatusBar1.SimpleText := 'Disk 1';
end;

procedure TGUIForm.tbDisk2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DiskMenu.Tag := TToolButton(Sender).Tag;
  //StatusBar1.SimpleText := 'Disk 2';
end;

procedure TGUIForm.ToolButton5Click(Sender: TObject);
begin
  RebootVM;
end;

procedure TGUIForm.FormChangeBounds(Sender: TObject);
var
  h: double;
begin
  h := sidecarPanel.Height;
  sidecarPanel.Width := Round(0.34 * h);
  self.ReposWindow;
end;

procedure TGUIForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CheckTimer.Enabled:=false;
  ToolTimer.Enabled := false;
  MouseTimer.Enabled := false;
  MicroM8Process.Active := false;
end;

procedure TGUIForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
    SimpleGet( baseUrl+'/api/control/quit' );
    CanClose := true;
end;

procedure TGUIForm.Button1Click(Sender: TObject);
begin
     self.ReposWindow;
end;

procedure TGUIForm.backdropClick(Sender: TObject);
begin

end;

{$IFDEF WINDOWS}
function TGUIForm.GetTitleOfActiveWindow: string;
var
  AHandle: THandle;
  ATitle: string;
  ALen: Integer;
begin
  Result := '';
  AHandle := GetForegroundWindow;

  if AHandle <> 0 then begin
    ALen := GetWindowTextLength(AHandle) + 1;
    SetLength(ATitle, ALen);
    GetWindowText(AHandle, PChar(ATitle), ALen);
    result := Trim(ATitle);
  end;
end;
{$ELSE}
// stub for now
function TGUIForm.GetTitleOfActiveWindow: string;
var s: string;
begin
  Result := '';
  s := SimpleGet(baseUrl + '/api/control/window/focused');
  if s = '1' then
     Result := 'microM8';
end;
{$ENDIF}

procedure TGUIForm.CheckTimerTimer(Sender: TObject);
begin
  if isFS then
     exit;
  //if MilliSecondsBetween(Now(), lastShowTime) < 500 then
  //   exit;
  if WindowState = wsMinimized then
     exit;
  //if hidden then
  //   exit;
  if GetTitleOfActiveWindow = 'microM8' then
   begin

     {$IFNDEF WINDOWS}
     if IsMouseBtnDown then
      exit;
     {$ENDIF}

     //Application.Restore;
     Application.BringToFront;
     {$IFDEF WINDOWS}
     SetForegroundWindow(Application.MainForm.Handle);
     {$ENDIF}
     //StatusBar1.SimpleText := 'App is refocussing';
     lastShowTime := Now();
   end;
  ReposWindow;
end;

procedure TGUIForm.DiskMenuClose(Sender: TObject);
begin
  inPopup := false;
end;

procedure TGUIForm.DiskMenuPopup(Sender: TObject);
begin
  inPopup := true;
end;

{$IFDEF WINDOWS}
const
  EXENAME: string = 'microm8.exe';
{$ELSE}
const
  EXENAME: string = 'microm8';
{$ENDIF}


procedure TGUIForm.FormCreate(Sender: TObject);
begin
     self.httpc := TFPHttpClient.Create(Nil);

     //ShowMessage( ExtractFilePath(Application.ExeName) + EXENAME );
     MicroM8Process.Executable :=  ExtractFilePath(Application.ExeName) + EXENAME;

     //if SimpleGet( baseUrl+'/api/control/health' ) <> 'ok' then
     //begin
            MicroM8Process.Active := true;
            sleep(1000);
     //end;

     CheckTimer.Enabled:=true;
     ToolTimer.Enabled := true;
     MouseTimer.Enabled := true;
     hidden := true;
     isFS := false;
end;

procedure TGUIForm.FormDeactivate(Sender: TObject);
begin
end;

procedure TGUIForm.FormHide(Sender: TObject);
begin
  RepaintWindow;
  HideM8;
end;

function MapKeyCode( Key: Word; Shift: TShiftState ): integer;
const
  	CSR_LEFT  = $e000;
	CSR_RIGHT = $e001;
	CSR_UP    = $e002;
	CSR_DOWN  = $e003;
        CTRL_A = $e041;
        SHIFT_CTRL_A = $e071;
begin
  case Key of
  219:
        if ssShift in Shift then
       Result := Ord('{')
      else
        Result := Ord('[');
  221:
              if ssShift in Shift then
       Result := Ord('}')
      else
        Result := Ord(']');
  222:
              if ssShift in Shift then
       Result := Ord('"')
      else
        Result := Ord('''');
  186:
              if ssShift in Shift then
       Result := Ord(':')
      else
        Result := Ord(';');
  220:
              if ssShift in Shift then
       Result := Ord('|')
      else
        Result := Ord('\');
  191:
              if ssShift in Shift then
       Result := Ord('?')
      else
        Result := Ord('/');
  190:
              if ssShift in Shift then
       Result := Ord('>')
      else
        Result := Ord('.');
  188:
              if ssShift in Shift then
       Result := Ord('<')
      else
        Result := Ord(',');
  187:
              if ssShift in Shift then
       Result := Ord('+')
      else
        Result := Ord('=');
  189:
              if ssShift in Shift then
       Result := Ord('_')
      else
        Result := Ord('-');
  192:
      if ssShift in Shift then
       Result := Ord('~')
      else
        Result := Ord('`');
  VK_Up: Result := CSR_UP;
  VK_Down: Result := CSR_DOWN;
  VK_Left: Result := CSR_LEFT;
  VK_Right: Result := CSR_RIGHT;
  VK_0..VK_9:
  begin
      if ssShift in Shift then
      case Key of
       VK_0: Result := Ord(')');
       VK_9: Result := Ord('(');
       VK_8: Result := Ord('*');
       VK_7: Result := Ord('&');
       VK_6: Result := Ord('^');
       VK_5: Result := Ord('%');
       VK_4: Result := Ord('$');
       VK_3: Result := Ord('#');
       VK_2: Result := Ord('@');
       VK_1: Result := Ord('!');
      end
      else
          Result := Integer(Key);
  end;
  VK_A..VK_Z:
  begin
             if (ssCtrl in Shift) and (ssShift in Shift) then
             begin
              StatusBar1.SimpleText := 'Shift+Ctrl+'+char(Key);
              Result := (Integer(Key) - 65) + SHIFT_CTRL_A;
             end
             else if ssShift in Shift then
              Result := Integer(Key)
             else if ssCtrl in Shift then
             begin
                if Key = 67 then
                  Result := 3
                else
                  Result := CTRL_A + Integer(Key-65);
             end
             else
               Result := Integer(Key)+32;
  end
  else
    result := Integer(Key)
  end;
end;

function MapShiftState( Key: Word; Shift: TShiftState ): integer;
var
  m: Integer;
begin
  m := 0;
  if ssShift in Shift then
     m := m or 1;
  if ssCtrl in Shift then
     m := m or 2;
  if ssAlt in Shift then
     m := m or 4;
  result := m;
end;

procedure TGUIForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  SendKey( MapKeyCode(Key, Shift), 0, 1, MapShiftState(Key, Shift) );
end;

procedure TGUIForm.FormKeyPress(Sender: TObject; var Key: char);
begin
  //SendKey( Integer(Ord(Key)), 0, 1, 0 );
end;

procedure TGUIForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SendKey( MapKeyCode(Key, Shift), 0, 0, MapShiftState(Key, Shift) );
  //StatusBar1.SimpleText := 'keycode ' + IntToStr(Key);
end;

procedure TGUIForm.FormResize(Sender: TObject);
var
  h: double;
begin
  h := sidecarPanel.Height;
  sidecarPanel.Width := Round(0.34 * h);
  ReposWindow;
end;

procedure TGUIForm.FormShow(Sender: TObject);
begin
  ShowM8;
  ReposWindow;
end;

procedure TGUIForm.FormUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin

end;

procedure TGUIForm.FormWindowStateChange(Sender: TObject);
begin
  //Memo1.Lines.Add('window state has changed');
  if WindowState = wsMinimized then
     HideM8
  else
    ShowM8;
end;

procedure TGUIForm.FSTimerTimer(Sender: TObject);
begin
  isFS := (GetConfig( 'video/current.fullscreen' ) = '1');
end;

procedure TGUIForm.InputClick(Sender: TObject);
var
  value: string;
begin
  // setup item states
  miINPAllCaps.Checked := (GetConfig( 'input/init.uppercase' ) = '1');
end;

procedure TGUIForm.MenuItem10Click(Sender: TObject);
begin
  { disk insert }
   RepaintWindow;
   HideM8;
   if odDiskImages.Execute then
   begin
        InsertDisk( 'local:'+odDiskImages.Filename, DiskMenu.Tag );
   end;
   ShowM8;
end;

procedure TGUIForm.MenuItem14Click(Sender: TObject);
begin
  { do fullscreen here }
  UpdateConfig('video/current.fullscreen', '1', false);
  isFS := true;
end;

procedure TGUIForm.MenuItem15Click(Sender: TObject);
var
  value: string;
begin
  // HGR Render Mode menu
  value := GetConfig('video/init.video.hgrmode');
  //StatusBar1.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '0': miColorDots.Checked := true;
       '1': miColorVoxels.Checked := true;
       '2': miColorRaster.Checked := true;
       '3': miMonoDots.Checked := true;
       '4': miMonoVoxels.Checked := true;
       '5': miMonoRaster.Checked := true;
       end;
  end;
end;

procedure TGUIForm.MenuItem16Click(Sender: TObject);
var
  value: string;
begin
  // DHGR Render Mode menu
  value := GetConfig('video/init.video.dhgrmode');
  //StatusBar1.SimpleText := value;
  if value <> '' then
  begin
       case value of
       '0': miDHRColorDots.Checked := true;
       '1': miDHRColorVoxels.Checked := true;
       '2': miDHRColorRaster.Checked := true;
       '3': miDHRMonoDots.Checked := true;
       '4': miDHRMonoVoxels.Checked := true;
       '5': miDHRMonoRaster.Checked := true;
       end;
  end;
end;

procedure TGUIForm.MenuItem17Click(Sender: TObject);
begin
  SimpleGet(baseUrl + '/api/control/hardware/disk/blank/0');
end;

procedure TGUIForm.MenuItem18Click(Sender: TObject);
begin
  SimpleGet(baseUrl + '/api/control/hardware/disk/blank/1');
end;

procedure TGUIForm.MenuItem2Click(Sender: TObject);
begin
  SimpleGet( baseUrl+'/api/control/quit' );
  Application.Terminate();
end;

end.

