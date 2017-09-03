//
//  CoreDataAPI.h
//  CoreDataDemo
//
//  Created by DUC-apple3 on 2017/9/1.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PhoneRecored+CoreDataClass.h"
#import "AppDelegate.h"
#import "PhoneRecoredModel.h"
@interface CoreDataAPI : NSObject
/**插入数据*/
+(BOOL)insertPhoneRecored:(PhoneRecoredModel *)phoneModel;

/**查询所有通话记录*/
+(NSArray *)searchPhoneRecored;

/**根据手机号查询通话记录*/
+ (NSArray *)searchWithPerson:(PhoneRecoredModel *)phoneModel;

/**根据日期和电话号删除数据*/
+ (void)deleteWithPerson:(PhoneRecoredModel *)phoneModel;

/**删除所有数据*/
+(void)deleteAllDatas;



@end
