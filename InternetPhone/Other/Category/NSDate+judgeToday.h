//
//  NSDate+judgeToday.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/4.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (judgeToday)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;
@end
