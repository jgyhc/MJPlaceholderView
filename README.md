# MJPlaceholderView

[![CI Status](https://img.shields.io/travis/jgyhc/MJPlaceholderView.svg?style=flat)](https://travis-ci.org/jgyhc/MJPlaceholderView)
[![Version](https://img.shields.io/cocoapods/v/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)
[![License](https://img.shields.io/cocoapods/l/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)
[![Platform](https://img.shields.io/cocoapods/p/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)

使用前，先确定愿不愿意加入依赖，不愿意的话，自行修改代码就好了！

为了布局方便依赖了:`Masonry`

为了方便配置全局视图样式，依赖了:`CTMediator`

为了监测网络请求状态引入了：`AFNetworking`

为了加载动图引入了：`YYImage`

实现思路：交换了`tableView`和`collectionView`的`reloadData`方法，另外还加入了没有网络情况的占位图和页面加载中的占位图！



最简单的时候，`self.collectionView.placeholderView = [MJPlaceholderView placeholder];`就可以使用了。
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

## Installation

MJPlaceholderView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MJPlaceholderView'
```

## Author

jgyhc, jgyhc@foxmail.com

## License

MJPlaceholderView is available under the MIT license. See the LICENSE file for more info.
