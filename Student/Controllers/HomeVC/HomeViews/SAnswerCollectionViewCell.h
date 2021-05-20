//
//  SHomeCollectionViewCell.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import <UIKit/UIKit.h>
#import "SBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAnswerCollectionViewCell : UICollectionViewCell

- (void)setupCellWithModel:(SBook *)model;
@end

NS_ASSUME_NONNULL_END
