//
//  MJPlaceholderView.m
//  ManJi
//
//  Created by manjiwang on 2018/12/17.
//  Copyright © 2018 Zgmanhui. All rights reserved.
//

#import "MJPlaceholderView.h"
#import <Masonry/Masonry.h>
#import <YYImage/YYImage.h>
#import <AFNetworking/AFNetworking.h>
#import "CTMediator.h"

#define MJPlaceholder_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface MJPlaceholderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) YYAnimatedImageView *imageView;

@property (nonatomic, strong) UILabel *attLabel;

@property (nonatomic, strong) UIButton *goButton;

@property (nonatomic, assign) BOOL reachability;

@property (nonatomic, assign) BOOL isLoading;
@end

@implementation MJPlaceholderView

/** 创建placeholderView */
+ (instancetype)placeholder {
    MJPlaceholderView *view = [[MJPlaceholderView alloc] init];
    return view;
}

- (void)placeholderStartLoading {
    _isLoading = YES;
    [self reloadData];
}

- (void)placeholderEndLoading {
    _isLoading = NO;
    [self reloadData];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _reachability = YES;//默认有网的
        [self initSubViews];
        [self netWorkChangeEvent];
    }
    return self;
}

#pragma mark - 检测网络状态变化
- (void)netWorkChangeEvent {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    __weak typeof(self) wself = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            wself.reachability = NO;
            [wself reloadData];
        }else {
            wself.reachability = YES;
        }
    }];
}

- (void)initSubViews {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.attLabel];
    [self addSubview:self.goButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(150);
        make.top.mas_equalTo(self.mas_top).mas_offset(100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(20);
        make.width.mas_lessThanOrEqualTo(MJPlaceholder_SCREEN_WIDTH - 20);
    }];
    
    [self.attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(2);
        make.width.mas_lessThanOrEqualTo(MJPlaceholder_SCREEN_WIDTH - 20);
    }];
    
    [self.goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.attLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
}

- (void)buttonHandleEvent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectButtonPlaceholderView:)]) {
        [self.delegate didSelectButtonPlaceholderView:self];
    }
    if (self.didSelectButtonPlaceholderViewBlock) {
        self.didSelectButtonPlaceholderViewBlock(self);
    }
}

- (void)reloadData {
    if (!_reachability) {
        _type = MJPlaceholderViewTypeNoNetwork;
    }else {
        if (_isLoading) {
            _type = MJPlaceholderViewTypeLoading;
        }else {
            _type = MJPlaceholderViewTypeNoData;
        }
    }
    switch (_type) {
        case MJPlaceholderViewTypeLoading: {
            [self updateViewWithParams:self.loadingPlacehoderParam];
        }
            break;
        case MJPlaceholderViewTypeNoData: {
            [self updateViewWithParams:self.noDataPlacehoderParam];
        }
            break;
        case MJPlaceholderViewTypeNoNetwork: {
            [self updateViewWithParams:self.noNetworkPlacehoderParam];
        }
            break;
            
        default:
            break;
    }
}

- (void)updateViewWithParams:(NSDictionary *)params {
    NSString *title = [params objectForKey:@"title"];
    if (title && [title isKindOfClass:[NSString class]] && title.length > 0) {
        self.titleLabel.text = title;
        self.titleLabel.hidden = NO;
    }else {
        self.titleLabel.hidden = YES;
    }
    
    NSString *subTitle = [params objectForKey:@"subTitle"];
    if (subTitle && [subTitle isKindOfClass:[NSString class]] && subTitle.length > 0) {
        self.attLabel.text = subTitle;
        self.attLabel.hidden = NO;
    }else {
        self.attLabel.hidden = YES;
    }
    
    NSString *buttonTitle = [params objectForKey:@"buttonTitle"];
    if (buttonTitle && [buttonTitle isKindOfClass:[NSString class]] && buttonTitle.length > 0) {
        [self.goButton setTitle:buttonTitle forState:UIControlStateNormal];
        self.goButton.hidden = NO;
    }else {
        self.goButton.hidden = YES;
    }
    
    UIImage *image = [params objectForKey:@"image"];
    if (image && [image isKindOfClass:[UIImage class]]) {
        self.imageView.image = image;
    }
}

- (YYAnimatedImageView *)imageView {
    if(_imageView == nil) {
        _imageView = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"imageView" params:nil shouldCacheTarget:YES];
        if (!_imageView) {
            _imageView = [[YYAnimatedImageView alloc] init];
            _imageView.contentMode = UIViewContentModeCenter;
        }
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"titleLabel" params:nil shouldCacheTarget:YES];
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.textColor = [UIColor grayColor];
            _titleLabel.font = [UIFont systemFontOfSize:15];
        }
    }
    return _titleLabel;
}

- (UILabel *)attLabel {
    if(_attLabel == nil) {
        _attLabel = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"subTitleLabel" params:nil shouldCacheTarget:YES];
        if (!_attLabel) {
            _attLabel = [[UILabel alloc] init];
            _attLabel.textColor = [UIColor grayColor];
            _attLabel.font = [UIFont systemFontOfSize:15];
        }
    }
    return _attLabel;
}

- (UIButton *)goButton {
    if(_goButton == nil) {
        _goButton = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"button" params:nil shouldCacheTarget:YES];
        if (!_goButton) {
            _goButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_goButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _goButton.titleLabel.font = [UIFont systemFontOfSize:15];
            _goButton.layer.cornerRadius = 3;
            _goButton.layer.borderWidth = 1;
        }
        [_goButton addTarget:self action:@selector(buttonHandleEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goButton;
}

- (NSDictionary *)loadingPlacehoderParam {
    if (!_loadingPlacehoderParam) {
        _loadingPlacehoderParam = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"loadingParams" params:nil shouldCacheTarget:YES];
    }
    return _loadingPlacehoderParam;
}

- (NSDictionary *)noDataPlacehoderParam {
    if (!_noDataPlacehoderParam) {
        _noDataPlacehoderParam = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"noDataParams" params:nil shouldCacheTarget:YES];
    }
    return _noDataPlacehoderParam;
}

- (NSDictionary *)noNetworkPlacehoderParam {
    if (!_noNetworkPlacehoderParam) {
        _noNetworkPlacehoderParam = [[CTMediator sharedInstance] performTarget:@"PlacehoderConfiger" action:@"noNetworkParams" params:nil shouldCacheTarget:YES];
    }
    return _noNetworkPlacehoderParam;
}

@end

