#
# Be sure to run `pod lib lint FlexibleHeader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexibleHeader'
  s.version          = '0.1.0'
  s.summary          = 'This helps people to integrate a fast flexible header in their apps'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This Flexible header is developed in Swift for other swift developers I just want to contribute to the community
                       DESC

  s.homepage         = 'https://github.com/miguel-jimenez-0529/FlexibleHeaderSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Miguel' => 'miguel.jimenez.0529@gmail.com' }
  s.source           = { :git => 'https://github.com/miguel-jimenez-0529/FlexibleHeaderSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'
  s.source_files = 'FlexibleHeader/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FlexibleHeader' => ['FlexibleHeader/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
