//
//  LoginModel.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/8/31.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HBaseModel.h"

@interface LoginModel : HBaseModel

@property (nonatomic ,copy) NSString *acitivation_date;

@property (nonatomic ,copy) NSString *code;

@property (nonatomic ,copy) NSString *expiry_date;

@property (nonatomic ,copy) NSString *icc_id;

@property (nonatomic ,copy) NSString *message;

@property (nonatomic ,copy) NSString *password;

@property (nonatomic ,copy) NSString *sip_ip;//服务器

@property (nonatomic ,copy) NSString *sip_password;

@property (nonatomic ,copy) NSString *sip_port;//端口

@property (nonatomic ,copy) NSString *sip_username;

@property (nonatomic ,copy) NSString *username;

@property (nonatomic ,copy) NSString *sip_new_password;

@end
