//
//  UICollectionView+MJPlaceholder.m
//  AFNetworking
//
//  Created by manjiwang on 2019/1/9.
//

#import "UICollectionView+MJPlaceholder.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static NSString *placeholderViewKey = @"placeholderViewKey";
@implementation UICollectionView (MJPlaceholder)

- (void)setPlaceholderView:(MJPlaceholderView *)placeholderView {
    if (placeholderView != self.placeholderView) {
        if (self.placeholderView) {
            [self.placeholderView removeFromSuperview];
        }
        objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self mj_logicalProcessing];
    }
}

- (MJPlaceholderView *)placeholderView {
    return  objc_getAssociatedObject(self, &placeholderViewKey);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"reloadData", @"deleteSections:", @"deleteItemsAtIndexPaths:"];
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *leeSelString = [@"mj_" stringByAppendingString:selString];
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method leeMethod = class_getInstanceMethod(self, NSSelectorFromString(leeSelString));
            method_exchangeImplementations(originalMethod, leeMethod);
        }];
    });
}

- (void)mj_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (!self.placeholderView) {
        [self mj_deleteItemsAtIndexPaths:indexPaths];
        return;
    }
    [self mj_logicalProcessing];
    [self mj_deleteItemsAtIndexPaths:indexPaths];
}

- (void)mj_deleteSections:(NSIndexSet *)sections {
    if (!self.placeholderView) {
        [self mj_deleteSections:sections];
        return;
    }
    [self mj_logicalProcessing];
    [self mj_deleteSections:sections];
}

- (void)mj_reloadData {
    if (!self.placeholderView) {
        [self mj_reloadData];
        return;
    }
    [self mj_logicalProcessing];
    [self mj_reloadData];
}

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

- (void)addPlaceholderView {
    if (!self.placeholderView) {
        self.placeholderView = [[MJPlaceholderView alloc] init];
    }
    [self addSubview:self.placeholderView];
    self.placeholderView.frame = self.bounds;
    [self.placeholderView reloadData];
}

- (void)removePlaceholderView  {
    [self.placeholderView removeFromSuperview];
}

- (NSUInteger)numberOfSectionsInScrollView {
    NSUInteger sections = 1;
    UICollectionView *collectionView = (UICollectionView *)self;
    if (collectionView.dataSource && [collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [collectionView.dataSource numberOfSectionsInCollectionView:collectionView];
    }
    return sections;
}

- (NSUInteger)numberOfRowsInSection0 {
    NSUInteger rows = 0;
    UICollectionView *collectionView = (UICollectionView *)self;
    if (collectionView.dataSource && [collectionView.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        rows = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:0];
    }
    return rows;
}


@end
