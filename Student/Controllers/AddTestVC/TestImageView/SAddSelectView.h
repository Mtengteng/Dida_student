//
//  SAddSelectView.h
//  Student
//
//  Created by 马腾 on 2021/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAddSelectView : UIView
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
