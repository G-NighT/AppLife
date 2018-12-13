unit FormMes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.Label1DblClick(Sender: TObject);
begin
  Form3.Close;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  Application.BringToFront;
end;

end.

