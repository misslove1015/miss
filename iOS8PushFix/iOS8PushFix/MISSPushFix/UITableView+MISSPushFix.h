//
//  UITableView+MISSPushFix.h
//  zcsy
//
//  Created by miss on 16/4/17.
//  Copyright © 2016年 fanwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MISSPushFix)

- (void)ky_putEstimatedCellHeightToCache:(NSIndexPath *) indexPath height:(CGFloat) height;

- (CGFloat)ky_getEstimatedCellHeightFromCache:(NSIndexPath *) indexPath defaultHeight:(CGFloat) defaultHeight;

- (BOOL)ky_isEstimatedRowHeightInCache:(NSIndexPath *) indexPath;

- (void)ky_tableViewReloadData;

@end
