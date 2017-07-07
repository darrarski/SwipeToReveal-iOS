source 'git://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'SwipeToRevealExample' do
  pod 'SwipeToReveal', :path => '.'
  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'SnapKit', '~> 3.0'
  pod 'SwiftLint', '~> 0.16'
  pod 'Reusable', '~> 4.0'
end

target 'SwipeToRevealExampleTests' do
  pod 'SwipeToReveal', :path => '.'
  pod 'Quick', '~> 1.1'
  pod 'Nimble', '~> 7.0'
  pod 'FBSnapshotTestCase', :git => 'git@github.com:facebook/ios-snapshot-test-case.git', :commit => 'd9ec82b'
  pod 'Nimble-Snapshots', '~> 6.2'
end

target 'SwipeToRevealTests' do
  pod 'SwipeToReveal', :path => '.'
  pod 'Quick', '~> 1.1'
  pod 'Nimble', '~> 7.0'
end
