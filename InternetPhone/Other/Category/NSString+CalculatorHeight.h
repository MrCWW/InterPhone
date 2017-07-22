//
//  NSString+CalculatorHeight.h
//  Here
//
//  Created by DUC-apple3 on 16/5/6.
//  Copyright © 2016年 DUC-apple3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CalculatorHeight)
//计算字符串高度
+ (CGFloat)heightForLabel:(NSString *)content Width:(CGFloat)width FontSize:(CGFloat)fontSize;
//计算字符串宽度
+ (CGFloat)widthForLabel:(NSString *)content height:(CGFloat)height FontSize:(CGFloat)fontSize;
@end
