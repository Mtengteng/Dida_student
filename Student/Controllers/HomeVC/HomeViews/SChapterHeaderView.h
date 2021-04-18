//
//  SChapterHeaderView.h
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SBookInfo;

@interface SChapterHeaderView : UIView
@property (nonatomic, strong) SBookInfo *bookInfo;

- (instancetype)initWithModel:(SBookInfo *)bookInfo;
@end

NS_ASSUME_NONNULL_END
