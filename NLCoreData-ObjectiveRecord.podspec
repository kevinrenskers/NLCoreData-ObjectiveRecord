Pod::Spec.new do |s|
  s.name         = "NLCoreData-ObjectiveRecord"
  s.version      = "0.1.0"
  s.summary      = "Adds ObjectiveRecord like syntax to NLCoreData"
  s.homepage     = "https://github.com/kevinrenskers/NLCoreData-ObjectiveRecord"
  s.license      = 'MIT'
  s.author       = { "Kevin Renskers" => "info@mixedcase.nl" }
  s.source       = { :git => "https://github.com/kevinrenskers/NLCoreData-ObjectiveRecord.git", :tag => s.version.to_s }
  s.ios.deployment_target = '6.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'Classes/*.{h,m}'
  s.requires_arc = true
  s.dependency 'NLCoreData'
  s.dependency 'ObjectiveSugar'
end
