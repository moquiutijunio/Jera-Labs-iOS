platform :ios, '9.1'

target 'Labs' do
    use_frameworks!
    
    # Pods for Labs
    
    #Layout
    pod 'Material', '~> 2.7.0'
    pod 'Cartography'
    
    #Animations
    pod 'Spruce', '~> 1.0.0'
#    pod 'Hero'
#    pod 'Motion', '~> 1.2'

    #Utilities
    pod 'Kingfisher', '~> 3'
    pod 'R.swift', '~> 3.2'
    pod 'SwiftLint'
    
    #Data Manager
    pod 'Firebase/Database'
    pod 'Moya-ObjectMapper/RxSwift', '~> 2.3'
    
    #Reactive
    pod 'RxCocoa', '~> 3.4'
    pod 'RxGesture', '~> 1.0'
    
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
    end
end
