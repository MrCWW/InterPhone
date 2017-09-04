//
//  SettingViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginModel.h"
@interface SettingViewController ()
@property (nonatomic,copy) UIButton *dlbutton;
@property (nonatomic,assign) int chatType;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dlbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 273, ScreenWidth, 40)];
    [_dlbutton setTitle:@"terms of use" forState:UIControlStateNormal];
    [_dlbutton setTitleColor:[UIColor colorWithRed:98.0/255 green:98.0/255  blue:98.0/255 alpha:1.0f]forState:UIControlStateNormal];
    _dlbutton.titleLabel.font    = [UIFont systemFontOfSize: 14];
    _dlbutton.clipsToBounds = YES;
    _dlbutton.layer.cornerRadius =0;
    _dlbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dlbutton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    [_dlbutton addTarget:self action:@selector(backClidtc:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imone  =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-40, 13, 18, 23)];
    UIImage *imageone = [UIImage imageNamed:@"Icon_RightPin"];
    imone.image = imageone;
    [_dlbutton addSubview:imone];
    [self.view addSubview:_dlbutton];
    

    NSMutableDictionary *dic =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *str2 = [dic objectForKey:@"username"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    NSDictionary *dict = @{@"username":str2,  @"token" : @"8389adec-3e18-11e7-a919-92ebcb67fe33"};
    [manager POST:@"http://175.41.52.241/api/account/account_info.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        _zhanghao.text = [responseObject objectForKey:@"username"];
        NSString *nssing1 = [responseObject objectForKey:@"balance"];
        NSString *nssing2 = @"帳戶剩餘 ";
        
        NSString * string3 = [NSString stringWithFormat:@"%@  %@ 分鐘", nssing2, nssing1];
        NSMutableAttributedString * attriStr=[[NSMutableAttributedString alloc]initWithString:string3];
        NSRange range = [string3 rangeOfString:@"帳戶剩餘"];
        [attriStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:84.0/255 green:148.0/255  blue:200.0/255 alpha:1.0f]} range:range];
        _balabce.attributedText=attriStr;
        NSString *nssing4 = @"語音失效日期 ";
        NSString * string5 = [NSString stringWithFormat:@"%@  %@ ", nssing4, [responseObject objectForKey:@"expiry_date"]];

        _dates.text = string5;
        NSLog(@"%@", [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}

- (void)backClidtc:(UIButton *)sender{
    
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.eznippon.com/clause/"]]];

    
}
- (IBAction)quit:(id)sender {
        [[UCSIPCCManager instance] removeAccount];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"userTokenInvalidNotification" object:nil];

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
