//
//  SANodeInfoView.h
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^nextActionBlock)(NSString *name,BOOL isPublic,NSString *gradeKey);

@interface SANodeInfoView : UIView
@property (nonatomic, copy) nextActionBlock nextBlock;
@property (nonatomic, strong) UIViewController *superVC;

@end

NS_ASSUME_NONNULL_END
