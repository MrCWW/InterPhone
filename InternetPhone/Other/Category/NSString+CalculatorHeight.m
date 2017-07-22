//
//  NSString+CalculatorHeight.m
//  Here
//
//  Created by DUC-apple3 on 16/5/6.
//  Copyright © 2016年 DUC-apple3. All rights reserved.
//

#import "NSString+CalculatorHeight.h"

@implementation NSString (CalculatorHeight)
+ (CGFloat)heightForLabel:(NSString *)content Width:(CGFloat)width FontSize:(CGFloat)fontSize
{
    //参数1.设置计算内容的宽和高
    //参数2.设置计算高度模式
    //参数3.设置计算字体大小属性
    //参数4.系统备用参数,设置为nil
    //其中宽度一定与显示内容的label宽度一致否则计算不准确  高度尽量大一些
    CGSize size = CGSizeMake(width, 10000);
    //字体大小一定与显示内容的label字体大小一致  默认是17.0
    NSDictionary *dic =[NSDictionary dictionaryWithObject:BaseFont(fontSize) forKey:NSFontAttributeName];
    CGRect frame =  [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return frame.size.height;
}
+ (CGFloat)widthForLabel:(NSString *)content height:(CGFloat)height FontSize:(CGFloat)fontSize {
    CGSize size = CGSizeMake(10000, height);
    //字体大小一定与显示内容的label字体大小一致  默认是17.0
    NSDictionary *dic =[NSDictionary dictionaryWithObject:BaseFont(fontSize) forKey:NSFontAttributeName];
    CGRect frame =  [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return frame.size.width;
}
@end
