//
//  LoginViewController.m
//  WoWoZhe
//
//  Created by MS on 15/10/26.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginWebViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _accountTextField.delegate = self;
    _codeTextField.delegate = self;
    
    //多线程的创建
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    });
    

    
}
- (IBAction)loginBtnClick:(UIButton *)sender {
}



- (IBAction)weixinClick:(UIButton *)sender {
}

- (IBAction)qqClick:(UIButton *)sender {
}

- (IBAction)xinlangClick:(UIButton *)sender {
    LoginWebViewController *lvc = [[LoginWebViewController alloc]init];
    lvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:1 animations:^{
        self.navigationController.navigationBar.alpha = 1;
    }];
    [super viewDidAppear:animated];
}
#pragma mark --- textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
//结束编辑,监听输入的文本。。
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
//return 之后的事件。。。。
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
