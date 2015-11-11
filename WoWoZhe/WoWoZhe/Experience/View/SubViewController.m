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
#import "ExperienceModel.h"
#import "ExperienceTableViewCell.h"
#import "UIImageView+WebCache.h"

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
    //注册cell
    [self registCell];
    _dataArr = [[NSMutableArray alloc]init];
    _page = 1;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self refreshData];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self refreshData];
    }];
    
    [_tableView.header beginRefreshing];
//    _tableView.footer.automaticallyHidden = NO;
}
#pragma mark -- 注册cell
- (void)registCell {
    [_tableView registerNib:[UINib nibWithNibName:@"ExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExperienceTableViewCell.h"];
    
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
            //上新页面的数据
            if ([_urlStr isEqualToString:@"http://sapi.beibei.com/resource/ads-iPhone-2147483646-App%20Store-1_3_4_5_6_7_19_22_42_28_36_43-3.3.1-0.html"]) {
                [self jsonFirstData:responseObject];
            }else {
            //json解析
            [self jsonData:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
            NSLog(@"网络请求失败");
        }];
    }
}
#pragma mark -- 上新网址的json解析
- (void)jsonFirstData:(id)object {
    
    
}


#pragma mark -- jsonData
- (void)jsonData:(id)object {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
    if (dic) {
        for (NSDictionary *martshowDic in [dic objectForKey:@"martshows"]) {
            //加进来第一层数据
            ExperienceModel *model = [[ExperienceModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            //将cell的数据加进来。
            [model setValuesForKeysWithDictionary:martshowDic];
            [_dataArr addObject:model];
        }
        //NSLog(@"%@",_dataArr);
        [_tableView reloadData];
    }
    
}



#pragma  mark -- tableView delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExperienceModel *model = [_dataArr objectAtIndex:indexPath.row];
    
    ExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExperienceTableViewCell.h"];
    [cell.mainIconView sd_setImageWithURL:[NSURL URLWithString:model.main_img]];
    cell.promotionLabel.text = model.promotion;
    cell.titleLabel.text = model.title;
    cell.buyLabel.text = model.buying_info;
    [cell.mjIconView sd_setImageWithURL:[NSURL URLWithString:model.mj_icon]];
    cell.mjLabel.text  = model.mj_promotion;
    
    ///待完善。。。
//    cell.timeLabel.text = [model.gmt_begin stringValue];
    NSDate *date = [NSDate date];
    NSTimeInterval now = [date timeIntervalSince1970];
    NSLog(@"%zd   %.f",model.gmt_end.integerValue,now);
    NSInteger end = model.gmt_end.integerValue;
    
    NSInteger left = (end - now) / 3600 ;
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%zd",left];
    
    
    return cell;

}









@end
