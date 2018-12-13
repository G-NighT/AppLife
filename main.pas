unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterBat, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Spin, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    men7: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    men0: TPanel;
    men1: TPanel;
    men2: TPanel;
    men3: TPanel;
    men4: TPanel;
    men5: TPanel;
    men6: TPanel;
    Panel4: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cvet(Sender: TObject);
    procedure cvet_leave(Sender: TObject);
    procedure cvet_move(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure men3Click(Sender: TObject);
    procedure men6Click(Sender: TObject);
    procedure men7Click(Sender: TObject);
    procedure RadioGroup3ChangeBounds(Sender: TObject);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: char);
    procedure Timer2Timer(Sender: TObject);
    procedure zacher(Sender: TCheckBox);
    procedure FormClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure men0Click(Sender: TObject);
    procedure men1Click(Sender: TObject);
    procedure men2Click(Sender: TObject);
    procedure men4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
    { private declarations }
    procedure add_do(s:string);
    procedure refile_do();
    procedure GoMainPanel();
  public
    { public declarations }

  end;

type stat_water=record
          day_mes: integer;
          val: real;
          end;

var
  Form1: TForm1;
  water: word;            {кол-во воды}
  AProcess: TProcess;     {Переменная для работы с CMD}
  Date: TDateTime;        {Время открытия программы}
  StartBlock: TDateTime;  {Время с последнего блока}
  ozidanie: word;          {Переменная для отсчёта блокировки}
  mas_do: array[0..20] of string;          {Массив с задачами}
  file_do: file of ShortString;
  file_zametk: TextFile;
  file_water: file of stat_water;

const
  TimeLosse: word=10; {Время блокировки в секундах}
  TimeBlock: integer=30; {Время работы до блокировки в минутах}
  Blocked: byte=0; {Какая-либо блокировка}
  Shutdown:string='shutdown -s -t 100';

implementation

uses FormBlock, FormMes;

{$R *.lfm}

{ TForm1 }


procedure TForm1.Label1DblClick(Sender: TObject);
begin
//  memo1.Text:=label1.Caption;
  memo1.Visible:=True;
  label1.visible:=false;
end;

procedure TForm1.men0Click(Sender: TObject);
begin
  GoMainPanel;
  cvet(Sender);
end;

procedure TForm1.men1Click(Sender: TObject);
  const ml:integer=0;
        n:integer=0;
  var ml_s:string;
      lit:string;
begin
  GoMainPanel;
  Panel3.Width:=616;
  cvet(Sender);
 if water < 2000 then
 try
  ml_s:=InputBox('Добавление жидкости',
      'Выпито воды (в мл):', '200');
  ml:=StrToInt(ml_s);
  inc(water,ml);
  if water > 1550 then Shape2.Brush.Color:=$000BFF0B
  else  if water > 1000 then Shape2.Brush.Color:=$007CFADD;
  if water >= 2000 then
     begin
       Shape2.Height:=220;
       Shape2.Top:=24;
       label3.Caption:='Ваш баланс'+#13+'жидкости:'+#13+'2.0 л';
     end
     else
     begin
       n:=Round(ml*0.1);
       Shape2.Height:=Shape2.Height+n;
       Shape2.Top:=Shape2.Top-n;
       lit:=FloatToStr(water/1000);
       label3.Caption:='Ваш баланс'+#13+'жидкости:'+#13+lit+' л';
     end;
 except;
 end;
//  Panel4.Width:=616;
end;

procedure TForm1.men2Click(Sender: TObject);
begin
  GoMainPanel;
  cvet(Sender);
  Panel4.Width:=616;
end;

procedure TForm1.men4Click(Sender: TObject);
begin
{  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := '@echo off';
  AProcess.CommandLine := shutdown;
//  AProcess.CommandLine := '@cls';
//  AProcess.Options := AProcess.Options + [poWaitOnExit];
  AProcess.Execute;   }
  cvet(Sender);
  GoMainPanel;
  Panel6.Width:=616;
//  AProcess.Free;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 if SpeedButton1.Tag=0 then
   begin
     Form1.Width:=616;
     Form1.Left:=Form1.Left+184;
     SpeedButton1.Tag:=1;
   end
   else
   begin
     Form1.Width:=800;
     Form1.Left:=Form1.Left-184;
     SpeedButton1.Tag:=0;
   end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var Hour, Min, Sec, MSec:word;
    razn: TDateTime;
begin
  {Процесс скрытия увидомления}
  if Form3.Tag=1 then
     begin
       Form3.Tag:=0;
       timer2.Enabled:=True;
     end
     else if Form3.Tag>1 then Form3.Tag:=Form3.Tag-1;

  razn:=Now-StartBlock;
  DecodeTime(razn, Hour, Min, Sec, MSec);
  Label5.Caption:='Последний перерыв: '+IntToStr(Min)+' минут '+IntToStr(Sec)+' секунд назад';
  if Blocked=1 then       {Если заблокирован}
     begin
       dec(ozidanie);
       Form2.Label1.Caption:='ПК заблокирован! Скиньте деньги на QIWI'+#13+
                                 'до форматирования диска осталось '+IntToStr(ozidanie);
       if ozidanie=0 then {Если блок снят автоматический}
          begin
            StartBlock:=Now;
            Blocked:=0;
            Form2.Close;
          end;
     end
  else if ({(Hour*60+Min)} sec >= TimeBlock) and (Blocked=0) then
    begin
      Form2.Show;
      ozidanie:=TimeLosse;
      Blocked:=1;
    end
   else if ((Min mod 20)=0) and (Blocked=0) then
	{Выкинуть сообщение о необходимости оторвать взгляд на 10-15 секунд};

  razn:=Now-Date;
  DecodeTime(razn, Hour, Min, Sec, MSec);

  label4.Caption:='Время за ПК: '+IntToStr(hour)+' час '+IntToStr(min)+' минуты '+IntToStr(sec)+' секунд';
end;

procedure TForm1.cvet_leave(Sender: TObject);
begin
  if (Sender as TPanel).Color<>$00F5F5F5 then
     (Sender as TPanel).Color:=$00E3E3E3;
end;

procedure TForm1.cvet_move(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender as TPanel).Color<>$00F5F5F5 then
     (Sender as TPanel).Color:=$00CFCFCF;
end;

procedure TForm1.cvet(Sender: TObject);
begin
  men0.Color:=$00E3E3E3;
  men1.Color:=$00E3E3E3;
  men2.Color:=$00E3E3E3;
  men3.Color:=$00E3E3E3;
  men4.Color:=$00E3E3E3;
  men5.Color:=$00E3E3E3;
  men6.Color:=$00E3E3E3;
  (Sender as TPanel).Color:=$00F5F5F5;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := '@echo off';
  AProcess.CommandLine := shutdown;
  AProcess.Execute;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := '@echo off';
  AProcess.CommandLine := 'shutdown -a';
  AProcess.Execute;
end;


procedure TForm1.add_do(s: string);
var CheckBox: TCheckBox;
begin
  CheckBox:=TCheckBox.Create(Form1); //Создание Memo
  CheckBox.Parent:=Form1.Panel4; // Задаем родителя
  CheckBox.Caption:=s;  // Тескт
  CheckBox.Left:=25; // Позиция по горизонтали
  CheckBox.Top:=45+(Edit1.Tag*20);  // Позиция по вертикали
  CheckBox.Font.Size:=11;

  CheckBox.OnChange:=CheckBox1.OnChange;
  CheckBox.Tag:=Edit1.Tag;

  mas_do[CheckBox.Tag]:=CheckBox.Caption;

  Edit1.Tag:=Edit1.Tag+1;
  Edit1.Top:=Edit1.Top+20;
end;

procedure TForm1.refile_do;
var i:byte;
begin
  rewrite(file_do);
  for i:=0 to 20 do
      if mas_do[i]<>'' then
         write(file_do,mas_do[i]);
  CloseFile(file_do);
end;

procedure TForm1.GoMainPanel;
begin
  Panel3.Width:=0;
  Panel4.Width:=0;
  Panel6.Width:=0;
  Panel8.Width:=0;
end;

procedure TForm1.zacher(Sender: TCheckBox);
var i:byte;
begin
  i:=Sender.Tag;
  if Sender.Checked then
       begin
       Sender.Font.Style:=[fsStrikeOut];
       mas_do[i]:='';
       end
    else
       begin
       Sender.Font.Style:=[];
       mas_do[i]:=Sender.Caption;
       end;
  refile_do;
end;

procedure TForm1.FormCreate(Sender: TObject);
var   s:ShortString;
      s2:string;
const i:byte=0;
begin     {По открытию программы делаем:}
  {Скрываем лишние панели}
  GoMainPanel;

  Date:=Now; {Задаём начальное время}
  StartBlock:=Now;

  {Создаём форму с уведомлением}
  Application.CreateForm(TForm3, Form3);
  Form3.Top:=0;
  Form3.Left:=0;
  Form3.Tag:=3;
  Form3.Label1.Caption:='Приложение успешно запущено';
  Form3.Show;

  Application.BringToFront; {Выводим главную форму на передний план}

  try   {Переходим в папку с данными}
  ChDir('data');
  except{Создаём если её не существует}
  MkDir('data');
  ChDir('data');
  end;

  AssignFile(file_do,'do.dat');
  AssignFile(file_zametk,'rem.dat');
  AssignFile(file_water,'water.dat');
  if FileExists('do.dat') and FileExists('rem.dat')
                          and FileExists('water.dat') then
        begin {Если файлы существуют}
          reset(file_do);
          while not(EOF(file_do)) do
                begin
                  read(file_do,s);
                  mas_do[i]:=s;
                  add_do(s);
                  inc(i);
                end;
          CloseFile(file_do);

          reset(file_zametk);
          if not(EOF(file_zametk)) then
            begin
             label1.Caption:='';
             memo1.Text:='';
             repeat
                  readln(file_zametk,s2);
                  label1.Caption:=label1.Caption+s2+#13;
                  memo1.Lines.Append(s2);
              until EOF(file_zametk);
              //memo1.Lines.Delete(memo1.Lines.Count-1);
            end;
          CloseFile(file_zametk);
        end
      else
        begin {Если файлы не существуют - создаём}
          rewrite(file_do);
          CloseFile(file_do);
          rewrite(file_zametk);
          CloseFile(file_zametk);
          rewrite(file_water);
          CloseFile(file_water);
        end;

end;

procedure TForm1.men3Click(Sender: TObject);
begin
  cvet(Sender);
  GoMainPanel;
  Panel5.Width:=616;
end;

procedure TForm1.men6Click(Sender: TObject);
begin
  cvet(Sender);
  GoMainPanel;
  Panel8.Width:=616;
end;


procedure TForm1.men7Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.RadioGroup3ChangeBounds(Sender: TObject);
begin
  case RadioGroup3.ItemIndex of
  0: shutdown:='shutdown -s -t 100';  {Выключение}
  1: shutdown:='shutdown -h';         {Гибернация}
  2: shutdown:='rundll32.exe powrprof.dll,SetSuspendState Sleep'; {Сон}
  3: shutdown:='shutdown -r';         {Перезагрузка}
  4: shutdown:='shutdown -l';         {Завершение сеанса}
  5: shutdown:='Rundll32.exe User32.dll,LockWorkStation'; {Блокировка}
  6: shutdown:='shutdown -p -f';
  end;
end;

procedure TForm1.SpinEdit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['0'..'9',#8,#13]) then Key:=#0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if Form3.AlphaBlendValue<20 then
     begin
       Form3.AlphaBlendValue:=210;
       Form3.Close;
       Timer2.Enabled:=False;
     end
     else
     begin
     Form3.AlphaBlendValue:=Form3.AlphaBlendValue-6;
     end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then
     begin
      if Edit1.Text<>'' then
      begin
      add_do(Edit1.Text);
      refile_do();

      Edit1.Text:='';
      end;
     end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caNone;
  Form3.Close;
  Application.Minimize;
end;

procedure TForm1.FormClick(Sender: TObject);
var s:String;
    i:byte;
begin
if memo1.Visible then
  begin
  label1.Caption:='';
  memo1.Visible:=False;
  label1.Visible:=True;

  {Сохраняем заметку в файл}
  rewrite(file_zametk);
  if memo1.Text<>'' then
      for i:=0 to (memo1.Lines.Count-1) do
      begin
        s:=Memo1.Lines.Strings[i];
        label1.Caption:=label1.Caption+s+#13;
        writeln(file_zametk,s);
      end;
  CloseFile(file_zametk);
  end;
end;


end.

