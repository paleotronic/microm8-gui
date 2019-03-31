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
    MenuItem2: TMenuItem;
    embedPanel: TPanel;
    menuRebootVM: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    DiskMenu: TPopupMenu;
    StatusBar1: TStatusBar;
    hc: TFPHttpClient;
    CheckTimer: TTimer;
    ToolBar1: TToolBar;
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
    procedure UnFreeze;
    procedure HideM8;
    procedure menuRebootVMClick(Sender: TObject);
    procedure ShowM8;
    procedure RebootVM;
    procedure ReposWindow;
    procedure RepaintWindow;
    function GetTitleOfActiveWindow: string;
    procedure SendKey(key: Char; ScanCode: Integer; KeyAction: Integer; Mods: Integer);
    procedure tbDisk1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbDisk2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton5Click(Sender: TObject);
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
     StatusBar1.SimpleText := 'App has gained focus!';
     if MillisecondsBetween(Now(), lastHideTime) < 1000 then
      exit;
     ShowM8;
     //Memo1.Lines.Add('app is activating');
end;

procedure TGUIForm.AppDeactivate(Sender: TObject);
begin
     if MillisecondsBetween(Now(), lastShowTime) < 1000 then
      exit;
     RepaintWindow;
     HideM8;
     StatusBar1.SimpleText := 'App has lost focus!';
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

procedure TGUIForm.SendKey(key: Char; ScanCode: Integer; KeyAction: Integer; Mods: Integer);
var
  json, S: string;
  Respo: TStringStream;
begin
     if key = Char(8) then
        key := Char(127);

     json := '{"key":' + IntToStr(Ord(key)) +
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
  if hidden then
     exit;
  if GetTitleOfActiveWindow = 'microM8' then
   begin
     //Application.Restore;
     Application.BringToFront;
     {$IFDEF WINDOWS}
     SetForegroundWindow(Application.MainForm.Handle);
     {$ENDIF}
     StatusBar1.SimpleText := 'App is refocussing';
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

procedure TGUIForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
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
  SendKey( Char(Key), 0, 1, m );
end;

procedure TGUIForm.FormKeyPress(Sender: TObject; var Key: char);
begin
  SendKey( Key, 0, 1, 0 );
end;

procedure TGUIForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  SendKey( Char(Key), 0, 0, m );
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

