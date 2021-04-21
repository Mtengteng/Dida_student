//
//  SAnswerSelectView.h
//  Student
//
//  Created by 马腾 on 2021/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^submit)(id model);

@interface SAnswerSelectCell : UICollectionViewCell
@property (nonatomic, copy) submit submitBlock;


- (void)setupCell;
@end

NS_ASSUME_NONNULL_END
