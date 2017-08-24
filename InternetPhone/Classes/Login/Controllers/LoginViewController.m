//
//  LoginViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)loginBtnAction:(id)sender {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:self.Loginaccount.text forKey:@"userNames"];
//    [userDefaults setObject:self.Loginpasswd.text forKey:@"userPassword"];
//    [userDefaults synchronize];
    Here_Save_UserName(self.Loginaccount.text);
    Here_Save_passWord(self.Loginpasswd.text);
     [[UCSIPCCManager instance] addProxyConfig:self.Loginaccount.text password:self.Loginpasswd.text displayName:@"123" domain:@"113.35.73.142" port:@"5060" withTransport:@"UDP"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoginSuc" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view from its nib.
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
