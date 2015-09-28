//
//  UITableView+WRBRefresh.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRBHeaderView.h"
#import "WRBFooterView.h"
#import "WRBRefreshView.h"

@interface UITableView (WRBRefresh)
@property (nonatomic, weak) WRBFooterView *footerView;
@property (nonatomic, weak) WRBHeaderView *headerView;
@end
