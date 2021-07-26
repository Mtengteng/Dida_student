//
//  SABaseInfoView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SABaseInfoView.h"

@interface SABaseInfoView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *publicLabel;
@property (nonatomic, strong) UILabel *gradeLabel;

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, assign) BOOL isPublish;

@end

@implementation SABaseInfoView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.nextBlock(@"", YES, @"");
}

@end
