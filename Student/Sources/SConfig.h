//
//  TConfig.h
//  teacher
//
//  Created by 马腾 on 2020/12/21.
//  Copyright © 2020 beiwaionline. All rights reserved.
//

#ifndef TConfig_h
#define TConfig_h

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define BW_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度

#define BW_NavBarHeight 44.0

#define BW_TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度

#define BW_TopHeight (BW_StatusBarHeight + BW_NavBarHeight) //整个导航栏高度

#define DefineWeakSelf __weak __typeof(self) weakSelf = self

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1920, 1080), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPHoneXr
#define iPHoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//判断数组是否为空
#define IS_VALID_ARRAY(array) (array && ![array isEqual:[NSNull null]] && [array isKindOfClass:[NSArray class]] && [array count])
//判断字符串是否为空
#define IS_VALID_STRING(string) (string && ![string isEqual:[NSNull null]] && [string isKindOfClass:[NSString class]] && [string length])

#define BWColor(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

#define NAV_HEIGHT  64

//iphonex系列 尺寸比例系数
#define iPhoneXRatio (SCREEN_HEIGHT / 812)
//竖屏使用
#define PAdaptation_x(x) ((x)*SCREEN_WIDTH/375)
#define PAaptation_y(y) (((y)*(iPhoneX ? SCREEN_HEIGHT - 145*iPhoneXRatio : SCREEN_HEIGHT))/667)
//横屏使用
#define LAdaptation_x(x) ((x)*(iPhoneX ? SCREEN_WIDTH - 145*iPhoneXRatio : SCREEN_WIDTH)/768)
#define LAdaptation_y(y) ((y)*SCREEN_HEIGHT/1024)




#endif /* TConfig_h */
