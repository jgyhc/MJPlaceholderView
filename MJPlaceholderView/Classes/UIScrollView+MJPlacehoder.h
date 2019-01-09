//
//  UIScrollView+MJPlacehoder.h
//  FBSnapshotTestCase
//
//  Created by manjiwang on 2019/1/8.
//

#import <UIKit/UIKit.h>
#import "MJPlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJPlacehoder)





/** 这里没有自定义的话  就默认MJPlaceholderView */
@property (nonatomic, strong) MJPlaceholderView *placeholderView;

@end

NS_ASSUME_NONNULL_END
