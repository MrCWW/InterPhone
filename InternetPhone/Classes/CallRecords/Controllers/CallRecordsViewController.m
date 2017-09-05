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
#import "PhoneRecoredModel.h"
#import "ShowAlter.h"
#define OneCell @"oneCell"
@interface CallRecordsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataTimeArray;
@property (weak, nonatomic) IBOutlet UIButton *answerCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *missedCallBtn;
@property (weak, nonatomic) IBOutlet UIButton *eidtCallBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *editDeleteTopView;//编辑界面头视图
@property (weak, nonatomic) IBOutlet UIButton *hiddenEditViewBtn;//隐藏编辑界面btn
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;//全选btn
@property (weak, nonatomic) IBOutlet UIButton *deleteDataBtn;//删除btn

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong)  UIView *lineView;
@property (nonatomic, strong) NSMutableArray *deleteDataArr;//需要删除的数组
@end

@implementation CallRecordsViewController
{

    BOOL _isSelectAllAction;//是否全选btn，默认NO
    BOOL _isDeleteAction;//是否删除btn，默认NO
    
}
- (NSMutableArray *)deleteDataArr {
    if (!_deleteDataArr) {
        _deleteDataArr = [NSMutableArray array];
    }
    return _deleteDataArr;
}
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
    _isEditAction = NO;//控制详情按钮是否显示
    [self allBtnStatus];
    [self.tableView reloadData];
}
//初始化编辑btn的状态
-(void)allBtnStatus{
    _isSelectAllAction = NO;
    [self.deleteDataArr removeAllObjects];
    self.selectAllBtn.selected = _isSelectAllAction;
    self.deleteDataBtn.selected = _isSelectAllAction;
    self.deleteDataBtn.userInteractionEnabled = _isSelectAllAction;
}
//全选操作
- (IBAction)selectAllAction:(id)sender {
    _isSelectAllAction = !_isSelectAllAction;
    self.selectAllBtn.selected = _isSelectAllAction;
    self.deleteDataBtn.selected = _isSelectAllAction;
    self.deleteDataBtn.userInteractionEnabled = _isSelectAllAction;
  
        //全选操作，清空删除数组，重新赋值
        [self.deleteDataArr removeAllObjects];
 
    [self.tableView reloadData];
}
//删除操作
- (IBAction)deleteDataAction:(id)sender {
    [ShowAlter showAlertToController:self title:@"提示" message:@"确定删除通话记录" cancelAction:@"取消" otherAction:@"确定" sureBlock:^{
        NSLog(@"%@",_deleteDataArr);
        for (PhoneRecoredModelCount *model in self.deleteDataArr) {
            //删除数据库
            [CoreDataAPI deleteWithPerson:model];
        }
        //重新获取数据源，刷新界面
        NSDictionary *dataDic = [CoreDataAPI searchPhoneRecored];
        self.dataArray = dataDic[@"totalArr"];
        self.dataTimeArray = dataDic[@"timeArr"];
        [self hiddenEditAciton:nil];//隐藏编辑界面
        [self.tableView reloadData];

    } cancelBlock:^{
        
    }];

}

//编辑
- (IBAction)eidtCallAction:(id)sender {
//    [self.bigScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    self.editDeleteTopView.hidden = NO;
    _isEditAction = YES;//控制详情按钮是否显示
    [self allBtnStatus];
    [self.tableView reloadData];
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
      [self.bigScrollView setContentOffset:CGPointMake(0, 0)];//显示通话记录tableview
    _isEditAction = NO;//非编辑模式
        self.editDeleteTopView.hidden = YES;//隐藏编辑界面
    NSLog(@"%@",_dataTimeArray);
    NSLog(@"%@",_dataArray);
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isEditAction = NO;//非编辑模式
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
    model.isShowDetial = !_isEditAction;//是否显示
    if (_isSelectAllAction == YES) {
        model.isSelectDelete = _isSelectAllAction;//是否全选，默认不选中
        [self.deleteDataArr addObject:model];//如果全选操作，则全部加进去
    }else {
        if (self.deleteDataArr.count == 0) {
            model.isSelectDelete = _isSelectAllAction;//当前没有选中的model
        }
    }

    cell.model = model;
    cell.indexPath = indexPath;
    cell.detialBlock = ^(NSIndexPath *indexPath) {
        //点击详情
          [self.bigScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    };
    //删除选中
    cell.deteleBlock = ^(NSIndexPath *indexPath) {
        model.isSelectDelete = !model.isSelectDelete;
//        weakCell.deleteBtn.selected = model.isSelectDelete;
        if (model.isSelectDelete) {
            //model被选中,添加到数组中
            [self.deleteDataArr addObject:model];
        
        }else {
            //model没被选中,从数组中移除
            _isSelectAllAction = NO;//当前数组非全选状态
            self.selectAllBtn.selected = _isSelectAllAction;
            [self.deleteDataArr removeObject:model];
        }
        if (self.deleteDataArr.count) {
            //如果删除数组中有值，则删除按钮高亮状态
            self.deleteDataBtn.selected = YES;
            self.deleteDataBtn.userInteractionEnabled = YES;
        }else {
            self.deleteDataBtn.selected = NO;
            self.deleteDataBtn.userInteractionEnabled = NO;
        }
//        [_tableView reloadData];
        NSLog(@"%@",_deleteDataArr);
         //刷新当前行
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *secArr = self.dataArray[indexPath.section];
    PhoneRecoredModelCount *model = secArr[indexPath.row];
    Here_Set_soundPhone(model.phone);//设置拨号number
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callBtnActionRecoredView" object:nil];
    [self insertCoredata:model];
}
#pragma mark - 点击拨号，插入到数据库&更新界面
- (void)insertCoredata:(PhoneRecoredModelCount *)model {
    //存储日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:today];//判断是周几
    NSString *timeWeekStr =  [self judegWeekDay:[comps weekday]];
    //        NSDate * date = p.updatedate;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MM月dd号";
    //日期字符串
    NSString *string = [format stringFromDate:today];
    NSLog(@"%@",string);
    PhoneRecoredModel *modelRecored = [[PhoneRecoredModel alloc] init];
    modelRecored.name = model.name;
    modelRecored.phone = model.phone;
    modelRecored.timedate = [NSString stringWithFormat:@"%@ %@",timeWeekStr,string];
    modelRecored.updatedate = today;
    //插入到数据库
    [CoreDataAPI insertPhoneRecored:modelRecored];
    //重新获取数据源，刷新界面
    NSDictionary *dataDic = [CoreDataAPI searchPhoneRecored];
    self.dataArray = dataDic[@"totalArr"];
    self.dataTimeArray = dataDic[@"timeArr"];
    [self hiddenEditAciton:nil];//隐藏编辑界面
    [self.tableView reloadData];

}

//判断周几
-(NSString *)judegWeekDay:(NSInteger)weekDay{
    //在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    NSString *strWeek;
    switch (weekDay) {
        case 1:
        {
            strWeek = @"周日";
        }
            break;
        case 2:
        {
            strWeek = @"周一";
        }
            break;
        case 3:
        {
            strWeek = @"周二";
        }
            break;
            
        case 4:
        {
            strWeek = @"周三";
        }
            break;
        case 5:
        {
            strWeek = @"周四";
        }
            break;
        case 6:
        {
            strWeek = @"周五";
        }
            break;
        case 7:
        {
            strWeek = @"周六";
        }
            break;
        default:
            break;
    }
    return strWeek;
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
