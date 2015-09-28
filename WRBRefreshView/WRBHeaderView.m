//
//  WRBHeaderView.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import "WRBHeaderView.h"

@interface WRBHeaderView ()
@property(nonatomic,weak)UIButton * alertButtonView;
@property(nonatomic,weak)UIView * loadingView;
@end

@implementation WRBHeaderView

#pragma mark - 显示前
+(id)headerView
{
    return [self refreshView];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    CGFloat headerX = 0;
    CGFloat headerY = newSuperview.frame.origin.y-60;
    CGFloat headerW = newSuperview.frame.size.width;
    CGFloat headerH = 60;
    
    self.frame = CGRectMake(headerX, headerY, headerW, headerH);
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
    self.status = WRBHeaderViewStatusBeginDrag;
    [_alertButtonView removeFromSuperview];
    [_loadingView removeFromSuperview];
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
        label.text = _headerViewLoadingString;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [view addSubview:activity];
        activity.frame = CGRectMake(90, 10, 40, 40);
        [activity startAnimating];
    }
    return _loadingView;
}

#pragma mark - 设置状态
-(void)setStatus:(WRBRefreshViewStatus)status
{
    _status = status;
    
    switch (status) {
        case WRBHeaderViewStatusBeginDrag:
            [self.alertButtonView setTitle:_headerViewBeginDragString forState:UIControlStateNormal];
            break;
            
        case WRBHeaderViewStatusDragging:
            [self.alertButtonView setTitle:_headerViewDraggingString forState:UIControlStateNormal];
            break;
            
        case WRBHeaderViewStatusLoading:
            self.alertButtonView.hidden = YES;
            [self loadingView];
            break;
            
        default:
            break;
    }
}


#pragma mark - 监听scrollView
-(void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self willMoveToSuperview:_scrollView];
    if (_scrollView.isDragging)
    {
        if (self.status != WRBHeaderViewStatusLoading) {
            if (_scrollView.contentOffset.y <= 0 && _scrollView.contentOffset.y > -self.frame.size.height)
            {
                [self setStatus:WRBHeaderViewStatusBeginDrag];
            }
            else if (_scrollView.contentOffset.y <= -self.frame.size.height)
            {
                
                [self setStatus:WRBHeaderViewStatusDragging];
            }
        }
    }//end if (_scrollView.isDragging)
    else
    {
        if (self.status == WRBHeaderViewStatusDragging) {
            self.status = WRBHeaderViewStatusLoading;
            _scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            [_delegate headerViewSendRequest:self WithStatus:WRBHeaderViewStatusLoading];
        }

    }//end else
}


@end
