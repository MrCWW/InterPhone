//
//  PhoneViewController.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "PhoneViewController.h"
#import "PopUpView.h"
#import "PopModel.h"
#import "HomePageHeaderCateforyView.h"
#define CollectionHeight ScreenHeight - 234
@interface PhoneViewController ()<CategorySelectDelegete,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
//@property (weak, nonatomic) IBOutlet UITextField *numberTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *qianzhuiLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
//城市
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) PopUpView *showView;
//数字view
@property (nonatomic, strong) HomePageHeaderCateforyView *headerCategoryView;
@property (nonatomic, strong) NSMutableArray *dataNumberArr;
//@property (nonatomic, strong) NSMutableArray *dataSaveNumberArr;//存储数字
@property (nonatomic, strong) NSMutableString *saveNumStr;//存储数字
@end

@implementation PhoneViewController
{
    BOOL _isHaveGB; //是否含有光标
}
//- (NSMutableArray *)dataSaveNumberArr {
//    if (!_dataSaveNumberArr) {
//        _dataSaveNumberArr = [NSMutableArray array];
//    }
//    return _dataSaveNumberArr;
//}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    if (self.strPhone.length) {
//        self.numberTextFiled.text = _strPhone;
//    }
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:YES];
//    self.strPhone = @"";
//}
- (NSMutableString *)saveNumStr{
    if (!_saveNumStr) {
        _saveNumStr = [NSMutableString string];
    }
    return _saveNumStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    //button长按事件
    [self.deleteBtn setImage:[UIImage imageNamed:@"20170720-中華電信-號碼刪除鍵-灰"] forState:UIControlStateHighlighted];
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
   longPress.minimumPressDuration = 0.8; //定义按的时间
   [_deleteBtn addGestureRecognizer:longPress];
    [self creatNumberView];
    
}
//创建拨号界面
- (void)creatNumberView {
    NSArray *imageArr = @[@"20170720-中華電信-數字1",@"20170720-中華電信-數字2",@"20170720-中華電信-數字3",@"20170720-中華電信-數字4",@"20170720-中華電信-數字5",@"20170720-中華電信-數字6",@"20170720-中華電信-數字7",@"20170720-中華電信-數字8",@"20170720-中華電信-數字9",@"20170720-中華電信-米字鍵",@"20170720-中華電信-數字0",@"20170720-中華電信-井字鍵"];
    self.dataNumberArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*",@"0",@"#", nil];
    HomePageHeaderCateforyView *headerV = [[HomePageHeaderCateforyView alloc] initWithFrame:HCGRECT(0, 50, ScreenWidth, CollectionHeight) imageArr:imageArr titleArr:nil];
    NSLog(@"%.2f",CollectionHeight);
    self.headerCategoryView = headerV;
    headerV.delegate = self;
    [self.view addSubview:headerV];
    
    self.numberTextFiled.inputView=[[UIView alloc]initWithFrame:CGRectZero];

}

//清空输入框
- (IBAction)deleteBtnAction:(id)sender {
    NSRange range = [self.numberTextFiled selectedRange];
    
    NSLog(@"%lu and %lu", (unsigned long)range.location, (unsigned long)range.length);
     NSInteger indexRange = range.location;//光标下标
     NSInteger lengthRange = range.length;//光标长度
    if (self.saveNumStr.length) {
        if (_saveNumStr.length -1 ==0&&indexRange!=0) {
            //如果光标存在，且长度为1，光标位置在数字后边
            _isHaveGB = NO;//光标消失
            [self.numberTextFiled resignFirstResponder];
        }
        if (indexRange==0&&lengthRange==0&&_isHaveGB==NO) {

            //光标不存在，从最后一个开始删除
            NSString *numStr =  [_saveNumStr substringToIndex:([_saveNumStr length]-1)];
              self.numberTextFiled.text = numStr;
               self.saveNumStr = [NSMutableString stringWithFormat:@"%@",numStr];
        }else if (indexRange ==0 &&lengthRange == _saveNumStr.length) {
        //光标全选
            [self btnLong:nil];
        }else if (indexRange >0 &&lengthRange == 0) {
            //光标在中间
            NSString *numStr  = [self.saveNumStr stringByReplacingCharactersInRange:NSMakeRange(indexRange-1, 1) withString:@""];
            self.numberTextFiled.text = numStr;
            
            [self.numberTextFiled setSelectedRange:NSMakeRange(indexRange-1, 0)];
            self.saveNumStr = [NSMutableString stringWithFormat:@"%@",numStr];
        }
    
   //
    }
 
}
- (void)btnLong:(UIButton *)sender {
    if (self.saveNumStr.length) {
       self.saveNumStr = [NSMutableString stringWithFormat:@""];
    self.numberTextFiled.text = self.saveNumStr;
        
    [self.numberTextFiled resignFirstResponder];
        _isHaveGB = NO;
    }
}
//选择城市
- (IBAction)cityBtnAction:(id)sender {
    self.dataArr = [NSMutableArray array];
    NSArray *arr = @[@{@"name":@"北京"},@{@"name":@"天津"},@{@"name":@"上海"},@{@"name":@"重庆"},@{@"name":@"河北"},@{@"name":@"北京"}];
    for (NSDictionary *dic in arr) {
        [_dataArr addObject:[PopModel modelWithDic:dic]];
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [_cityBtn convertRect: _cityBtn.bounds toView:window];
    CGFloat height;
    if (_dataArr.count > 5) {
        height = 40 * DISTENCEH * 5;
    }else{
        height = 40 * DISTENCEH * _dataArr.count;
    }
    PopUpView *showView = [PopUpView initWithFrame:CGRectMake(_cityBtn.left, _cityBtn.bottom, _cityBtn.width, height) popUpFrame:rect textArr:_dataArr block:^(NSString *str) {
        [_cityBtn setTitle:str forState:0];
    }];
    self.showView = showView;
    [self.view addSubview:showView];
}
#pragma mark - 拨号按钮触发方法
- (IBAction)callBtnAction:(id)sender {
    if (_numberTextFiled.text.length) {
        //存储日期
         NSDate *today = [NSDate date];
//        NSDate * date = p.updatedate;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy年MM月dd号";
        //日期字符串
        NSString *string = [format stringFromDate:today];
        PhoneRecoredModel *model = [[PhoneRecoredModel alloc] init];
        model.name = _strName;
        model.phone = _numberTextFiled.text;
        model.timedate = string;
        model.updatedate = today;
        //插入到数据库
        [CoreDataAPI insertPhoneRecored:model];
    }else {
        [MBProgressHUD showText:@"請輸入號碼" toView:self.view];
    }
    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSRange range = textField.selectedRange;
    
    NSLog(@" == %lu and %lu", (unsigned long)range.location, (unsigned long)range.length);
    _isHaveGB = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CategorySelectDelegete
- (void)selectdeCategoryAction:(NSInteger)itemIndex {
    NSLog(@"%ld",itemIndex);
    NSRange range = [self.numberTextFiled selectedRange];
    
    NSLog(@"%lu and %lu", (unsigned long)range.location, (unsigned long)range.length);
    NSInteger indexRange = range.location;//光标下标
    NSInteger lengthRange = range.length;//光标长度

        
        if (indexRange==0&&lengthRange==0&&_isHaveGB==NO) {
            
            //光标不存在，从最后一个开始添加
            self.saveNumStr = [NSMutableString stringWithFormat:@"%@%@",self.saveNumStr,self.dataNumberArr[itemIndex]];
            self.numberTextFiled.text = self.saveNumStr;
        }else if (indexRange ==0 &&lengthRange == _saveNumStr.length) {
            //光标全选，删除之后添加
            [self btnLong:nil];
            self.saveNumStr = [NSMutableString stringWithFormat:@"%@%@",self.saveNumStr,self.dataNumberArr[itemIndex]];
            self.numberTextFiled.text = self.saveNumStr;
        }else if (indexRange >=0 &&lengthRange == 0&&_isHaveGB == YES) {
            //光标在中间，添加
         [self.saveNumStr insertString:self.dataNumberArr[itemIndex] atIndex:indexRange];
            
            self.numberTextFiled.text = self.saveNumStr;
//
           [self.numberTextFiled setSelectedRange:NSMakeRange(indexRange+1, 0)];
//            self.saveNumStr = numStr;
            
            
            
        }
        //
    


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
