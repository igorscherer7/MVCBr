ViewHead = '/// <summary>                                                     '
  + #10#13 + '///    Um View representa a camada de apresenta��o ao usu�rio    '
  + #10#13 + '///    dever� associar a um controller onde ocorrer�          ' +
  #10#13 + '///    a troca de informa��o e comunica��o com os Models         ' +
  #13#10 + '/// </summary>                                                    '
  + #13#10 + 'unit %UnitIdent;                                ' + #13#10 +
  '                                                          ' + #13#10 +
  'interface                                                 ' + #13#10 +
  'uses                                                      ' + #13#10 +
  '{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF}           ' + #13#10 +
  '  System.SysUtils, System.Classes,MVCBr.Interf,System.JSON, ' + #13#10 +
  '  MVCBr.View,MVCBr.FormView, %MdlInterf ,MVCBr.Controller; ' + #13#10 +
  '                                                     ' + #13#10;
ViewDef = '                                   '#13#10 +
  'type                                                 ' + #13#10 +
  '/// Interface para a VIEW                                         ' + #13#10
  + '  I%FormIdent = interface(IView)                      ' + #13#10 +
  '    [''%guid'']                                           ' + #13#10 +
  '    // incluir especializacoes aqui                       ' + #13#10 +
  '  end;                                                    ' + #13#10 +
  '                                                          ' + #13#10 +
  '/// Object Factory que implementa a interface da VIEW             ' + #13#10
  + '  T%FormIdent = class(TFormFactory {T%AncestorIdent} ,IView,IThisAs<T%FormIdent>,'
  + #13#10 + '                      I%FormIdent,IViewAs<I%FormIdent>)' + #13#10
  + '                                                          ' + #13#10 +
  '  private                                                 ' + #13#10 +
  '    FViewModel : I%FormIdentModel;                    ' + #13#10 +
  '    FInited:boolean;                                  ' + #13#10 +
  '  protected                                               ' + #13#10 +
  '    function Controller(const aController: IController): IView;override;' +
  #13#10 + '  public                                                    ' +
  #13#10 + '   { Public declarations }                                ' + #13#10
  + '    class function New(AController:IController):IView;    ' + #13#10 +
  '    function ViewModel(const AViewModel:I%FormIdentModel):IView;' + #13#10 +
  '    function ThisAs:T%FormIdent;                      ' + #13#10 +
  '    function ViewAs:I%FormIdent;                      ' + #13#10 +
  '    function ShowView(const AProc:TProc<IView>):integer;override;' + #13#10 +
  '    function UpdateView: IView;override;                      ' + #13#10 +
  '  end;                                                    ' + #13#10 +
  '                                                          ' + #13#10;

ViewImpl = 'function T%FormIdent.UpdateView:IView;             ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  result := inherited;                                    ' + #13#10 +
  '  if assigned(FViewModel) then FViewModel.updateView(self as IView);' +
  #13#10 + '  {codigo para atualizar a View vai aqui...}              ' + #13#10
  + 'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ViewAs:I%FormIdent;              ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  result := self;                                         ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'class function T%FormIdent.new(AController:IController):IView;    ' + #13#10
  + 'begin                                                     ' + #13#10 +
  '   result := T%FormIdent.create(nil);                     ' + #13#10 +
  '   result.controller(AController);                        ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.Controller(const AController:IController):IView; ' +
  #13#10 + 'begin                                              ' + #13#10 +
  '  result := inherited Controller(AController);              ' + #13#10 +
  '  if not assigned(FViewModel) then                          ' + #13#10 +
  '    FViewModel := getViewModel as I%FormIdentModel;         ' + #13#10 +
  '  if not FInited then begin Init; FInited:=true; end;      ' + #13#10 +
  'end;                                                        ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ViewModel(const AViewModel:I%FormIdentModel):IView;' +
  #13#10 + 'begin                                                     ' + #13#10
  + '   result := self;                                        ' + #13#10 +
  '  if assigned(AViewModel) then                          ' + #13#10 +
  '   FViewModel := AViewModel;                          ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ThisAs:T%FormIdent;                  ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '   result := self;                                        ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ShowView(const AProc:TProc<IView>):integer;' + #13#10 +
  'var                                                 ' + #13#10 +
  '  vm: IModel;                                       ' + #13#10 +
  'begin                                               ' + #13#10 +
  '  if assigned(FController) then                     ' + #13#10 +
  '  begin                                             ' + #13#10 +
  '    vm := FController.GetModelByType(mtViewModel);  ' + #13#10 +
  '    if assigned(vm) then                            ' + #13#10 +
  '      supports(vm.This,I%FormIdentModel,FViewModel);      ' + #13#10 +
  '  end;                                              ' + #13#10 +
  '  inherited;                                              ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10;

ViewCode = ViewHead + ViewDef +
  '                                                          ' + #13#10 +
  'implementation                                            ' + #13#10 +
  '                                                          ' + #13#10 +
  '{$R *.DFM}                                                ' + #13#10 +
  '                                                          ' + #13#10 +
  ViewImpl +
  'end.                                                      ' + #13#10;

ViewCodeFMX = ViewHead + ViewDef +
  '                                                          ' + #13#10 +
  'implementation                                            ' + #13#10 +
  '                                                          ' + #13#10 +
  '{$R *.FMX}                                                ' + #13#10 +
  '                                                          ' + #13#10 +
  ViewImpl +
  'end.                                                      ' + #13#10;

ViewCode2 = ViewHead + ViewDef +
  '                                                          ' + #13#10 +
  'implementation                                            ' + #13#10 +
  '                                                          ' + #13#10 +
  ViewImpl +
  'end.                                                      ' + #13#10;

// ---------------------------------------------------------------//
ViewCodeNoViewModel =
  '/// <summary>                                                     ' + #13#10
  + '///    Uma View representa a camada de apresenta��o ao usu�rio    ' +
  #13#10 + '///    deve esta associado a um controller onde ocorrer�          '
  + #13#10 +
  '///    a troca de informa��es e comunica��o com os Models         ' + #13#10
  + '/// </summary>                                                    ' +
  #13#10 + 'unit %ModelIdent;                                ' + #13#10 +
  '                                                          ' + #13#10 +
  'interface                                                 ' + #13#10 +
  'uses                                                      ' + #13#10 +
  '{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF}           ' + #13#10 +
  '  System.SysUtils, System.Classes,MVCBr.Interf,System.JSON, ' + #13#10 +
  '  MVCBr.View,MVCBr.FormView,MVCBr.Controller; ' + #13#10 +
  '                                                     ' + #13#10 +
  '                                   '#13#10 +
  'type                                                 ' + #13#10 +
  '/// Interface para a VIEW                                      ' + #13#10 +
  '  I%FormIdent = interface(IView)                      ' + #13#10 +
  '    [''%guid'']                                           ' + #13#10 +
  '    // incluir especializacoes aqui                       ' + #13#10 +
  '  end;                                                    ' + #13#10 +
  '                                                          ' + #13#10 +
  '/// Object Factory que implementa a interface da VIEW             ' + #13#10
  + '  T%FormIdent = class(TFormFactory {T%AncestorIdent} ,IView,IThisAs<T%FormIdent>,'
  + #13#10 + '  I%FormIdent,IViewAs<I%FormIdent>)' + #13#10 +
  '  private FInited:boolean;                                ' + #13#10 +
  '  protected                                           ' + #13#10 +
  '    function Controller(const aController:IController):IView;override;' + #13#10+
  '  public                                         ' + #13#10 +
  '   { Public declarations }                                ' + #13#10 +
  '    class function New(AController:IController):IView;    ' + #13#10 +
  '    function ThisAs:T%FormIdent;                      ' + #13#10 +
  '    function ViewAs:I%FormIdent;                      ' + #13#10 +
  '    function ShowView(const AProc: TProc<IView>): integer;override;' +#13#10+
  'end;                                                    ' + #13#10 +
  '                                                          ' + #13#10 +
  'Implementation ' + #13#10 +
  '{$R *.DFM}                                                ' + #13#10 +
  '                                                          ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ViewAs:I%FormIdent;              ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  result := self;                                         ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'class function T%FormIdent.new(AController:IController):IView;    ' + #13#10
  + 'begin                                                     ' + #13#10 +
  '   result := T%FormIdent.create(nil);                     ' + #13#10 +
  '   result.controller(AController);                        ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.Controller(const AController:IController):IView; ' +
  #13#10 + 'begin                                              ' + #13#10 +
  '  result := inherited Controller(AController);              ' + #13#10 +
  '  if not FInited then begin init; FInited:=true; end;     ' + #13#10 +
  'end;                                                        ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ThisAs:T%FormIdent;                  ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '   result := self;                                        ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'function T%FormIdent.ShowView(const AProc:TProc<IView>):integer;' + #13#10 +
  'begin                                               ' + #13#10 +
  '  inherited;                                              ' + #13#10 +
  'end;                                                      ' + #13#10 +
  #13#10+
  'end.                                                      ' + #13#10;
