//
//  SAPublishView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SAPublishView.h"
#import "SANode.h"

@interface SAPublishView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *publicLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@property (nonatomic, strong) UILabel *pathLabel;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, assign) BOOL isPublish;
@property (nonatomic, strong) NSArray *gradeArray;
@property (nonatomic, strong) NSString *selectGrade;
@property (nonatomic, strong) UIButton *yesBtn;
@property (nonatomic, strong) UIButton *noBtn;
@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) NSArray *nodeArray;

@end

@implementation SAPublishView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(LAdaptation_y(60));
            make.left.equalTo(self).offset(LAdaptation_x(40));
        }];
        
        [self addSubview:self.titleField];
        [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(LAdaptation_x(30));
        }];
        
        [self addSubview:self.pathLabel];
        [self.pathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(LAdaptation_y(20));
            make.left.equalTo(self.titleLabel);
        }];
        
        [self.scrollView setFrame:CGRectMake(LAdaptation_x(24), LAdaptation_y(150),self.bounds.size.width - LAdaptation_x(48), LAdaptation_y(120))];
        [self addSubview:self.scrollView];
        
        
        [self addSubview:self.publicLabel];
        [self.publicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(LAdaptation_y(200));
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(LAdaptation_x(50));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        self.yesBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.yesBtn.tag = 1000;
        [self.yesBtn setTitle:@"是" forState:UIControlStateNormal];
        [self.yesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.yesBtn addTarget:self action:@selector(clickPublishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.yesBtn];
        
        [self.yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.publicLabel);
            make.left.equalTo(self.publicLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(40));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        self.noBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.noBtn.tag = 1001;
        [self.noBtn setTitle:@"否" forState:UIControlStateNormal];
        [self.noBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.noBtn addTarget:self action:@selector(clickPublishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.noBtn];
        
        [self.noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.publicLabel);
            make.left.equalTo(self.yesBtn.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(40));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        [self addSubview:self.gradeLabel];
        [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.publicLabel.mas_bottom).offset(LAdaptation_y(30));
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(LAdaptation_x(50));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        self.gradeArray = @[@"数学",@"物理"];
        for (NSInteger i = 0; i < self.gradeArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = 2000+i;
            [button setTitle:self.gradeArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickGradeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.gradeLabel);
                make.left.mas_offset(LAdaptation_x(80)+ LAdaptation_x(50) * i + LAdaptation_x(10));
                make.width.mas_equalTo(LAdaptation_x(40));
                make.height.mas_equalTo(LAdaptation_y(30));
            }];
        }
        
        
        
    }
    return self;
}
- (void)setDataWith:(NSArray *)array
{
    self.nodeArray = array;
    
    for (NSInteger i = 0; i < array.count;i++) {
        
        SANode *node = [array safeObjectAtIndex:i];

        if (node.type == NodeType_start) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width/array.count, self.scrollView.bounds.size.height)];
            [self.scrollView addSubview:view];
            
            UIImageView *pointView = [[UIImageView alloc] init];
            [pointView setImage:[UIImage imageNamed:@"node_root"]];
            [view addSubview:pointView];
            
            [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
                make.centerX.equalTo(view);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            UIImageView *lineView = [[UIImageView alloc] init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(pointView);
                make.left.equalTo(pointView.mas_right);
                make.right.equalTo(view.mas_right);
                make.height.equalTo(@1);
            }];
            
            
        }else if (node.type == NodeType_end) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*self.scrollView.bounds.size.width/array.count, 0, self.scrollView.bounds.size.width/array.count, self.scrollView.bounds.size.height)];
            [self.scrollView addSubview:view];
            
            UIImageView *pointView = [[UIImageView alloc] init];
            [pointView setImage:[UIImage imageNamed:@"node_root"]];
            [view addSubview:pointView];
            
            [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(view);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            UIImageView *lineView = [[UIImageView alloc] init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(pointView);
                make.left.equalTo(view);
                make.right.equalTo(pointView.mas_left);
                make.height.equalTo(@1);
            }];
            
        }else{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*self.scrollView.bounds.size.width/array.count, 0, self.scrollView.bounds.size.width/array.count, self.scrollView.bounds.size.height)];
            [self.scrollView addSubview:view];
            
            UIImageView *addView = [[UIImageView alloc] init];
            if (node.type == NodeType_kw) {
                addView.backgroundColor = [UIColor blueColor];
            }else{
                addView.backgroundColor = [UIColor yellowColor];
            }
            [view addSubview:addView];
            
            [addView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(view);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            UIImageView *lineView1 = [[UIImageView alloc] init];
            lineView1.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:lineView1];
            
            [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(addView);
                make.left.equalTo(view);
                make.right.equalTo(addView.mas_left);
                make.height.equalTo(@1);
            }];
            
            UIImageView *lineView = [[UIImageView alloc] init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(addView);
                make.left.equalTo(addView.mas_right);
                make.right.equalTo(view.mas_right);
                make.height.equalTo(@1);
            }];
        }
    }
}
- (void)clickPublishAction:(UIButton *)button
{
    if (button.tag == 1000) {
        self.isPublish = YES;
        [self.yesBtn setTitleColor:BWColor(98, 166, 248, 1.0) forState:UIControlStateNormal];
        [self.noBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }else{
        self.isPublish = NO;
        [self.noBtn setTitleColor:BWColor(98, 166, 248, 1.0) forState:UIControlStateNormal];
        [self.yesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }

}
- (void)clickGradeAction:(UIButton *)button
{
    
    self.selectGrade = [self.gradeArray safeObjectAtIndex:button.tag - 2000];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)view;
            if (button.tag == subBtn.tag) {
                [button setTitleColor:BWColor(98, 166, 248, 1.0) forState:UIControlStateNormal];
            }else{
                [subBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            }
        }
    }
}
- (void)publishAction:(id)sender
{
    if (self.publish) {
        self.publish(self.titleField.text, self.nodeArray, @"");
    }
}

#pragma mark - LazyLoad -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"学习集名称";
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}
- (UITextField *)titleField
{
    if (!_titleField) {
        _titleField = [[UITextField alloc] init];
        _titleField.placeholder = @"请输入名称";
        _titleField.textColor = [UIColor blackColor];
    }
    return _titleField;
}
- (UILabel *)publicLabel
{
    if (!_publicLabel) {
        _publicLabel = [[UILabel alloc] init];
        _publicLabel.text = @"公开";
        _publicLabel.font = [UIFont systemFontOfSize:16.0];
        _publicLabel.textColor = [UIColor lightGrayColor];
    }
    return _publicLabel;
}
- (UILabel *)gradeLabel
{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc] init];
        _gradeLabel.text = @"标注";
        _gradeLabel.font = [UIFont systemFontOfSize:16.0];
        _gradeLabel.textColor = [UIColor lightGrayColor];
    }
    return _gradeLabel;
}
- (UILabel *)pathLabel
{
    if (!_pathLabel) {
        _pathLabel = [[UILabel alloc] init];
        _pathLabel.text = @"路径节点";
        _pathLabel.font = [UIFont systemFontOfSize:16.0];
        _pathLabel.textColor = [UIColor lightGrayColor];
    }
    return _pathLabel;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}
- (UIButton *)publishBtn
{
    if (_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_publishBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_publishBtn setBackgroundColor:[UIColor blueColor]];
        [_publishBtn addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}
@end
