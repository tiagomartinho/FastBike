use_frameworks!
platform :ios, '9.0'

target 'FastBike' do
  pod 'Google/Analytics'
end

target 'FastBikeTests' do
  pod 'Google/Analytics'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
