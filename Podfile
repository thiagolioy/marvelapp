# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Marvel' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  plugin 'cocoapods-keys', {
    :project => "Marvel",
    :target => "Marvel",
    :keys => [
      "MarvelApiKey",
      "MarvelPrivateKey"
    ]}

  # Pods for Marvel

   pod 'Moya/RxSwift'
   pod 'Moya-ObjectMapper/RxSwift'
   pod 'RxSwift', '~> 3.2'
   pod 'RxCocoa', '~> 3.2'
	 pod 'RealmSwift', '~> 2.4'
	 pod 'RxRealm', '~> 0.5.1'
	 pod 'RxDataSources', '~> 1.0.2'
	 pod 'Action', '~> 2.2.1'
	 pod 'NSObject+Rx', '~> 2.0'


   pod 'SwiftGen'
   pod 'CryptoSwift'
   pod 'Dollar'
   pod 'Kingfisher'
   pod 'Reusable'
   pod 'SnapKit'
end

target 'MarvelTests' do
  use_frameworks!

  pod 'Quick'
  pod 'Nimble'
  pod 'Fakery'
  pod 'ObjectMapper'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
