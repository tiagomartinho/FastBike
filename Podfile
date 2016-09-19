use_frameworks!
platform :ios, '9.0'

def app_pods
    pod 'Google/Analytics'
    pod 'BuddyBuildSDK'
end

target 'FastBike' do
  app_pods
end

target 'FastBikeTests' do
  app_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
