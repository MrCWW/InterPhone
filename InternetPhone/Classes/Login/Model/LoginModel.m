//
//  LoginModel.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/8/31.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
// 在保存对象时，告诉保存当前对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.acitivation_date  forKey:@"acitivation_date"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.expiry_date forKey:@"expiry_date"];
    [aCoder encodeObject:self.icc_id forKey:@"icc_id"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.sip_ip forKey:@"sip_ip"];
    [aCoder encodeObject:self.sip_password forKey:@"sip_password"];
    [aCoder encodeObject:self.sip_port forKey:@"sip_port"];
    [aCoder encodeObject:self.sip_username forKey:@"sip_username"];
    [aCoder encodeObject:self.username forKey:@"username"];
}
// 当解析一个文件的时候调用 （要告诉当前要解析文件当中的那些属性）
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.acitivation_date = [aDecoder decodeObjectForKey:@"acitivation_date"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.expiry_date = [aDecoder decodeObjectForKey:@"expiry_date"];
        self.icc_id = [aDecoder decodeObjectForKey:@"icc_id"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.sip_ip = [aDecoder decodeObjectForKey:@"sip_ip"];
        self.sip_password = [aDecoder decodeObjectForKey:@"sip_password"];
        self.sip_port = [aDecoder decodeObjectForKey:@"sip_port"];
        self.sip_username = [aDecoder decodeObjectForKey:@"sip_username"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        
    }
    return self;
}
@end
