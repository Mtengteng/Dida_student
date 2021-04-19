//
//  SectionTableViewCell.h
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SChapterSection;

@interface SectionTableViewCell : UITableViewCell

- (void)setupCellWithModel:(SChapterSection *)model;

@end

NS_ASSUME_NONNULL_END
