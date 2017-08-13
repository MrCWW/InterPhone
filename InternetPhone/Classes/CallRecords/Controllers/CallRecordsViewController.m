//
//  CallRecordsViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "CallRecordsViewController.h"
#import "CallRecordsDetailViewController.h"
#import "AnswerCallViewController.h"
#import "MissedCallViewController.h"
@interface CallRecordsViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *answerCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *missedCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *eidtCallBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong)  UIView *lineView;
@end

@implementation CallRecordsViewController
- (IBAction)answerAction:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        self.lineView.frame = HCGRECT(0, 48, 70, 2);
    }];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}
- (IBAction)missedAction:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        self.lineView.frame = HCGRECT(70, 48, 70, 2);
    }];
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
}
//编辑
- (IBAction)eidtCallAction:(id)sender {
    [self.bigScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
}
//返回第一页
- (IBAction)backFirstViewAction:(id)sender {
    [self.bigScrollView setContentOffset:CGPointMake(0, 0)];
}
//去通讯录
- (IBAction)goAddressBookAction:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatScrollView];
}
- (void)creatScrollView {
    self.lineView = [[UIView alloc] initWithFrame:HCGRECT(0, 48, 70, 2)];
    _lineView.backgroundColor = [UIColor blueColor];
    [self.headerView addSubview:_lineView];
    self.scrollView = [[UIScrollView alloc]initWithFrame:HCGRECT(0, 50, ScreenWidth, ScreenHeight - 179)];
    NSInteger scrollHeight = self.scrollView.height;
    //    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    //    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth*2, scrollHeight );
    [self.bigScrollView addSubview:self.scrollView];
    
    AnswerCallViewController *aVC = [[AnswerCallViewController alloc] init];
    
    [self addChildViewController:aVC];
    aVC.view.frame = HCGRECT(0, 0, ScreenWidth, scrollHeight);
    aVC.view.backgroundColor  = [UIColor redColor];
    [self.scrollView addSubview:aVC.view];
    
    MissedCallViewController *bVC = [[MissedCallViewController alloc] init];
    
    [self addChildViewController:bVC];
    bVC.view.frame = HCGRECT(ScreenWidth, 0, ScreenWidth, scrollHeight);
    [self.scrollView addSubview:bVC.view];
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
