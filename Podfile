# Uncomment this line to define a global platform for your project

# Expose Objective-C frameworks to Swift
# Build and link dependencies as static frameworks
use_frameworks! :linkage => :static

abstract_target 'MatrixSDK' do
    pod 'OLMKit', '~> 3.2.5', :inhibit_warnings => true
    #pod 'OLMKit', :path => '../olm/OLMKit.podspec'
    
    pod 'libbase58', '~> 0.1.4'
    pod 'MatrixSDKCrypto', "0.3.4", :inhibit_warnings => true
    
    target 'MatrixSDK-iOS' do
        platform :ios, '11.0'
        
        target 'MatrixSDKTests-iOS' do
            inherit! :search_paths
            pod 'OHHTTPStubs', '~> 9.1.0'
        end
    end
    
    target 'MatrixSDK-macOS' do
        platform :osx, '10.10'

        target 'MatrixSDKTests-macOS' do
            inherit! :search_paths
            pod 'OHHTTPStubs', '~> 9.1.0'
        end
    end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
