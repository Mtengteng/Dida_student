//
//  SAddImageView.h
//  Student
//
//  Created by 马腾 on 2021/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^addImgBlock)(void);

@interface SAddImageView : UIView
@property (nonatomic, copy) addImgBlock addBlock;
@property (nonatomic, strong) NSMutableArray *imgList;

- (instancetype)initWithFrame:(CGRect)frame withSuperVC:(UIViewController *)superVC;

@end

NS_ASSUME_NONNULL_END
