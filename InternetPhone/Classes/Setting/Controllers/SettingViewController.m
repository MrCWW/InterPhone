//
//  SettingViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (nonatomic,copy) UIButton *dlbutton;

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
}

- (void)backClidtc:(UIButton *)sender{
    
    
}
- (IBAction)quit:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"quit" object:nil];

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
