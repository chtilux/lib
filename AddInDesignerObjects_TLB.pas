unit AddInDesignerObjects_TLB;

// ************************************************************************ //
// AVERTISSEMENT
// -------
// Les types déclarés dans ce fichier ont été générés à partir de données lues
// depuis la bibliothèque de types. Si cette dernière (via une autre bibliothèque de types
// s'y référant) est explicitement ou indirectement ré-importée, ou la commande "Actualiser"
// de l'éditeur de bibliothèque de types est activée lors de la modification de la bibliothèque
// de types, le contenu de ce fichier sera régénéré et toutes les modifications
// manuellement apportées seront perdues.
// ************************************************************************ //

// $Rev: 52393 $
// Fichier généré le 23/04/2015 14:56:51 depuis la bibliothèque de types ci-dessous.

// ************************************************************************  //
// Biblio. types : C:\Program Files\Common Files\Designer\MSADDNDR.DLL (1)
// LIBID : {AC0714F2-3D04-11D1-AE7D-00A0C90F26F4}
// LCID : 0
// Fichier d'aide : 
// Chaîne d'aide : Microsoft Add-In Designer
// DepndLst : 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // L'unité doit être compilée sans pointeur à type contrôlé.  
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;
  
// *********************************************************************//
// GUIDS déclarés dans la bibliothèque de types. Préfixes utilisés:        
//   Bibliothèques de types : LIBID_xxxx                                      
//   CoClasses              : CLASS_xxxx                                      
//   Interfaces DISP        : DIID_xxxx                                       
//   Interfaces Non-DISP    : IID_xxxx                                        
// *********************************************************************//
const
  // Versions mineure et majeure de la bibliothèque de types
  AddInDesignerObjectsMajorVersion = 1;
  AddInDesignerObjectsMinorVersion = 0;

  LIBID_AddInDesignerObjects: TGUID = '{AC0714F2-3D04-11D1-AE7D-00A0C90F26F4}';

  IID_IAddinDesigner: TGUID = '{AC0714F3-3D04-11D1-AE7D-00A0C90F26F4}';
  IID_IAddinInstance: TGUID = '{AC0714F4-3D04-11D1-AE7D-00A0C90F26F4}';
  IID__IDTExtensibility2: TGUID = '{B65AD801-ABAF-11D0-BB8B-00A0C90F2744}';
  CLASS_AddinDesigner: TGUID = '{AC0714F6-3D04-11D1-AE7D-00A0C90F26F4}';
  CLASS_AddinDesigner2: TGUID = '{E436987E-F427-4AD7-8738-6D0895A3E93F}';
  CLASS_AddinInstance: TGUID = '{AC0714F7-3D04-11D1-AE7D-00A0C90F26F4}';
  CLASS_AddinInstance2: TGUID = '{AB5357A7-3179-47F9-A705-966B8B936D5E}';

// *********************************************************************//
// Déclaration d'énumérations définies dans la bibliothèque de types                    
// *********************************************************************//
// Constantes pour enum ext_ConnectMode
type
  ext_ConnectMode = TOleEnum;
const
  ext_cm_AfterStartup = $00000000;
  ext_cm_Startup = $00000001;
  ext_cm_External = $00000002;
  ext_cm_CommandLine = $00000003;

// Constantes pour enum ext_DisconnectMode
type
  ext_DisconnectMode = TOleEnum;
const
  ext_dm_HostShutdown = $00000000;
  ext_dm_UserClosed = $00000001;

type

// *********************************************************************//
// Déclaration Forward des types définis dans la bibliothèque de types                     
// *********************************************************************//
  IAddinDesigner = interface;
  IAddinDesignerDisp = dispinterface;
  IAddinInstance = interface;
  IAddinInstanceDisp = dispinterface;
  _IDTExtensibility2 = interface;
  _IDTExtensibility2Disp = dispinterface;

// *********************************************************************//
// Déclaration de CoClasses définies dans la bibliothèque de types        
// (REMARQUE: On affecte chaque CoClasse à son Interface par défaut)      
// *********************************************************************//
  AddinDesigner = IAddinDesigner;
  AddinDesigner2 = IAddinDesigner;
  AddinInstance = IAddinInstance;
  AddinInstance2 = IAddinInstance;


// *********************************************************************//
// Déclaration de structures, d'unions et d'alias.                         
// *********************************************************************//
  PPSafeArray1 = ^PSafeArray; {*}

  IDTExtensibility2 = _IDTExtensibility2; 

// *********************************************************************//
// Interface :   IAddinDesigner
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID :        {AC0714F3-3D04-11D1-AE7D-00A0C90F26F4}
// *********************************************************************//
  IAddinDesigner = interface(IDispatch)
    ['{AC0714F3-3D04-11D1-AE7D-00A0C90F26F4}']
  end;

// *********************************************************************//
// DispIntf :    IAddinDesignerDisp
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID :        {AC0714F3-3D04-11D1-AE7D-00A0C90F26F4}
// *********************************************************************//
  IAddinDesignerDisp = dispinterface
    ['{AC0714F3-3D04-11D1-AE7D-00A0C90F26F4}']
  end;

// *********************************************************************//
// Interface :   IAddinInstance
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID :        {AC0714F4-3D04-11D1-AE7D-00A0C90F26F4}
// *********************************************************************//
  IAddinInstance = interface(IDispatch)
    ['{AC0714F4-3D04-11D1-AE7D-00A0C90F26F4}']
  end;

// *********************************************************************//
// DispIntf :    IAddinInstanceDisp
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID :        {AC0714F4-3D04-11D1-AE7D-00A0C90F26F4}
// *********************************************************************//
  IAddinInstanceDisp = dispinterface
    ['{AC0714F4-3D04-11D1-AE7D-00A0C90F26F4}']
  end;

// *********************************************************************//
// Interface :   _IDTExtensibility2
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID :        {B65AD801-ABAF-11D0-BB8B-00A0C90F2744}
// *********************************************************************//
  _IDTExtensibility2 = interface(IDispatch)
    ['{B65AD801-ABAF-11D0-BB8B-00A0C90F2744}']
    procedure OnConnection(const Application: IDispatch; ConnectMode: ext_ConnectMode; 
                           const AddInInst: IDispatch; var custom: PSafeArray); safecall;
    procedure OnDisconnection(RemoveMode: ext_DisconnectMode; var custom: PSafeArray); safecall;
    procedure OnAddInsUpdate(var custom: PSafeArray); safecall;
    procedure OnStartupComplete(var custom: PSafeArray); safecall;
    procedure OnBeginShutdown(var custom: PSafeArray); safecall;
  end;

// *********************************************************************//
// DispIntf :    _IDTExtensibility2Disp
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID :        {B65AD801-ABAF-11D0-BB8B-00A0C90F2744}
// *********************************************************************//
  _IDTExtensibility2Disp = dispinterface
    ['{B65AD801-ABAF-11D0-BB8B-00A0C90F2744}']
    procedure OnConnection(const Application: IDispatch; ConnectMode: ext_ConnectMode; 
                           const AddInInst: IDispatch; 
                           var custom: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 1;
    procedure OnDisconnection(RemoveMode: ext_DisconnectMode; 
                              var custom: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 2;
    procedure OnAddInsUpdate(var custom: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 3;
    procedure OnStartupComplete(var custom: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 4;
    procedure OnBeginShutdown(var custom: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 5;
  end;

// *********************************************************************//
// La classe CoAddinDesigner fournit une méthode Create et CreateRemote pour
// créer des instances de l'interface par défaut IAddinDesigner exposée
// par la CoClasse AddinDesigner. Les fonctions sont destinées à être utilisées par
// les clients désirant automatiser les objets CoClasse exposés par
// le serveur de cette bibliothèque de types.
// *********************************************************************//
  CoAddinDesigner = class
    class function Create: IAddinDesigner;
    class function CreateRemote(const MachineName: string): IAddinDesigner;
  end;

// *********************************************************************//
// La classe CoAddinDesigner2 fournit une méthode Create et CreateRemote pour
// créer des instances de l'interface par défaut IAddinDesigner exposée
// par la CoClasse AddinDesigner2. Les fonctions sont destinées à être utilisées par
// les clients désirant automatiser les objets CoClasse exposés par
// le serveur de cette bibliothèque de types.
// *********************************************************************//
  CoAddinDesigner2 = class
    class function Create: IAddinDesigner;
    class function CreateRemote(const MachineName: string): IAddinDesigner;
  end;

// *********************************************************************//
// La classe CoAddinInstance fournit une méthode Create et CreateRemote pour
// créer des instances de l'interface par défaut IAddinInstance exposée
// par la CoClasse AddinInstance. Les fonctions sont destinées à être utilisées par
// les clients désirant automatiser les objets CoClasse exposés par
// le serveur de cette bibliothèque de types.
// *********************************************************************//
  CoAddinInstance = class
    class function Create: IAddinInstance;
    class function CreateRemote(const MachineName: string): IAddinInstance;
  end;

// *********************************************************************//
// La classe CoAddinInstance2 fournit une méthode Create et CreateRemote pour
// créer des instances de l'interface par défaut IAddinInstance exposée
// par la CoClasse AddinInstance2. Les fonctions sont destinées à être utilisées par
// les clients désirant automatiser les objets CoClasse exposés par
// le serveur de cette bibliothèque de types.
// *********************************************************************//
  CoAddinInstance2 = class
    class function Create: IAddinInstance;
    class function CreateRemote(const MachineName: string): IAddinInstance;
  end;

implementation

uses System.Win.ComObj;

class function CoAddinDesigner.Create: IAddinDesigner;
begin
  Result := CreateComObject(CLASS_AddinDesigner) as IAddinDesigner;
end;

class function CoAddinDesigner.CreateRemote(const MachineName: string): IAddinDesigner;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AddinDesigner) as IAddinDesigner;
end;

class function CoAddinDesigner2.Create: IAddinDesigner;
begin
  Result := CreateComObject(CLASS_AddinDesigner2) as IAddinDesigner;
end;

class function CoAddinDesigner2.CreateRemote(const MachineName: string): IAddinDesigner;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AddinDesigner2) as IAddinDesigner;
end;

class function CoAddinInstance.Create: IAddinInstance;
begin
  Result := CreateComObject(CLASS_AddinInstance) as IAddinInstance;
end;

class function CoAddinInstance.CreateRemote(const MachineName: string): IAddinInstance;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AddinInstance) as IAddinInstance;
end;

class function CoAddinInstance2.Create: IAddinInstance;
begin
  Result := CreateComObject(CLASS_AddinInstance2) as IAddinInstance;
end;

class function CoAddinInstance2.CreateRemote(const MachineName: string): IAddinInstance;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AddinInstance2) as IAddinInstance;
end;

end.
