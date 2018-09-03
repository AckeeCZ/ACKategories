Pod::Spec.new do |s|
  s.name             = 'ACKategories'
  s.version          = '5.6.1'
  s.summary          = 'A bunch of useful tools, cocoa subclasses and extensions'
  s.description      = <<-DESC
Tools, cocoa subclasses and extensions we love to use at Ackee.
                       DESC
  s.homepage         = 'https://github.com/AckeeCZ/ACKategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ackee' => 'info@ackee.cz' }
  s.source           = { :git => 'https://github.com/AckeeCZ/ACKategories.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ackeecz'
  s.ios.deployment_target = '8.3'
  s.source_files = 'ACKategories/**/*'
  s.frameworks = 'UIKit'
end
