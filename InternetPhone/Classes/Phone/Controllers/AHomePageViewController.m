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

//添加子controller
@property (nonatomic, strong) PhoneViewController *phoneVC;
@property (nonatomic, strong) AddressBookViewController *addressBookVC;
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
- (AddressBookViewController *)addressBookVC {
    if (!_addressBookVC) {
        _addressBookVC = [[AddressBookViewController alloc] init];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectPic = self.phonePic;
    self.selectLabel = self.phoneLabel;
    // Do any additional setup after loading the view from its nib.
    [self creatScrollView];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
