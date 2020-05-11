{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

Code template generated with SynGen.
The original code is: C:\radw3\dpr\bin\SynHighlighterZPL.pas, released 2020-05-03.
Description: Syntax Parser/Highlighter
The initial author of this file is chtilux.
Copyright (c) 2020, all rights reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

-------------------------------------------------------------------------------}

{$IFNDEF QSYNHIGHLIGHTERZPL}
unit SynHighlighterZPL;
{$ENDIF}

{$I SynEdit.inc}

interface

uses
{$IFDEF SYN_CLX}
  QGraphics,
  QSynEditTypes,
  QSynEditHighlighter,
  QSynUnicode,
{$ELSE}
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynUnicode,
{$ENDIF}
  SysUtils,
  Classes;

type
  TtkTokenKind = (
    tkIdentifier,
    tkKey,
    tkNull,
    tkUnknown);

  TRangeState = (rsUnKnown);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function (Index: Integer): TtkTokenKind of object;

type
  TSynZPLSyn = class(TSynCustomHighlighter)
  private
    fRange: TRangeState;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0..222] of TIdentFuncTableFunc;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    function HashKey(Str: PWideChar): Cardinal;
    function Func94a(Index: Integer): TtkTokenKind;
    function Func94a64(Index: Integer): TtkTokenKind;
    function Func94b0(Index: Integer): TtkTokenKind;
    function Func94b1(Index: Integer): TtkTokenKind;
    function Func94b2(Index: Integer): TtkTokenKind;
    function Func94b3(Index: Integer): TtkTokenKind;
    function Func94b4(Index: Integer): TtkTokenKind;
    function Func94b5(Index: Integer): TtkTokenKind;
    function Func94b7(Index: Integer): TtkTokenKind;
    function Func94b8(Index: Integer): TtkTokenKind;
    function Func94b9(Index: Integer): TtkTokenKind;
    function Func94ba(Index: Integer): TtkTokenKind;
    function Func94bb(Index: Integer): TtkTokenKind;
    function Func94bc(Index: Integer): TtkTokenKind;
    function Func94bd(Index: Integer): TtkTokenKind;
    function Func94be(Index: Integer): TtkTokenKind;
    function Func94bf(Index: Integer): TtkTokenKind;
    function Func94bi(Index: Integer): TtkTokenKind;
    function Func94bj(Index: Integer): TtkTokenKind;
    function Func94bk(Index: Integer): TtkTokenKind;
    function Func94bl(Index: Integer): TtkTokenKind;
    function Func94bm(Index: Integer): TtkTokenKind;
    function Func94bo(Index: Integer): TtkTokenKind;
    function Func94bp(Index: Integer): TtkTokenKind;
    function Func94bq(Index: Integer): TtkTokenKind;
    function Func94br(Index: Integer): TtkTokenKind;
    function Func94bs(Index: Integer): TtkTokenKind;
    function Func94bt(Index: Integer): TtkTokenKind;
    function Func94bu(Index: Integer): TtkTokenKind;
    function Func94bx(Index: Integer): TtkTokenKind;
    function Func94by(Index: Integer): TtkTokenKind;
    function Func94bz(Index: Integer): TtkTokenKind;
    function Func94cf(Index: Integer): TtkTokenKind;
    function Func94ci(Index: Integer): TtkTokenKind;
    function Func94cw(Index: Integer): TtkTokenKind;
    function Func94fb(Index: Integer): TtkTokenKind;
    function Func94fc(Index: Integer): TtkTokenKind;
    function Func94fd(Index: Integer): TtkTokenKind;
    function Func94fh(Index: Integer): TtkTokenKind;
    function Func94fl(Index: Integer): TtkTokenKind;
    function Func94fm(Index: Integer): TtkTokenKind;
    function Func94fn(Index: Integer): TtkTokenKind;
    function Func94fo(Index: Integer): TtkTokenKind;
    function Func94fp(Index: Integer): TtkTokenKind;
    function Func94fr(Index: Integer): TtkTokenKind;
    function Func94fs(Index: Integer): TtkTokenKind;
    function Func94ft(Index: Integer): TtkTokenKind;
    function Func94fv(Index: Integer): TtkTokenKind;
    function Func94fw(Index: Integer): TtkTokenKind;
    function Func94fx(Index: Integer): TtkTokenKind;
    function Func94gb(Index: Integer): TtkTokenKind;
    function Func94gc(Index: Integer): TtkTokenKind;
    function Func94gd(Index: Integer): TtkTokenKind;
    function Func94ge(Index: Integer): TtkTokenKind;
    function Func94gf(Index: Integer): TtkTokenKind;
    function Func94gs(Index: Integer): TtkTokenKind;
    function Func94ht(Index: Integer): TtkTokenKind;
    function Func94lf(Index: Integer): TtkTokenKind;
    function Func94lh(Index: Integer): TtkTokenKind;
    function Func94ll(Index: Integer): TtkTokenKind;
    function Func94lr(Index: Integer): TtkTokenKind;
    function Func94ls(Index: Integer): TtkTokenKind;
    function Func94lt(Index: Integer): TtkTokenKind;
    function Func94md(Index: Integer): TtkTokenKind;
    function Func94ml(Index: Integer): TtkTokenKind;
    function Func94mn(Index: Integer): TtkTokenKind;
    function Func94mt(Index: Integer): TtkTokenKind;
    function Func94pf(Index: Integer): TtkTokenKind;
    function Func94ph(Index: Integer): TtkTokenKind;
    function Func94pm(Index: Integer): TtkTokenKind;
    function Func94po(Index: Integer): TtkTokenKind;
    function Func94pp(Index: Integer): TtkTokenKind;
    function Func94pq(Index: Integer): TtkTokenKind;
    function Func94pr(Index: Integer): TtkTokenKind;
    function Func94ps(Index: Integer): TtkTokenKind;
    function Func94pw(Index: Integer): TtkTokenKind;
    function Func94tb(Index: Integer): TtkTokenKind;
    function Func94xa(Index: Integer): TtkTokenKind;
    function Func94xg(Index: Integer): TtkTokenKind;
    function Func94xz(Index: Integer): TtkTokenKind;
    function Func126dg(Index: Integer): TtkTokenKind;
    function Func126sd(Index: Integer): TtkTokenKind;
    procedure IdentProc;
    procedure UnknownProc;
    function AltFunc(Index: Integer): TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PWideChar): TtkTokenKind;
    procedure NullProc;
    procedure CRProc;
    procedure LFProc;
  protected
    function GetSampleSource: UnicodeString; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetFriendlyLanguageName: UnicodeString; override;
    class function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: Integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetKeyWords(TokenKind: Integer): UnicodeString; override;
    function GetTokenID: TtkTokenKind;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: Integer; override;
    function IsIdentChar(AChar: WideChar): Boolean; override;
    procedure Next; override;
  published
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
  end;

implementation

uses
{$IFDEF SYN_CLX}
  QSynEditStrConst;
{$ELSE}
  SynEditStrConst;
{$ENDIF}

resourcestring
  SYNS_FilterZPL = '*.zpl;*.zplx';
  SYNS_LangZPL = 'ZPL';
  SYNS_FriendlyLangZPL = 'ZPL';

const
  // as this language is case-insensitive keywords *must* be in lowercase
  KeyWords: array[0..81] of UnicodeString = (
    '^a', '^a@', '^b0', '^b1', '^b2', '^b3', '^b4', '^b5', '^b7', '^b8', '^b9',
    '^ba', '^bb', '^bc', '^bd', '^be', '^bf', '^bi', '^bj', '^bk', '^bl', '^bm',
    '^bo', '^bp', '^bq', '^br', '^bs', '^bt', '^bu', '^bx', '^by', '^bz', '^cf',
    '^ci', '^cw', '^fb', '^fc', '^fd', '^fh', '^fl', '^fm', '^fn', '^fo', '^fp',
    '^fr', '^fs', '^ft', '^fv', '^fw', '^fx', '^gb', '^gc', '^gd', '^ge', '^gf',
    '^gs', '^ht', '^lf', '^lh', '^ll', '^lr', '^ls', '^lt', '^md', '^ml', '^mn',
    '^mt', '^pf', '^ph', '^pm', '^po', '^pp', '^pq', '^pr', '^ps', '^pw', '^tb',
    '^xa', '^xg', '^xz', '~dg', '~sd'
  );

  KeyIndices: array[0..222] of Integer = (
    -1, -1, -1, -1, -1, -1, -1, 61, -1, -1, -1, -1, -1, 3, -1, 6, -1, 8, -1, -1, 
    -1, -1, 52, -1, -1, -1, 79, 37, 1, -1, 76, -1, 55, 40, -1, 43, -1, 45, -1, 
    47, 81, -1, -1, -1, -1, 11, -1, 14, -1, -1, -1, 18, -1, 21, 68, 23, -1, 26, 
    -1, -1, 72, 30, -1, -1, 75, -1, -1, -1, -1, -1, -1, -1, -1, 65, 58, -1, -1, 
    66, -1, -1, -1, -1, 62, -1, -1, -1, -1, -1, 4, -1, 7, -1, 9, -1, -1, 50, -1, 
    53, -1, -1, 35, -1, 56, -1, 38, -1, -1, -1, 41, -1, -1, -1, 46, -1, 48, 0, 
    -1, 80, -1, -1, 12, -1, 15, -1, -1, -1, 19, 67, -1, 34, 24, -1, 27, 70, -1, 
    73, 31, -1, -1, -1, -1, -1, -1, -1, -1, -1, 64, 57, -1, -1, -1, 59, -1, -1, 
    -1, 60, -1, -1, 77, -1, -1, 2, 78, 5, -1, -1, -1, 10, -1, -1, 51, -1, 54, 
    -1, -1, 36, -1, -1, -1, -1, -1, 39, -1, 42, -1, 44, -1, -1, -1, 49, -1, -1, 
    32, -1, 33, 13, -1, 16, -1, 17, -1, 20, -1, 22, -1, 25, 69, 28, 71, 29, 74, 
    -1, -1, -1, -1, 63, -1, -1, -1, -1, -1, -1, -1 
  );

procedure TSynZPLSyn.InitIdent;
var
  i: Integer;
begin
  for i := Low(fIdentFuncTable) to High(fIdentFuncTable) do
    if KeyIndices[i] = -1 then
      fIdentFuncTable[i] := AltFunc;

  fIdentFuncTable[115] := Func94a;
  fIdentFuncTable[28] := Func94a64;
  fIdentFuncTable[161] := Func94b0;
  fIdentFuncTable[13] := Func94b1;
  fIdentFuncTable[88] := Func94b2;
  fIdentFuncTable[163] := Func94b3;
  fIdentFuncTable[15] := Func94b4;
  fIdentFuncTable[90] := Func94b5;
  fIdentFuncTable[17] := Func94b7;
  fIdentFuncTable[92] := Func94b8;
  fIdentFuncTable[167] := Func94b9;
  fIdentFuncTable[45] := Func94ba;
  fIdentFuncTable[120] := Func94bb;
  fIdentFuncTable[195] := Func94bc;
  fIdentFuncTable[47] := Func94bd;
  fIdentFuncTable[122] := Func94be;
  fIdentFuncTable[197] := Func94bf;
  fIdentFuncTable[199] := Func94bi;
  fIdentFuncTable[51] := Func94bj;
  fIdentFuncTable[126] := Func94bk;
  fIdentFuncTable[201] := Func94bl;
  fIdentFuncTable[53] := Func94bm;
  fIdentFuncTable[203] := Func94bo;
  fIdentFuncTable[55] := Func94bp;
  fIdentFuncTable[130] := Func94bq;
  fIdentFuncTable[205] := Func94br;
  fIdentFuncTable[57] := Func94bs;
  fIdentFuncTable[132] := Func94bt;
  fIdentFuncTable[207] := Func94bu;
  fIdentFuncTable[209] := Func94bx;
  fIdentFuncTable[61] := Func94by;
  fIdentFuncTable[136] := Func94bz;
  fIdentFuncTable[192] := Func94cf;
  fIdentFuncTable[194] := Func94ci;
  fIdentFuncTable[129] := Func94cw;
  fIdentFuncTable[100] := Func94fb;
  fIdentFuncTable[175] := Func94fc;
  fIdentFuncTable[27] := Func94fd;
  fIdentFuncTable[104] := Func94fh;
  fIdentFuncTable[181] := Func94fl;
  fIdentFuncTable[33] := Func94fm;
  fIdentFuncTable[108] := Func94fn;
  fIdentFuncTable[183] := Func94fo;
  fIdentFuncTable[35] := Func94fp;
  fIdentFuncTable[185] := Func94fr;
  fIdentFuncTable[37] := Func94fs;
  fIdentFuncTable[112] := Func94ft;
  fIdentFuncTable[39] := Func94fv;
  fIdentFuncTable[114] := Func94fw;
  fIdentFuncTable[189] := Func94fx;
  fIdentFuncTable[95] := Func94gb;
  fIdentFuncTable[170] := Func94gc;
  fIdentFuncTable[22] := Func94gd;
  fIdentFuncTable[97] := Func94ge;
  fIdentFuncTable[172] := Func94gf;
  fIdentFuncTable[32] := Func94gs;
  fIdentFuncTable[102] := Func94ht;
  fIdentFuncTable[147] := Func94lf;
  fIdentFuncTable[74] := Func94lh;
  fIdentFuncTable[151] := Func94ll;
  fIdentFuncTable[155] := Func94lr;
  fIdentFuncTable[7] := Func94ls;
  fIdentFuncTable[82] := Func94lt;
  fIdentFuncTable[215] := Func94md;
  fIdentFuncTable[146] := Func94ml;
  fIdentFuncTable[73] := Func94mn;
  fIdentFuncTable[77] := Func94mt;
  fIdentFuncTable[127] := Func94pf;
  fIdentFuncTable[54] := Func94ph;
  fIdentFuncTable[206] := Func94pm;
  fIdentFuncTable[133] := Func94po;
  fIdentFuncTable[208] := Func94pp;
  fIdentFuncTable[60] := Func94pq;
  fIdentFuncTable[135] := Func94pr;
  fIdentFuncTable[210] := Func94ps;
  fIdentFuncTable[64] := Func94pw;
  fIdentFuncTable[30] := Func94tb;
  fIdentFuncTable[158] := Func94xa;
  fIdentFuncTable[162] := Func94xg;
  fIdentFuncTable[26] := Func94xz;
  fIdentFuncTable[117] := Func126dg;
  fIdentFuncTable[40] := Func126sd;
end;

{$Q-}
function TSynZPLSyn.HashKey(Str: PWideChar): Cardinal;
begin
  Result := 0;
  while IsIdentChar(Str^) do
  begin
    Result := Result * 996 + Ord(Str^) * 75;
    inc(Str);
  end;
  Result := Result mod 223;
  fStringLen := Str - fToIdent;
end;
{$Q+}

function TSynZPLSyn.Func94a(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94a64(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b0(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b1(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b2(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b3(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b4(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b5(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b7(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b8(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94b9(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ba(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94be(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bi(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bj(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bk(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bm(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bo(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bq(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94br(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bt(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bu(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94by(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94bz(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94cf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ci(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94cw(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fh(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fm(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fn(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fo(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fr(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ft(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fv(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fw(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94fx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94gb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94gc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94gd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ge(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94gf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94gs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ht(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94lf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94lh(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ll(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94lr(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ls(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94lt(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94md(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ml(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94mn(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94mt(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94pf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ph(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94pm(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94po(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94pp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94pq(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94pr(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94ps(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94pw(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94tb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94xa(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94xg(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func94xz(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func126dg(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.Func126sd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKey
  else
    Result := tkIdentifier;
end;

function TSynZPLSyn.AltFunc(Index: Integer): TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynZPLSyn.IdentKind(MayBe: PWideChar): TtkTokenKind;
var
  Key: Cardinal;
begin
  fToIdent := MayBe;
  Key := HashKey(MayBe);
  if Key <= High(fIdentFuncTable) then
    Result := fIdentFuncTable[Key](KeyIndices[Key])
  else
    Result := tkIdentifier;
end;

procedure TSynZPLSyn.NullProc;
begin
  fTokenID := tkNull;
  inc(Run);
end;

procedure TSynZPLSyn.CRProc;
begin
  fTokenID := tkUnknown;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynZPLSyn.LFProc;
begin
  fTokenID := tkUnknown;
  inc(Run);
end;

constructor TSynZPLSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCaseSensitive := False;

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrKey, SYNS_FriendlyAttrKey);
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrReservedWord, SYNS_FriendlyAttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fKeyAttri.Foreground := clRed;
  AddAttribute(fKeyAttri);

  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  fDefaultFilter := SYNS_FilterZPL;
  fRange := rsUnknown;
end;

procedure TSynZPLSyn.IdentProc;
begin
  FTokenID := IdentKind(FLine + Run);
  Inc(Run, FStringLen);
  while IsIdentChar(FLine[Run]) do
    Inc(Run);

end;

procedure TSynZPLSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynZPLSyn.Next;
begin
  fTokenPos := Run;
  case fLine[Run] of
    #0: NullProc;
    #10: LFProc;
    #13: CRProc;
    '~', '^': IdentProc;
  else
    UnknownProc;
  end;
  inherited;
end;

function TSynZPLSyn.GetDefaultAttribute(Index: Integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
  else
    Result := nil;
  end;
end;

function TSynZPLSyn.GetEol: Boolean;
begin
  Result := Run = fLineLen + 1;
end;

function TSynZPLSyn.GetKeyWords(TokenKind: Integer): UnicodeString;
begin
  Result := 
    '^A,^A@,^B0,^B1,^B2,^B3,^B4,^B5,^B7,^B8,^B9,^BA,^BB,^BC,^BD,^BE,^BF,^B' +
    'I,^BJ,^BK,^BL,^BM,^BO,^BP,^BQ,^BR,^BS,^BT,^BU,^BX,^BY,^BZ,^CF,^CI,^CW,' +
    '^FB,^FC,^FD,^FH,^FL,^FM,^FN,^FO,^FP,^FR,^FS,^FT,^FV,^FW,^FX,^GB,^GC,^G' +
    'D,^GE,^GF,^GS,^HT,^LF,^LH,^LL,^LR,^LS,^LT,^MD,^ML,^MN,^MT,^PF,^PH,^PM,' +
    '^PO,^PP,^PQ,^PR,^PS,^PW,^TB,^XA,^XG,^XZ,~DG,~SD';
end;

function TSynZPLSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynZPLSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkUnknown: Result := fIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TSynZPLSyn.GetTokenKind: Integer;
begin
  Result := Ord(fTokenId);
end;

function TSynZPLSyn.IsIdentChar(AChar: WideChar): Boolean;
begin
  case AChar of
    '^','~':
      Result := True;
    else
      Result := False;
  end;
end;

function TSynZPLSyn.GetSampleSource: UnicodeString;
begin
  Result := 
    'Sample source for: '#13#10 +
    'Syntax Parser/Highlighter';
end;

function TSynZPLSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterZPL;
end;

class function TSynZPLSyn.GetFriendlyLanguageName: UnicodeString;
begin
  Result := SYNS_FriendlyLangZPL;
end;

class function TSynZPLSyn.GetLanguageName: string;
begin
  Result := SYNS_LangZPL;
end;

procedure TSynZPLSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynZPLSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynZPLSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

initialization
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynZPLSyn);
{$ENDIF}
end.
