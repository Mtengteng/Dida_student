//
//  SAnswerSelectView.m
//  Student
//
//  Created by 马腾 on 2021/4/21.
//

#import "SAnswerSelectCell.h"
#import "SAnswer.h"

@implementation SAnswerSelectCell


- (void)setupCellWithArray:(NSArray *)answerList
{
    for (NSInteger i = 0; i < answerList.count; i++) {
        
        SAnswer *answer = [answerList safeObjectAtIndex:i];

        UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(i*(self.bounds.size.width/answerList.count), 0, self.bounds.size.width/answerList.count, self.bounds.size.height)];
        [self addSubview:btnBgView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = answer.answerId.integerValue;
        [button setFrame:CGRectMake(btnBgView.frame.size.width/2 - LAdaptation_x(40)/2, btnBgView.frame.size.height/2 - LAdaptation_y(40)/2, LAdaptation_x(40), LAdaptation_y(40))];
        [button setTitle:answer.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:answer.isSelected ?[UIColor blueColor]: [UIColor grayColor]];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnBgView addSubview:button];
    }
}
- (void)clickAction:(UIButton *)button
{
    if (self.selectAnswerBlock) {
        self.selectAnswerBlock(button.tag);
    }
}
@end
