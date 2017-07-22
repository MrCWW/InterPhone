//
//  HBaseViewController.h
//  Here
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 奥里里亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBaseViewController : UIViewController

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, copy) NSString *navigationTitle;

- (void)leftButtonAction;
- (void)rightButtonAction;

@end
