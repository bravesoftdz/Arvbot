unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, Vcl.ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdCmdTCPClient, IdIRC, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Samples.Spin, ShellApi, Vcl.Menus,
  StrUtils, SideFunctions;

type TAuthor = record
   email: string;
  end;

const
  CasesCount: byte = 6;
  intSize = SizeOf(integer);
  Author: TAuthor = (email: 'Netoen@ya.ru');
  DefaultCommandChar: char = '$';
  HelpStrings: array of string = ['1) launch it. Specify channel name (to join to) and hit "Start ArvBot". It will greet you in channel if you did it right' +#13#10+
'2) write down poll options in fields right to the memo. For now empty fields will be ignored' +sLineBreak+
'3) Hit "Open poll" button. It should announce poll in both memo and twitch chat' +sLineBreak+
'4) let people vote using $vote <option>, where option can be both #<case> as well as <case_text>. For example $vote 3 or $vote Shadow of Mordor' +sLineBreak+
'5) When finished voting, hit "Close Poll" button. It will summarize results in both memo and twitch chat' +sLineBreak+
'6) Hit "Clear votes" if needed.' +sLineBreak+
'7) repeat as many times as you want'
,
'You can use middle mouse button on "Close poll" button to close poll withouht summarizing'
,
'If you try to do something (say, pressing button) and nothing really happens - try pressing "debuging" checkbox and look there for "ERROR" message. If any - please notify me. It will be fixed ASAP.' +sLineBreak+
'atm most of the bugs probably can be gone through by just restarting the program.' +sLineBreak+
'Remember about first 2 symbols not being numeric, as it will try to count vote towards its number first and only otherwise check vote as a text.'
,
'All suggestions, bugs and everything else about program feel free, and please do so, to send over to netoen@yandex.ru'
,
'To get your OAuth pls follow this link: http://www.twitchapps.com/tmi/' +sLineBreak+
'Press "Ok" to get sent to that site' +sLineBreak+
'Don''t worry, it will be only used once to check your twitch account' +sLineBreak+
'It is made to protect people from abusing bot in non-owned channels'];

type TMyFunctionResult = record
   Code: integer;    // -3 changevote -2 error, 1-99 positive, -1 negative
   Text: String;
  end;

type TmyFile = record
   size: integer;
   buffer: shortstring;
  end;

type TTwitchMessage = record
   Nickname, Id, Color, Text, Channel: String;
   IsMod: boolean;
  end;

type
  TForm1 = class(TForm)
    ButtonStartbot: TButton;
   IdIrc1: TIdIrc;
   Edit1,Edit2,Edit3,Edit4,Edit5,Edit6: TEdit;
   EditRaw, EditChannel: TEdit;
   Label1,
    LabelOverallvotes: TLabel;
   SpinEdit1,SpinEdit2,SpinEdit3,SpinEdit4,SpinEdit5,SpinEdit6: TSpinEdit;
   Panel1,Panel2,Panel3,Panel4,Panel5,Panel6,Panel7,Panel8,Panel9,Panel10: TPanel;
   ProgressBar1,ProgressBar2,ProgressBar3,ProgressBar4,ProgressBar5,ProgressBar6: TProgressBar;
   Timer1, TimerMessages: TTimer;
    CheckBoxFloodless: TCheckBox;
    IdAntiFreeze1: TIdAntiFreeze;
    RichEdit1: TRichEdit;
    RichEditDebug: TRichEdit;
    ButtonVotedList: TButton;
    Label3: TLabel;
    ButtonHelp: TButton;
    EditQuestion: TEdit;
    PageControl1: TPageControl;
    TabSheetMain: TTabSheet;
    TabSheetDebug: TTabSheet;
    TabSheetSettings: TTabSheet;
    EditControllingChar: TEdit;
    LabelControlChar: TLabel;
    ButtonDebug: TButton;
    EditOAuth: TEdit;
    PopupMenuHelp: TPopupMenu;
    MenuItemStarting: TMenuItem;
    MenuItemTips: TMenuItem;
    MenuItemReports: TMenuItem;
    MenuItemContacts: TMenuItem;
    PanelPageControlMainTop: TPanel;
    CheckBoxDouble_Buffered: TCheckBox;
    CheckBoxTimedpoll: TCheckBox;
    SpinEditTimedpoll: TSpinEdit;
    TimerTimedpollLC: TTimer;
    TimerTimedpoll: TTimer;
    IdIRCTest: TIdIRC;
    MenuItemOAuth: TMenuItem;
    ButtonSave: TButton;
    ButtonLoad: TButton;
    TabSheetListvoted: TTabSheet;
    ListBoxVoted: TListBox;
    CheckBoxClearpollotions: TCheckBox;
    ListBoxVotedOption: TListBox;
    TimerNoop: TTimer;
    procedure ButtonStartbotClick(Sender: TObject);
    procedure IdIRC1Raw(ASender: TIdContext; AIn: Boolean;
      const AMessage: string);
    procedure CheckBoxDouble_BufferedClick(Sender: TObject);
    procedure EditChannelKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure EditRawKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure ButtonClosepollClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonLastcallClick(Sender: TObject);
    procedure TimerMessagesTimer(Sender: TObject);
    procedure CheckBoxFloodlessClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure ButtonClosepollMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditControllingCharChange(Sender: TObject);
    procedure EditControllingCharKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonDebugClick(Sender: TObject);
    procedure MenuItemStartingClick(Sender: TObject);
    procedure MenuItemTipsClick(Sender: TObject);
    procedure MenuItemReportsClick(Sender: TObject);
    procedure MenuItemContactsClick(Sender: TObject);
    procedure TimerTimedpollLCTimer(Sender: TObject);
    procedure TimerTimedpollTimer(Sender: TObject);
    procedure IdIRCTestRaw(ASender: TIdContext; AIn: Boolean;
      const AMessage: string);
    procedure MenuItemOAuthClick(Sender: TObject);
    procedure EditChannelExit(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure EditOAuthKeyPress(Sender: TObject; var Key: Char);
    procedure TimerNoopTimer(Sender: TObject);
  private
    function Useralreadyvoted(out i: integer; const AMessage:  TTwitchMessage): boolean;
    procedure LaunchClientConnection(const code: shortint);
    procedure TextToCommand(const AMessage: String; var return: TStringList);
    procedure AnalyzeTwitchMessage(const AMessage: String; var ReturnMessage: TTwitchMessage);
    procedure AnalyzeCommand(const AMessage: TTwitchMessage; var Command: TStringList);
    procedure AcceptVote(const AMessage: TTwitchMessage; AVote: byte);
    procedure RejectVote(const ANickname, AReason: String);
    procedure SetNewValue(Sender: TSpinEdit);
    procedure Summarize;
    procedure TestVote(const AMessage: TTwitchMessage; const Command: TStringList; MyAttributes: byte);
    procedure SyncVLCMessage(const AMessage: string);
    procedure AnouncePoll(var buffer: string);
  public
    { Public declarations }
  end;

  type TOngoingPoll = record
   Question: String;
   IsOn: Boolean;
  end;

  type TVotes = record
   Id, Nickname: String;
   Vote: byte;
  end;

var
  Form1: TForm1;
  OverallVotes: Cardinal;
  OngoingPoll: TOngoingPoll;
  Votes: array of TVotes;
  PendingMessages: String;
  MaxValue: word = 1;
  StringNumbers: set of '0'..'9' = ['0'..'9'];
  StringLowLetters: set of 'a'..'z' = ['a'..'z'];
  StringHighLetters: set of 'A'..'Z' = ['A'..'Z'];

implementation

{$R *.dfm}

procedure TForm1.ButtonStartbotClick(Sender: TObject);
begin
 if IdIrc1.Connected then
 begin
  try
   try
    IdIrc1.IOHandler.InputBuffer.Clear;
    IdIrc1.Part(#35 + EditChannel.Text, 'Leaving');
    IdIrc1.Disconnect('Leaving');
   except
   on E: Exception do
    begin
     RichEdit1.Lines.Add('Error trying to disonnect from server: ' + E.Message);
     RichEditDebug.Lines.Add('Error trying to disconnect from server: ' + E.Message);
    end;
   end;
  finally
  ButtonStartbot.Caption := 'Start ArvBot!';
  RichEdit1.Lines.Add('DisConnecting from twitch');
  RichEditDebug.Lines.Add('DisConnecting from twitch');
  EditChannel.Enabled := True;
  if IdIRCTest.Connected then
   try
    IdIrc1.IOHandler.InputBuffer.Clear;
    IdIRCTest.Disconnect('Leaving');
   except
    on E: Exception do RichEdit1.Lines.Add('[ERROR] trying to disconnect on identefication socket' + E.Message);
   end;
  end;
 end
 else if (EditChannel.Text <> '') and (EditOAuth.Text <> '') then
 begin
  ButtonStartbot.Enabled := False;
  IdIRCTest.Nickname := EditChannel.Text;
  IdIRCTest.Username := EditChannel.Text;
  IdIRCTest.Password := EditOAuth.Text;
  try IdIRCTest.Connect;
  except
   on E: Exception do
   begin
    RichEdit1.Lines.Add('[ERROR] trying to check your L/P: ' + E.Message);
    RichEditDebug.Lines.Add('[ERROR] trying to check your L/P: ' + E.Message);
    IdIrc1.Disconnect('Leaving');
   end;
  end;
//  EditChannel.Text := 'arvaneleron';
 end
 else {EditChannel.Text := 'netoen'; }ShowMessage('You need to specify your twitch nickname and OAuth first!');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 RichEdit1.Clear;
end;

procedure TForm1.AnouncePoll(var buffer: string);
var i: byte;
begin
  buffer := EditQuestion.Text + ' | Vote using ' + EditControllingChar.Text + 'vote <option> for: ';
  for i := 1 to CasesCount do
   if TEdit(FindComponent('Edit' + IntToStr(i))).Text <> '' then
    buffer := buffer + IntToStr(i) + ':{' + TEdit(FindComponent('Edit' + IntToStr(i))).Text + '}; ';
end;

procedure TForm1.Button3Click(Sender: TObject);  // Open Poll
var buffer: String; i: byte;
begin
 if not OngoingPoll.IsOn then
 begin
  if CheckBoxTimedpoll.Checked and (SpinEditTimedpoll.Value > 0) then
  begin
   TimerTimedpoll.Interval := SpinEditTimedpoll.Value * 1000;
   TimerTimedpollLC.Interval := SpinEditTimedpoll.Value * 800;
   TimerTimedpoll.Enabled := True;
   TimerTimedpollLC.Enabled := True;
  end;
  OngoingPoll.IsOn := True;
  AnouncePoll(buffer);
//  RichEdit1.SelAttributes.Color := clBlack;
  if CheckBoxTimedpoll.Checked and (SpinEditTimedpoll.Value > 0) then
   buffer := buffer + ' Poll will be going for ' + IntToStr(SpinEditTimedpoll.Value) + ' seconds!';
  RichEdit1.Lines.Add(buffer);
  if IdIrc1.Connected then
   IdIrc1.Say(#35 + EditChannel.Text, buffer);
 end
 else ShowMessage('Already has been started');
end;

procedure TForm1.ButtonClosepollClick(Sender: TObject);  // Close poll
begin
 if OngoingPoll.IsOn then
 begin
  OngoingPoll.IsOn := False;
  Summarize;
  SetLength(Votes, 0);
  if CheckBoxClearpollotions.Checked then Button5Click(Self);
 end
 else Summarize;
end;

procedure TForm1.ButtonClosepollMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button = mbMiddle then
  if OngoingPoll.IsOn then
  begin
   OngoingPoll.IsOn := False;
   RichEdit1.Lines.Add('Closed poll without summarizing');
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var i: byte;
begin
 SetLength(Votes, 0);
 for i := 1 to CasesCount do
 begin
  with TProgressBar(FindComponent('ProgressBar' + IntToStr(i))) do
  begin
   Position := 0;
   Max := 1;
  end;
  TSpinEdit(FindComponent('SpinEdit' + IntToStr(i))).Value := 0;
  TEdit(FindComponent('Edit' + IntToStr(i))).Text := '';
 end;
 EditQuestion.Text := '';
 ListBoxVoted.Clear;
 MaxValue := 1;
end;

procedure TForm1.ButtonLastcallClick(Sender: TObject);
var buffer: string;
begin
 buffer := 'LAST CALL';//. Be sure to vote cause poll is closing soon!';
 RichEdit1.Lines.Add(buffer);
 if IdIrc1.Connected then IdIrc1.Say(#35 + EditChannel.Text, buffer + ' SwiftRage');
end;

procedure TForm1.ButtonSaveClick(Sender: TObject);
var
 FileStream1: TFileStream;
 myFile: TmyFile;
begin
 EditOAuth.SetFocus;
 if (EditOAuth.Text <> '') and (EditChannel.Text <> '') then
 begin
  FileStream1 := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'settings.ini', fmCreate);
  try
   myFile.buffer := XorStr(EditOAuth.Text, EditChannel.Text);
   myFile.size := SizeOf(myFile.buffer);
   try
    FileStream1.WriteBuffer(myFile.size, intSize);
    FileStream1.WriteBuffer(myFile.buffer, myFile.size);
   except on E: Exception do SyncVLCMessage('[ERROR] trying to write to file: ' + E.Message);
   end;
  finally
   FileStream1.Free;
  end;
 end
 else ShowMessage('You need to specify twitch nickname and OAuth first !');
end;

procedure TForm1.ButtonLoadClick(Sender: TObject);
var
 FileStream1: TFileStream;
 myFile: TmyFile;
begin
 if EditChannel.Text = '' then ShowMessage('You need to specify twitch nickname first !')
 else
 begin
  EditOAuth.SetFocus;
  FileStream1 := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'settings.ini', fmOpenReadWrite);
  try
   try
    FileStream1.ReadBuffer(myFile.size, intSize);
    FileStream1.ReadBuffer(myFile.buffer, myFile.size);
   except on E: Exception do SyncVLCMessage('[ERROR] trying to read from file: ' + E.Message);
   end;
   EditOAuth.Text := XorStr(myFile.buffer, EditChannel.Text);
  finally
   FileStream1.Free;
  end;
 end;
end;

procedure TForm1.ButtonDebugClick(Sender: TObject);
begin
 EditQuestion.Text := 'q w e ?';
 Edit1.Text := 'q';
 Edit2.Text := 'w';
 Edit3.Text := 'e';
// MessageDlg(GetFileVersion());
end;

procedure TForm1.ButtonHelpClick(Sender: TObject);
var s: String;
begin
//ShowMessage(s);
PopupMenuHelp.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TForm1.CheckBoxFloodlessClick(Sender: TObject);
begin
 if CheckBoxFloodless.Checked then TimerMessages.Interval := 2500 else TimerMessages.Interval := 1000;
end;

procedure TForm1.CheckBoxDouble_BufferedClick(Sender: TObject);
begin
 Form1.DoubleBuffered := CheckBoxDouble_Buffered.Checked;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
var restrictor: byte; s: string;
begin
 restrictor := 0;
 while (AnsiPos(#32#32, TEdit(Sender).Text) <> 0) and (restrictor < 100) do
 begin
  TEdit(Sender).Text := AnsiReplaceStr(TEdit(Sender).Text, #32#32, #32);
  inc(restrictor);
 end;
 if TEdit(Sender).Text <> '' then
 begin
  s := TEdit(Sender).Text;
  if s[1] = #32 then
  begin
   s := Copy(s, 2, high(integer));
   TEdit(Sender).Text := s;
  end;
 end;
end;

procedure TForm1.EditChannelExit(Sender: TObject);
begin
 EditChannel.Text := AnsiLowerCase(EditChannel.Text);
end;

procedure TForm1.EditChannelKeyPress(Sender: TObject; var Key: Char);
var s: String;
begin
 if Key = #13 then
 begin
  ButtonStartbot.Click;
  exit;
 end;
 if not ((Key in StringNumbers) or (Key in StringLowLetters) or
  (Key in StringHighLetters) or (Key = '_') or (Key = #3) or (Key = #8)) then
  Key := #0;
// EditChannel.Text := IntToStr(Ord(key));
// Key := #0;
end;

procedure TForm1.EditControllingCharChange(Sender: TObject);
begin
 if AnsiPos(EditControllingChar.Text, '!@#$%^&*') = 0 then EditControllingChar.Text := DefaultCommandChar;
 EditControllingChar.SelectAll;
end;

procedure TForm1.EditControllingCharKeyPress(Sender: TObject; var Key: Char);
begin
 if AnsiPos(Key, '!@#$%^&*') = 0 then Key := DefaultCommandChar;
 EditControllingChar.SelectAll;
end;

procedure TForm1.EditOAuthKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then ButtonStartbot.Click;
end;

procedure TForm1.EditRawKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and (IdIrc1.Connected) then IdIrc1.Raw(EditRaw.Text);
end;

procedure TForm1.IdIRC1Raw(ASender: TIdContext; AIn: Boolean;
  const AMessage: string);
var
 TwitchMessage: TTwitchMessage;
 Command: TStringList;
 f : TextFile;
begin
// AssignFile(f, 'debug.log');
// if FileExists('debug.log') then Append(f) else Rewrite(f);
// writeln(f, AMessage);
// CloseFile(f);
// if AnsiPos('NOTICE * :Error logging in', AMessage) <> 0 then ButtonStartbot.Click;
 if not AIn then exit;
 TThread.Synchronize(nil, procedure
  begin
   RichEditDebug.Lines.Add(AMessage);
  end);
 AnalyzeTwitchMessage(AMessage, TwitchMessage);
 if (AMessage[1] = '@') and
 ((AnsiLowerCase(TwitchMessage.Nickname) <> 'arvbot') and (TwitchMessage.Id <> '103047385')) then
  try
   try
   Command := TStringList.Create;
   Command.Delimiter := ' ';
   TextToCommand(TwitchMessage.Text, Command);
   if Command.Count > 0 then AnalyzeCommand(TwitchMessage, Command);
   except on E: Exception do TThread.Synchronize(nil, procedure begin RichEditDebug.Lines.Add('[ERROR!]: onIRCRaw ' + E.Message) end);
   end;
  finally
    Command.Free;
  end;
end;

procedure TForm1.IdIRCTestRaw(ASender: TIdContext; AIn: Boolean;
  const AMessage: string);
begin
 if not AIn then exit;
 if AnsiPos('NOTICE * :Error logging in', AMessage) <> 0 then
  LaunchClientConnection(-1)
 else if AnsiPos('Welcome, GLHF!', AMessage) <> 0 then
  LaunchClientConnection(0)
 else if AnsiPos('376 ', AMessage) <> 0 then
  IdIRCTest.Disconnect('Leaving');
end;

procedure TForm1.LaunchClientConnection(const code: shortint);
begin
 case code of
  -1: // error logging in
  begin
   TThread.Synchronize(nil, procedure
    begin
     SyncVLCMessage('[ERROR] Failed to log in using your credentials!');
     ButtonStartbot.Enabled := True;
    end);
   IdIRCTest.Disconnect('Leaving');
//   RichEdit1.Lines.Add('[ERROR] Failed to log in using your credentials!');
//   RichEditDebug.Lines.Add('[ERROR] Failed to log in using your credentials!');
  end;
  0: //ok, launch
  begin
   TThread.Synchronize(nil, procedure
    begin
     ButtonStartbot.Enabled := True;
    end);
   try
    try
     IdIrc1.Connect;
    except
    on E: Exception do
     begin
      TThread.Synchronize(nil, procedure begin SyncVLCMessage('[ERROR] trying to connect to server: ' + E.Message) end);
//      RichEdit1.Lines.Add('[ERROR] trying to connect to server: ' + E.Message);
//      RichEditDebug.Lines.Add('[ERROR] trying to connect to server: ' + E.Message);
      IdIRC1.Disconnect('Leaving');
//      IdIRCTest.Disconnect('Leaving');
      exit;
     end;
    end;
   finally
   ButtonStartbot.Caption := 'Stop ArvBot';
   EditChannel.Text := AnsiLowerCase(EditChannel.Text);
   IdIrc1.Join(#35 + EditChannel.Text);
   IdIrc1.Raw('CAP REQ :twitch.tv/membership');
   IdIrc1.Raw('CAP REQ :twitch.tv/commands');
   IdIrc1.Raw('CAP REQ :twitch.tv/tags');
   IdIrc1.Say(#35 + EditChannel.Text, 'Hello everyone!');
   TThread.Synchronize(nil, procedure begin SyncVLCMessage('Connecting to twitch on channel ' + EditChannel.Text) end);
//   TThread.Synchronize(nil,  procedure
//    begin
//     RichEdit1.Lines.Add('Connecting to twitch on channel ' + EditChannel.Text);
//     RichEditDebug.Lines.Add('Connecting to twitch on channel ' + EditChannel.Text);
//    end                                 );
   EditChannel.Enabled := False;
//   IdIRCTest.Disconnect('Leaving');
   end;
  end;
 end;

end;

procedure TForm1.MenuItemContactsClick(Sender: TObject);
begin
 ShowMessage(HelpStrings[3]);
end;

procedure TForm1.MenuItemOAuthClick(Sender: TObject);
begin
 if MessageDlg(HelpStrings[4], mtConfirmation, mbOKCancel, 0) = mrOk then
  try ShellExecute(Handle, nil, 'http://www.twitchapps.com/tmi/', nil, nil, SW_SHOWNORMAL);
  except
   on E: Exception do
   begin
    RichEdit1.Lines.Add('[ERROR] trying to open link from help: ' + E.Message);
    RichEditDebug.Lines.Add('[ERROR] trying to open link from help: ' + E.Message);
   end;
  end;
end;

procedure TForm1.MenuItemReportsClick(Sender: TObject);
begin
 ShowMessage(HelpStrings[2]);
end;

procedure TForm1.MenuItemStartingClick(Sender: TObject);
begin
 ShowMessage(HelpStrings[0]);
end;

procedure TForm1.MenuItemTipsClick(Sender: TObject);
begin
 ShowMessage(HelpStrings[1]);
end;

procedure TForm1.RejectVote(const ANickname, AReason: String);
var buffer: String;
begin
 buffer := ANickname + AReason;
 if (AnsiPos(buffer, PendingMessages) = 0) and
 (AnsiPos(ANickname + ' has voted for #', PendingMessages) = 0) then
 begin
  PendingMessages := PendingMessages + buffer;
 end;
end;

procedure TForm1.AcceptVote(const AMessage: TTwitchMessage; AVote: byte);
var
 buffer: AnsiString;
 SL: TStringList;
begin
 with TSpinEdit(FindComponent('SpinEdit' + IntToStr(AVote))) do
  Value := Value + 1;
 SetLength(Votes, Length(Votes) + 1);
 with Votes[Length(Votes) - 1] do
 begin
  Id := AMessage.Id;
  Nickname := AMessage.Nickname;
  Vote := AVote;
 end;
 buffer := #32 + AMessage.Nickname + ' has voted for #' + IntToStr(AVote) + ':{' + TEdit(FindComponent('Edit' + IntToStr(AVote))).Text + '}';
 if AnsiPos(buffer, PendingMessages) = 0 then
  PendingMessages := PendingMessages + buffer;
 TThread.Synchronize(nil, procedure
 var i: byte;
 begin
  RichEdit1.Lines.Add(buffer);
  try
   try
    SL := TStringList.Create;
    for i := 0 to Length(Votes) - 1  do
     SL.Add(Votes[i].Nickname);
    ListBoxVoted.Items := SL;
    SL.Clear;
    for i := 0 to Length(Votes) - 1  do
     SL.Add(IntToStr(Votes[i].Vote));
    ListBoxVotedOption.Items := SL;
   except on e: Exception do RichEdit1.Lines.Add('[ERROR!]: trying to create ListBoxVoted ' + E.Message);
   end;
  finally
   SL.Free;
  end;
 end);
end;

procedure TForm1.AnalyzeCommand(const AMessage: TTwitchMessage; var Command: TStringList);
var
// AVote: byte;
 Voted: Boolean;
 i,k: Byte;
 buffer: string;
begin
 if AnsiLowerCase(Command[0]) = 'debug' then
 begin
//  Command.Delimiter := ' ';
//  buffer := Command.DelimitedText;
//  TThread.Synchronize(nil, procedure
//  begin
//   RichEdit1.Lines.Add(buffer);
//  end);
//  buffer := '';
//  exit;
 end;
 if (AnsiLowerCase(Command[0]) = 'vote') and (Command.Count > 1) then // VOTE
 begin
  TestVote(AMessage, Command, 0)
 end
 else if (AnsiLowerCase(Command[0]) = 'changevote') and (Command.Count > 1) then        // CHANGEVOTE
 begin
  if Length(Votes) > 0 then
   TestVote(AMessage, Command, 1);
 end
 else if AnsiLowerCase(Command[0]) = 'question' then
 begin
  if AnsiPos(EditQuestion.Text, PendingMessages) = 0 then
   if IdIrc1.Connected then
   begin
    AnouncePoll(buffer);
    IdIrc1.Say(#35 + EditChannel.Text, buffer);
   end;
 end
 else if (AnsiLowerCase(Command[0]) = 'commands') and (AMessage.IsMod) then
 begin
  RichEdit1.Lines.Add('vote, changevote, question');
  if IdIrc1.Connected then IdIrc1.Say(#35 + EditChannel.Text, 'vote, changevote, question');
 end
 else if AnsiLowerCase(Command[0]) = 'openpoll' then
 begin

 end
 else if AnsiLowerCase(Command[0]) = 'stoppoll' then
 begin

 end
 else if AnsiLowerCase(Command[0]) = 'myvote' then
 begin
  PendingMessages := PendingMessages + AMessage.Nickname + '`s vote was: ' + ListBoxVotedOption.Items[ListBoxVoted.Items.IndexOf(AMessage.Nickname)];
  TimerMessages.Enabled := True;
 end;
end;

function TForm1.Useralreadyvoted(out i: integer; const AMessage:  TTwitchMessage): boolean;
var
 q: byte;
begin
 Result := False;
 i := -1;
 for q := 0 to Length(Votes) - 1 do
 begin
  if Votes[q].Id = AMessage.Id  then
  begin
   Result := True;
   i := q;
   break;
  end;
 end;
end;

procedure TForm1.TestVote(const AMessage: TTwitchMessage; const Command: TStringList; MyAttributes: byte);
var
 AVote: byte;
 Voted: Boolean;
 buffer: string;
 k: Byte; //Counter for common use
 i: Integer;
 MyFunctionResult: TMyFunctionResult;
begin
 with MyFunctionResult do
 begin
  Text := '';
  Code := -2;
 end;
 if OngoingPoll.IsOn then
 begin
  if (Command[1][1] in StringNumbers) then
  begin
   if (Command[1][2] in StringNumbers) then
    AVote := StrToIntDef(Command[1][1] + Command[1][2], 0)
   else AVote := StrToIntDef(Command[1][1], 0)
  end
  else AVote := 0;
  if (AVote > 0) and (AVote <= CasesCount) then
  begin
   if (Length(Votes) = 0) then               // Empy vote list
   begin
    if (TEdit(FindComponent('Edit' + IntToStr(AVote))).Text <> '') then
     MyFunctionResult.Code := AVote //AcceptVote   //AcceptVote(AMessage, AVote)
    else with MyFunctionResult do // RejectVote(AMessage.Nickname, ' no such poll option. ');
    begin
     Code := -1;
     Text := ' no such poll option. ';
    end;
   end
   else        // Has already voted ?
   begin
    Voted := Useralreadyvoted(i, AMessage);
    if TEdit(FindComponent('Edit' + IntToStr(AVote))).Text <> '' then   // vote option exists ?
    begin
     if (not Voted) {or (AMessage.Id = '29332089')} then MyFunctionResult.Code := AVote; //AcceptVote(AMessage, AVote)
     if Voted and (MyAttributes = 1) then  // 1 for changevote
      if Votes[i].Vote <> AVote then      // actual change of vote
      begin
       MyFunctionResult.Code := -3;
       buffer := AMessage.Nickname + ' changed vote to #' +
                              IntToStr(AVote) + ':{' + TEdit(FindComponent('Edit' + IntToStr(AVote))).Text + '}';
       TThread.Synchronize(nil, procedure
       begin
        with TSpinEdit(FindComponent('SpinEdit' + IntToStr(Votes[i].Vote))) do Value := Value - 1;
        with TSpinEdit(FindComponent('SpinEdit' + IntToStr(AVote))) do Value := Value + 1;
        RichEdit1.Lines.Add(buffer);
       end);
       Votes[i].Vote := AVote;
       ListBoxVotedOption.Items[i] := IntToStr(AVote);
       PendingMessages := PendingMessages + #32 + buffer;
      end
      else with MyFunctionResult do
      begin
       Code := -1;
       Text := ' you already voted for that. ';
      end;
     if Voted and (MyAttributes = 0) then with MyFunctionResult do     // 0 for just voting
     begin
      code := -1;
      Text := ' already voted. ';
     end;
    end
    else
     with MyFunctionResult do
     begin
      code := -1;
      Text := ' no such poll option. ';
     end;
   end;
  end;
//  else for i := 1 to CasesCount do
//   if AnsiPos(Command[1], TEdit(FindComponent('Edit' + IntToStr(i))).Text) <> 0 then
//    if AnsiPos(TEdit(FindComponent('Edit' + IntToStr(i))).Text, Command.DelimitedText) <> 0 then
//    begin
//     if Length(Votes) = 0 then         // Empy vote list
//      MyFunctionResult.Code := i // AcceptVote(AMessage, i);
//     else
//     begin
//      Voted := Useralreadyvoted(k, AMessage);    // Has already voted ?
//      if (not Voted) {or (AMessage.Id = '29332089')} then MyFunctionResult.Code := AVote;
//      if Voted and (MyAttributes = 1) then
//       if Votes[k].Vote <> i then      // CHANGEVOTE !
//       begin
//        MyFunctionResult.Code := -3;
//        with TSpinEdit(FindComponent('SpinEdit' + IntToStr(Votes[k].Vote))) do Value := Value - 1;
//        with TSpinEdit(FindComponent('SpinEdit' + IntToStr(i))) do Value := Value + 1;
//        Votes[k].Vote := i;
//        buffer := AMessage.Nickname + ' changed vote to #' + IntToStr(i) + ':{' + TEdit(FindComponent('Edit' + IntToStr(AVote))).Text + '}';
//        PendingMessages := PendingMessages + #32 + buffer;
//        RichEdit1.Lines.Add(buffer);
//        if IdIrc1.Connected then IdIrc1.Say(#35 + EditChannel.Text, buffer);
//        exit;
//       end
//       else with MyFunctionResult do
//       begin
//        Code := -1;
//        Text := ' exact same option. ';
//       end;
//      if Voted and (MyAttributes <> 1) then with MyFunctionResult do
//      begin
//       code := -1;
//       Text := ' already voted. ';
//      end;
//     end;
//    end;
 end
 else with MyFunctionResult do//RejectVote(AMessage.Nickname, ' no poll to vote on. ');
 begin
  Code := -1;
  Text := ' no poll to vote on. ';
 end;

 with MyFunctionResult do
 case Code of
 -2:begin //ERROR! ;
//     RichEdit1.Lines.Add('ERROR, see debug for more info');
//     RichEditDebug.Lines.Add('[ERROR!] AnalyzeCommand, basic test has failed ! Please send this row to developer ' + author.email);
    end;
 -1: RejectVote(AMessage.Nickname, Text); //RejectVote
 else if (Code >= 0) and (Code < 100) then
  AcceptVote(AMessage, Code);
 end;
end;

procedure TForm1.TextToCommand(const AMessage: String; var return: TStringList);
var Offset, NewOffset, Restriction: byte; s: string;
begin
 s := EditControllingChar.Text;
 if not (AMessage[1] = s[1]) then exit;
 Offset := 1;
 NewOffset := 1;
 Restriction := 0;
 while (Offset <> 0) and (restriction < 100) do
 begin
  inc(restriction);
  try NewOffset := PosEx(' ', AMessage, offset + 1);
  except break;
  end;
  if NewOffset = 0 then
  begin
   if Offset <= Length(AMessage) then
    return.Add(Copy(AMessage, Offset + 1, High(integer)));
   break;
  end;
  return.Add(Copy(AMessage, Offset + 1, NewOffset - Offset - 1));
  try
  while AMessage[NewOffset + 1] = ' ' do Inc(NewOffset);
  except break;
  end;
  Offset := NewOffset;
 end;
end;

procedure TForm1.AnalyzeTwitchMessage(const AMessage: String;
  var ReturnMessage: TTwitchMessage);
var Start, Stop: word; buffer: String;
begin
  Start := AnsiPos(';color=#', AMessage) + Length(';color=#');
  Stop := AnsiPos(';display-name=', AMessage);
 ReturnMessage.Color := AnsiReverseString(Copy(AMessage, Start, Stop-Start));
  Start := Stop + Length(';display-name=');
  Stop := PosEx(';', AMessage, Start);
 if Copy(AMessage, Start, Stop-Start) <> '' then ReturnMessage.Nickname := Copy(AMessage, Start, Stop-Start)
  else ReturnMessage.Nickname := 'Set display name in twitch settings';
  Start := AnsiPos(';user-id=', AMessage) + Length(';user-id=');
  Stop := PosEx(';', AMessage, Start);
 ReturnMessage.Id := Copy(AMessage, Start, Stop-Start);
  Start := AnsiPos(';user-type=', AMessage) + Length(';user-type=');
  Stop := PosEx(' :', AMessage, Start);
 if Copy(AMessage, Start, Stop-Start) <> '' then
  ReturnMessage.IsMod := True else ReturnMessage.IsMod := False;
  Start := AnsiPos('PRIVMSG ', AMessage) + Length('PRIVMSG ');
  Stop := PosEx(' :', AMessage, Start);
 ReturnMessage.Channel := Copy(AMessage, Start, Stop-Start);
  Start := AnsiPos(ReturnMessage.Channel + ' :', AMessage) + Length(ReturnMessage.Channel) + 2;
 ReturnMessage.Text := Copy(AMessage, Start, High(integer));
end;

procedure TForm1.SetNewValue(Sender: TSpinEdit);
var i: byte; decrease: boolean;
begin
 OverallVotes := 0;
 if Sender.Value > MaxValue then
 begin
  MaxValue := Sender.Value;
  for i := 1 to CasesCount do
  begin
   TProgressBar(FindComponent('ProgressBar' + IntToStr(i))).Max := MaxValue;
   OverallVotes := OverallVotes + TSpinEdit(FindComponent('SpinEdit' + IntToStr(i))).Value;
  end;
 end
 else
 begin
  MaxValue := 1;
  for i := 1 to CasesCount do
   if TSpinEdit(FindComponent('SpinEdit' + IntToStr(i))).Value > MaxValue then
    MaxValue := TSpinEdit(FindComponent('SpinEdit' + IntToStr(i))).Value;
  for i := 1 to CasesCount do
  begin
   TProgressBar(FindComponent('ProgressBar' + IntToStr(i))).Max := MaxValue;
   OverallVotes := OverallVotes + TSpinEdit(FindComponent('SpinEdit' + IntToStr(i))).Value;
  end;
 end;
 LabelOverallvotes.Caption := IntToStr(OverallVotes);
 TProgressBar(FindComponent('ProgressBar' + Copy(Sender.Name, Length('SpinEdit') + 1, High(integer)))).Position := Sender.Value;
//RichEdit1.Lines.Add('ProgressBar' + Copy(Sender.Name, Length('SpinEdit') + 1, High(integer)));
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
 if TSpinEdit(Sender).Value < 0 then TSpinEdit(Sender).Value := 0
 else SetNewValue(TSpinEdit(Sender));
end;

procedure TForm1.Summarize;
var i: byte; buffer: String; solo, noonevoted: boolean;
begin
 buffer := EditQuestion.Text + #32;
 solo := False;
 noonevoted := True;
 for i := 1 to CasesCount do
 begin
  if (TProgressBar(FindComponent('ProgressBar' + IntToStr(i))).Max =
   TProgressBar(FindComponent('ProgressBar' + IntToStr(i))).Position) then
  begin
   if buffer = (EditQuestion.Text + #32) then
   begin
    buffer := 'Poll results are: ' + IntToStr(i) + ':{' +
     TEdit(FindComponent('Edit' + IntToStr(i))).Text + '}';
    solo := True;
    noonevoted := false;
   end
   else  //buffer isn't empty
   begin
    if solo then solo := false;
    buffer := buffer + ' TIED UP WITH ' + IntToStr(i) + ':{' +
     TEdit(FindComponent('Edit' + IntToStr(i))).Text + '}';
   end;
  end;
 end;
 if solo or noonevoted then
 begin
  if buffer = (EditQuestion.Text + #32) then buffer := 'No one has voted :( How did that happen?!'     // NOONE HAS VOTED ?!
  else buffer := buffer + ' has won';
 end
 else if not noonevoted then buffer := buffer + ' have won';
 if (Length(buffer) < 400) and (not noonevoted) then
  buffer := buffer + ' with ' + IntToStr(ProgressBar1.Max) + ' vote';
 if (ProgressBar1.Max > 1) and (not noonevoted) then buffer := buffer + 's';
 if not noonevoted then buffer := buffer + ' out of ' + IntToStr(OverallVotes) + ' votes overall';
 RichEdit1.Lines.Add(buffer);
 if noonevoted then buffer := buffer + ' NotLikeThis';
 if IdIrc1.Connected then IdIrc1.Say(#35 + EditChannel.Text, buffer);
end;

procedure TForm1.SyncVLCMessage(const AMessage: string);
begin
 RichEdit1.Lines.Add(AMessage);
 RichEditDebug.Lines.Add(AMessage);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 if IdIrc1.Connected then Label1.Caption := 'Connected' else Label1.Caption := 'DisConnected';
end;

procedure TForm1.TimerMessagesTimer(Sender: TObject);
var restrictor: byte;
begin
 restrictor := 0;
 if IdIrc1.Connected then
  if PendingMessages <> '' then
  begin
   while (AnsiPos(#32#32, PendingMessages) <> 0) and (restrictor < 100) do
   begin
    inc(restrictor);
    PendingMessages := AnsiReplaceStr(PendingMessages, #32#32, #32);
   end;
   IdIrc1.Say(#35 + EditChannel.Text, PendingMessages);
   PendingMessages := '';
  end;
end;

procedure TForm1.TimerNoopTimer(Sender: TObject);
begin
 if IdIrc1.Connected then
 begin
  IdIrc1.Raw('NOOP');
 end;
end;

procedure TForm1.TimerTimedpollLCTimer(Sender: TObject);
begin
 ButtonLastcallClick(Sender);
 TimerTimedpollLC.Enabled := False;
end;

procedure TForm1.TimerTimedpollTimer(Sender: TObject);
begin
 ButtonClosepollClick(Sender);
 TimerTimedpoll.Enabled := False;
end;

end.
