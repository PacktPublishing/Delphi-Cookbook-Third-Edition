object ServerModule: TServerModule
  OldCreateOrder = False
  Height = 258
  Width = 383
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 8888
    OnConnect = IdTCPServer1Connect
    OnExecute = IdTCPServer1Execute
    Left = 160
    Top = 104
  end
end
