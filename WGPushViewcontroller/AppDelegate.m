//
//  AppDelegate.m
//  WGPushViewcontroller
//
//  Created by wanggang on 2018/4/23.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/message.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    /*
     下面四句代码等价于
    ViewController *con = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
    */
    
    id classAlloc = objc_msgSend(objc_getClass("ViewController"), sel_registerName("alloc"));
    id classInit = objc_msgSend(classAlloc, sel_registerName("init"));
    
    id navAlloc = objc_msgSend(objc_getClass("UINavigationController"), sel_registerName("alloc"));
    /*
     这一句在真机上会崩溃，必须先定义原型才可以使用，这样才不会发生崩溃
     id navInit = objc_msgSend(navAlloc, sel_registerName("initWithRootViewController:"), classInit);
     */
    id (*action)(id, SEL, UIViewController*) = (id (*)(id, SEL, UIViewController*)) objc_msgSend;
    id navInit = action(navAlloc, sel_registerName("initWithRootViewController:"), classInit);
    
    self.window.rootViewController = navInit;
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


@end
