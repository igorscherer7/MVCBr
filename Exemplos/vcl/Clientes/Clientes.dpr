PROGRAM Clientes;






  MVCBr.ApplicationController,
  MVCBr.Controller,
  Main.Controller in 'controller\Main.Controller.pas',
  Main.ViewModel.Interf in 'viewmodel\Main.ViewModel.Interf.pas',
  Main.ViewModel in 'viewmodel\Main.ViewModel.pas',
  MainView in 'view\MainView.pas' {MainView},
  Validacoes.Model in 'persistentmodel\Validacoes.Model.pas',
  Validacoes.Model.Interf in 'persistentmodel\Validacoes.Model.Interf.pas',
  TabClientes.ModuleModel in 'module\TabClientes.ModuleModel.pas' {TabClientesModuleModel: TDataModule},
  TabClientes.ModuleModel.Interf in 'module\TabClientes.ModuleModel.Interf.pas',
  ProcurarEnderecos.Controller in 'ProcurarEnderecos\controller\ProcurarEnderecos.Controller.pas',
  ProcurarEnderecosView in 'ProcurarEnderecos\view\ProcurarEnderecosView.pas' {ProcurarEnderecosView},
  ProcurarEnderecos.ViewModel in 'ProcurarEnderecos\viewmodel\ProcurarEnderecos.ViewModel.pas',
  ProcurarEnderecos.ViewModel.Interf in 'ProcurarEnderecos\viewmodel\ProcurarEnderecos.ViewModel.Interf.pas';

{$R *.res}









