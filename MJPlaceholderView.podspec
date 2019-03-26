#
# Be sure to run `pod lib lint MJPlaceholderView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MJPlaceholderView'
  s.version          = '1.5.5'
  s.summary          = '一个用于tableView和collectionView空页面占位控件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
一个用于tableView和collectionView空页面占位控件，逻辑非常简单！但是应该还有问题！后面慢慢优化吧~
                       DESC

  s.homepage         = 'https://github.com/jgyhc/MJPlaceholderView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jgyhc' => 'jgyhc@foxmail.com.com' }
  s.source           = { :git => 'https://github.com/jgyhc/MJPlaceholderView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MJPlaceholderView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MJPlaceholderView' => ['MJPlaceholderView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking'
    s.dependency 'Masonry'
    s.dependency 'YYImage'
    s.dependency 'CTMediator'
    s.dependency 'Aspects'
end
