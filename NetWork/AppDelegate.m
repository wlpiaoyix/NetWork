//
//  AppDelegate.m
//  NetWork
//
//  Created by wlpiaoyi on 15/12/23.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "AppDelegate.h"
#import "PYHttpRequest.h"
#import <Utile/NSData+Expand.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *ip = @"http://192.168.1.77";
    
//    PYHttpRequest *request = [PYHttpRequest new];
//    NSString * GlHttpBaseUrlCommon = @"http://123.57.42.26:38081/api/common/v1";
//    request.url = [NSString stringWithFormat:@"%@?type=%@&cp_id=1001",GlHttpBaseUrlCommon, @"weather"];
//    [request setHeadRequest:@{@"Content-Type":@"x-www-form-urlencoded;charset=UTF-8"}];
//    
//    [request requestWithType:PYRequestGet params:@{@"width":@(400),@"height":@(800),@"area":@"asdfa"} blockComplete:^(NSInteger status, id  _Nullable data, id<PYHttpRequest>  _Nonnull target) {
//        
//        if (status == 0 || [data isKindOfClass:[NSError class]]) {
//            return;
//        }
//        
//        NSDictionary * dict = [data toDictionary];
//        NSLog(@"");
//    
//    }];
//    [request setBlockSuccess:^(NSInteger status, id  _Nullable data, id<PYHttpRequest>  _Nonnull target) {
//        NSLog(@"");
//    }];
//    [request requestPost:[NSString stringWithFormat:@"%@:8080/test/ad.wlpiaoyi",ip] params:@{@"id":@(1),@"name":@"飘逸"}];
    // Override point for customization after application launch.
    return YES;
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
