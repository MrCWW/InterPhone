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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSNumber *num = Here_Is_Login;
    if (num == nil) {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    }else{
        if ([num intValue] == 1) {
//     [self.window setRootViewController:[A mainPageViewController]];
        }else{
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        }
    }
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userloginSuc) name:@"UserLoginSuc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTokenIvalid) name:@"userTokenInvalidNotification" object:nil];
    

    [self.window makeKeyAndVisible];

    return YES;
}


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
    self.window.rootViewController = [[HBaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    
}

//用户登录成功
- (void)userloginSuc {
    [MBProgressHUD showText:@"登录成功" toView:nil];
    [self.window setRootViewController:[[HBaseNavigationController alloc] initWithRootViewController:[[AHomePageViewController alloc] init]]];
       [self.window makeKeyAndVisible];
    
}


@end
