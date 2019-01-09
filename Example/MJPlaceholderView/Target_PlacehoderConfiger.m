//
//  Target_PlacehoderConfiger.m
//  MJPlaceholderView_Example
//
//  Created by manjiwang on 2019/1/9.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import "Target_PlacehoderConfiger.h"
#import <YYImage/YYImage.h>

@implementation Target_PlacehoderConfiger

- (id)Action_titleLabel:(NSDictionary *)params {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"暂无数据";
    return label;
}

- (id)Action_subTitleLabel:(NSDictionary *)params {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

- (id)Action_button:(NSDictionary *)params {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我要逛逛" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 1;
    return button;
}

- (id)Action_imageView:(NSDictionary *)params {
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"暂无商品"];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}


- (id)Action_noNetworkParams:(NSDictionary *)params {
    return @{@"title": @"网络走丢了",
             @"buttonTitle": @"点击重试",
             @"subTitle": @"",
             @"imageName": @"WX20190109-143138"
             };
}

- (id)Action_noDataParams:(NSDictionary *)params {
    return @{@"title": @"没有数据",
             @"buttonTitle": @"点击重试",
             @"subTitle": @"",
             @"imageName": @"WX20190109-143510"
             };
}

- (id)Action_loadingParams:(NSDictionary *)params {
    return @{@"title": @"",
             @"buttonTitle": @"",
             @"subTitle": @"",
             @"imageName": @"10dba6ac0679e4c11cb95f93bc375c45c9c624e59a86-KPUDlr_fw658.gif"
             };
}



@end
