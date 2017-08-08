//
//  AddModel.m
//  InternetPhone
//
//  Created by wangkun on 2017/8/8.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AddModel.h"

@implementation AddModel
+ (instancetype)modelWithdic:(NSDictionary *)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    AddModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
