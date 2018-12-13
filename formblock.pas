unit FormBlock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Label1: TLabel;
    procedure Label1DblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

uses FormMes;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Label1DblClick(Sender: TObject);
begin
  Form2.Close;
  Form3.Label1.Caption:='Перерыв отложен на 5 минут';
  Form3.Tag:=6;
  Form3.Show;
end;


end.

