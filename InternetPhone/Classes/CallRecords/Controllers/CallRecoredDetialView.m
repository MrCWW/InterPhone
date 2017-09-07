//
//  CallRecoredDetialView.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/5.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "CallRecoredDetialView.h"
#import "CallRecoredsDetialTableViewCell.h"

#define OneCell @"oneCell"
@interface CallRecoredDetialView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PhoneRecoredModel *model;
@end
@implementation CallRecoredDetialView
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrView = [[NSBundle mainBundle] loadNibNamed:@"CallRecoredDetialView" owner:self options:nil];
        UIView *view = arrView[0];
        self.bottomView = view;
        view.frame = HCGRECT(0, 0, ScreenWidth, self.height);
        [self addSubview:view];
        [self creatTableView];
    }
    return self;
}

- (void)creatTableView {
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCoreData:) name:@"getCallRecoredDetialNoti" object:nil];
    //创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:HCGRECT(0, 204, ScreenWidth, self.bottomView.height - 204) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉cell分割线
        self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
    [self.tableView registerNib:[UINib nibWithNibName:@"CallRecoredsDetialTableViewCell" bundle:nil] forCellReuseIdentifier:OneCell];
      self.tableView.tableFooterView = [UIView new];
    [self.bottomView addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CallRecoredsDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneCell];
    PhoneRecoredModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}
#pragma mark - 收到通知，查询数据库，获取数据源
- (void)getCoreData:(NSNotification *)sender {
    NSDictionary *dic = sender.object;
    PhoneRecoredModel *model = dic[@"phone"];
    self.model = model;
    //根据手机号，查询
    self.phoneNumberLabel.text = model.phone;
  self.dataArray = [NSMutableArray arrayWithArray: [CoreDataAPI searchWithPerson:model]];
    [self.tableView reloadData];
}
- (IBAction)callBtnAction:(id)sender {
    //拨号通知
    Here_Set_soundPhone(self.model.phone);//设置拨号number
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callBtnActionRecoredView" object:nil];
// 插入数据库
    [self insertCoredata:self.model];
}
#pragma mark - 点击拨号，插入到数据库&更新界面
- (void)insertCoredata:(PhoneRecoredModel *)model {
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
//    modelRecored.phone = model.phone;
    NSString *cityStr = Here_Is_gravity;
    if ([cityStr isEqualToString:@"台灣"]) {
        modelRecored.phone = [NSString stringWithFormat:@"002886%@",model.phone];
    }else {
        modelRecored.phone = [NSString stringWithFormat:@"00281%@",model.phone];
    }
    modelRecored.timedate = [NSString stringWithFormat:@"%@ %@",timeWeekStr,string];
    modelRecored.updatedate = today;
    //插入到数据库
    [CoreDataAPI insertPhoneRecored:modelRecored];
    //重新获取数据源，刷新界面, 发送通知
   [[NSNotificationCenter defaultCenter] postNotificationName:@"callRecoredDataNoti" object:nil];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
