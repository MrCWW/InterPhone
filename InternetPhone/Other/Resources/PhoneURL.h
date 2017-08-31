//
//  PhoneURL.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/8/30.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#ifndef PhoneURL_h
#define PhoneURL_h
#define Phone_URL_Domian @"http://175.41.52.241/api/"
#define app_token @"8389adec-3e18-11e7-a919-92ebcb67fe33"

/**登录注册*/
//登录
#define Phone_URL_login_php [NSString stringWithFormat:@"%@login.php",Phone_URL_Domian]
//获取用户信息
#define Phone_URL_account_account_info_php [NSString stringWithFormat:@"%@account/account_info.php?",Phone_URL_Domian]
#endif /* PhoneURL_h */
