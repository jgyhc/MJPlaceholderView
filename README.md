# MJPlaceholderView

[![CI Status](https://img.shields.io/travis/jgyhc/MJPlaceholderView.svg?style=flat)](https://travis-ci.org/jgyhc/MJPlaceholderView)
[![Version](https://img.shields.io/cocoapods/v/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)
[![License](https://img.shields.io/cocoapods/l/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)
[![Platform](https://img.shields.io/cocoapods/p/MJPlaceholderView.svg?style=flat)](https://cocoapods.org/pods/MJPlaceholderView)

## 引入
### pod引入

```
pod 'MJPlaceholderView'
```

## 实现原理
  通过监控`tableView`和`collectionView`的数据源方法来控制我们的占位图是否展示，组件里使用了`Aspects`来分别监听`tableView`和`collectionView`的数据源更新方法，`tableView`相关的核心代码：
```
objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
SEL selectors[4] = {
	@selector(deleteSections:),
	@selector(reloadData),
	@selector(deleteRowsAtIndexPaths:withRowAnimation:),
	@selector(deleteItemsAtIndexPaths:)
};
for (NSInteger i = 0; i < 4; i ++) {
	SEL selector = selectors[i];
	[self aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^{
		[self mj_logicalProcessing];
	} error:nil];
}
[self mj_logicalProcessing];
```
`collectionView`相关的核心代码：
```
objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
SEL selectors[3] = {
	@selector(deleteSections:),
	@selector(reloadData),
	@selector(deleteItemsAtIndexPaths:)
};
for (NSInteger i = 0; i < 3; i ++) {
	SEL selector = selectors[i];
	[self aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^{
		[self mj_logicalProcessing];
	} error:nil];
}
[self mj_logicalProcessing];
```
`mj_logicalProcessing`方法则控制`MJPlaceholderView`的显示隐藏即可：
```
- (void)mj_logicalProcessing {
    NSUInteger sections = [self numberOfSectionsInScrollView];
    if (sections == 0) {
        [self addPlaceholderView];
    }else if (sections == 1) {
        NSUInteger rows = [self numberOfRowsInSection0];
        if (rows == 0) {
            [self addPlaceholderView];
        }else {
            [self removePlaceholderView];
        }
    }else {
        [self removePlaceholderView];
    }
}

```
## 使用
#### 全局配置通用样式
项目引入`CTMediator`来进行全局配置，主项目引入`Target_PlacehoderConfiger.h`和`Target_PlacehoderConfiger.m`文件，在`Action_titleLabel`、`Action_subTitleLabel`等方法中配置样式即可。有了全局配置的样式之后，在有需要的地方只需1行代码就可以完成占位图的设置：
```
self.collectionView.placeholderView = [MJPlaceholderView placeholder];
```
#### 局部配置
在个别的地方需要单独设置不同的图片和和文字的可以通过字典的方式传入配置信息：
```
self.tableView.placeholderView = [MJPlaceholderView placeholder];
UIImage *image = [UIImage imageNamed:@"goods_detail_no_comments_icon"];
self.tableView.placeholderView.noDataPlacehoderParam = @{@"title":@"该商品当前暂无评论",
														 @"image":image?image:[UIImage new]
														 };
```

## 依赖
使用前，先确定愿不愿意加入依赖，不愿意的话，自行修改代码就好了！

为了布局方便依赖了:`Masonry`

为了方便配置全局视图样式，依赖了:`CTMediator`

为了监测网络请求状态引入了：`AFNetworking`

为了加载动图引入了：`YYImage`

实现思路：交换了`tableView`和`collectionView`的`reloadData`方法，另外还加入了没有网络情况的占位图和页面加载中的占位图！

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
