//
//  CallRecordsTableViewCell.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/4.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "CallRecordsTableViewCell.h"
#import "PhoneRecoredModelCount.h"
@interface CallRecordsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation CallRecordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(PhoneRecoredModelCount *)model {
    
    if (model.name.length) {
        //名字存在显示名字
        if ([model.countPhone integerValue] == 1) {
            //拨打次数，1次不显示个数
            _nameLabel.text = model.name;
        }else {
            _nameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.name,model.countPhone];
        }
    }else {
    //名字不存在，显示电话号
        if ([model.countPhone integerValue] == 1) {
            _nameLabel.text = model.phone;
        }else {
            _nameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.phone,model.countPhone];
        }
    }
}
- (IBAction)detialBtnAction:(id)sender {
    if (self.detialBlock) {
        self.detialBlock(self.indexPath);
    }
}
- (IBAction)deleteBtnAction:(id)sender {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
