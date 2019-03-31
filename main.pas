unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, StdCtrls, fphttpclient, LCLType, Buttons, DateUtils,
{$IFDEF WINDOWS}
  Windows,
{$ENDIF}
  Sockets
  ;

type

  { TGUIForm }

  TGUIForm = class(TForm)
    BackdropImage: TImage;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
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
    hc: TFPHttpClient;
    CheckTimer: TTimer;
    ToolBar1: TToolBar;
    procedure BackdropImageClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckTimerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
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
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Freeze;
    procedure miD1BlankClick(Sender: TObject);
    procedure miD1FileClick(Sender: TObject);
    procedure miD2BlankClick(Sender: TObject);
    procedure miD2FileClick(Sender: TObject);
    procedure miFileCatClick(Sender: TObject);
    procedure miIntFPClick(Sender: TObject);
    procedure miIntINTClick(Sender: TObject);
    procedure miIntLOGOClick(Sender: TObject);
    procedure miSLIClick(Sender: TObject);
    procedure miSPEjectClick(Sender: TObject);
    procedure miSPFileClick(Sender: TObject);
    procedure UnFreeze;
    procedure HideM8;
    procedure menuRebootVMClick(Sender: TObject);
    procedure ShowM8;
    procedure RebootVM;
    procedure ReposWindow;
    procedure RepaintWindow;
    function GetTitleOfActiveWindow: string;
    procedure SendKey(key: Integer; ScanCode: Integer; KeyAction: Integer; Mods: Integer);
    procedure tbDisk1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbDisk2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton5Click(Sender: TObject);
    procedure InsertDisk(Filename: string; Drive: integer);
  private
    lx, ly, lw, lh: integer;
    lastShowTime: TDateTime;
    lastHideTime: TDateTime;
    hidden: boolean;
  public
    procedure AppActivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    constructor Create(TheOwner: TComponent); override;

  end;

var
  GUIForm: TGUIForm;

implementation

{$R *.lfm}

{ TGUIForm }

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
     StatusBar1.SimpleText := GetTitleOfActiveWindow;
     //Memo1.Lines.Add('app is deactivating');
end;

procedure TGUIForm.RebootVM;
begin
       self.hc.Get('http://localhost:38911/api/control/system/reboot');
end;

procedure TGUIForm.Freeze;
begin
       self.hc.Get('http://localhost:38911/api/control/window/freeze');
end;

procedure TGUIForm.miD1BlankClick(Sender: TObject);
begin
        self.hc.Get('http://localhost:38911/api/control/hardware/disk/eject/0');
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
         self.hc.Get('http://localhost:38911/api/control/hardware/disk/eject/1');
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

procedure TGUIForm.miFileCatClick(Sender: TObject);
begin
    self.hc.Get('http://localhost:38911/api/control/system/catalog');
end;

procedure TGUIForm.miIntFPClick(Sender: TObject);
begin
    self.hc.Get('http://localhost:38911/api/control/interpreter/fp');
end;

procedure TGUIForm.miIntINTClick(Sender: TObject);
begin
    self.hc.Get('http://localhost:38911/api/control/interpreter/int');
end;

procedure TGUIForm.miIntLOGOClick(Sender: TObject);
begin
    self.hc.Get('http://localhost:38911/api/control/interpreter/logo');
end;

procedure TGUIForm.miSLIClick(Sender: TObject);
begin
      self.hc.Get('http://localhost:38911/api/control/input/meta/key/i/value/'+TMenuItem(Sender).Caption);
end;

procedure TGUIForm.miSPEjectClick(Sender: TObject);
begin
      self.hc.Get('http://localhost:38911/api/control/hardware/disk/eject/2');
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

procedure TGUIForm.UnFreeze;
begin
       self.hc.Get('http://localhost:38911/api/control/window/unfreeze');
end;

procedure TGUIForm.HideM8;
begin
       if hidden then
         exit;
       //Memo1.Lines.Add('hiding m8 window');
       self.hc.Get('http://localhost:38911/api/control/window/hide');
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
       self.hc.Get('http://localhost:38911/api/control/window/show');
       lastShowTime := Now();
       hidden := false;
end;

procedure TGUIForm.RepaintWindow;
var
  S: TMemoryStream;
  filename: string;
begin
       S := TMemoryStream.Create();
       self.hc.Get('http://localhost:38911/api/control/window/screen', S);
       if S.Size > 0 then
       begin
            filename := GetUserDir + PathSeparator + 'microm8scrn.png';
            StatusBar1.SimpleText:='Got '+IntToStr(S.Size)+' bytes of PNG data';
            S.SaveToFile(filename);
            BackdropImage.Picture.LoadFromFile(filename);
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
     self.hc.SimpleFormPost('http://localhost:38911/api/control/window/position',json,Respo);
     S := Respo.DataString;
     self.StatusBar1.SimpleText:=S;
     Respo.Destroy;
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
     self.hc.SimpleFormPost('http://localhost:38911/api/control/input/keyevent',json,Respo);
     S := Respo.DataString;
     self.StatusBar1.SimpleText:=S;
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
     self.hc.SimpleFormPost('http://localhost:38911/api/control/hardware/disk/insert',json,Respo);
     S := Respo.DataString;
     self.StatusBar1.SimpleText:=json;
     Respo.Destroy;
end;

procedure TGUIForm.tbDisk1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   DiskMenu.Tag := TToolButton(Sender).Tag;
   StatusBar1.SimpleText := 'Disk 1';
end;

procedure TGUIForm.tbDisk2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DiskMenu.Tag := TToolButton(Sender).Tag;
  StatusBar1.SimpleText := 'Disk 2';
end;

procedure TGUIForm.ToolButton5Click(Sender: TObject);
begin
  RebootVM;
end;

procedure TGUIForm.MenuItem1Click(Sender: TObject);
begin

end;

procedure TGUIForm.FormActivate(Sender: TObject);
begin
end;

procedure TGUIForm.FormChangeBounds(Sender: TObject);
begin
  self.ReposWindow;
end;

procedure TGUIForm.Button1Click(Sender: TObject);
begin
     self.ReposWindow;
end;

procedure TGUIForm.BackdropImageClick(Sender: TObject);
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
  s := self.hc.Get('http://localhost:38911/api/control/window/focused');
  if s = '1' then
     Result := 'microM8';
end;
{$ENDIF}

procedure TGUIForm.CheckTimerTimer(Sender: TObject);
begin
  //if MilliSecondsBetween(Now(), lastShowTime) < 500 then
  //   exit;
  if WindowState = wsMinimized then
     exit;
  //if hidden then
  //   exit;
  if GetTitleOfActiveWindow = 'microM8' then
   begin
     //Application.Restore;
     Application.BringToFront;
     {$IFDEF WINDOWS}
     SetForegroundWindow(Application.MainForm.Handle);
     {$ENDIF}
     //StatusBar1.SimpleText := 'App is refocussing';
     lastShowTime := Now();
   end;
end;

procedure TGUIForm.FormCreate(Sender: TObject);
begin
     self.hc := TFPHttpClient.Create(Nil);
     hidden := true;
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
             if ssShift in Shift then
              Result := Integer(Key)
             else if ssCtrl in Shift then
             begin
                if Key = 67 then
                  Result := 3
                else
                  Result := CTRL_A + Integer(Key-64);
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
  StatusBar1.SimpleText := 'keycode ' + IntToStr(Key);
end;

procedure TGUIForm.FormResize(Sender: TObject);
begin
  // on form resize we need to send a size request
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

procedure TGUIForm.MenuItem2Click(Sender: TObject);
begin
  Application.Terminate();
end;

end.

