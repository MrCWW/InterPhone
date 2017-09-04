//
//  PhoneRecoredModelCount.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/4.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HBaseModel.h"
#import "PhoneRecoredModel.h"
@interface PhoneRecoredModelCount : PhoneRecoredModel
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *phone;
//@property (nonatomic, strong) NSDate *updatedate;
//@property (nonatomic, copy) NSString *timedate;
@property (nonatomic, copy) NSString *countPhone;
@property (nonatomic, assign) BOOL isShowDetial;//是否显示详情按钮(默认显示详情YES，隐藏删除按钮)
@property (nonatomic, assign) BOOL isSelectDelete;//删除是否被选中，默认NO
@end
