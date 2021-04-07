//
//  SBaseNavigationVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SBaseNavigationVC.h"

@interface SBaseNavigationVC ()

@end

@implementation SBaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]]; //去掉黑线
}



@end
