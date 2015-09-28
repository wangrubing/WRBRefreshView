//
//  UITableView+WRBRefresh.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import "UITableView+WRBRefresh.h"
#import <objc/runtime.h>

static void * UITableViewFooterViewKey = (void *)@"UITableViewFooterViewKey";
static void * UITableViewHeaderViewKey = (void *)@"UITableViewHeaderViewKey";

@implementation UITableView (WRBRefresh)

-(id)footerView
{
    return objc_getAssociatedObject(self, UITableViewFooterViewKey);
}

-(void)setFooterView:(WRBFooterView *)footerView
{
    objc_setAssociatedObject(self, UITableViewFooterViewKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)headerView
{
    return objc_getAssociatedObject(self, UITableViewHeaderViewKey);
}

-(void)setHeaderView:(WRBHeaderView *)headerView
{
    objc_setAssociatedObject(self, UITableViewHeaderViewKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    WRBFooterView *footerView = [WRBFooterView footerView];
    [self addSubview:footerView];
    self.footerView = footerView;
//    [footerView setTitle:@"拖拽" forState:WRBFooterViewStatusBeginDrag];
//    [footerView setTitle:@"松开" forState:WRBFooterViewStatusDragging];

    WRBHeaderView *headerView = [WRBHeaderView headerView];
    [self addSubview:headerView];
    self.headerView = headerView;
}
@end
