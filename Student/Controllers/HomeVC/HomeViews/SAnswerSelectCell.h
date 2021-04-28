//
//  SAnswerSelectView.h
//  Student
//
//  Created by 马腾 on 2021/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SAnswer;

typedef void(^selectAnswer)(NSInteger answerId);

@interface SAnswerSelectCell : UICollectionViewCell
@property (nonatomic, copy) selectAnswer selectAnswerBlock;

- (void)setupCellWithArray:(NSArray *)answerList;
@end

NS_ASSUME_NONNULL_END
