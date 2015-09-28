//
//  ViewController.m
//  WRBRefresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 wrb. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+WRBRefresh.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, WRBHeaderViewDelegate, WRBFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.footerView.delegate = self;
    self.tableView.headerView.delegate = self;
}

#pragma mark -UITableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"123";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)footerViewSendRequest:(WRBFooterView *)footerView WithStatus:(WRBRefreshViewStatus)status
{
    NSLog(@"发起网络请求");
    [self performSelector:@selector(sendRequest) withObject:nil afterDelay:1];
}

-(void)sendRequest
{
    [self.tableView.footerView stopAnimating];
    NSLog(@"结束网络请求");
}

-(void)headerViewSendRequest:(WRBHeaderView *)headerView WithStatus:(WRBRefreshViewStatus)status
{
    NSLog(@"发起刷新请求");
    [self performSelector:@selector(sendRefreshRequest) withObject:nil afterDelay:1];
}

-(void)sendRefreshRequest
{
    [self.tableView.headerView stopAnimating];
    NSLog(@"结束刷新请求");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
