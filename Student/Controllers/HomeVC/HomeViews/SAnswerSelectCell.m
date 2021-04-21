//
//  SAnswerSelectView.m
//  Student
//
//  Created by 马腾 on 2021/4/21.
//

#import "SAnswerSelectCell.h"

@implementation SAnswerSelectCell


- (void)setupCell
{
    NSArray *item = @[@"A",@"B",@"C",@"D"];
    for (NSInteger i = 0; i < item.count; i++) {
        
        UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(i*(self.bounds.size.width/item.count), 0, self.bounds.size.width/item.count, self.bounds.size.height)];
        [self addSubview:btnBgView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000+i;
        [button setFrame:CGRectMake(btnBgView.frame.size.width/2 - LAdaptation_x(40)/2, btnBgView.frame.size.height/2 - LAdaptation_y(40)/2, LAdaptation_x(40), LAdaptation_y(40))];
        [button setTitle:[item safeObjectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnBgView addSubview:button];
    }
}
- (void)clickAction:(UIButton *)button
{
    for (UIView *sub in self.subviews) {
        
        for (UIView *targetView in sub.subviews) {
            if ([targetView isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)targetView;
                if (button.tag == btn.tag) {
                    [btn setBackgroundColor:[UIColor blueColor]];
                }else{
                    [btn setBackgroundColor:[UIColor grayColor]];

                }
            }
        }
    }
}
@end
