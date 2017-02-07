Pod::Spec.new do |s|
  s.name                  = 'SwipeToReveal'
  s.version               = '1.0.1'
  s.summary               = 'Customizable swipe-to-reveal view for iOS apps'
  s.homepage              = 'https://github.com/darrarski/SwipeToReveal-iOS'
  s.author                = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.social_media_url      = 'https://twitter.com/darrarski'
  s.license               = { :type => 'MIT', 
                              :file => 'LICENSE' }
  s.source                = { :git => 'https://github.com/darrarski/SwipeToReveal-iOS.git', 
                              :tag => "v#{s.version}" }
  s.platform              = :ios
  s.ios.deployment_target = '9.0'
  s.source_files          = 'Source'
  s.requires_arc          = true
  s.frameworks            = 'UIKit'
  
  s.dependency 'SnapKit', '~> 3.0'
end
