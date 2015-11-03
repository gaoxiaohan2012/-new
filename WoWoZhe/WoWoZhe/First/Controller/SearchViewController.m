//
//  SearchViewController.m
//  WoWoZhe
//
//  Created by xiaohan on 15/10/25.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "SearchViewController.h"
#import "categaryModel.h"


@interface SearchViewController ()<UISearchBarDelegate>
{
    NSString *_serachBarText;
    UISearchBar *_searchBar;
}
@end

@implementation SearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
- (void)viewWillDisappear:(BOOL)animated {
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    //视图消失前，，放弃第一响应
    [_searchBar resignFirstResponder];
    [super viewWillDisappear:animated];
    
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSearchBar];
    [self createBtn];
}
- (void)createSearchBar {
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _searchBar.placeholder = @"请输入你想要的宝贝";
    _searchBar.delegate = self;
    [_searchBar becomeFirstResponder];
    self.navigationItem.titleView = _searchBar;
    
    //设置rightItem
    NSMutableDictionary *textAttribute = [[NSMutableDictionary alloc]init];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttribute[NSForegroundColorAttributeName] = [UIColor blackColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
}

#pragma mark -- rightItemClick
- (void)rightItemClick {
    
    
    
}

- (void)createBtn {
    CGSize size = self.view.frame.size;
    int i = 0;
    for (categaryModel *model  in _dataArr) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(10+(size.width/4)*(i%4), 64+(int)50 * (i / 4), 0, 0);
        [button sizeToFit];
        [button setTitle:model.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (i== 3) {
            [button setTitle:@"我是你们" forState:UIControlStateNormal];
        }
        //自适应button的宽高。。。。。。
        [button sizeToFit];
        button.layer.borderWidth = 2;
        button.layer.cornerRadius = 10;
        button.layer.borderColor = [UIColor greenColor].CGColor;
        i++;
        [self.view addSubview:button];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _serachBarText = searchText;
   // NSLog(@"++++++++%@",_serachBarText);
    
}
//最后需要搜索的内容。。。。。。。。
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _serachBarText = searchBar.text;
    NSLog(@"最后搜索的%@",_serachBarText);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}


@end
