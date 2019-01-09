# MJPlaceholderView

[![CI Status](https://img.shields.io/travis/jgyhc/MJPlaceholderView.svg?style=flat)](https://travis-ci.org/jgyhc/MJPlaceholderView)
[![Version](https://img.shields.io/cocoapods/v/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)
[![License](https://img.shields.io/cocoapods/l/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)
[![Platform](https://img.shields.io/cocoapods/p/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)

实现思路：交换了`tableView`和`collectionView`的`reloadData`方法，另外还加入了没有网络情况的占位图和页面加载中的占位图！

最简单的时候，`self.collectionView.placeholderView = [MJPlaceholderView placeholder];`就可以适用了。
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
