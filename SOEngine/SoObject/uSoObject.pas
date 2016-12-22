unit uSoObject;

interface

uses
  uGeometryClasses, System.Types, System.Classes, uCommonClasses, uSoProperties, uSoProperty,
  uSoObjectDefaultProperties, uSoTypes, uSoPosition, uSoPositionAdapter, uISoObject;

type
  TSoObject = class(TInterfacedObject, ISoObject)
  private
    FContainer: TObject;
    function GetProperty(APropertyName: string): TSoProperty;
    function GetHeight: Single;
    function GetWidth: Single;
  protected
    FPosition: TSoPosition;
    FProperties: TSoProperties;
    FOnDestroyHandlers: TNotifyEventList;
    FOnChangePositionHandlers: TEventList<TPosition>;
    procedure SetContainer(const AContainer: TObject);
    constructor Create(const APositionAdapter: TSoPositionAdapter);
    function GetPosition: TSoPosition;
  public
    property Position: TSoPosition read GetPosition;
    property Width: Single read GetWidth;
    property Height: Single read GetHeight;
    property Container: TObject read FContainer;
    property Properties[APropertyName: string]: TSoProperty read GetProperty; default;// write SetProperty; default;

    function HasProperty(const APropertyName: string): Boolean;
    function AddProperty(const AName: string): TSoProperty;
    procedure AddDestroyHandler(const AHandler: TNotifyEvent);
    procedure RemoveDestroyHandler(const AHandler: TNotifyEvent);
    procedure SetPositionSilent(const AX, AY: Single; const ARotate: Single);

    procedure Kill;
    destructor Destroy; override;
  end;

implementation

{ TSoObject }

procedure TSoObject.AddDestroyHandler(const AHandler: TNotifyEvent);
begin
  FOnDestroyHandlers.Add(AHandler);
end;

function TSoObject.AddProperty(const AName: string): TSoProperty;
begin
  Result := FProperties.Add(AName);
end;

constructor TSoObject.Create(const APositionAdapter: TSoPositionAdapter);
begin
  FOnDestroyHandlers := TNotifyEventList.Create;
  FOnChangePositionHandlers := TEventList<TPosition>.Create;
  FProperties := TSoProperties.Create;

  FPosition := TSoPosition.Create(APositionAdapter);
end;

destructor TSoObject.Destroy;
begin
  FOnDestroyHandlers.RaiseEvent(Self);
  FOnDestroyHandlers.Free;
  FOnChangePositionHandlers.Free;
  FProperties.Free;
  FPosition.Free;

  inherited;
end;

function TSoObject.GetHeight: Single;
begin
  Result := FProperties[RenditionRect].Val<TRectObject>.Height;
end;

function TSoObject.GetPosition: TSoPosition;
begin
  Result := FPosition;
end;

function TSoObject.GetProperty(APropertyName: string): TSoProperty;
begin
  Result := FProperties[APropertyName];
end;

function TSoObject.GetWidth: Single;
begin
  Result := FProperties[RenditionRect].Val<TRectObject>.Width;
end;

function TSoObject.HasProperty(const APropertyName: string): Boolean;
begin
  Result := FProperties.HasProperty(APropertyName);
end;

procedure TSoObject.Kill;
begin

end;

procedure TSoObject.RemoveDestroyHandler(const AHandler: TNotifyEvent);
begin
  FOnDestroyHandlers.Remove(AHandler);
end;

procedure TSoObject.SetContainer(const AContainer: TObject);
begin
  FContainer := AContainer;
end;

procedure TSoObject.SetPositionSilent(const AX, AY: Single; const ARotate: Single);
begin
  FPosition.X := AX;
  FPosition.Y := AY;
  FPosition.Rotate := ARotate;
end;

end.
