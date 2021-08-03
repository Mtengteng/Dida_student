//
//  BWAlertCtrl.m
//  bwclassgoverment
//
//  Created by 马腾 on 2018/1/25.
//  Copyright © 2018年 beiwaionline. All rights reserved.
//

#import "BWAlertCtrl.h"

@interface BWAlertCtrl ()

@end

@implementation BWAlertCtrl


+ (id)alertControllerWithTitle:(NSString *)title buttonArray:(NSArray *)array message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle withVC:(UIViewController *)viewController clickBlock:(void (^)(NSString *buttonTitle))clickAction
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    alertCtrl.popoverPresentationController.sourceView = viewController.view;
    alertCtrl.popoverPresentationController.sourceRect = CGRectMake(0, viewController.view.bounds.size.height, viewController.view.bounds.size.width, LAdaptation_y(200));
    
    for (int i = 0;i < array.count;i++) {
        UIAlertAction *action ;
        
        if ([[array safeObjectAtIndex:i] isEqualToString:@"取消"]) {
            action = [UIAlertAction actionWithTitle:[array safeObjectAtIndex:i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
        }else{
            action = [UIAlertAction actionWithTitle:[array safeObjectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                clickAction(action.title);
            }];
        }
        
        
        [alertCtrl addAction:action];
    }
    
    [viewController presentViewController:alertCtrl animated:YES completion:nil];
    
    return alertCtrl;

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

