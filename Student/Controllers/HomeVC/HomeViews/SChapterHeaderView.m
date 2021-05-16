//
//  SChapterHeaderView.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "SChapterHeaderView.h"
#import "SBook.h"
#import "SBookImageView.h"

@interface SChapterHeaderView()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) SBookImageView *bookImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subLabel;



@end

@implementation SChapterHeaderView

- (instancetype)initWithModel:(SBookInfo *)bookInfo
{
    if (self = [super init]) {
        
        self.bookInfo = bookInfo;
        
        [self setupContent];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.bookImageView];
    [self.bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LAdaptation_y(93));
        make.left.equalTo(self).offset(LAdaptation_x(69));
        make.width.mas_equalTo(LAdaptation_x(128));
        make.height.mas_equalTo(LAdaptation_y(176));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookImageView);
        make.left.equalTo(self.bookImageView.mas_right).offset(LAdaptation_x(10));
        make.height.mas_equalTo(LAdaptation_y(20));
    }];
    
    [self addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(LAdaptation_y(8));
        make.left.equalTo(self.nameLabel);
        make.height.mas_equalTo(LAdaptation_y(20));
    }];
}
- (void)setupContent
{
//    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:self.bookInfo.bookPic]];
//    self.nameLabel.text = self.bookInfo.bookName;
//    self.subLabel.text = self.bookInfo.bookTags;
}

#pragma mark - LazyLoad -
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_bgImageView setImage:[UIImage imageNamed:@"chapterVC_headerBg"]];
    }
    return _bgImageView;
}
- (SBookImageView *)bookImageView
{
    if (!_bookImageView) {
        _bookImageView = [[SBookImageView alloc] init];
    }
    return _bookImageView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}
- (UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.font = [UIFont systemFontOfSize:14.0];
        _subLabel.textColor = [UIColor whiteColor];
    }
    return _subLabel;
}
@end
