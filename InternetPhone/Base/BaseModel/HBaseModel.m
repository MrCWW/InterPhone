//
//  HBaseModel.m
//  Here
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 奥里里亚. All rights reserved.
//

#import "HBaseModel.h"

@implementation HBaseModel
+(instancetype)modelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
