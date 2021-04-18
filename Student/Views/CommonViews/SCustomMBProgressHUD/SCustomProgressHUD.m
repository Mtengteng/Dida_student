//
//  SCustomProgressHUD.m
//  smartCourse
//
//  Created by 马腾 on 2021/3/4.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "SCustomProgressHUD.h"
#import <Lottie/Lottie.h>

@interface SCustomProgressHUD()


@end

@implementation SCustomProgressHUD

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated
{
    SCustomProgressHUD *hud = [[self alloc] init];
    hud.backgroundColor = [UIColor clearColor];
    [view addSubview:hud];
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    LOTAnimationView *imageView = [LOTAnimationView animationNamed:@"loading.json"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.loopAnimation = YES;
    [imageView setAnimationSpeed:1.0];
    [hud addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(hud);
    }];
    [imageView play];
    return hud;
}

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            [subview removeFromSuperview];
        }
    }
}
@end
