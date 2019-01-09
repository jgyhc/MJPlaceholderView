#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MJPlaceholder.h"
#import "MJPlaceholderView.h"
#import "UICollectionView+MJPlaceholder.h"
#import "UITableView+MJPlaceholder.h"

FOUNDATION_EXPORT double MJPlaceholderViewVersionNumber;
FOUNDATION_EXPORT const unsigned char MJPlaceholderViewVersionString[];

