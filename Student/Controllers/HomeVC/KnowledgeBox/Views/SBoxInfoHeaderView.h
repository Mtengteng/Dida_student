//
//  SBoxInfoHeaderView.h
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBoxInfoHeaderView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@property (nonatomic, strong) UILabel *gradeInfoLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *tagInfoLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *sourceInfoLabel;
@property (nonatomic, strong) UILabel *updateLabel;
@property (nonatomic, strong) UILabel *updateInfoLabel;
@property (nonatomic, strong) UILabel *studyCountLabel;
@property (nonatomic, strong) UILabel *studyCountInfoLabel;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
