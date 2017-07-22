//
//  HomePageViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HomePageViewController.h"
#import "AddressBookViewController.h"
#import "PhoneViewController.h"
#import "SettingViewController.h"
#import "CallRecordsViewController.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController

+ (instancetype)mainPageViewController{
    
    PhoneViewController *vc1 = [[PhoneViewController alloc] init];
    AddressBookViewController *vc2 = [[AddressBookViewController alloc] init];
    CallRecordsViewController *vc3 = [[CallRecordsViewController alloc] init];
    SettingViewController *vc4 = [[SettingViewController alloc] init];
    NSArray *classNameArr = @[vc1,vc2,vc3,vc4];
    NSArray *titles = @[@"電話", @"聯絡人", @"通話記錄",@"設定"];
    return [[self alloc] initWithViewControllerClasses:classNameArr andTheirTitles:titles];
}
- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles{
    if (self = [super initWithViewControllerClasses:classes andTheirTitles:titles]) {
        self.viewFrame = HCGRECT(0,40 ,ScreenWidth, ScreenHeight -40);
        self.menuHeight = 50;
        self.titleSizeSelected = 13;
        self.titleSizeNormal = 13;
        self.pageAnimatable = YES;
        self.menuViewStyle = WMMenuViewStyleDefault;
        self.titleColorSelected = [UIColor blueColor];
        self.menuBGColor = SETBASECOLOR(0xf2f2f2);
        self.titleColorNormal = [UIColor lightGrayColor];
        self.titleFontName = @"PingFangSC-Regular";
        self.menuItemWidth = ScreenWidth / 4;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
