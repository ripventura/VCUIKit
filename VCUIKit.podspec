#
# Be sure to run `pod lib lint VCUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VCUIKit'
  s.version          = '0.1.17'
  s.summary          = 'A collection of classes and extensions written in Swift 4 to help you optimize your time when developing iOS applications.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a collection of classes and extensions written in Swift 4 to help you optimize your time when developing iOS applications. All the code was done by me, so please if you think you can contribute, lets share some thoughts!

When I get some time I will update the Wiki page with detailed description of each class / method.
                       DESC

  s.homepage         = 'https://github.com/ripventura/VCUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ripventura' => 'vitorcesco@gmail.com' }
  s.source           = { :git => 'https://github.com/ripventura/VCUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'VCUIKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VCUIKit' => ['VCUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
s.dependency 'SwiftMessages', '~> 4.0.0'
s.dependency 'SnapKit', '~> 4.0.0'
s.dependency 'FCAlertView', '~> 1.4'
s.dependency 'SVProgressHUD', '~> 2.2.1'
end
