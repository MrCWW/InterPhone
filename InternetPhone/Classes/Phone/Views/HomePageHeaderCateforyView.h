//
//  HomePageHeaderCateforyView.h
//  ZuLinLa
//
//  Created by DUC-apple3 on 2017/6/28.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class HomePageCategoryModel;
@protocol CategorySelectDelegete<NSObject>
@optional
-(void)selectdeCategoryAction:(NSInteger)itemIndex;
@end
@interface HomePageHeaderCateforyView : UIView
- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr titleArr:(NSArray *)titleArr;
@property(weak,nonatomic)id<CategorySelectDelegete>delegate;
@property (nonatomic, copy) NSArray *categoryArray;
@end
