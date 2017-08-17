Pod::Spec.new do |s|
  s.name             = 'DBFlatPicker'
  s.version          = '1.0.0'
  s.summary          = 'Flat picker for iOS written on Objective-C'
  s.description      = <<-DESC
                       Flat picker, similar to UIPickerview, for iOS written on Objective-C. 
                       DESC

  s.homepage         = 'https://github.com/immago/DBFlatPicker'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'Dmitry Byankin' => 'the.immago@gmail.com' }
  s.source           = { :git => 'https://github.com/immago/DBFlatPicker.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Classes/**/*'
end
