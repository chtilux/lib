unit NumberEdit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  TNumberEdit = class(TCustomEdit)
  private
    { Private declarations }
    FDecimal: boolean;
    FMask: string;
    FCurrency: boolean;
    FCurrencyString: string;
    procedure SetDecimal(const Value: boolean);
    procedure SetValue(const Value: Extended);
    function GetValue: Extended;
    procedure SetMask(const Value: string);
    procedure SetCurrency(const Value: boolean);
    procedure SetCurrencyString(const Value: string);
  protected
    { Protected declarations }
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Currency: boolean read FCurrency write SetCurrency default False;
    property CurrencyString: string read FCurrencyString write SetCurrencyString;
    property Decimal: boolean read FDecimal write SetDecimal default True;
    property Mask: string read FMask write SetMask;
    property Value: Extended read GetValue write SetValue;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
//    property NumbersOnly;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
//    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('chtilux', [TNumberEdit]);
end;

{ TNumberEdit }

constructor TNumberEdit.Create(AOwner: TComponent);
begin
  inherited;
  Alignment := taRightJustify;
//  NumbersOnly := True;
  TextHint := 'Numbers only...';
  FDecimal := True;
  FCurrency := False;
  FCurrencyString := FormatSettings.CurrencyString;
  Mask := '';
  Value := 0;
  Text := '';
end;

function GetNumber(Value: string; var Number: Extended) : boolean;
var
  i : Integer;
  sNumber : string;
begin
   Result := true;
   for i := 1 to Length(Value) do begin
    case Value[i] of
      '0'..'9' : sNumber := sNumber + Value[i];
      '+','-'  : begin
        if i = 1 then
          sNumber := sNumber + Value[i]
        else
          Result := false;
    end;
    else
      if Value[i] = FormatSettings.DecimalSeparator then
        sNumber := sNumber + Value[i]
      else if not (Value[i] = FormatSettings.ThousandSeparator) then
        Result := false;
    end;
  end;

  Number := StrToFloat(sNumber);
end;

procedure TNumberEdit.DoEnter;
var
  v: Extended;
begin
  inherited;
  if Text <> '' then
  begin
    GetNumber(Text, v);
    Text := FloatToStr(v);
  end;
  SelectAll;
end;

procedure TNumberEdit.DoExit;
begin
  Text := FormatFloat(FMask, Value);
  if FCurrency then
    Text := Format('%s%s',[Text,CurrencyString]);
  inherited;
end;

function TNumberEdit.GetValue: Extended;
begin
  Result := StrToFloatDef(Text,0);
end;

procedure TNumberEdit.KeyPress(var Key: Char);
const
  cs: set of Char = ['0'..'9',#8,#13,#27,'-','+'];
begin
  if not(CharInSet(Key, cs)) and not(Key = FormatSettings.DecimalSeparator) then
    Key := #0
  else if FDecimal and (Key = FormatSettings.DecimalSeparator) then
  begin
    if Pos(FormatSettings.DecimalSeparator,Text) > 0 then
      Key := #0;
  end
  else
  begin
    case Key  of
      '-','+': begin
        if (Pos(Key,Text) > 0) or ((Length(Text) > 0) and (SelStart > 0)) then
          Key := #0;
      end;
    end;
  end;
  inherited;
end;

procedure TNumberEdit.SetCurrency(const Value: boolean);
begin
  FCurrency := Value;
end;

procedure TNumberEdit.SetCurrencyString(const Value: string);
begin
  FCurrencyString := Value;
end;

procedure TNumberEdit.SetDecimal(const Value: boolean);
begin
  FDecimal := Value;
end;

procedure TNumberEdit.SetMask(const Value: string);
begin
  FMask := Value;
end;

procedure TNumberEdit.SetValue(const Value: Extended);
begin
  Text := FormatFloat(FMask,Value);
end;

end.
