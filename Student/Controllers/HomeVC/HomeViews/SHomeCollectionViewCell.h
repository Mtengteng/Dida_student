//
//  SHomeCollectionViewCell.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import <UIKit/UIKit.h>
#import "SBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHomeCollectionViewCell : UICollectionViewCell

- (void)setupCellWithModel:(SBookInfo *)model;
@end

NS_ASSUME_NONNULL_END
