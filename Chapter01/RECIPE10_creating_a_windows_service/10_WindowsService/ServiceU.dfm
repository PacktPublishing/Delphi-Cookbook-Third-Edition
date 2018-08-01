object SampleService: TSampleService
  OldCreateOrder = False
  DisplayName = 'My Sample Service'
  AfterInstall = ServiceAfterInstall
  OnContinue = ServiceContinue
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 155
  Width = 241
end
