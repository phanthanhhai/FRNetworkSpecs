Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "FRNetwork"
  s.summary = "FRNetwork is network manager"
  s.requires_arc = true
  s.version = "1.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "hapt" => "phanhai151@gmail.com" }
  s.homepage = "https://github.com/phanthanhhai/FRNetwork"
  s.source = { :git => "https://github.com/phanthanhhai/FRNetwork.git", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.framework = "CoreLocation"
  s.dependency 'SwiftyJSON', '~> 2.3.2'
  s.dependency 'Alamofire', '~> 3.3'
  s.source_files = "FRNetwork/**/*.{swift,h,m}"
  #s.resources = "FRNetwork/**/*.{png,jpeg,jpg,storyboard,xib}"
end