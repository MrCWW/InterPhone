//
//  LCMenuView.h
//  WeiShouBao
//
//  Created by  DUC-apple3 on 16/12/30.
//  Copyright © 2016年 DUC-apple3. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    MenuViewStyleDefault,     // 默认
    MenuViewStyleLine,        // 带下划线 (颜色会变化)
    MenuViewStyleFoold,       // 涌入效果 (填充)
    MenuViewStyleFooldHollow, // 涌入效果 (空心的)
    
} MenuViewStyle;


@class LCMenuView;

@protocol MenuViewDelegate <NSObject>

@optional

- (void)MenuViewDelegate:(LCMenuView*)menuciew WithIndex:(int)index;

@end


@interface LCMenuView : UIView



@property (nonatomic,weak)id<MenuViewDelegate> delegate;

@property (nonatomic,assign)MenuViewStyle style;


- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)rate;
- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style AndTitles:(NSArray *)titles;
- (void)selectWithIndex:(int)index AndOtherIndex:(int)tag;
- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style AndTitles:(NSArray *)titles frame:(CGRect)frame;
@property (nonatomic, strong) NSArray *titlesArr;

@end
