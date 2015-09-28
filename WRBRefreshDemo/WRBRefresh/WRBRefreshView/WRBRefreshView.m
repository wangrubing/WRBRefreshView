//
//  WRBRefreshView.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import "WRBRefreshView.h"

@implementation WRBRefreshView

+(id)refreshView
{
    return [[self alloc] init];
}

-(void)didMoveToSuperview
{
    self.scrollView = (UIScrollView *)self.superview;
    [self setDefaultTitles];
}

#pragma mark - 设置标题
-(void)setTitle:(NSString *)title forState:(WRBRefreshViewStatus)status
{
    switch (status) {
        case WRBFooterViewStatusBeginDrag:
            _footerViewBeginDragString = title? title:_footerViewBeginDragString;
            break;
            
        case WRBFooterViewStatusDragging:
            _footerViewDraggingString = title? title:_footerViewDraggingString;
            break;
            
        case WRBFooterViewStatusLoading:
            _footerViewLoadingString = title? title:_footerViewLoadingString;
            break;
        
        case WRBHeaderViewStatusBeginDrag:
            _headerViewBeginDragString = title? title:_headerViewBeginDragString;
            break;
            
        case WRBHeaderViewStatusDragging:
            _headerViewDraggingString = title? title:_headerViewDraggingString;
            break;
            
        case WRBHeaderViewStatusLoading:
            _headerViewLoadingString = title? title:_headerViewLoadingString;
            break;
            
        default:
            break;
    }
}

-(void)setDefaultTitles
{
    _footerViewBeginDragString = @"拖拽加载更多⬆️。。。";
    _footerViewDraggingString = @"松开加载更多⬇️。。。";
    _footerViewLoadingString = @"正在努力加载😄";
    _headerViewBeginDragString = @"下拉刷新⬇️";
    _headerViewDraggingString = @"松开刷新⬆️";
    _headerViewLoadingString = @"刷新成功😄";
}

@end
