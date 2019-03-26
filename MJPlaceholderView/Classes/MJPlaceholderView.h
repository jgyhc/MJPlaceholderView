//
//  MJPlaceholderView.h
//  ManJi
//
//  Created by manjiwang on 2018/12/17.
//  Copyright © 2018 Zgmanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN





@class MJPlaceholderView;
typedef NS_ENUM(NSInteger, MJPlaceholderViewType) {
    /** 加载中 */
    MJPlaceholderViewTypeLoading = 1,
    
    /** 没有数据 */
    MJPlaceholderViewTypeNoData = 2,
    
    /** 没网络的情况 */
    MJPlaceholderViewTypeNoNetwork = 3
};

@protocol MJPlaceholderViewDelegate <NSObject>

@optional

- (void)didSelectButtonPlaceholderView:(MJPlaceholderView *)placeholderView;

@end

@interface MJPlaceholderView : UIView

/** 创建placeholderView */
+ (instancetype)placeholder;

- (void)placeholderStartLoading;

- (void)placeholderEndLoading;

- (void)reloadData;

@property (nonatomic, weak) id <MJPlaceholderViewDelegate> delegate;

@property (nonatomic, copy) void (^didSelectButtonPlaceholderViewBlock)(MJPlaceholderView *placeholderView);

@property (nonatomic, assign) MJPlaceholderViewType type;

/** {
 "title": "标题",
 "subTitle": "副标题",
 "buttonTitle": "按钮标题",
 "image":"UIImage"
 } */
@property (nonatomic, strong) NSDictionary * noDataPlacehoderParam;

@property (nonatomic, strong) NSDictionary * noNetworkPlacehoderParam;

@property (nonatomic, strong) NSDictionary * loadingPlacehoderParam;




//tableView头部的存在应该影响placeholderView的位置
@property (nonatomic, assign) CGFloat headerHeader;

@end


NS_ASSUME_NONNULL_END
