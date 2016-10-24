#
# Be sure to run `pod lib lint ACKategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ACKategories'
  s.version          = '4.0.0'
  s.summary          = 'A bunch of useful tools, cocoa subclasses and extensions'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Tools, cocoa subclasses and extensions we love to use at Ackee.
                       DESC

  s.homepage         = 'https://github.com/AckeeCZ/ACKategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ackee' => 'info@ackee.cz' }
  s.source           = { :git => 'https://github.com/AckeeCZ/ACKategories.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ackeecz'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ACKategories/Classes/**/*'

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
