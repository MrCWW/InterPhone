//
//  HBaseViewController.m
//  Here
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 奥里里亚. All rights reserved.
//

#import "HBaseViewController.h"
#import "HNavigationView.h"

@interface HBaseViewController ()



@end

@implementation HBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationTitle) {
        HNavigationView *view = [[HNavigationView alloc] initWithTitle:self.navigationTitle];
        [view addSubview:self.leftButton];
        [view addSubview:self.rightButton];
        [self.view addSubview:view];
    }
}

#pragma -mark 左侧按钮初始化
-(UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(10, 30, 24, 24);
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setImage:[UIImage imageNamed:@"返回黑"] forState:UIControlStateNormal];
    }
    return _leftButton;
}
- (void)leftButtonAction
{
    
}

#pragma -mark 右侧按钮初始化
- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 -24, 30, 24, 24);
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (void)rightButtonAction
{
    
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
#pragma setOrientation
- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
