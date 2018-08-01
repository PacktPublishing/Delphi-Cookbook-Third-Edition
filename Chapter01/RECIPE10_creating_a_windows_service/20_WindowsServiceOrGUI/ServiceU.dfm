object SampleService_ServiceVersion: TSampleService_ServiceVersion
  OldCreateOrder = False
  DisplayName = 'My Sample Service (Service Version)'
  AfterInstall = ServiceAfterInstall
  OnContinue = ServiceContinue
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 155
  Width = 241
end
