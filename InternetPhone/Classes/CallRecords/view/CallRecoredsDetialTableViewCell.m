//
//  CallRecoredsDetialTableViewCell.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/5.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "CallRecoredsDetialTableViewCell.h"
@interface CallRecoredsDetialTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *labelRecored;

@end
@implementation CallRecoredsDetialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(PhoneRecoredModel *)model {
    _model = model;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"HH:mm";
    //日期字符串
    NSString *string = [format stringFromDate:model.updatedate];
    self.labelRecored.text = [NSString stringWithFormat:@"%@ at %@",model.timedate,string];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
