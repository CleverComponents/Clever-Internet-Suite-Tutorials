unit ProgressForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmProgress = class(TForm)
    ProgressBar: TProgressBar;
    btnStop: TButton;
    lblMessage: TLabel;
    procedure btnStopClick(Sender: TObject);
  private
    FOnStop: TNotifyEvent;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure SendProgress(AMessageCount: Integer);
    procedure RetrProgress(AMessageCount: Integer);
    procedure SetupProgress(AMessageCount: Integer);
    procedure StepProgress;
    property OnStop: TNotifyEvent read FOnStop write FOnStop;
  end;

implementation

{$R *.dfm}

{ TfrmProgress }

procedure TfrmProgress.RetrProgress(AMessageCount: Integer);
begin
  lblMessage.Caption := 'Retrieve Messages';
  SetupProgress(AMessageCount);
  Show();
end;

procedure TfrmProgress.SendProgress(AMessageCount: Integer);
begin
  lblMessage.Caption := 'Send Message';
  SetupProgress(AMessageCount);
  Show();
end;

procedure TfrmProgress.StepProgress;
begin
  ProgressBar.StepIt();
  Application.ProcessMessages();
end;

procedure TfrmProgress.btnStopClick(Sender: TObject);
begin
  if Assigned(OnStop) then
  begin
    OnStop(Self);
  end;
end;

procedure TfrmProgress.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (Screen.ActiveCustomForm <> nil) then
  begin
    Params.WndParent := Screen.ActiveCustomForm.Handle;
  end;
end;

procedure TfrmProgress.SetupProgress(AMessageCount: Integer);
begin
  ProgressBar.Max := AMessageCount;
  ProgressBar.Position := 0;
  Application.ProcessMessages();
end;

end.
