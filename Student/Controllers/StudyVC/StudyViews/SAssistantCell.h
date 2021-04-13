//
//  SAssistantCell.h
//  Student
//
//  Created by 马腾 on 2021/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SBookInfo;

@interface SAssistantCell : UICollectionView

- (void)setupCellWithModel:(SBookInfo *)bookInfo;
@end

NS_ASSUME_NONNULL_END
