//
//  SChapterCell.h
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SChapter;
@class SChapterSection;

typedef void(^didSelectModel)(SChapterSection *model);

@interface SChapterCell : UICollectionViewCell
@property (nonatomic,copy) didSelectModel didSelectModelBlock;

- (void)setupCellWithModel:(SChapter *)model;

- (void)loadSectionArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
