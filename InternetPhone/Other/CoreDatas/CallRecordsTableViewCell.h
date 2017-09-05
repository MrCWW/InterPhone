//
//  CallRecordsTableViewCell.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/4.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhoneRecoredModelCount;
typedef void (^detialBtnBlock)(NSIndexPath *indexPath);
typedef void (^deteleBtnBlock)(NSIndexPath *indexPath);
@interface CallRecordsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *detialBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) detialBtnBlock detialBlock;//详情block
@property (nonatomic, copy) deteleBtnBlock deteleBlock;//删除block
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) PhoneRecoredModelCount *model;
@end