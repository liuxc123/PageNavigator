Pod::Spec.new do |s|
  s.name             = 'PageNavigator'
  s.version          = '1.1.0'
  s.summary          = 'A simple app internal navigation framework to replace the cumbersome navigation logic.'
  s.homepage         = 'https://github.com/liuxc123/PageNavigator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/PageNavigator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.requires_arc     = true
  s.swift_version    = "5.0"

  s.source_files     = 'PageNavigator/Classes/**/*'
  s.frameworks       = 'UIKit', 'Foundation'

end
