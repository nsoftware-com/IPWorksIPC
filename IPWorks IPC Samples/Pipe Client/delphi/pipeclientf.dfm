object FormPipeclient: TFormPipeclient
  Left = 0
  Top = 0
  Caption = 'PipeClient Demo'
  ClientHeight = 394
  ClientWidth = 463
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
    Width = 449
    Height = 55
    AutoSize = False
    Caption = 
      'This is a demo to show how to use the PipeClient component to co' +
      'nnect to a PipeServer. Specify the pipe name below and press Con' +
      'nect to establish a connection. Data may then be sent and receiv' +
      'ed.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object IServer: TLabel
    Left = 8
    Top = 75
    Width = 50
    Height = 13
    Caption = 'Pipe Name'
  end
  object IText: TLabel
    Left = 8
    Top = 144
    Width = 136
    Height = 13
    Caption = 'Enter the text to send here:'
  end
  object IData: TLabel
    Left = 216
    Top = 69
    Width = 130
    Height = 13
    Caption = 'Data received from server:'
  end
  object txtPipeName: TEdit
    Left = 80
    Top = 72
    Width = 105
    Height = 21
    TabOrder = 0
    Text = 'MyPipeServer'
  end
  object tbtConnect: TButton
    Left = 8
    Top = 113
    Width = 81
    Height = 25
    Caption = 'Connect'
    TabOrder = 1
    OnClick = tbtConnectClick
  end
  object txtText: TEdit
    Left = 8
    Top = 168
    Width = 177
    Height = 21
    TabOrder = 2
    Text = 'Echo this text.'
  end
  object tbtSend: TButton
    Left = 48
    Top = 352
    Width = 97
    Height = 25
    Caption = 'Send'
    TabOrder = 3
    OnClick = tbtSendClick
  end
  object ITrack: TListBox
    Left = 216
    Top = 88
    Width = 241
    Height = 281
    ItemHeight = 13
    TabOrder = 4
  end
  object tbtDisconnect: TButton
    Left = 104
    Top = 113
    Width = 81
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 5
    OnClick = tbtDisconnectClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 200
    Width = 177
    Height = 146
    Caption = 'Status'
    TabOrder = 6
    object ListStatus: TListBox
      Left = 0
      Top = 16
      Width = 177
      Height = 127
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object PipeClient1: TiipPipeClient
    OnConnected = PipeClient1Connected
    OnDataIn = PipeClient1DataIn
    OnDisconnected = PipeClient1Disconnected
    Left = 160
    Top = 352
  end
end


