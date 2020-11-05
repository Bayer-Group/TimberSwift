Pod::Spec.new do |s|
  s.name             = 'TimberSwift'
  s.version          = '1.0.0'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/MonsantoCo/TimberSwift'
  s.author           = { 'Vernon Schierding' => '@schlingding' }
  s.summary          = 'Unified messaging from frameworks to the parent application'
  s.source           = { :git => 'https://github.com/MonsantoCo/TimberSwift.git', :tag => s.version }
  s.source_files     = 'Sources/TimberSwift/**/*'
  s.platform         = :ios, "10.0"
  s.swift_versions   = ["5.3"]
end
