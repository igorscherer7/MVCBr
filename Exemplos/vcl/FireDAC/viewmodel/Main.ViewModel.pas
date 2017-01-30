Unit Main.ViewModel;

interface

{$I+ ..\inc\mvcbr.inc}

uses MVCBr.Interf, MVCBr.ViewModel, Main.ViewModel.Interf, MVCBr.FiredacModel,
  MVCBr.FiredacModel.Interf, Grupos.DataModel,Grupos.DataModel.Interf;

Type
  TMainViewModel = class(TViewModelFactory, IMainViewModel,
    IViewModelAs<IMainViewModel>)
  public
    FGrupos: IGruposDataModel;
  public
    constructor create; override;
    function ViewModelAs: IMainViewModel;
    class function new(): IMainViewModel; overload;
    class function new(const AController: IController): IMainViewModel;
      overload;
  end;

implementation

function TMainViewModel.ViewModelAs: IMainViewModel;
begin
  result := self;
end;

class function TMainViewModel.new(): IMainViewModel;
begin
  result := new(nil);
end;

constructor TMainViewModel.create;
begin
  inherited;
  FGrupos := TGruposDataModel.new(GetController);
  FGrupos.DriverID('FB').UserName('sysdba').Password('masterkey');
  FGrupos.ConnectionString := 'Hostname=localhost;Database=c:\dados\angelica3.fdb;dialect=1';
end;

class function TMainViewModel.new(const AController: IController)
  : IMainViewModel;
begin
  result := TMainViewModel.create;
  result.controller(AController);
end;

end.
