//
//  UITableView+MJPlaceholder.m
//  AFNetworking
//
//  Created by manjiwang on 2019/1/9.
//

#import "UITableView+MJPlaceholder.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import <Aspects/Aspects.h>

static NSString *placeholderViewKey = @"placeholderViewKey";
@implementation UITableView (MJPlaceholder)

- (void)setPlaceholderView:(MJPlaceholderView *)placeholderView {
    if (placeholderView != self.placeholderView) {
        if (self.placeholderView) {
            [self.placeholderView removeFromSuperview];
        }
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
    }
}

- (MJPlaceholderView *)placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
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
    self.autoresizesSubviews = YES;
    [self addSubview:self.placeholderView];
    self.placeholderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
