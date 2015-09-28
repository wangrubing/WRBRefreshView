//
//  WRBFooterView.h
//  美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRBRefreshView.h"
@class WRBFooterView;

@protocol WRBFooterViewDelegate <NSObject>

-(void)footerViewSendRequest:(WRBFooterView *)footerView WithStatus:(WRBRefreshViewStatus)status;

@end

@interface WRBFooterView : WRBRefreshView
@property (nonatomic, strong) id <WRBFooterViewDelegate> delegate;
+(id)footerView;
-(void)stopAnimating;

@end
