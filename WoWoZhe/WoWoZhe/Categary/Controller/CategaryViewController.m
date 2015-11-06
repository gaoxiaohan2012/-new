//
//  CategaryViewController.m
//  WoWoZhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "CategaryViewController.h"
#import "CategaryButton.h"

#define k_categaryUrl @"http://i.wowozhe.com/home/m?target=ios&v=274&act=get_cate"
#define k_categaryBtnUrl @"http://i.wowozhe.com/home/m?act=top_cate"

@interface CategaryViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_btnArr;
    NSMutableArray *_scrollButtonArr;
    CategaryButton *_selectedBtn;
    BOOL _isAlertView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

@implementation CategaryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"商品分类";
    [self dataSource];
    [self createUI];
}
- (void)createUI {
    _searchBtn.layer.borderWidth = 1;
    _searchBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _searchBtn.layer.cornerRadius = 15;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CategaryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CategaryCollectionViewCell"];
    
    _scrollView.delegate = self;
//    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
}
#pragma mark -- 数据源
- (void)dataSource {
    _dataArr = [[NSMutableArray alloc]init];
    _btnArr = [[NSMutableArray alloc]init];
    _scrollButtonArr = [[NSMutableArray alloc]init];
    
//    NSDictionary *body = @{@"":@""};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager POST:k_categaryUrl parameters:nil success:^(AFHTTPRequestOperation * operation, id object) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
        if (dict) {
            int i = 0;
            for (NSDictionary *dataDci in [dict objectForKey:@"data"]) {
                categaryModel *model = [[categaryModel alloc]init];
                [model setValuesForKeysWithDictionary:dataDci];
                NSMutableArray *array = [[NSMutableArray alloc]init];
                //判断一下，，因为数据源中可能没有数据
                i++;
                
                //妈的，，，第九个竟然没有数据，，，那个数组是空的。。
                if (i != 9) {
                    for (NSDictionary *cateDic in [dataDci objectForKey:@"cate_chird"]) {
                        categaryModel *cm = [[categaryModel alloc]init];
                        [cm setValuesForKeysWithDictionary:cateDic];
                        [array addObject:cm];
                    }
                }
                model.categaryArr = array;
                
                [_dataArr addObject:model];
            }
            _selectedBtn.modelArr = [_dataArr[0] categaryArr];
            [_collectionView reloadData];
        }
        
        //get左边btn的数据源。。。。。
        [[HLManager defaultManager] startConnectionWithUrlStr:k_categaryBtnUrl target:self action:@selector(hlConnection:) tag:0];
        
        if (!_isAlertView) {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"come on" message:@"快点看看吧！" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [view show];
            _isAlertView = YES;
        }
        
    } failure:^(AFHTTPRequestOperation * operation , NSError * error) {
        MYLog(@"categary post----error");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
       
    }];
    
}

- (void)hlConnection:(HLConnection *)hc {
    if (hc.isSuccess) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:hc.downloadData options:0 error:nil];
        if (dict) {
            for (NSDictionary *dataDci in [dict objectForKey:@"data"]) {
                categaryModel *model = [[categaryModel alloc]init];
                [model setValuesForKeysWithDictionary:dataDci];
                [_btnArr addObject:model];
            }
        }
    }
//    MYLog(@"%@",_btnArr);
    [self createLeftBtn];
    
}
#pragma mark --左边btn的创建
- (void)createLeftBtn {
    for (int i = 0; i<_btnArr.count; i++) {
        CGFloat btnHeight = 60;
        categaryModel *model = _btnArr[i];
        CategaryButton *buton = [[CategaryButton alloc]initWithFrame:CGRectMake(0, i*btnHeight, _scrollView.frame.size.width, btnHeight)];
        buton.titleLabel.font = [UIFont systemFontOfSize:13];
        [buton setTitle:model.title forState:UIControlStateNormal];
        [buton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        buton.modelArr = [[_dataArr objectAtIndex:i] categaryArr];;
        buton.tag = 1000+i;
        [buton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //初始化为第一个btn选中状态
        if (i == 0) {
            buton.selected = YES;
            buton.modelArr = [_dataArr[0] categaryArr];
            _selectedBtn = buton;
        }
        [_scrollButtonArr addObject:buton];
        [_scrollView addSubview:buton];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, btnHeight * (i+1));
    }
    //初始化的时候，一旦有数据了，就开始刷新了。。。。
    [_collectionView reloadData];
}

#pragma mark -- leftBtnClick 
- (void)leftBtnClick:(CategaryButton *)btn {
#pragma mark -- leftbtn的多次点击跳转事件。
    //跳转详情页
    if (_selectedBtn == btn) {
        MYLog(@"又点了我一次，我要准备跳转详情页了");
    }
    for (CategaryButton *button in _scrollButtonArr) {
        if (button != btn) {
            button.selected = NO;
        }
    }
    btn.selected = YES;
    _selectedBtn = btn;
    //刷新数据
    [_collectionView reloadData];
}

#pragma  mark -- collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedBtn.modelArr.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategaryCollectionViewCell" forIndexPath:indexPath];
    if (_selectedBtn.modelArr) {
        categaryModel *model = _selectedBtn.modelArr[indexPath.row];
        cell.titleLabel.text = model.title;
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        //.....定制cell。。
    }
    
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(_collectionView.frame.size.width/3 - 9, 100);
    return size;
}
#pragma mark -- 点击cell的事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"categary 点击了第%zd个cell",indexPath.row);
}

#pragma mark -- 搜索条
- (IBAction)searchBtnClick:(UIButton *)sender {
    SearchViewController *svc  = [[SearchViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    svc.dataArr = _btnArr;
    [self.navigationController pushViewController:svc animated:NO];
    
}


@end
