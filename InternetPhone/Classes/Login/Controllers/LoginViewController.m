//
//  LoginViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)loginBtnAction:(id)sender {
//
    Here_Save_UserName(self.Loginaccount.text);
    Here_Save_passWord(self.Loginpasswd.text);
    

    NSDictionary *dict = @{@"username": self.Loginaccount.text, @"password" : self.Loginpasswd.text, @"token" : @"8389adec-3e18-11e7-a919-92ebcb67fe33"};
[AFNTool postPhone:Phone_URL_login_php Body:dict success:^(id result) {
    NSLog(@"%@", result);

    if ([result[@"message"] isEqualToString:@"Login Successful"]) {
        NSDictionary *dic = result;
        LoginModel *model = [LoginModel modelWithDic:dic];
        kArchiverHomepageModel(model);
//sip用户名 密码登录
             [[UCSIPCCManager instance] addProxyConfig:@"8117002998" password:@"fA2ZL3B7Bkdi2Ku" displayName:@"123" domain:model.sip_ip port:model.sip_port withTransport:@"UDP"];
    }else {
        [MBProgressHUD showText:@"登錄失败" toView:nil];
        
    }
} failure:^(NSError *error) {
    [MBProgressHUD showText:@"登錄失败" toView:nil];
}];
    

}
//服务条款
- (IBAction)servicebutton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.eznippon.com/clause/"]]];
}
//注意事项
- (IBAction)restbutton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.eznippon.com/appprecautions/"]]];
}
//忘记密码
- (IBAction)pswdbutton:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://shop.eznippon.com/member/helper/card/cht_change_pass"]]];
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
