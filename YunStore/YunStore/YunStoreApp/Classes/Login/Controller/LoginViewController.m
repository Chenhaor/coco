//
//  LoginViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextField.h"
#import "ThirdPartyLoginView.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginTextField *userNameTextField;
@property (nonatomic, strong) LoginTextField *passwordTextField;
@property (nonatomic, strong) UIButton *secureButton;

@property (nonatomic, strong) UIButton *ensureButton;
@property (nonatomic, strong) UIButton *findPasswordButton;
@property (nonatomic, strong) ThirdPartyLoginView *thirdPartyLoginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.view.backgroundColor=DEFAULT_BACKGROUND_COLOR;

    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.thirdPartyLoginView];
    [self createBarButtonItem];
    
    [self createUI];
}

-(void)createUI{
    self.ensureButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ensureButton.frame=CGRectMake(15, 15+CGRectGetMaxY(_passwordTextField.frame), kScreenWidth-30, 50);
    [self.ensureButton.layer setCornerRadius:5];
    [self.ensureButton.layer setMasksToBounds:YES];
    [self.ensureButton setTitle:@"确定" forState:UIControlStateNormal];
    self.ensureButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.ensureButton setTitleColor:SECOND_DEGREE_COLOR forState:UIControlStateNormal];
    self.ensureButton.backgroundColor=RGBCOLOR(221, 221, 221);
    [self.view addSubview:self.ensureButton];
    
    self.findPasswordButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.findPasswordButton.frame=CGRectMake(15, CGRectGetMaxY(_ensureButton.frame), kScreenWidth-30, 50);
    [self.findPasswordButton.layer setCornerRadius:5];
    [self.findPasswordButton.layer setMasksToBounds:YES];
    [self.findPasswordButton setTitle:@"找回密码？" forState:UIControlStateNormal];
    self.findPasswordButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.findPasswordButton setTitleColor:SECOND_DEGREE_COLOR forState:UIControlStateNormal];    self.findPasswordButton.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.findPasswordButton];
}

-(ThirdPartyLoginView *)thirdPartyLoginView{
    if (!_thirdPartyLoginView) {
        _thirdPartyLoginView=[[ThirdPartyLoginView alloc]initWithFrame:CGRectMake(0, kScreenHeight-165-64, kScreenWidth, 165)];
    }
    return _thirdPartyLoginView;
}

- (LoginTextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [[LoginTextField alloc] initWithImage:@"YF_UserName" placeHolder:@"用户名/手机号/邮箱" top:25];
        _userNameTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        _userNameTextField.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        _userNameTextField.returnKeyType = UIReturnKeyNext;
        _userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _userNameTextField.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0];
        _userNameTextField.delegate = self;
    }
    return _userNameTextField;
}

- (LoginTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[LoginTextField alloc] initWithImage:@"YF_password" placeHolder:@"请输入密码" top:CGRectGetMaxY(self.userNameTextField.frame) + 1];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.delegate = self;
        _passwordTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        _passwordTextField.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        _passwordTextField.returnKeyType = UIReturnKeyJoin;
        _passwordTextField.clearButtonMode = UITextFieldViewModeNever;
        _passwordTextField.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13.0];
        _passwordTextField.delegate = self;
        
        self.secureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.secureButton.selected = _passwordTextField.secureTextEntry;
        self.secureButton.frame = CGRectMake(0, 17, 40, 15);
        [self.secureButton setImage:[UIImage imageNamed:@"YF_hidePassWord"] forState:UIControlStateNormal];
        [self.secureButton setImage:[UIImage imageNamed:@"YF_ShowPassWord"] forState:UIControlStateSelected];
        [self.secureButton addTarget:self action:@selector(clickTextfieldButton) forControlEvents:UIControlEventTouchUpInside];
        //        [_passwordTextField.rightView addSubview:self.secureButton];
        _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        _passwordTextField.rightView = self.secureButton;
    }
    return _passwordTextField;
}

-(void)createBarButtonItem{
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"getBack"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBaritem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftBaritem;
    
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBaritem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBaritem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickTextfieldButton{
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    self.secureButton.selected = !self.secureButton.selected;
}
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)rightClick{


}

@end
