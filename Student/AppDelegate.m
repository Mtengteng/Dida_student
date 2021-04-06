//
//  AppDelegate.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "AppDelegate.h"
#import "SBaseNavigationVC.h"
#import "SLoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SBaseNavigationVC *nav = [[SBaseNavigationVC alloc] initWithRootViewController:[[SLoginVC alloc] init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
