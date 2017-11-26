platform :ios, '9.1'

target 'Labs' do
  use_frameworks!

  # Pods for Labs
  pod 'R.swift', '~> 3.2'
  pod 'Material', '~> 2.9'
  pod 'RxCocoa', '~> 3.4'
  pod 'RxGesture', '~> 1.0'
  pod 'Cartography'
  pod 'Kingfisher', '~> 3'
  pod 'Moya-ObjectMapper/RxSwift', '~> 2.3'
  pod 'Firebase/Database'
  pod 'SwiftLint'
  pod 'Spruce', '~> 1.0.0'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
    end
end
