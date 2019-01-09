//
//  UITableView+MJPlaceholder.h
//  AFNetworking
//
//  Created by manjiwang on 2019/1/9.
//

#import <UIKit/UIKit.h>
#import "MJPlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (MJPlaceholder)

/** 这里没有自定义的话  就默认MJPlaceholderView */
@property (nonatomic, strong) MJPlaceholderView *placeholderView;

@end

NS_ASSUME_NONNULL_END
