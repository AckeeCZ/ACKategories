Pod::Spec.new do |s|
  s.name             = 'ACKategories'
  s.version          = '6.3.0'
  s.summary          = 'A bunch of useful tools, cocoa subclasses and extensions'
  s.description      = <<-DESC
Tools, cocoa subclasses and extensions we love to use at Ackee.
                       DESC
  s.homepage         = 'https://github.com/AckeeCZ/ACKategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ackee' => 'info@ackee.cz' }
  s.source           = { :git => 'https://github.com/AckeeCZ/ACKategories.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ackeecz'
  s.swift_version    = '5.1.3'
  s.default_subspec  = 'iOS'
  s.ios.deployment_target = '8.3'
  s.osx.deployment_target = '10.9'
  
  s.subspec 'Core' do |core|
      core.source_files     = 'ACKategoriesCore/**/*.swift'
  end
  
  s.subspec 'iOS' do |ios|
      ios.dependency 'ACKategories/Core'
      ios.source_files     = 'ACKategories-iOS/**/*.swift'
      ios.exclude_files    = 'ACKategories-iOS/Aliases.swift'
  end
end
