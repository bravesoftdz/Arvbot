object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'ArvBot'
  ClientHeight = 481
  ClientWidth = 461
  Color = clBtnFace
  Constraints.MaxHeight = 508
  Constraints.MinHeight = 508
  Constraints.MinWidth = 469
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 217
    Top = 91
    Width = 244
    Height = 390
    Align = alClient
    TabOrder = 2
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 242
      Height = 83
      Align = alTop
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      DesignSize = (
        242
        83)
      object Button3: TButton
        Left = 4
        Top = 3
        Width = 58
        Height = 25
        Hint = 'Until opened - votes will not be accepted'
        Caption = 'Open Poll'
        TabOrder = 0
        OnClick = Button3Click
      end
      object ButtonClosepoll: TButton
        Left = 66
        Top = 3
        Width = 53
        Height = 25
        Hint = 
          'Summarize results and stop accepting votes. Pressing with alread' +
          'y closed poll will repaste results.'
        Caption = 'Close Poll'
        TabOrder = 1
        OnClick = ButtonClosepollClick
        OnMouseDown = ButtonClosepollMouseDown
      end
      object Button5: TButton
        Left = 177
        Top = 3
        Width = 60
        Height = 25
        Hint = 'Will only clear votes below, not stop poll'
        Caption = 'Clear Votes'
        TabOrder = 2
        OnClick = Button5Click
      end
      object EditQuestion: TEdit
        Left = 5
        Top = 32
        Width = 232
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        TextHint = 'Poll question'
      end
      object ButtonLastcall: TButton
        Left = 122
        Top = 3
        Width = 52
        Height = 25
        Caption = 'Last Call'
        TabOrder = 4
        OnClick = ButtonLastcallClick
      end
      object CheckBoxTimedpoll: TCheckBox
        Left = 5
        Top = 59
        Width = 157
        Height = 17
        Caption = 'Time-limited poll'
        TabOrder = 5
      end
      object SpinEditTimedpoll: TSpinEdit
        Left = 110
        Top = 57
        Width = 126
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 84
      Width = 242
      Height = 50
      Align = alTop
      TabOrder = 1
      DesignSize = (
        242
        50)
      object SpinEdit1: TSpinEdit
        Left = 187
        Top = 3
        Width = 47
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object ProgressBar1: TProgressBar
        Left = 5
        Top = 31
        Width = 229
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        Max = 1
        TabOrder = 1
      end
      object Edit1: TEdit
        Left = 5
        Top = 4
        Width = 176
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TextHint = 'Case 1'
        OnExit = Edit1Exit
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 134
      Width = 242
      Height = 50
      Align = alTop
      TabOrder = 2
      DesignSize = (
        242
        50)
      object SpinEdit2: TSpinEdit
        Left = 187
        Top = 3
        Width = 47
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object ProgressBar2: TProgressBar
        Left = 5
        Top = 31
        Width = 229
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        Max = 1
        TabOrder = 1
      end
      object Edit2: TEdit
        Left = 5
        Top = 3
        Width = 176
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TextHint = 'Case 2'
        OnExit = Edit1Exit
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 184
      Width = 242
      Height = 50
      Align = alTop
      TabOrder = 3
      DesignSize = (
        242
        50)
      object SpinEdit3: TSpinEdit
        Left = 187
        Top = 3
        Width = 47
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object ProgressBar3: TProgressBar
        Left = 5
        Top = 31
        Width = 229
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        Max = 1
        TabOrder = 1
      end
      object Edit3: TEdit
        Left = 5
        Top = 3
        Width = 176
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TextHint = 'Case 3'
        OnExit = Edit1Exit
      end
    end
    object Panel8: TPanel
      Left = 1
      Top = 234
      Width = 242
      Height = 50
      Align = alTop
      TabOrder = 4
      DesignSize = (
        242
        50)
      object SpinEdit4: TSpinEdit
        Left = 187
        Top = 3
        Width = 47
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object ProgressBar4: TProgressBar
        Left = 5
        Top = 31
        Width = 229
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        Max = 1
        Step = 1
        TabOrder = 1
      end
      object Edit4: TEdit
        Left = 5
        Top = 3
        Width = 175
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TextHint = 'Case 4'
        OnExit = Edit1Exit
      end
    end
    object Panel9: TPanel
      Left = 1
      Top = 284
      Width = 242
      Height = 50
      Align = alTop
      TabOrder = 5
      DesignSize = (
        242
        50)
      object SpinEdit5: TSpinEdit
        Left = 187
        Top = 3
        Width = 47
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object ProgressBar5: TProgressBar
        Left = 4
        Top = 31
        Width = 230
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        Max = 1
        Step = 1
        TabOrder = 1
      end
      object Edit5: TEdit
        Left = 5
        Top = 3
        Width = 175
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TextHint = 'Case 5'
        OnExit = Edit1Exit
      end
    end
    object Panel10: TPanel
      Left = 1
      Top = 334
      Width = 242
      Height = 50
      Align = alTop
      TabOrder = 6
      DesignSize = (
        242
        50)
      object SpinEdit6: TSpinEdit
        Left = 187
        Top = 3
        Width = 47
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object ProgressBar6: TProgressBar
        Left = 5
        Top = 31
        Width = 229
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        Max = 1
        Step = 1
        TabOrder = 1
      end
      object Edit6: TEdit
        Left = 5
        Top = 3
        Width = 176
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TextHint = 'Case 6'
        OnExit = Edit1Exit
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 91
    Width = 217
    Height = 390
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 215
      Height = 388
      ActivePage = TabSheetSettings
      Align = alClient
      TabOrder = 0
      object TabSheetMain: TTabSheet
        Caption = 'Main'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object RichEdit1: TRichEdit
          Left = 0
          Top = 29
          Width = 207
          Height = 331
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clHighlightText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HideSelection = False
          HideScrollBars = False
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          Zoom = 100
        end
        object PanelPageControlMainTop: TPanel
          Left = 0
          Top = 0
          Width = 207
          Height = 29
          Align = alTop
          TabOrder = 1
          object Button2: TButton
            Left = 130
            Top = 2
            Width = 75
            Height = 25
            Caption = 'Clear Memo'
            TabOrder = 0
            OnClick = Button2Click
          end
        end
      end
      object TabSheetDebug: TTabSheet
        Caption = 'Debug'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object RichEditDebug: TRichEdit
          Left = 0
          Top = 21
          Width = 207
          Height = 339
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clHighlightText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          Zoom = 100
        end
        object EditRaw: TEdit
          Left = 0
          Top = 0
          Width = 207
          Height = 21
          Hint = 
            'RAW messages to server. Use only if understand and for debugging' +
            '!'
          Align = alTop
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          TextHint = 'For RAW messages to server'
          OnKeyPress = EditRawKeyPress
        end
      end
      object TabSheetListvoted: TTabSheet
        Caption = 'List voted'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object ListBoxVoted: TListBox
          Left = 0
          Top = 0
          Width = 177
          Height = 360
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
        object ListBoxVotedOption: TListBox
          Left = 177
          Top = 0
          Width = 30
          Height = 360
          Align = alRight
          ItemHeight = 13
          TabOrder = 1
        end
      end
      object TabSheetSettings: TTabSheet
        Caption = 'Settings'
        ImageIndex = 2
        object LabelControlChar: TLabel
          Left = 3
          Top = 6
          Width = 100
          Height = 13
          Caption = 'Controlling character'
        end
        object CheckBoxFloodless: TCheckBox
          Left = 3
          Top = 25
          Width = 138
          Height = 17
          Hint = 'Bigger delay between bot'#39's pending messages'
          Caption = 'Flood-less (somewhat)'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 0
          OnClick = CheckBoxFloodlessClick
        end
        object EditControllingChar: TEdit
          Left = 182
          Top = 3
          Width = 24
          Height = 21
          MaxLength = 1
          TabOrder = 1
          Text = '$'
          OnChange = EditControllingCharChange
          OnClick = EditControllingCharChange
          OnKeyPress = EditControllingCharKeyPress
        end
        object ButtonDebug: TButton
          Left = 0
          Top = 332
          Width = 75
          Height = 25
          Caption = 'Debug'
          TabOrder = 2
          OnClick = ButtonDebugClick
        end
        object CheckBoxDouble_Buffered: TCheckBox
          Left = 3
          Top = 48
          Width = 126
          Height = 17
          Caption = 'Double-buffered'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = CheckBoxDouble_BufferedClick
        end
        object CheckBoxClearpollotions: TCheckBox
          Left = 3
          Top = 71
          Width = 166
          Height = 17
          Caption = 'Clear poll upon closing'
          TabOrder = 4
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 91
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 387
      Top = 59
      Width = 64
      Height = 13
      Caption = 'Disconnected'
    end
    object LabelOverallvotes: TLabel
      Left = 391
      Top = 73
      Width = 64
      Height = 13
      Caption = 'Overall votes'
    end
    object Label3: TLabel
      Left = 192
      Top = 59
      Width = 181
      Height = 26
      Hint = 'That'#39's because viewers are able to vote using option'#39's number'
      Caption = 
        'Please remember, that first 2 symbols of any case should not be ' +
        'numbers!'
      ParentShowHint = False
      ShowHint = True
      WordWrap = True
    end
    object ButtonStartbot: TButton
      Left = 356
      Top = 4
      Width = 99
      Height = 25
      Caption = 'Start ArvBot !'
      TabOrder = 0
      OnClick = ButtonStartbotClick
    end
    object EditChannel: TEdit
      Left = 5
      Top = 6
      Width = 345
      Height = 21
      Hint = 'Channel name'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextHint = 'Twitch nickname/channel to connect to'
      OnExit = EditChannelExit
      OnKeyPress = EditChannelKeyPress
    end
    object ButtonVotedList: TButton
      Left = 356
      Top = 31
      Width = 63
      Height = 25
      Caption = 'List Voted'
      TabOrder = 3
      Visible = False
    end
    object ButtonHelp: TButton
      Left = 422
      Top = 31
      Width = 33
      Height = 25
      Caption = 'Help'
      PopupMenu = PopupMenuHelp
      TabOrder = 4
      OnClick = ButtonHelpClick
    end
    object EditOAuth: TEdit
      Left = 5
      Top = 33
      Width = 345
      Height = 21
      Hint = 'Put your OAuth here. More info in help'
      ParentShowHint = False
      PasswordChar = '*'
      ShowHint = True
      TabOrder = 2
      TextHint = 'Your OAuth, see help for more info'
      OnKeyPress = EditOAuthKeyPress
    end
    object ButtonSave: TButton
      Left = 5
      Top = 60
      Width = 100
      Height = 25
      Caption = 'Save OAuth to disk'
      TabOrder = 5
      OnClick = ButtonSaveClick
    end
    object ButtonLoad: TButton
      Left = 111
      Top = 60
      Width = 75
      Height = 25
      Caption = 'Load OAuth'
      TabOrder = 6
      OnClick = ButtonLoadClick
    end
  end
  object IdIRC1: TIdIRC
    ConnectTimeout = 0
    Host = 'irc.twitch.tv'
    IPVersion = Id_IPv4
    ReadTimeout = -1
    CommandHandlers = <>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Nickname = 'arvbot'
    Username = 'arvbot'
    Password = 'oauth:br9b5qznba9sye8jj6egulpnt75zzq'
    UserMode = []
    OnRaw = IdIRC1Raw
    Left = 176
    Top = 424
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 136
    Top = 376
  end
  object TimerMessages: TTimer
    Interval = 2500
    OnTimer = TimerMessagesTimer
    Left = 176
    Top = 376
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 136
    Top = 424
  end
  object PopupMenuHelp: TPopupMenu
    MenuAnimation = [maTopToBottom]
    Left = 176
    Top = 336
    object MenuItemStarting: TMenuItem
      Caption = 'Starting with bot'
      OnClick = MenuItemStartingClick
    end
    object MenuItemOAuth: TMenuItem
      Caption = 'OAuth'
      OnClick = MenuItemOAuthClick
    end
    object MenuItemTips: TMenuItem
      Caption = 'Tips and Hints'
      OnClick = MenuItemTipsClick
    end
    object MenuItemReports: TMenuItem
      Caption = 'Bugs and Errors'
      OnClick = MenuItemReportsClick
    end
    object MenuItemContacts: TMenuItem
      Caption = 'Contacts'
      OnClick = MenuItemContactsClick
    end
  end
  object TimerTimedpollLC: TTimer
    Enabled = False
    OnTimer = TimerTimedpollLCTimer
    Left = 50
    Top = 387
  end
  object TimerTimedpoll: TTimer
    Enabled = False
    OnTimer = TimerTimedpollTimer
    Left = 8
    Top = 384
  end
  object IdIRCTest: TIdIRC
    ConnectTimeout = 0
    Host = 'irc.twitch.tv'
    IPVersion = Id_IPv4
    ReadTimeout = -1
    CommandHandlers = <>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Username = ''
    Password = ''
    UserMode = []
    OnRaw = IdIRCTestRaw
    Left = 48
    Top = 344
  end
  object TimerNoop: TTimer
    Interval = 300000
    OnTimer = TimerNoopTimer
    Left = 90
    Top = 385
  end
end
