platform :ios, '11.0'

use_frameworks! 

target 'GitHubSearch' do
    pod 'RxSwift', '5.1.1'
    pod 'RxCocoa', '5.1.1'
end

target 'GitHubSearchTests' do
  pod 'Nimble'

  pod 'RxBlocking', '5.1.1'
  pod 'RxTest', '5.1.1'
end

target 'GitHubSearchUITests' do
 inherit! :search_paths
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

