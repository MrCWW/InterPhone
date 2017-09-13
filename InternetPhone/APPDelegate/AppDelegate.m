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
#import "LoginModel.h"
#import "CallOutgoingView.h"
#import "CallIncomingView.h"
@interface AppDelegate ()<UCSIPCCDelegate>
@property (nonatomic, strong) AHomePageViewController *dialerVC;
@property (nonatomic, strong) LoginViewController *vc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//        self.dialerVC = [[AHomePageViewController alloc] init];

    NSNumber *num = Here_Is_Login;
    if (num) {
        self.vc = [[LoginViewController alloc] init];
        self.window.rootViewController = [[HBaseNavigationController alloc] initWithRootViewController:self.vc];
    }else {
        
        LoginModel *model = kUnarchiverHomepageModel;
        if (model == nil) {
            self.vc = [[LoginViewController alloc] init];
            self.window.rootViewController = [[HBaseNavigationController alloc] initWithRootViewController:self.vc];        }else{
                //sip用户名 密码登录
                [[UCSIPCCManager instance] addProxyConfig:model.sip_username password:model.sip_new_password displayName:@"123"domain:model.sip_ip port:model.sip_port withTransport:@"UDP"];
                self.dialerVC = [[AHomePageViewController alloc] init];
                [self.window setRootViewController:[[HBaseNavigationController alloc] initWithRootViewController:self.dialerVC]];
            }

        }
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userloginSuc) name:@"UserLoginSuc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTokenIvalid) name:@"userTokenInvalidNotification" object:nil];
    
    
    [self.window makeKeyAndVisible];
    [self setNotification];
    //    [self regiestNotif];
//    self.dialerVC = [[AHomePageViewController alloc] init];
//    [self.window setRootViewController:[[HBaseNavigationController alloc] initWithRootViewController:self.dialerVC]];
    return YES;
}

- (void)setNotification{
    
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
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.bob.TcoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PhoneRecored" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PhoneRecored"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
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
//发起电话回调
- (void)onOutgoingCall:(UCSCall *)call withState:(UCSCallState)state withMessage:(NSDictionary *)message
{
    CallOutgoingView *vc = [CallOutgoingView new];
    [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)onIncomingCall:(UCSCall *)call withState:(UCSCallState)state withMessage:(NSDictionary *)message
{
    CallIncomingView *vc = [CallIncomingView new];
    vc.call = call;
    [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)onDialFailed:(UCSCallState)state withMessage:(NSDictionary *)message {
    [SVProgressHUD showErrorWithStatus:@"请输入正确的号码"];
}

- (void)onHangUp:(UCSCall *)call withState:(UCSCallState)state withMessage:(NSDictionary *)message
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UCS_Call_Released" object:nil userInfo:nil];
}
@end
