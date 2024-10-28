object FormPipeexec: TFormPipeexec
  Left = 0
  Top = 0
  Caption = 'PipeExec Demo'
  ClientHeight = 394
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    593
    394)
  PixelsPerInch = 96
  TextHeight = 13
  object INotify: TLabel
    Left = 8
    Top = 8
    Width = 577
    Height = 25
    AutoSize = False
    Caption = 
      'This demo shows how to use the PipeExec component to launch a pr' +
      'ocess then send and receive data to and from the process. Start ' +
      'the process below, then type input in the textbox.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 39
    Width = 577
    Height = 115
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Process Information'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Path:'
    end
    object Label2: TLabel
      Left = 16
      Top = 51
      Width = 26
      Height = 13
      Caption = 'Args:'
    end
    object tProcessPath: TEdit
      Left = 64
      Top = 21
      Width = 377
      Height = 21
      TabOrder = 0
      Text = 'C:\Windows\System32\cmd.exe'
    end
    object tProcessArgs: TEdit
      Left = 64
      Top = 48
      Width = 377
      Height = 21
      TabOrder = 1
      Text = '/Q'
    end
    object bStart: TButton
      Left = 64
      Top = 75
      Width = 81
      Height = 25
      Caption = '&Start'
      TabOrder = 2
      OnClick = bStartClick
    end
  end
  object tOutput: TMemo
    Left = 8
    Top = 160
    Width = 577
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
    OnKeyPress = tOutputKeyPress
  end
  object iipPipeExec1: TiipPipeExec
    OnStderr = iipPipeExec1Stderr
    OnStdout = iipPipeExec1Stdout
    Left = 464
    Top = 96
  end
end


