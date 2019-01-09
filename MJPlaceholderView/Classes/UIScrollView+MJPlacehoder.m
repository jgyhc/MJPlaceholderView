//
//  UIScrollView+MJPlacehoder.m
//  FBSnapshotTestCase
//
//  Created by manjiwang on 2019/1/8.
//

#import "UIScrollView+MJPlacehoder.h"
#import <objc/runtime.h>

static NSString *placeholderViewKey = @"placeholderViewKey";

@implementation UIScrollView (MJPlacehoder)

- (void)setPlaceholderView:(MJPlaceholderView *)placeholderView {
    if (placeholderView != self.placeholderView) {
        objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self mj_logicalProcessing];
    }
}

- (MJPlaceholderView *)placeholderView {
    MJPlaceholderView *view = objc_getAssociatedObject(self, &placeholderViewKey);
    if (!view) {
        view = [[MJPlaceholderView alloc] init];
        objc_setAssociatedObject(self, &placeholderViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray;
        if ([[self class] isKindOfClass:[UITableView class]]) {
            selStringsArray = @[@"reloadData", @"deleteSections:", @"deleteRowsAtIndexPaths:withRowAnimation:", @"deleteItemsAtIndexPaths:"];
        }else if ([[self class] isKindOfClass:[UICollectionView class]]) {
            selStringsArray = @[@"reloadData", @"deleteSections:", @"deleteItemsAtIndexPaths:"];
        }
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

- (void)mj_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (!self.placeholderView) {
        [self mj_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        return;
    }
    [self mj_logicalProcessing];
    [self mj_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
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
    NSString * classString = NSStringFromClass(self.class);
    if (![classString isEqualToString:@"UITableView"] && ![classString isEqualToString:@"UICollectionView"]) {
        return;
    }
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
    self.placeholderView.frame = self.bounds;
    [self addSubview:self.placeholderView];
}

- (void)removePlaceholderView  {
    [self.placeholderView removeFromSuperview];
}

- (NSUInteger)numberOfSectionsInScrollView {
    NSUInteger sections = 1;
    NSString * classString = NSStringFromClass(self.class);
    if ([classString isEqualToString:@"UITableView"]) {
        UITableView *tableView = (UITableView *)self;
        if (tableView.dataSource && [tableView.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [tableView.dataSource numberOfSectionsInTableView:tableView];
        }
    }
    if ([classString isEqualToString:@"UICollectionView"]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        if (collectionView.dataSource && [collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [collectionView.dataSource numberOfSectionsInCollectionView:collectionView];
        }
    }
    return sections;
}

- (NSUInteger)numberOfRowsInSection0 {
    NSUInteger rows = 0;
    NSString * classString = NSStringFromClass(self.class);
    if ([classString isEqualToString:@"UITableView"]) {
        UITableView *tableView = (UITableView *)self;
        if (tableView.dataSource && [tableView.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            rows = [tableView.dataSource tableView:tableView numberOfRowsInSection:0];
        }
    }
    if ([classString isEqualToString:@"UICollectionView"]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        if (collectionView.dataSource && [collectionView.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            rows = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:0];
        }
    }
    return rows;
}


@end
