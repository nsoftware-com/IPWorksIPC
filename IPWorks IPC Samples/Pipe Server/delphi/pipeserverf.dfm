object FormPipeserver: TFormPipeserver
  Left = 0
  Top = 0
  Caption = 'PipeServer Demo'
  ClientHeight = 337
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object INotify: TLabel
    Left = 8
    Top = 8
    Width = 504
    Height = 26
    Caption = 
      'This demo shows how to use the PipeServer component to accept co' +
      'nnections from a PipeClient. Specify the name of the pipe below a' +
      'nd then press Start.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object IPipe: TLabel
    Left = 16
    Top = 48
    Width = 54
    Height = 13
    Caption = 'Pipe Name:'
  end
  object IText: TLabel
    Left = 8
    Top = 288
    Width = 113
    Height = 13
    Caption = 'Send data to the client:'
  end
  object txtPipeName: TEdit
    Left = 96
    Top = 45
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'MyPipeServer'
  end
  object btnStart: TButton
    Left = 272
    Top = 41
    Width = 97
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 392
    Top = 41
    Width = 105
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object tbLog: TListBox
    Left = 8
    Top = 73
    Width = 513
    Height = 209
    ItemHeight = 13
    TabOrder = 3
  end
  object txtMessage: TEdit
    Left = 8
    Top = 307
    Width = 401
    Height = 21
    TabOrder = 4
    Text = 'Hello World!'
  end
  object tbtSend: TButton
    Left = 424
    Top = 307
    Width = 97
    Height = 22
    Caption = 'Send'
    TabOrder = 5
    OnClick = tbtSendClick
  end
  object PipeServer1: TiipPipeServer
    OnConnected = PipeServer1Connected
    OnDataIn = PipeServer1DataIn
    OnDisconnected = PipeServer1Disconnected
    Left = 504
    Top = 24
  end
end


