//
//  SBoxInfoHeaderView.m
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import "SBoxInfoHeaderView.h"

@implementation SBoxInfoHeaderView

- (instancetype)init
{
    if (self = [super init]) {
        
        UIImageView *bgView = [[UIImageView alloc] init];
        [bgView setImage:[UIImage imageNamed:@"chapterVC_headerBg"]];
        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        self.titleLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(LAdaptation_y(80));
            make.left.equalTo(self).offset(LAdaptation_x(50));
        }];
        
        self.gradeLabel = [[UILabel alloc] init];
        self.gradeLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.gradeLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.gradeLabel];
        
        [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(LAdaptation_y(10));
            make.left.equalTo(self.titleLabel);
        }];
        
        self.gradeInfoLabel = [[UILabel alloc] init];
        self.gradeInfoLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.gradeInfoLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.gradeInfoLabel];
        
        [self.gradeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gradeLabel);
            make.left.equalTo(self.gradeLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(120));
        }];
        
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.tagLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.tagLabel];
        
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gradeLabel);
            make.left.equalTo(self.gradeInfoLabel.mas_right).offset(LAdaptation_x(15));
        }];
        
        self.tagInfoLabel = [[UILabel alloc] init];
        self.tagInfoLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.tagInfoLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.tagInfoLabel];
        
        [self.tagInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagLabel);
            make.left.equalTo(self.tagLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(120));
        }];
        
        self.sourceLabel = [[UILabel alloc] init];
        self.sourceLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.sourceLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.sourceLabel];
        
        [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gradeLabel.mas_bottom).offset(LAdaptation_y(10));
            make.left.equalTo(self.titleLabel);
        }];
        
        self.sourceInfoLabel = [[UILabel alloc] init];
        self.sourceInfoLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.sourceInfoLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.sourceInfoLabel];
        
        [self.sourceInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sourceLabel);
            make.left.equalTo(self.sourceLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(120));
        }];
        
        self.updateLabel = [[UILabel alloc] init];
        self.updateLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.updateLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.updateLabel];
        
        [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sourceLabel);
            make.left.equalTo(self.sourceInfoLabel.mas_right).offset(LAdaptation_x(15));
        }];
        
        self.updateInfoLabel = [[UILabel alloc] init];
        self.updateInfoLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.updateInfoLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.updateInfoLabel];
        
        [self.updateInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.updateLabel);
            make.left.equalTo(self.updateLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(120));
        }];
        
        self.studyCountLabel = [[UILabel alloc] init];
        self.studyCountLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.studyCountLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.studyCountLabel];
        
        [self.studyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.updateLabel.mas_bottom).offset(LAdaptation_y(10));
            make.left.equalTo(self.titleLabel);
        }];
        
        self.studyCountInfoLabel = [[UILabel alloc] init];
        self.studyCountInfoLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.studyCountInfoLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:self.studyCountInfoLabel];
        
        [self.studyCountInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.studyCountLabel);
            make.left.equalTo(self.studyCountLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(120));
        }];
    }
    return self;
}
@end
