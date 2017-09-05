//
//  CallRecordsViewController.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HBaseViewController.h"

@interface CallRecordsViewController : HBaseViewController
{
    BOOL _isEditAction;//是否编辑操作，默认NO
}
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

@end
