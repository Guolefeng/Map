//
//  AppDelegate.m
//  百度地图_Demo
//
//  Created by 郭乐峰 on 2017/4/10.
//  Copyright © 2017年 niuniu. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
//
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
//
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
//
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
//
//#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
// --------------- 百度地图 ----------------
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权事件, 请设定 generalDelegate
    BOOL ret = [mapManager start:@"To0YYQXcuYsetKul4rEN1VPD14inznny" generalDelegate:nil];
    
    if (ret) {
        NSLog(@"manager start success!");
    } else {
        NSLog(@"manager start failed!");
    }
    
    
// --------------- 百度地图 ----------------
    
    
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:[[GuideViewController alloc] init]];
    self.window.rootViewController = NC;
    
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


@end
