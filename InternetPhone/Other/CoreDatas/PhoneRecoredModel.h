//
//  PhoneRecoredModel.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/3.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HBaseModel.h"

@interface PhoneRecoredModel : HBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, strong) NSDate *updatedate;
@property (nonatomic, copy) NSString *timedate;

@end
