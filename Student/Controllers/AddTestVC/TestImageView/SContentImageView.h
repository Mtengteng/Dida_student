//
//  SContentImageView.h
//  Student
//
//  Created by 马腾 on 2021/5/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^deleteItemBlock)(NSInteger tag);

@interface SContentImageView : UIImageView
@property (nonatomic, copy) deleteItemBlock deleteBlock;

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
