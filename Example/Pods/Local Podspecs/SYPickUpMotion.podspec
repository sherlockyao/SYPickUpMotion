#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "SYPickUpMotion"
  s.version          = "0.1.0"
  s.summary          = "A Gesture lib to Pick up a UIView them move it around"
  s.description      = <<-DESC
                        This motion is used when you need to hold touch on an UIView element to pick it up,
                         then panning around the screen with the element stick to your finger.
                       DESC
  s.homepage         = "https://github.com/sherlockyao/SYPickUpMotion"
  s.license          = 'MIT'
  s.author           = { "Sherlock Yao" => "yaosherlock@gmail.com" }
  s.source           = { :git => "https://github.com/sherlockyao/SYPickUpMotion.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.resources = 'Assets/*.png'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
