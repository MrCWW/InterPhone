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
#import "PhoneRecoredModelCount.h"
#import "CallRecordsTableViewCell.h"
#import "NSDate+judgeToday.h"
#define OneCell @"oneCell"
@interface CallRecordsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataTimeArray;
@property (weak, nonatomic) IBOutlet UIButton *answerCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *missedCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *eidtCallBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UIView *editDeleteTopView;//编辑界面头视图
@property (weak, nonatomic) IBOutlet UIButton *hiddenEditViewBtn;//隐藏编辑界面btn
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;//全选btn
@property (weak, nonatomic) IBOutlet UIButton *deleteDataBtn;//删除btn

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong)  UIView *lineView;
@end

@implementation CallRecordsViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataTimeArray {
    if (!_dataTimeArray) {
        _dataTimeArray = [NSMutableArray array];
    }
    return _dataTimeArray;
}
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
//隐藏编辑界面
- (IBAction)hiddenEditAciton:(id)sender {
    self.editDeleteTopView.hidden = YES;
}
//全选操作
- (IBAction)selectAllAction:(id)sender {
}
//删除操作
- (IBAction)deleteDataAction:(id)sender {
}

//编辑
- (IBAction)eidtCallAction:(id)sender {
//    [self.bigScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    self.editDeleteTopView.hidden = NO;
}
//返回第一页
- (IBAction)backFirstViewAction:(id)sender {
    [self.bigScrollView setContentOffset:CGPointMake(0, 0)];
}
//去通讯录
- (IBAction)goAddressBookAction:(id)sender {

}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 获取数据源
//到通话记录界面发送通知，查询数据库
- (void)callRecoredDataNoti:(NSNotification *)sender {
    NSDictionary *dataDic = [CoreDataAPI searchPhoneRecored];
    self.dataArray = dataDic[@"totalArr"];
    self.dataTimeArray = dataDic[@"timeArr"];
    NSLog(@"%@",_dataTimeArray);
    NSLog(@"%@",_dataArray);
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callRecoredDataNoti:) name:@"callRecoredDataNoti" object:nil];
    NSDictionary *dataDic = [CoreDataAPI searchPhoneRecored];
    self.dataArray = dataDic[@"totalArr"];
    self.dataTimeArray = dataDic[@"timeArr"];
    [self creatScrollView];
}
//创建tableView
- (void)creatScrollView {
    self.lineView = [[UIView alloc] initWithFrame:HCGRECT(0, 48, 70, 2)];
    _lineView.backgroundColor = [UIColor blueColor];
    [self.headerView addSubview:_lineView];// 暂时去掉
    
        //创建tableView
        self.tableView = [[UITableView alloc] initWithFrame:HCGRECT(0, 50, ScreenWidth, ScreenHeight - 179) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉cell分割线
        //    self.tableView.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
        self.tableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
        [self.tableView registerNib:[UINib nibWithNibName:@"CallRecordsTableViewCell" bundle:nil] forCellReuseIdentifier:OneCell];
         [self.bigScrollView addSubview:self.tableView];
        

  
//    self.scrollView = [[UIScrollView alloc]initWithFrame:HCGRECT(0, 50, ScreenWidth, ScreenHeight - 179)];
//    NSInteger scrollHeight = self.scrollView.height;
//    //    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.delegate = self;
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.bounces = NO;
//    //    self.scrollView.directionalLockEnabled = YES;
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth*2, scrollHeight );
//    [self.bigScrollView addSubview:self.scrollView];
//    
//    AnswerCallViewController *aVC = [[AnswerCallViewController alloc] init];
//    
//    [self addChildViewController:aVC];
//    aVC.view.frame = HCGRECT(0, 0, ScreenWidth, scrollHeight);
//    aVC.view.backgroundColor  = [UIColor redColor];
//    [self.scrollView addSubview:aVC.view];
//    
//    MissedCallViewController *bVC = [[MissedCallViewController alloc] init];
//    
//    [self addChildViewController:bVC];
//    bVC.view.frame = HCGRECT(ScreenWidth, 0, ScreenWidth, scrollHeight);
//    [self.scrollView addSubview:bVC.view];
    
    
    
}
#pragma mark -- <UITableViewDataSource,UITableViewDelegate>

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataTimeArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *secArr = self.dataArray[section];
    return secArr.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:HCGRECT(0, 0, ScreenWidth, 44)];
    UILabel *lable = [[UILabel alloc] initWithFrame:HCGRECT(0, 0, ScreenWidth, 44)];
    lable.textAlignment = NSTextAlignmentCenter;
//    lable.text = self.dataTimeArray[section];
    NSString *labelStr;
    PhoneRecoredModelCount *model = self.dataArray[section][0];
    if ([model.updatedate isToday]) {
        labelStr = @"今天";
    } else if ([model.updatedate isYesterday]) {
        labelStr = @"昨天";
    }else {
        labelStr = self.dataTimeArray[section];
    }
    lable.text = labelStr;
    lable.font = BaseFont(15);
    lable.textColor = [UIColor blueColor];
    [view addSubview:lable];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *secArr = self.dataArray[indexPath.section];
    PhoneRecoredModelCount *model = secArr[indexPath.row];
    //    __weak typeof(self)weakSelf = self;
    CallRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneCell];
    cell.model = model;
    cell.indexPath = indexPath;
    cell.detialBlock = ^(NSIndexPath *indexPath) {
        //点击详情
          [self.bigScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self.bigScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
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
