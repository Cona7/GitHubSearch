platform :ios, '11.0'

target 'GitHubSearch' do
inhibit_all_warnings!

target 'GitHubSearchTests' do
    inherit! :search_paths
  end

  target 'GitHubSearchUITests' do
    inherit! :search_paths
  end
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
