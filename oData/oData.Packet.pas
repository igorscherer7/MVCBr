unit oData.Packet;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Json,
  Data.DB;

type

  TODataJsonPacket = class;

  IODataJsonPacket = interface(TFunc<TODataJsonPacket>)
  end;

  TODataJsonPacket = class(TInterfacedObject, IODataJsonPacket)
  protected
    FOwned: boolean;
    FJson: TJsonObject;
    function Invoke: TODataJsonPacket;
  public
    constructor Create(AContext: string; AOwned: boolean); overload;
    constructor Create(); overload;
    destructor Destroy; override;
    class function New(AContext: string; AOwned: boolean): IODataJsonPacket;
    function This: TJsonValue;
    function AsJsonObject: TJsonObject;
    function TryGetValue<T>(AChave: string; out AValue: T): boolean;
    function Contexts(AValue: string): TODataJsonPacket; virtual;
    procedure Starts; virtual;
    function Values(AJson: TJsonArray): TODataJsonPacket;
    function GenValue(AChave: String; AValue: String): TODataJsonPacket;
    function Tops(AValue: Integer): TODataJsonPacket;
    function Skips(AValue: Integer): TODataJsonPacket;
    function Ends: TODataJsonPacket; virtual;
    procedure Counts(ACount: Integer); virtual;
  end;

implementation

uses MVCFramework.DataSet.Utils, System.Json.Helper,
  System.DateUtils;

{ TODataJsonPacket }

function TODataJsonPacket.AsJsonObject: TJsonObject;
begin
  result := FJson;
end;

function TODataJsonPacket.Contexts(AValue: string): TODataJsonPacket;
const
  _context = '@odata.context';
var
  js: TJsonPair;
begin
  if TryGetValue<TJsonPair>(_context, js) then
  begin // trick for change value
    js.JsonValue.Free;
    js.JsonValue := TJSONString.Create(AValue)
  end
  else
    FJson.addPair(_context, AValue);
end;

procedure TODataJsonPacket.Counts(ACount: Integer);
var
  js: TJsonPair;
const
  _name = '@odata.count';
begin
  FJson.RemovePair(_name);
  FJson.addPair(_name, ACount);
end;

constructor TODataJsonPacket.Create;
begin
  raise exception.Create
    ('Do create with ..create(context,owned) insteadof create');
end;

constructor TODataJsonPacket.Create(AContext: string; AOwned: boolean);
begin
  inherited Create;
  FJson := TJsonObject.Create;
  FOwned := AOwned;
  Contexts(AContext);
  Starts;
end;

destructor TODataJsonPacket.Destroy;
begin
  if not FOwned then
    FreeAndNil(FOwned);
  inherited;
end;

function TODataJsonPacket.Ends: TODataJsonPacket;
begin
  result := self;
  FJson.addPair('EndsAt', DateToISO8601(now));
end;

function TODataJsonPacket.GenValue(AChave, AValue: String): TODataJsonPacket;
var
  arr: TJsonArray;
begin
  arr := TJsonArray.Create;
  arr.AddElement(TJsonValue.new(AChave, AValue));
  Values(arr);
  Ends;
end;

function TODataJsonPacket.Invoke: TODataJsonPacket;
begin
  result := self;
end;

class function TODataJsonPacket.New(AContext: string; AOwned: boolean)
  : IODataJsonPacket;
begin
  result := TODataJsonPacket.Create(AContext, AOwned);
end;

function TODataJsonPacket.Skips(AValue: Integer): TODataJsonPacket;
begin
  result := self;
  if AValue > 0 then
    FJson.addPair('@odata.skip', AValue);
end;

procedure TODataJsonPacket.Starts;
begin
  FJson.addPair('StartsAt', DateToISO8601(now));
end;

function TODataJsonPacket.This: TJsonValue;
begin
  result := FJson;
end;

function TODataJsonPacket.Tops(AValue: Integer): TODataJsonPacket;
begin
  result := self;
  if AValue > 0 then
    FJson.addPair('@odata.top', AValue);
end;

function TODataJsonPacket.TryGetValue<T>(AChave: string; out AValue: T)
  : boolean;
begin
  result := FJson.TryGetValue<T>(AChave, AValue);
end;

function TODataJsonPacket.Values(AJson: TJsonArray): TODataJsonPacket;
begin
  result := self;
  FJson.addPair('value', AJson);
  Counts(AJson.Length);
end;

end.
