//
//  HNavigationView.m
//  Here
//
//  Created by duc－sunyi on 2017/7/14.
//  Copyright © 2017年 奥里里亚. All rights reserved.
//

#import "HNavigationView.h"

#define kNavigationHight 64
#define kNavigationBackColor [UIColor colorWithRed:248/255.f green:231/255.f blue:28/255.f alpha:1.0]
#define kNavigationTitleColor [UIColor colorWithRed:38/255.f green:39/255.f blue:36/255.f alpha:1.0]
#define kNavigationFontName @"PingFangSC-Medium"
#define kNavigationFont 17.0

@implementation HNavigationView

- (HNavigationView *)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self = [[HNavigationView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kNavigationHight)];
        self.backgroundColor = kNavigationBackColor;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.center = self.center;
        titleLabel.frame = CGRectMake(self.frame.size.width * 0.2, 30, self.frame.size.width *0.6, 24);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kNavigationTitleColor;
        titleLabel.font = [UIFont fontWithName:kNavigationFontName size:kNavigationFont];
        [self addSubview:titleLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
