//
//  exchangeViewController.m
//  InternetPhone
//
//  Created by wangkun on 2017/9/9.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "exchangeViewController.h"

@interface exchangeViewController ()
@property (nonatomic,copy) UITextField *zhField;
@property (weak, nonatomic) IBOutlet UIButton *aniubutton;

@end

@implementation exchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *zhlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 153, ScreenWidth, 1)];
    zhlabel.backgroundColor = [UIColor colorWithRed:222.0/255 green:222.0/255  blue:222.0/255 alpha:1.0f];
    [self.view addSubview:zhlabel];
    UILabel *mmlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 107, ScreenWidth, 1)];
    mmlabel.backgroundColor = [UIColor colorWithRed:222.0/255 green:222.0/255  blue:222.0/255 alpha:1.0f];
    [self.view addSubview:mmlabel];
    
    _zhField = [[UITextField alloc] initWithFrame:CGRectMake(10, 115, ScreenWidth, 40)];
//    _zhField.backgroundColor = [UIColor brownColor];
    _zhField.placeholder = @"請輸入加值碼：";
    [_zhField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_zhField];
    //点击空白处收回键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
- (IBAction)anbutton:(id)sender {
    
    if ((_aniubutton.selected = !_aniubutton.selected)) {
        
        [_aniubutton setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
    }else{
        
        
        [_aniubutton setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
        
    }

}
- (IBAction)backnutton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)exchange:(id)sender {
    [MBProgressHUD showText:@"该功能暂未开通，敬请期待" toView:nil];

}
- (IBAction)buy:(id)sender {
    [MBProgressHUD showText:@"该功能暂未开通，敬请期待" toView:nil];

}
// 点击空白处收起键盘
-(void)keyboardHide:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
    
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
