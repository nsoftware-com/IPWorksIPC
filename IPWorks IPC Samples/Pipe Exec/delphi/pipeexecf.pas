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
unit pipeexecf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, iipcore, iiptypes, iippipeexec;

type
  TFormPipeexec = class(TForm)
    INotify: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    tProcessPath: TEdit;
    tProcessArgs: TEdit;
    bStart: TButton;
    tOutput: TMemo;
    iipPipeExec1: TiipPipeExec;
    procedure bStartClick(Sender: TObject);
    procedure tOutputKeyPress(Sender: TObject; var Key: Char);
    procedure ScrollOutput();
    procedure iipPipeExec1Stderr(Sender: TObject; Text: string; TextB: TArray<System.Byte>; EOL: Boolean);
    procedure iipPipeExec1Stdout(Sender: TObject; Text: string; TextB: TArray<System.Byte>; EOL: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPipeexec: TFormPipeexec;

implementation

{$R *.dfm}

// Scroll to the end of tOutput
procedure TFormPipeexec.ScrollOutput();
begin
  SendMessage(tOutput.Handle, EM_LINESCROLL, 0, tOutput.Lines.Count);
end;

procedure TFormPipeexec.tOutputKeyPress(Sender: TObject; var Key: Char);
var
  Text: string; TextB: TArray<System.Byte>;
begin
  Try
    if (Key = Chr(VK_RETURN))then
      text := #13#10
    else
      text := Key;

    iipPipeExec1.Stdin := text;

    tOutput.Text := tOutput.Text + text;
    tOutput.SelStart := Length(tOutput.Text);
    ScrollOutput();

    Key := #0;
  Except
    // Ignore Exceptions
  End;
end;

procedure TFormPipeexec.bStartClick(Sender: TObject);
begin
  Try
    if (bStart.Caption = '&Start') then
    begin
      tOutput.Clear();
      iipPipeExec1.ProcessFileName := tProcessPath.Text;
      iipPipeExec1.ProcessArgs := tProcessArgs.Text;
      iipPipeExec1.StartProcess();
      bStart.Caption := '&Stop';
    end
    else
    begin
      iipPipeExec1.StopProcess();
      bStart.Caption := '&Start';
    end;
  Except on E: Exception do
    ShowMessage('Error: ' + E.Message)
  End;
end;

procedure TFormPipeexec.iipPipeExec1Stderr(Sender: TObject; Text: string; TextB: TArray<System.Byte>;
  EOL: Boolean);
begin
  tOutput.Text := tOutput.Text + Text;
  tOutput.SelStart := Length(tOutput.Text);
  ScrollOutput();
end;

procedure TFormPipeexec.iipPipeExec1Stdout(Sender: TObject; Text: string; TextB: TArray<System.Byte>;
  EOL: Boolean);
begin
  tOutput.Text := tOutput.Text + Text;
  tOutput.SelStart := Length(tOutput.Text);
  ScrollOutput();
end;


end.

