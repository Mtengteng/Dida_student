//
//  SHomeSelectView.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

//学科选择view
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SCDictInfoModel;
typedef void(^selectSubIndexBlock)(SCDictInfoModel *model,NSInteger index);

@interface SelectSubView : UIView
@property (nonatomic, copy) selectSubIndexBlock selectSubBlock;

- (instancetype)initWithItemArray:(NSArray *)itemList;

- (void)setFirstSub:(void(^)(SCDictInfoModel *model,NSInteger index))selectFirst;

@end

NS_ASSUME_NONNULL_END
