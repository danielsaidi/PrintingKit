Pod::Spec.new do |s|
  s.name             = 'PrintingKit'
  s.version          = '0.0.1'
  s.swift_versions   = ['5.7']
  s.summary          = 'PrintingKit...'
  s.description      = 'PrintingKit is...great?'

  s.homepage         = 'https://github.com/danielsaidi/PrintingKit'
  s.license          = { :type => 'NONE', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/PrintingKit.git', :tag => s.version.to_s }
  
  s.swift_version = '5.7'
  s.source_files = 'Sources/ApiKit/**/*.swift'
end
