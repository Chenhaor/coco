//
//  GWRegisterViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWRegisterViewController.h"
#import "GWCustomInputView.h"

@interface GWRegisterViewController ()

@end

@implementation GWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    
    [self setLayout];
}


- (void)setLayout
{
    [self setNavigationItemRightBarButtomWithTitle:@"登陆"
                                  titleNormalColor:RGBCOLOR(233, 80, 45)
                                  titleSelectColor:RGBCOLOR(233, 80, 45)];
    
    
    GWCustomInputView *accountInputView = [[GWCustomInputView alloc] initInputViewWithFrame:CGRectMake(14, 20, kScreenWidth - 28, 50)
                                                                                iconImgName:@"login_phone"
                                                                                placeHolder:@"手机号"];
    [self.view addSubview:accountInputView];
    
    
    GWCustomInputView *passwordInputView = [[GWCustomInputView alloc] initInputViewWithFrame:CGRectMake(14, CGRectGetMaxY(accountInputView.frame) + 2, kScreenWidth - 28, 49)
                                                                                 iconImgName:@"login_password"
                                                                                 placeHolder:@"密码"];
    [self.view addSubview:passwordInputView];
    
    
    UIImageView *confirmPasswordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(passwordInputView.frame) + 2, kScreenWidth - 28, 50)];
    confirmPasswordImgView.userInteractionEnabled = YES;
    confirmPasswordImgView.image = [UIImage imageNamed:@"login_input_bg"];
    [self.view addSubview:confirmPasswordImgView];
    UITextField *confirmPasswordTextFild = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, CGRectGetWidth(confirmPasswordImgView.frame) - 86, 30)];
    confirmPasswordTextFild.placeholder = @"确认密码";
    [confirmPasswordImgView addSubview:confirmPasswordTextFild];
    UIImageView *confirmIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(confirmPasswordImgView.frame) - 36.0, 16, 12, 18)];
    confirmIconImgView.image = [UIImage imageNamed:@"login_confirmPassword"];
    [confirmPasswordImgView addSubview:confirmIconImgView];
    
    
    GWCustomInputView *getValideCodeView = [[GWCustomInputView alloc] initInputViewWithFrame:CGRectMake(14, CGRectGetMaxY(confirmPasswordImgView.frame) + 20, kScreenWidth - 28, 50)
                                                                                         iconImgName:nil
                                                                                         placeHolder:@"手机验证码"];
    [self.view addSubview:getValideCodeView];
    UIButton *valideCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(getValideCodeView.frame) - 145, 0, 145, 50)];
    [valideCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [valideCodeBtn setBackgroundImage:[UIImage imageNamed:@"login_valideCodeBtn"] forState:UIControlStateNormal];
    [getValideCodeView addSubview:valideCodeBtn];
    
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(getValideCodeView.frame) + 20, kScreenWidth - 28, 50)];
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
