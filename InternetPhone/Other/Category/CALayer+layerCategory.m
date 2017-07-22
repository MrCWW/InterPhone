//
//  CALayer+layerCategory.m
//  WeiShouBao
//
//  Created by DUC-apple3 on 16/10/4.
//  Copyright © 2016年 DUC-apple3. All rights reserved.
//

#import "CALayer+layerCategory.h"

@implementation CALayer (layerCategory)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
