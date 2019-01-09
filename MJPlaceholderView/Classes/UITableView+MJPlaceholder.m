//
//  UITableView+MJPlaceholder.m
//  AFNetworking
//
//  Created by manjiwang on 2019/1/9.
//

#import "UITableView+MJPlaceholder.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static NSString *placeholderViewKey = @"placeholderViewKey";
@implementation UITableView (MJPlaceholder)

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
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"reloadData", @"deleteSections:", @"deleteRowsAtIndexPaths:withRowAnimation:", @"deleteItemsAtIndexPaths:"];
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
    //    [self.placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    //    }];
    //    [self.placeholderView layoutIfNeeded];
    [self.placeholderView reloadData];
}

- (void)removePlaceholderView  {
    [self.placeholderView removeFromSuperview];
}

- (NSUInteger)numberOfSectionsInScrollView {
    NSUInteger sections = 1;
    UITableView *tableView = (UITableView *)self;
    if (tableView.dataSource && [tableView.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [tableView.dataSource numberOfSectionsInTableView:tableView];
    }
    return sections;
}

- (NSUInteger)numberOfRowsInSection0 {
    NSUInteger rows = 0;
    UITableView *tableView = (UITableView *)self;
    if (tableView.dataSource && [tableView.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        rows = [tableView.dataSource tableView:tableView numberOfRowsInSection:0];
    }
    return rows;
}


@end
