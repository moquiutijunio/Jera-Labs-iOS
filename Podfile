platform :ios, '9.1'

target 'Labs' do
    use_frameworks!
    inhibit_all_warnings!
    # Pods for Labs
    
    #Layout
    pod 'Material', '~> 2'
    pod 'Cartography', '~> 3'
    
    #Animations
    pod 'Spruce', '~> 1'

    #Utilities
    pod 'Kingfisher', '~> 4'
    pod 'R.swift'
    pod 'SwiftLint'
    
    #Data Manager
    pod 'Firebase/Database'
    pod 'Moya-ObjectMapper/RxSwift'
    
    #Reactive
    pod 'RxSwift', '~> 4'
    pod 'RxCocoa', '~> 4'
    pod 'RxGesture', '~> 1.2'
    
    swift4 = ['Material', 'Cartography', 'Kingfisher', 'R.swift', 'RxSwift', 'RxCocoa', 'RxGesture', 'Moya-ObjectMapper/RxSwift']
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            swift_version = nil
            
            if swift4.include?(target.name)
                swift_version = '4.0'
                else
                swift_version = '3.2'
            end
            
            if swift_version
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = swift_version
                    config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
                end
            end
        end
    end
end
