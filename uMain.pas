unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Dialogs,
  Vcl.ActnList, System.Actions, Vcl.StdActns, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Controls, Vcl.Forms, Dm;

type
  TfrmMain = class(TForm)
    btnConnect: TButton;
    edtDBName: TEdit;
    edtHost: TEdit;
    edtPassword: TEdit;
    edtUsername: TEdit;
    lblDBName: TLabel;
    lblHost: TLabel;
    lblPassword: TLabel;
    lblPort: TLabel;
    lblUser: TLabel;
    sePort: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
  private
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  DataModule1.InitDriverLink;
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  try
    if string(edtHost.Text).Trim.IsEmpty then
      edtHost.Text := 'localhost';
    if string(edtUsername.Text).Trim.IsEmpty then
      edtUsername.Text := 'postgres';
    if string(edtPassword.Text).Trim.IsEmpty then
      edtPassword.Text := 'postgres';

    DataModule1.ConnectToDatabase(edtDBName.Text, edtHost.Text, sePort.Value.ToString, edtUsername.Text, edtPassword.Text);
    ShowMessage('Congratulations!' + sLineBreak + 'Connection to "' + edtDBName.Text + '" is successful');
  except
    on E: Exception do
      ShowMessage('Connection to "' + edtDBName.Text + '" failed. Check your settings.' + sLineBreak + E.Message);
  end;
end;

end.
