//
//  AddDetailViewController.m
//  InternetPhone
//
//  Created by wangkun on 2017/8/1.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AddDetailViewController.h"
#import "PhoneViewController.h"
@interface AddDetailViewController ()

@end

@implementation AddDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
- (void)createUI{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 23, 150, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -85, 0, 0)];
    [button setImage:[UIImage imageNamed:@"btn_backBlack"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickbacktwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *im  =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 50, 100, 100)];
    UIImage *image = [UIImage imageNamed:@"5@3x20170720"];
    im.image = image;
    im.layer.masksToBounds = YES;
    im.layer.cornerRadius = im.frame.size.width/2;
    [self.view addSubview:im];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,CGRectGetMaxY(im.frame)+5, 180, 30)];
    lb.text = _strname;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor blackColor];
    lb.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:lb];
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,CGRectGetMaxY(lb.frame)+5, 180, 30)];
    lb1.text = @"電話號碼";
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.textColor = [UIColor colorWithRed:98.0/255 green:98.0/255  blue:98.0/255 alpha:1.0f];
    lb1.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,CGRectGetMaxY(lb1.frame)+5, 180, 30)];
    lb2.text = _strPhone;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.textColor = [UIColor colorWithRed:98.0/255 green:98.0/255  blue:98.0/255 alpha:1.0f];
    lb2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lb2];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(ScreenWidth/2-16, CGRectGetMaxY(lb2.frame)+5, 50, 50);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 10, 10)];
    button1.backgroundColor = [UIColor orangeColor];
    [button1 setImage:[UIImage imageNamed:@"20170720-中華電信-撥號"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickbackphone:) forControlEvents:UIControlEventTouchUpInside];
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = button1.frame.size.width/2;
    [self.view addSubview:button1];


}

//pop返回方法，如果是push过来的就会使用此方法
- (void)clickbacktwo:(UIBarButtonItem *)but {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)clickbackphone:(UIBarButtonItem *)but {
    PhoneViewController *meVc = [[PhoneViewController alloc]init];
    meVc.strPhone = _strPhone;
    [self.navigationController pushViewController:meVc animated:YES];

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
