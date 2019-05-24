object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Left = 192
  Top = 125
  Height = 144
  Width = 150
  object conexao: TZConnection
    ControlsCodePage = cGET_ACP
    Connected = True
    SQLHourGlass = True
    HostName = '.\SQLEXPRESS'
    Port = 0
    Database = 'db_sga'
    Protocol = 'mssql'
    LibraryLocation = 
      'C:\Sistemas\Sistema Gerenciador de Abastecimento\fontes\ntwdblib' +
      '.dll'
    Left = 40
    Top = 16
  end
end
