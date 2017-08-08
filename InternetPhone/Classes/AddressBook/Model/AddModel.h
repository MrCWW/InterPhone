//
//  AddModel.h
//  InternetPhone
//
//  Created by wangkun on 2017/8/8.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

+ (instancetype)modelWithdic:(NSDictionary *)dic;

@end
