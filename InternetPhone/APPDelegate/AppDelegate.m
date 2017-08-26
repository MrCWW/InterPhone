//
//  AppDelegate.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/7/22.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HBaseNavigationController.h"
#import "AHomePageViewController.h"
@interface AppDelegate ()<UCSIPCCDelegate>
@property (nonatomic, strong) AHomePageViewController *dialerVC;
@property (nonatomic, strong) LoginViewController *vc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSNumber *num = Here_Is_Login;
    if (num == nil) {
        self.vc = [[LoginViewController alloc] init];
        self.window.rootViewController = [[HBaseNavigationController alloc] initWithRootViewController:self.vc];
    }else{
        if ([num intValue] == 1) {
            //     [self.window setRootViewController:[A mainPageViewController]];
            self.dialerVC = [[AHomePageViewController alloc] init];
            [self.window setRootViewController:[[HBaseNavigationController alloc] initWithRootViewController:self.dialerVC]];
                 [[UCSIPCCManager instance] addProxyConfig:Here_Get_UserName password:Here_Get_passWord displayName:@"123" domain:@"113.35.73.142" port:@"5060" withTransport:@"UDP"];

        }else{
            self.vc = [[LoginViewController alloc] init];
            self.window.rootViewController = [[HBaseNavigationController alloc] initWithRootViewController:self.vc];
        }
    }
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userloginSuc) name:@"UserLoginSuc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTokenIvalid) name:@"userTokenInvalidNotification" object:nil];
    
    
    [self.window makeKeyAndVisible];
    [self setNotification];
    //    [self regiestNotif];
    
    return YES;
}

- (void)setNotification{
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callStateUpdateEvent:) name:kUCSCallUpdate object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationUpdateEvent:) name:kUCSRegistrationUpdate object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userConfigSucceedEvent) name:@"addConfigSucceed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userConfigSucceedEvent) name:@"removeConfigSucceed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goConfigEvent) name:@"goConfig" object:nil];
    
    [[UCSIPCCManager instance] startUCSphone];
    
    [[UCSIPCCManager instance] setDelegate:self];
}
- (void)userConfigSucceedEvent{
   
}
- (void)goConfigEvent {
}
////注册通知
//-(void)regiestNotif{
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quit) name:@"quit" object:nil];
//}
//
//-(void)quit{
//
//    MBProgressHUD *hud = [MBProgressHUD lc_showMessag:@"正在退出" toView:nil];
//    [self login];
//    [hud hide:YES];
//
//}
//-(void)login{
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    [self.window setRootViewController:loginVC];
//
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark -- 用户token失效退出登陆
-(void)userTokenIvalid{
    
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.vc = [[LoginViewController alloc] init];
    self.window.rootViewController = [[HBaseNavigationController alloc] initWithRootViewController:self.vc];
    
    
}

//用户登录成功
- (void)userloginSuc {
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [MBProgressHUD showText:@"登錄成功" toView:nil];
    self.dialerVC = [[AHomePageViewController alloc] init];
    [self.window setRootViewController:[[HBaseNavigationController alloc] initWithRootViewController:self.dialerVC]];
    [self.window makeKeyAndVisible];
    
}
//登录回调方法
- (void)onRegisterStateChange:(UCSRegistrationState)state message:(const char *)message
{
    //    NSLog(@"{\nstate:%d, \nmessage:%s\n}", state, message);
    
    switch (state) {
        case UCSRegistrationOk: {
            // 登陆成功
            {
                //在登录页，登录成功的话，跳主页
                if ([Here_Is_Login integerValue] ==0) {
                    [self userloginSuc];
                }
                [self.dialerVC onRegisterStateChange:state message:message];
            }
            break;
        }
        case UCSRegistrationNone:
        case UCSRegistrationCleared: {
//            self.stateLabel.textColor = [UIColor blackColor];
//            self.stateLabel.text = @"· 未登录";
//            self.statusView.backgroundColor = [UIColor redColor];
            //未登录，登录失败跳登录页
            if ([Here_Is_Login integerValue] == 1) {
                
                [self userTokenIvalid];
            }
//          [MBProgressHUD showText:@"登录失败" toView:nil];
            break;
        }
        case UCSRegistrationFailed: {
            {
                //在主页，登录失败跳登录页
                if ([Here_Is_Login integerValue] == 1) {
                    
                    [self userTokenIvalid];
                }
                 [MBProgressHUD showText:@"登錄失败" toView:nil];
                
            }
            break;
        }
        case UCSRegistrationProgress: {
            {
                 [MBProgressHUD showText:@"登錄中" toView:nil];
            }
            break;
        }
        default:break;
    }

    
    [self.dialerVC onRegisterStateChange:state message:message];
}


@end
