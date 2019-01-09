//
//  Target_PlacehoderConfiger.h
//  MJPlaceholderView_Example
//
//  Created by manjiwang on 2019/1/9.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_PlacehoderConfiger : NSObject


- (id)Action_titleLabel:(NSDictionary *)params;

- (id)Action_subTitleLabel:(NSDictionary *)params;

- (id)Action_button:(NSDictionary *)params;

- (id)Action_imageView:(NSDictionary *)params;

- (id)Action_noNetworkParams:(NSDictionary *)params;

- (id)Action_noDataParams:(NSDictionary *)params;

- (id)Action_loadingParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
