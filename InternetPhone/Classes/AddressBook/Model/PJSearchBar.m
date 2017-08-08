//
//  PJSearchBar.m
//  PJSearchBar
//
//  Created by 孙培杰 on 16/11/3.
//  Copyright © 2016年 sunpeijie. All rights reserved.
//

#import "PJSearchBar.h"

@interface PJSearchBar ()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *searchLabel;

@end

@implementation PJSearchBar

- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    if (self = [super initWithFrame:frame]) {
        [self initSearchBarWithFrame:(CGRect)frame withPlaceholder:placeholder];
    }
    return self;
}

- (void)initSearchBarWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder{
    self.tintColor = [UIColor whiteColor];
    self.searchBarStyle = UISearchBarStyleMinimal;
    NSMutableString *blankString = [[NSMutableString alloc] init];
    
    int numberOfBlankCharacter = frame.size.width * 0.2;
    
    for (int i = 0; i < numberOfBlankCharacter; i++) {
        //根据searchBar的长度计算应该插入多少个空格占位
        [blankString appendString:@""];
    }
    self.placeholder = blankString;
    self.backgroundColor = [UIColor whiteColor];
    self.searchTextField = [self valueForKey:@"searchField"];
    self.searchTextField.delegate = self;
    self.searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, 255, 30)];
    self.searchLabel.textColor = [UIColor blackColor];
    self.searchLabel.font = [UIFont systemFontOfSize:14];
    self.searchLabel.text = placeholder;
    [self.searchTextField addSubview:self.searchLabel];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.searchLabel setHidden:YES];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        
        [self.searchLabel setHidden:NO];
    }
}

@end
