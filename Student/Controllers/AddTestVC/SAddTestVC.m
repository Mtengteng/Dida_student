//
//  SAddTestVC.m
//  Student
//
//  Created by 马腾 on 2021/5/18.
//

#import "SAddTestVC.h"
#import "SAddImageView.h"


@interface SAddTestVC ()
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) SAddImageView *addImageView;


@end

@implementation SAddTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加试卷";
    
    [self createUI];
}
- (void)createUI
{
    DefineWeakSelf;
    [self createLeftBackBtn:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.view addSubview:self.addLabel];
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LAdaptation_y(40));
        make.left.equalTo(self.view).offset(LAdaptation_x(20));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    [self.view addSubview:self.addImageView];
}


#pragma mark - LazyLoad -
- (UILabel *)addLabel
{
    if (!_addLabel) {
        _addLabel = [[UILabel alloc] init];
        _addLabel.text = @"试卷内容";
        _addLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _addLabel;
}
- (SAddImageView *)addImageView
{
    if (!_addImageView) {
        _addImageView = [[SAddImageView alloc] initWithFrame:CGRectMake(LAdaptation_x(90), LAdaptation_y(40), SCREEN_WIDTH, LAdaptation_y(100)) withSuperVC:self];
    }
    return _addImageView;
}
@end
