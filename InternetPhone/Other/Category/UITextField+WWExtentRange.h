//
//  UITextField+WWExtentRange.h
//  ZuLinLa
//
//  Created by DUC-apple3 on 2017/7/23.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (WWExtentRange)
- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end
