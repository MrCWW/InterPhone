//
//  NSDate+judgeToday.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/4.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "NSDate+judgeToday.h"

@implementation NSDate (judgeToday)
- (BOOL)isToday
{
    //now: 2015-09-05 11:23:00
    //self 调用这个方法的对象本身
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}
- (BOOL)isYesterday
{
    //2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    //2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    //获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return selfCmps.year == nowCmps.year;
}

/**
 *  返回这种格式的日期 yyyy-MM-dd
 */
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return  [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
