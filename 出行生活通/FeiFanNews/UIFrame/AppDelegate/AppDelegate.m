//
//  AppDelegate.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NewsController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)dealloc
{
    self.window = nil;
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    MainController *mainVC = [[MainController alloc]init];
    self.window.rootViewController = mainVC;
    //设定通知接受夜间模式
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(night) name:@"night" object:nil];
    //设定通知接受白天模式
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(day) name:@"day" object:nil];
    [mainVC release];
   
    
    //网络监测
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    //厚度
    [SVProgressHUD setRingThickness:6];
    //1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //当网络状态改变后，会调用这个方法
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请检查您当前的网路" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert1 show];
                [alert1 release];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"好痛苦！断网了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert2 show];
                [alert2 release];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [SVProgressHUD showSuccessWithStatus:@"3G/4G网络"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [SVProgressHUD showSuccessWithStatus:@"WIFI"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            }
                break;
            default:
                break;
        }
        
    }];
    //3 开始监测
    [manager startMonitoring];
    
//    启动界面
    UIImageView *startImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    startImage.image = [UIImage imageNamed:@"open"];
    [self.window addSubview:startImage];
    //添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [startImage addGestureRecognizer:tap];
    startImage.userInteractionEnabled = YES;
    [tap release];
    [startImage release];
     [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(tapAction) userInfo:nil repeats:NO];
    return YES;
}
- (void)tapAction
{
    CATransition *transition = [CATransition animation];
//    transition.type = @"suckEffect";
    transition.duration = 1.5;
    [self.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [self.window.layer addAnimation:transition forKey:@"12"];
}


//夜间模式
- (void)night{
    self.window.alpha = 0.5;

}
//白天模式
- (void)day{
    self.window.alpha = 1.0;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
