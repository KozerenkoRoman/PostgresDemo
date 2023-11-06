unit dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB;

type
  TDataModule1 = class(TDataModule)
    Connection: TFDConnection;
  private
    FPGDriverLink: TFDPhysPgDriverLink;
  public
    procedure ConnectToDatabase(const aDatabase, aHost, aPort, aUserName, aPassword: string);
    procedure DisconnectFromDatabase;
    procedure InitDriverLink;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.InitDriverLink;
begin
  if not Assigned(FPGDriverLink) then
  begin
    FPGDriverLink := TFDPhysPgDriverLink.Create(Self);
    FPGDriverLink.Release;
    FPGDriverLink.VendorLib := ExtractFilePath(ParamStr(0)) +
     {$IFDEF CPUX64}'..\PGlib\bin64\libpq.dll' {$ELSE}  '..\PGlib\bin\libpq.dll'{$ENDIF CPUX64};
  end;
end;

procedure TDataModule1.ConnectToDatabase(const aDatabase, aHost, aPort, aUserName, aPassword: string);
begin
  InitDriverLink;
  Connection.Close;
  Connection.Params.DriverID := 'PG';
  Connection.Params.Database := aDatabase;
  if aHost <> '' then
    Connection.Params.Values['Server'] := aHost;
  if aPort <> '' then
    Connection.Params.Values['Port'] := aPort;
  if aUserName <> '' then
    Connection.Params.Values['User_Name'] := aUserName;
  if aPassword <> '' then
    Connection.Params.Values['Password'] := aPassword;
  Connection.Open;
end;

procedure TDataModule1.DisconnectFromDatabase;
begin
  Connection.Close;
end;

end.
