{ //************************************************************// }
{ //                                                            // }
{ //         C�digo gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 13/02/2017 23:07:44                                  // }
{ //************************************************************// }
/// <summary>
/// O controller possui as seguintes caracter�sticas:
/// - pode possuir 1 view associado  (GetView)
/// - pode receber 0 ou mais Model   (GetModel<Ixxx>)
/// - se auto registra no application controller
/// - pode localizar controller externos e instanci�-los
/// (resolveController<I..>)
/// </summary>
unit AppPageControl.Controller;

/// <summary>
/// Object Factory para implementar o Controller
/// </summary>
interface

{ .$I ..\inc\mvcbr.inc }
uses
  System.SysUtils, {$IFDEF FMX} FMX.Forms, {$ELSE} VCL.Forms, {$ENDIF}
  System.Classes, MVCBr.Interf,
  MVCBr.PageView,
  MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
  System.RTTI, AppPageControl.Controller.Interf,
  Editor.Controller.Interf,
  AppPageControl.ViewModel, AppPageControl.ViewModel.Interf, AppPageControlView;

type
  TAppPageControlController = class(TControllerFactory,
    IAppPageControlController, IThisAs<TAppPageControlController>,
    IModelAs<IAppPageControlViewModel>)
  protected
    FPageView: IPageViews;
    Procedure DoCommand(ACommand: string;
      const AArgs: array of TValue); override;
  public
    // inicializar os m�dulos personalizados em CreateModules
    Procedure CreateModules; virtual;
    Constructor Create; override;
    Destructor Destroy; override;
    /// New Cria nova inst�ncia para o Controller
    class function New(): IController; overload;
    class function New(const AView: IView; const AModel: IModel)
      : IController; overload;
    class function New(const AModel: IModel): IController; overload;
    function ThisAs: TAppPageControlController;
    /// Init ap�s criado a inst�ncia � chamado para concluir init
    procedure init; override;
    /// ModeAs retornar a pr�pria interface do controller
    function ModelAs: IAppPageControlViewModel;

    //
    procedure AddView(AViewController:TGuid);
  end;

implementation

uses MVCBr.VCL.PageView;

/// Creator para a classe Controller
procedure TAppPageControlController.AddView(AViewController: TGuid);
begin
   FPageView.AddView(AViewController);
end;

Constructor TAppPageControlController.Create;
begin
  inherited;
  FPageView := TVCLPageViewManager.New(self);
  /// Inicializar as Views...
  add(TAppPageControlViewModel.New(self).ID('{AppPageControl.ViewModel}'));
  /// Inicializar os modulos
  CreateModules; // < criar os modulos persolnizados
end;

/// Finaliza o controller
Destructor TAppPageControlController.Destroy;
begin
  inherited;
end;

/// Classe Function basica para criar o controller
class function TAppPageControlController.New(): IController;
begin
  result := New(nil, nil);
end;

/// Classe para criar o controller com View e Model criado
class function TAppPageControlController.New(const AView: IView;
  const AModel: IModel): IController;
var
  vm: IViewModel;
begin
  result := TAppPageControlController.Create as IController;
  result.View(AView).add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
    begin
      vm.View(AView).Controller(result);
    end;
end;

/// Classe para inicializar o Controller com um Modulo inicialz.
class function TAppPageControlController.New(const AModel: IModel): IController;
begin
  result := New(nil, AModel);
end;

/// Cast para a interface local do controller
function TAppPageControlController.ThisAs: TAppPageControlController;
begin
  result := self;
end;

/// Cast para o ViewModel local do controller
function TAppPageControlController.ModelAs: IAppPageControlViewModel;
begin
  if count >= 0 then
    supports(GetModelByType(mtViewModel), IAppPageControlViewModel, result);
end;

/// Executar algum comando customizavel
Procedure TAppPageControlController.DoCommand(ACommand: string;
  const AArgs: Array of TValue);
begin
  inherited;
end;

/// Evento INIT chamado apos a inicializacao do controller
procedure TAppPageControlController.init;
var
  ref: TAppPageControlView;
begin
  inherited;
  if not assigned(FView) then
  begin
    Application.CreateForm(TAppPageControlView, ref);
    supports(ref, IView, FView);
{$IFDEF FMX}
    if Application.MainForm = nil then
      Application.RealCreateForms;
{$ENDIF}
  end;

  // associa o PageControl ao MainView
  FPageView.PageContainer := ref.PageControl1;

  AfterInit;

  FPageView.AddView( IEditorController   );


end;

/// Adicionar os modulos e MODELs personalizados
Procedure TAppPageControlController.CreateModules;
begin
  // adicionar os seus MODELs aqui
  // exemplo: add( MeuModel.new(self) );
end;

initialization

/// Inicializa��o automatica do Controller ao iniciar o APP
// TAppPageControlController.New(TAppPageControlView.New,TAppPageControlViewModel.New)).init();
/// Registrar Interface e ClassFactory para o MVCBr
RegisterInterfacedClass(TAppPageControlController.ClassName,
  IAppPageControlController, TAppPageControlController,false);

finalization

/// Remover o Registro da Interface
unRegisterInterfacedClass(TAppPageControlController.ClassName);

end.
