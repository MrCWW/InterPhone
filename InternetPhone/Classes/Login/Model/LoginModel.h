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

@property (nonatomic ,copy) NSString *sip_ip;

@property (nonatomic ,copy) NSString *sip_password;

@property (nonatomic ,copy) NSString *sip_port;

@property (nonatomic ,copy) NSString *sip_username;

@property (nonatomic ,copy) NSString *username;
@end
