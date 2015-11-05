//
//  SubViewController.m
//  WoWoZhe
//
//  Created by xiaohan on 15/11/4.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "SubViewController.h"
#import "XHTopScrollView.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

@interface SubViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    NSString *_usrStr;
    BOOL _isRefresh;
    NSInteger _page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    _page = 1;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self refreshData];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [_tableView.footer beginRefreshing];
        [self refreshData];
    }];
    
    [_tableView.header beginRefreshing];
    _tableView.footer.automaticallyHidden = NO;
}
#pragma mark -- 刷新数据
- (void)reloadData:(NSString *)urlStr {
    //判断是不是第一次或者数组有没有数据
    if (!_isRefresh || !_dataArr.count) {
        _urlStr = urlStr;
        [self refreshData];
        _isRefresh = YES;
    }
}

- (void)refreshData {
    //判断是不是拼接的网址。。
    NSRange range = [_urlStr rangeOfString:@"%d"];
    if (range.length) {
        _urlStr = [NSString stringWithFormat:_urlStr,_page];
    }
    if (_urlStr.length) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:_urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible  = NO;
            //json解析
            [self jsonData:responseObject];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"网络请求失败");
        }];
    }
}

#pragma mark -- jsonData
- (void)jsonData:(id)object {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
    if (dic) {
        NSLog(@"%@",dic);
    }
    
}



#pragma  mark -- tableView delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = @"我是个大好人";
    
    return cell;
}









@end
