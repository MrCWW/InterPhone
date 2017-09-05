//
//  AHomePageViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/23.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AHomePageViewController.h"
#import "AddressBookViewController.h"
#import "PhoneViewController.h"
#import "SettingViewController.h"
#import "CallRecordsViewController.h"
@interface AHomePageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *phonePic;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addressBookPic;
@property (weak, nonatomic) IBOutlet UILabel *addressBookLabel;
@property (weak, nonatomic) IBOutlet UIImageView *callRecordsPic;
@property (weak, nonatomic) IBOutlet UILabel *callRecordsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *setPic;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;

@property (nonatomic, strong) UIImageView *selectPic;
@property (nonatomic, strong) UILabel *selectLabel;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
//添加子controller
@property (nonatomic, strong) PhoneViewController *phoneVC;
@property (nonatomic, strong) AddRessBookViewController *addressBookVC;
@property (nonatomic, strong) CallRecordsViewController *callRecordsVC;
@property (nonatomic, strong) SettingViewController *setVC;

@end

@implementation AHomePageViewController

- (PhoneViewController *)phoneVC {
    if (!_phoneVC) {
        _phoneVC = [[PhoneViewController alloc] init];
        _phoneVC.view.frame = HCGRECT(0, 0, ScreenWidth, ScreenHeight - 129);
    }
    return _phoneVC;
}
- (AddRessBookViewController *)addressBookVC {
    if (!_addressBookVC) {
        _addressBookVC = [[AddRessBookViewController alloc] init];
        _addressBookVC.view.frame = HCGRECT(ScreenWidth, 0, ScreenWidth, ScreenHeight - 129);
    }
    return _addressBookVC;
}
- (CallRecordsViewController *)callRecordsVC {
    if (!_callRecordsVC) {
        _callRecordsVC = [[CallRecordsViewController alloc] init];
        _callRecordsVC.view.frame = HCGRECT(ScreenWidth*2, 0, ScreenWidth, ScreenHeight - 129);
    }
    return _callRecordsVC;
}

- (SettingViewController *)setVC {
    if (!_setVC) {
        _setVC = [[SettingViewController alloc] init];
        _setVC.view.frame = HCGRECT(ScreenWidth*3, 0, ScreenWidth, ScreenHeight - 129);
    }
    return _setVC;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectPic = self.phonePic;
    self.selectLabel = self.phoneLabel;
    // Do any additional setup after loading the view from its nib.
    //打电话界面通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callActionNoti:) name:@"callActionNoti" object:nil];
    //去通讯录界面通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goAddressBooksNoti:) name:@"goAddressBooksNoti" object:nil];
    [self creatScrollView];
}
#pragma mark - 切换到拨打电话界面通知
- (void)callActionNoti:(NSNotification *)sender {
    NSDictionary *dic = sender.object;
    NSLog(@"%@",dic);
    self.phoneLabel.textColor = [UIColor colorWithRed:0/255.0 green:91/255.0 blue:176/255.0 alpha:1.0f];
    self.selectLabel.textColor = [UIColor colorWithRGB:0x282828];
    self.phonePic.image = [UIImage imageNamed:@"20170720-中華電信-電話符號-藍"];
    self.phoneVC.numberTextFiled.text = dic[@"phone"];
    Here_Set_soundPhone(self.phoneVC.numberTextFiled.text)
    self.selectPic.image = [self imageNameWithTag:self.selectLabel.tag];
    self.selectLabel = self.phoneLabel;
    self.selectPic = self.phonePic;
    self.phoneVC.strPhone = dic[@"phone"];
    self.phoneVC.strName = dic[@"name"];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}
//去通讯录界面通知
- (void)goAddressBooksNoti:(NSNotification *)sender {
    [self addressBookAction:nil];
}
- (void)creatScrollView {

    self.scrollView = [[UIScrollView alloc]initWithFrame:HCGRECT(0, 129, ScreenWidth, ScreenHeight -129)];
    NSInteger scrollHeight = self.scrollView.height;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth*4, scrollHeight );
    [self.view addSubview:self.scrollView];
    
    if (!_phoneVC) {
        [self addChildViewController:self.phoneVC];
        [self.scrollView addSubview:self.phoneVC.view];
    }

    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//电话
- (IBAction)phoneAction:(id)sender {
    if (self.selectLabel == self.phoneLabel) {
        return;
    }
    self.phoneLabel.textColor = [UIColor colorWithRed:0/255.0 green:91/255.0 blue:176/255.0 alpha:1.0f];
    self.selectLabel.textColor = [UIColor colorWithRGB:0x282828];
    self.phonePic.image = [UIImage imageNamed:@"20170720-中華電信-電話符號-藍"];
    self.phoneVC.numberTextFiled.text = @"";
    self.phoneVC.strPhone = @"";
    self.phoneVC.strName = @"";
    self.phoneVC.saveNumStr = @"";
    Here_Set_soundPhone(@"");
    self.selectPic.image = [self imageNameWithTag:self.selectLabel.tag];
    self.selectLabel = self.phoneLabel;
    self.selectPic = self.phonePic;
      self.scrollView.contentOffset = CGPointMake(0, 0);

}
//通讯录
- (IBAction)addressBookAction:(id)sender {
    if (self.selectLabel == self.addressBookLabel) {
        return;
    }
    self.addressBookLabel.textColor =[UIColor colorWithRed:0/255.0 green:91/255.0 blue:176/255.0 alpha:1.0f];

    self.selectLabel.textColor = [UIColor colorWithRGB:0x282828];
    self.addressBookPic.image = [UIImage imageNamed:@"20170720-中華電信-聯絡人-藍"];
    self.selectPic.image = [self imageNameWithTag:self.selectLabel.tag];
    self.selectLabel = self.addressBookLabel;
    self.selectPic = self.addressBookPic;
    self.scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
    
    if (!_addressBookVC) {
        [self addChildViewController:self.addressBookVC];
        [self.scrollView addSubview:self.addressBookVC.view];
        
    }
}
//通话记录
- (IBAction)callRecordsAction:(id)sender {
    if (self.selectLabel == self.callRecordsLabel) {
        return;
    }
    self.callRecordsLabel.textColor = [UIColor colorWithRed:0/255.0 green:91/255.0 blue:176/255.0 alpha:1.0f];

    self.selectLabel.textColor = [UIColor colorWithRGB:0x282828];
    self.callRecordsPic.image = [UIImage imageNamed:@"20170720-中華電信-通話紀錄-藍"];
    self.selectPic.image = [self imageNameWithTag:self.selectLabel.tag];
    self.selectLabel = self.callRecordsLabel;
    self.selectPic = self.callRecordsPic;
    self.scrollView.contentOffset = CGPointMake(ScreenWidth*2, 0);
  
    //发送通知，查询数据库
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callRecoredDataNoti" object:nil];
    if (!_callRecordsVC) {
        [self addChildViewController:self.callRecordsVC];
        [self.scrollView addSubview:self.callRecordsVC.view];
    }
}
//设定
- (IBAction)settingAction:(id)sender {
    if (self.selectLabel == self.setLabel) {
        return;
    }
    self.setLabel.textColor = [UIColor colorWithRed:0/255.0 green:91/255.0 blue:176/255.0 alpha:1.0f];

    self.selectLabel.textColor = [UIColor colorWithRGB:0x282828];
    self.setPic.image = [UIImage imageNamed:@"20170720-中華電信-設定-藍"];
    self.selectPic.image = [self imageNameWithTag:self.selectLabel.tag];
    self.selectLabel = self.setLabel;
    self.selectPic = self.setPic;
    self.scrollView.contentOffset = CGPointMake(ScreenWidth*3, 0);
    
    if (!_setVC) {
        [self addChildViewController:self.setVC];
        [self.scrollView addSubview:self.setVC.view];
        
    }
}
- (UIImage *)imageNameWithTag:(NSInteger)tag {
    NSString *imageStr = nil;
    switch (tag) {
        case 110:
            imageStr = @"20170720-中華電信-電話符號-灰";
            break;
        case 111:
            imageStr = @"9@3x20170720";
            break;
        case 112:
            imageStr = @"21@3x20170720";
            break;
        case 113:
            imageStr = @"11@3x20170720";
            break;
        default:
            break;
    }
    return [UIImage imageNamed:imageStr];
}
- (void)onRegisterStateChange:(UCSRegistrationState) state message:(const char*) message {
    
    switch (state) {
        case UCSRegistrationOk: {
            // 登陆成功
            self.stateLabel.text = @" 已登錄";
            self.statusView.backgroundColor = [UIColor colorWithRGB:0x8DC249];
            self.stateLabel.textColor = [UIColor whiteColor];
            break;
        }
        case UCSRegistrationNone:
        case UCSRegistrationCleared: {
            self.stateLabel.text = @" 未登錄";
            self.statusView.backgroundColor = [UIColor redColor];
            self.stateLabel.textColor = [UIColor redColor];

            break;
        }
        case UCSRegistrationFailed: {
            self.stateLabel.text = @" 登錄失败";
            self.statusView.backgroundColor = [UIColor redColor];
            self.stateLabel.textColor = [UIColor redColor];

            break;
        }
        case UCSRegistrationProgress: {
            self.stateLabel.textColor = [UIColor colorWithRed:0.9765 green:0.4039 blue:0.0 alpha:1.0];
            self.stateLabel.text = @" 登錄中...";
            self.statusView.backgroundColor = [UIColor redColor];
            break;
        }
        default:break;
    }
    
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
