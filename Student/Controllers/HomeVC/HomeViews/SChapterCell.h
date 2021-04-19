//
//  SChapterCell.h
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SChapter;

@interface SChapterCell : UICollectionViewCell

- (void)setupCellWithModel:(SChapter *)model;

- (void)loadSectionArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
