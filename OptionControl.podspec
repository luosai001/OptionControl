

Pod::Spec.new do |s|
  s.name             = "OptionControl"
  s.version          = "1.0.0"
  s.summary          = "OptionControl for SingleOption and MutilOption"

  s.description      = <<-DESC
    OptionControl for SingleOption and MutilOption that helps you
                       DESC

  s.homepage         = "https://github.com/luosai001/OptionControl"

  s.license          = 'MIT'
  s.author           = { "luosai" => "luosai19910103@163.com" }
  s.source           = { :git => "https://github.com/luosai001/OptionControl.git", :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'

  s.source_files = 'OptionControl/Classes/**/*'
  
  s.resource_bundles = {
    'OptionControl' => ['OptionControl/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'

end
