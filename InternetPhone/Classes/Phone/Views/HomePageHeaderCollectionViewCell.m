//
//  HomePageHeaderCollectionViewCell.m
//  ZuLinLa
//
//  Created by DUC-apple3 on 2017/6/28.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HomePageHeaderCollectionViewCell.h"
@interface HomePageHeaderCollectionViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemHeight;

@end
@implementation HomePageHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (ScreenWidth<330) {
        self.itemWidth.constant = 40;
        self.itemHeight.constant = 40;
    }
}

@end
