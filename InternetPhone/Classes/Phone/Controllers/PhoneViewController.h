//
//  PhoneViewController.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HBaseViewController.h"

@interface PhoneViewController : HBaseViewController
@property(nonatomic,strong)NSString *strPhone;//手机号
@property(nonatomic,strong)NSString *strName;//姓名
@property (weak, nonatomic) IBOutlet UITextField *numberTextFiled;
@property (nonatomic, strong) NSMutableString *saveNumStr;//存储数字
@end
