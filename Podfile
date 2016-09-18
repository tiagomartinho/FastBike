target 'FastBike' do
  use_frameworks!
  platform :ios, '10.0'
  pod 'Google/Analytics'
end

target 'FastBikeTests' do
  pod 'Google/Analytics'
end

target 'FastBikeWatchOS Extension' do
    use_frameworks!
    platform :watchos, '3.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
