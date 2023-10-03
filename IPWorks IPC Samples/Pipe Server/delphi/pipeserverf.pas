(*
 * IPWorks IPC 2022 Delphi Edition - Sample Project
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
unit pipeserverf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, iipcore, iiptypes, iippipeserver;

type
  TFormPipeserver = class(TForm)
    INotify: TLabel;
    IPipe: TLabel;
    txtPipeName: TEdit;
    btnStart: TButton;
    btnStop: TButton;
    tbLog: TListBox;
    IText: TLabel;
    txtMessage: TEdit;
    tbtSend: TButton;
    PipeServer1: TiipPipeServer;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure tbtSendClick(Sender: TObject);
    procedure PipeServer1Connected(Sender: TObject; ConnectionId: Integer);
    procedure PipeServer1DataIn(Sender: TObject; ConnectionId: Integer;
      Text: string; TextB: TArray<System.Byte>; EOL: Boolean);
    procedure PipeServer1Disconnected(Sender: TObject; ConnectionId: Integer);

  private
    clientId: Integer;
  public
    { Public declarations }
  end;

var
  FormPipeserver: TFormPipeserver;

implementation

{$R *.dfm}

procedure TFormPipeserver.btnStartClick(Sender: TObject);
begin
      PipeServer1.PipeName :=  txtPipeName.Text;
      PipeServer1.DefaultEOL := #13#10;
      PipeServer1.Listening := True;
      tbLog.Items.Add('Server started. ' + #13#10);
end;

procedure TFormPipeserver.btnStopClick(Sender: TObject);
begin
      PipeServer1.Listening := False;
      PipeServer1.Shutdown();
      tbLog.Items.Add('Server stopped. ' + #13#10);
end;

procedure TFormPipeserver.PipeServer1Connected(Sender: TObject;
  ConnectionId: Integer);
begin
  tbLog.Items.Add('PipeClient ' + IntToStr(ConnectionId) + ' has connected.' + #13#10);
  clientId := ConnectionId;
end;

procedure TFormPipeserver.PipeServer1DataIn(Sender: TObject;
  ConnectionId: Integer; Text: string; TextB: TArray<System.Byte>; EOL: Boolean);
begin
      tbLog.Items.Add('Echoing [' + IntToStr(ConnectionId) + ']: ' + Text + #13#10);
      PipeServer1.DataToSend[ConnectionId] := Text + #13#10;
end;

procedure TFormPipeserver.PipeServer1Disconnected(Sender: TObject;
  ConnectionId: Integer);
begin
      tbLog.Items.Add('PipeClient ' + IntToStr(ConnectionId) + ' disconnected.' + #13#10);
end;

procedure TFormPipeserver.tbtSendClick(Sender: TObject);
begin
     try
      PipeServer1.DataToSend[clientId] := txtMessage.Text + #13#10;
      tbLog.Items.Add('Sending ' + txtMessage.Text + #13#10);
    except on E: Exception do
      ShowMessage(E.Message);
    end;
end;

end.

