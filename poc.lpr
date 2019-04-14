program poc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazopenglcontext, main, mixer;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='microm8-gui';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TGUIForm, GUIForm);
  Application.CreateForm(TfrmMixer, frmMixer);
  Application.Run;
end.

