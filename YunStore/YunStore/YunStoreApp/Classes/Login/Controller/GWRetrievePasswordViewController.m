//
//  GWRetrievePasswordViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWRetrievePasswordViewController.h"
#import "GWCustomInputView.h"

@interface GWRetrievePasswordViewController ()

@end

@implementation GWRetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    
    [self setLayout];
}

- (void)setLayout
{
    GWCustomInputView *newPasswordInputView = [[GWCustomInputView alloc] initInputViewWithFrame:CGRectMake(14, 20, kScreenWidth - 28, 50)
                                                                                    iconImgName:nil
                                                                                    placeHolder:@"新密码"];
    [self.view addSubview:newPasswordInputView];
    
    
    GWCustomInputView *passwordInputView = [[GWCustomInputView alloc] initInputViewWithFrame:CGRectMake(14, CGRectGetMaxY(newPasswordInputView.frame) + 8, kScreenWidth - 28, 49)
                                                                                 iconImgName:nil
                                                                                 placeHolder:@"重新输入密码"];
    [self.view addSubview:passwordInputView];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(passwordInputView.frame) + 20, kScreenWidth - 28, 50)];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"login_confirmBtn"] forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
