//
//  HHomePageViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HHomePageViewController.h"
#import "ZTViewController.h"
@interface HHomePageViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) ZTViewController *ztView;

@end

@implementation HHomePageViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"電話",@"聯絡人",@"通話記錄",@"設定", nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view from its nib.
}

-(void)createView{
    
    if (self.dataArray.count == 0)  return;
    
    NSMutableArray *classArr = [NSMutableArray array];
    [classArr addObject:NSClassFromString(@"PhoneViewController")];
    [classArr addObject:NSClassFromString(@"AddressBookViewController")];
    [classArr addObject:NSClassFromString(@"CallRecordsViewController")];
    [classArr addObject:NSClassFromString(@"SettingViewController")];
    
    ZTViewController *vca = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleDefault];
    self.ztView = vca;
    [vca loadVC:classArr AndTitle:self.dataArray];
  
    
   
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
