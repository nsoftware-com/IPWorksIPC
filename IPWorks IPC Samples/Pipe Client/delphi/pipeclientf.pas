(*
 * IPWorks IPC 2024 Delphi Edition - Sample Project
 *
 * This sample project demonstrates the usage of IPWorks IPC in a 
 * simple, straightforward way. It is not intended to be a complete 
 * application. Error handling and other checks are simplified for clarity.
 *
 * www.nsoftware.com/ipworksipc
 *
 * This code is subject to the terms and conditions specified in the 
 * corresponding product license agreement which outlines the authorized 
 * usage and restrictions.
 *)
unit pipeclientf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, iipcore, iiptypes, iippipeclient;

type
  TFormPipeclient = class(TForm)
    INotify: TLabel;
    IServer: TLabel;
    txtPipeName: TEdit;
    tbtConnect: TButton;
    IText: TLabel;
    txtText: TEdit;
    tbtSend: TButton;
    ITrack: TListBox;
    IData: TLabel;
    tbtDisconnect: TButton;
    GroupBox1: TGroupBox;
    ListStatus: TListBox;
    PipeClient1: TiipPipeClient;
    procedure tbtConnectClick(Sender: TObject);
    procedure tbtDisconnectClick(Sender: TObject);
    procedure tbtSendClick(Sender: TObject);
    procedure PipeClient1Connected(Sender: TObject);
    procedure PipeClient1DataIn(Sender: TObject; Text: string; TextB: TArray<System.Byte>; EOL: Boolean);
    procedure PipeClient1Disconnected(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPipeclient: TFormPipeclient;

implementation

{$R *.dfm}


procedure TFormPipeclient.PipeClient1Connected(Sender: TObject);
begin
  ListStatus.Items.Add('Connected.');
end;

procedure TFormPipeclient.PipeClient1DataIn(Sender: TObject; Text: string; TextB: TArray<System.Byte>;
  EOL: Boolean);
begin
  ITrack.Items.Add('Received ''' + Text + '''' + #13#10);
end;

procedure TFormPipeclient.PipeClient1Disconnected(Sender: TObject);
begin
  ListStatus.Items.Add('Disconnected.');
end;

procedure TFormPipeclient.tbtConnectClick(Sender: TObject);
begin
    ITrack.Clear;
    tbtSend.Enabled := False;
    tbtConnect.Enabled := False;
    PipeClient1.PipeName := txtPipeName.Text;
    PipeClient1.EOL := #13#10;
    try
       PipeClient1.Connect();
    except on E: Exception do
      ShowMessage(E.Message);
    end;
    tbtConnect.Enabled := True;
    tbtSend.Enabled := True;
end;

procedure TFormPipeclient.tbtDisconnectClick(Sender: TObject);
begin
    tbtDisconnect.Enabled := False;
    PipeClient1.Disconnect();
    tbtDisconnect.Enabled := True;
end;

procedure TFormPipeclient.tbtSendClick(Sender: TObject);
begin
      if PipeClient1.Connected then
      begin
         PipeClient1.SendText(txtText.Text + #13#10);
         ITrack.Items.Add('Sending ''' + txtText.Text + '''' + #13#10);
      end
      else begin
        ITrack.Items.Add('You are not connected.' + #13#10);
      end;
end;

end.

