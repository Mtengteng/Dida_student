//
//  SelectWhiteBGBar.h
//  Student
//
//  Created by 马腾 on 2021/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectWhiteBar)(NSString *barTitle);

@interface SelectWhiteBGBar : UIView
@property (nonatomic, copy) selectWhiteBar selectWhiteBarBlock;

- (instancetype)initWithItemArray:(NSArray *)itemArray;

@end

NS_ASSUME_NONNULL_END
