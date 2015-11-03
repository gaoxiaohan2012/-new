//
//  FirstViewController.m
//  WoWoZhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "FirstViewController.h"
#define k_shouyeUrl @"http://www.wowozhe.com/home/m?act=home/data_v2_6"
//#define k_downUrl @"http://www.wowozhe.com/home/m?act=home%2Fdata_v2_6&json=%7B%22pagination%22%3A%7B%22page%22%3A%223%22%7D%7D HTTP/1.1"
#define k_downUrl @"http://www.wowozhe.com/home/m?act=home/data_v2_6"

@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_memuArr;
    NSMutableArray *_sliderArr;
    BOOL _isRefresh;
    int _page;
    NSString *_urlStr;
    int _otherDataArrCount;
    CGFloat _originOffSet;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [[NSMutableArray alloc]init];
    _memuArr = [[NSMutableArray alloc]init];
    _sliderArr = [[NSMutableArray alloc]init];
    
    [self createUIHeader];
    [self registCell];
}

- (void)registCell {
    [_collectionView registerNib:[UINib nibWithNibName:@"FirstViewCell" bundle:nil]forCellWithReuseIdentifier:@"FirstViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"SliderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SliderCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"MenuCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"MenuCollectionViewCell"];
}

- (void)createUIHeader {
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        _urlStr = k_shouyeUrl;
        [self mjRefresh];
    }];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        _urlStr = k_downUrl;
        [self mjRefresh];
    }];
    
    footer.hidden = YES;
    _collectionView.footer.automaticallyHidden = NO;
    _collectionView.header = header;
    _collectionView.footer = footer;

}

- (void)reloadData {
    if (!_urlStr.length) {
        _urlStr = k_shouyeUrl;
        [_collectionView.header beginRefreshing];
    }
}

- (void)mjRefresh {
     [[HLManager defaultManager] startConnectionWithUrlStr:_urlStr target:self action:@selector(hlConnection:) tag:0];
}

- (void)hlConnection:(HLConnection *)hc {
    if (hc.isSuccess) {
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        _collectionView.footer.hidden = NO;
        [_memuArr removeAllObjects];
        [_sliderArr removeAllObjects];
       // [_dataArr removeAllObjects];
        [self jsonData:hc];
    }
    
}

#pragma mark -- json解析
- (void)jsonData:(HLConnection *)hc {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:hc.downloadData options:0 error:nil];
    if (dict) {
        NSDictionary *dataDic = [dict objectForKey:@"data"];
        for (NSDictionary *firstDic in [dataDic objectForKey:@"items"]) {
            FirstModel *fm = [[FirstModel alloc]init];
            [fm setValuesForKeysWithDictionary:firstDic];
            [_dataArr addObject:fm];
        }
        for (NSDictionary *menuDci in [dataDic objectForKey:@"menu"]) {
            menuModel *mm = [[menuModel alloc]init];
            [mm setValuesForKeysWithDictionary:menuDci];
            [_memuArr addObject:mm];
        }
        for (NSDictionary *slideDci in [dataDic objectForKey:@"slider"]) {
            sliderModel *sm = [[sliderModel alloc]init];
            [sm setValuesForKeysWithDictionary:slideDci];
            [_sliderArr addObject:sm];
        }
        [_collectionView reloadData];
       // MYLog(@"%@",_dataArr);
    }
    
}

#pragma mark -- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _otherDataArrCount = 0;
    if (_sliderArr.count && _memuArr.count) {
        _otherDataArrCount = 2;
    }
    
    return [_dataArr count] + _otherDataArrCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SliderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SliderCollectionViewCell" forIndexPath:indexPath];
        [cell reloadDataArr:_sliderArr];
        return cell;
    }
    if (indexPath.row == 1) {
        MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCollectionViewCell" forIndexPath:indexPath];
        
        for (int i = 0; i < _memuArr.count; i++) {
            menuModel *model = _memuArr[i];
            if (i==0) {
                [cell.iconVIew1 sd_setImageWithURL:[NSURL URLWithString:model.icon]];
                cell.titleLabel1.text = model.title;
                
            }
            if (i==1) {
                [cell.iconView2 sd_setImageWithURL:[NSURL URLWithString:model.icon]];
                 cell.titleLabel2.text = model.title;
            }
            if (i==2) {
                [cell.iconVIew3 sd_setImageWithURL:[NSURL URLWithString:model.icon]];
                 cell.titleLabel3.text = model.title;
            }
            if (i==3) {
                [cell.iconView4 sd_setImageWithURL:[NSURL URLWithString:model.icon]];
                 cell.titleLabel4.text = model.title;
            }
        }
        return cell;
    }
    
    FirstModel *model = [_dataArr objectAtIndex:indexPath.row-_otherDataArrCount];
    FirstViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = model.title;
    cell.priceLabel.text= model.price;
    [cell.likeBtn setTitle:model.likes forState:UIControlStateNormal];
    [cell.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.img]];
//    cell.likeBtn.imageView.image = [UIImage imageNamed:@"ic_no_collection"];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return CGSizeMake(SIZE.width - 4, 200);
    }
    if (indexPath.row == 1) {
        return CGSizeMake(SIZE.width - 4, 60);
    }
    
    return CGSizeMake(SIZE.width/2 - 7, 200);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    if (section == 1 || section == 0) {
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstModel *model = [_dataArr objectAtIndex:indexPath.row-_otherDataArrCount];
    MYLog(@"点击了%@",model.title);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isRefresh) {
        [self reloadData];
        [_collectionView.header beginRefreshing];
        _isRefresh = YES;
    }
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    self.navigationItem.leftBarButtonItem.title = @"窝窝折";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"窝窝折";
    label.textColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:label];
    
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    button.layer.cornerRadius = 15;
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(rightItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"请输入你想要购买的宝贝" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.titleLabel.textColor = [UIColor blackColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark -- rightItem 点击事件
- (void)rightItemBtnClick:(UIButton *)btn {
    SearchViewController *svc = [[SearchViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}

#pragma mark -- scrollView delegate 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_collectionView.contentOffset.y >= 0) {
        _originOffSet = _collectionView.contentOffset.y ;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSet = _collectionView.contentOffset.y;
    if (_originOffSet >= offSet) {
        [UIView animateWithDuration:0.4 animations:^{
            [self.tabBarController.tabBar setFrame:CGRectMake(0, self.view.frame.size.height - 49, _collectionView.frame.size.width, 49)];
        }];
    }else {
        [UIView animateWithDuration:0.4 animations:^{
            [self.tabBarController.tabBar setFrame:CGRectMake(0, self.view.frame.size.height, _collectionView.frame.size.width, 49)];
        }];
    }
}







@end
