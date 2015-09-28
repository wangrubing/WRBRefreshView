//
//  WRBHeaderView.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRBRefreshView.h"
@class WRBHeaderView;

@protocol WRBHeaderViewDelegate <NSObject>

-(void)headerViewSendRequest:(WRBHeaderView *)headerView WithStatus:(WRBRefreshViewStatus)status;

@end

@interface WRBHeaderView : WRBRefreshView
@property (nonatomic, strong) id <WRBHeaderViewDelegate> delegate;
+(id)headerView;
-(void)stopAnimating;
@end
