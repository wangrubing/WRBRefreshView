//
//  WRBRefreshView.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    WRBFooterViewStatusBeginDrag,
    WRBFooterViewStatusDragging,
    WRBFooterViewStatusLoading,
    WRBHeaderViewStatusBeginDrag,
    WRBHeaderViewStatusDragging,
    WRBHeaderViewStatusLoading,
} WRBRefreshViewStatus;

@interface WRBRefreshView : UIView
{
    WRBRefreshViewStatus _status;
    UIScrollView *_scrollView;
    NSString *_headerViewBeginDragString;
    NSString *_headerViewDraggingString;
    NSString *_headerViewLoadingString;
    NSString *_footerViewBeginDragString;
    NSString *_footerViewDraggingString;
    NSString *_footerViewLoadingString;
    
}
@property (nonatomic, assign) WRBRefreshViewStatus status;
@property (nonatomic, strong) UIScrollView *scrollView;
+(id)refreshView;
-(void)setTitle:(NSString *)title forState:(WRBRefreshViewStatus)status;
@end
