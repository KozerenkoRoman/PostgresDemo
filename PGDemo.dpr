program PGDemo;

uses
  Vcl.Forms,
  Windows,
  uMain in 'uMain.pas' {frmMain},
  dm in 'dm.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
