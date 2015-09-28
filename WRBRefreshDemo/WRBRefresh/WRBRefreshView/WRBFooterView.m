//
//  WRBFooterView.m
//  美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import "WRBFooterView.h"

@interface WRBFooterView ()
@property (nonatomic, weak) UIButton *alertButtonView;
@property (nonatomic, weak) UIView *loadingView;
@end

@implementation WRBFooterView

#pragma mark - 页面显示前
+(id)footerView
{
    return [self refreshView];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView *tableView = (UITableView *)newSuperview;
    
    CGFloat selfX = 0;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];
}

#pragma mark - 停止
-(void)stopAnimating
{
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self clear];
}

-(void)clear
{
    self.status = WRBFooterViewStatusBeginDrag;
    [_alertButtonView removeFromSuperview];
    [_loadingView removeFromSuperview];
}

#pragma mark - 设置状态
-(void)setStatus:(WRBRefreshViewStatus)status
{
    _status = status;
    switch (status) {
        case WRBFooterViewStatusBeginDrag:
            [self.alertButtonView setTitle:_footerViewBeginDragString forState:UIControlStateNormal];
            break;
            
        case WRBFooterViewStatusDragging:
            [self.alertButtonView setTitle:_footerViewDraggingString forState:UIControlStateNormal];
            break;
            
        case WRBFooterViewStatusLoading:
            self.alertButtonView.hidden = YES;
            [self loadingView];
            break;
            
        default:
            break;
    }
}

#pragma mark - 监听scrollView的滚动
-(void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self willMoveToSuperview:_scrollView];
    if (_scrollView.isDragging) {
        CGFloat maxY = _scrollView.contentSize.height - _scrollView.frame.size.height;
        CGFloat footerViewHeight = self.frame.size.height;
        
        if (self.status != WRBFooterViewStatusLoading)
        {
            if (_scrollView.contentOffset.y >= maxY && _scrollView.contentOffset.y < maxY + footerViewHeight)
            {
                self.status = WRBFooterViewStatusBeginDrag;
            }
            else if (_scrollView.contentOffset.y > maxY + footerViewHeight)
            {
                self.status = WRBFooterViewStatusDragging;
            }
        }
    }//end if (_scrollView.isDragging)
    else
    {
        if (self.status == WRBFooterViewStatusDragging) {
            self.status = WRBFooterViewStatusLoading;
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            [_delegate footerViewSendRequest:self WithStatus:WRBFooterViewStatusLoading];
        }
    }//end else
}

#pragma mark - 控件懒加载
-(UIButton *)alertButtonView
{
    if (_alertButtonView == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _alertButtonView = btn;
        
        btn.frame = self.bounds;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    return _alertButtonView;
}

-(UIView *)loadingView
{
    if (_loadingView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:view];
        _loadingView = view;
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        [view addSubview:label];
        label.text = _footerViewLoadingString;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [view addSubview:activity];
        activity.frame = CGRectMake(90, 10, 40, 40);
        [activity startAnimating];
    }
    return _loadingView;
}

@end
