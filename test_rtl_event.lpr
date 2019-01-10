program test_rtl_event;

uses
  {$IFDEF LINUX}
  cthreads,
  {$ENDIF}
  sysutils, classes;

type

  { TEventThread }

  TEventThread = class(TThread)
  private
    FEvent: PRTLEvent;
  protected
    procedure Execute; override;
  public
    constructor Create(AEvent: PRTLEvent);
  end;

var
  FEvent: PRTLEvent;
  FirstThread: TEventThread;

{ TEventThread }

procedure TEventThread.Execute;
begin
  WriteLn('Setting event');
  RTLeventSetEvent(FEvent);
end;

constructor TEventThread.Create(AEvent: PRTLEvent);
begin
  inherited Create(False);
  FEvent := AEvent;
end;

begin
  FEvent := RTLEventCreate;

  FirstThread := TEventThread.Create(FEvent);
  WriteLn('Waiting for event...');
  RTLeventWaitFor(FEvent);
  WriteLn('Waited');
  WriteLn('Waiting for event once more...');
  RTLeventWaitFor(FEvent);
  WriteLn('Done')
end.

