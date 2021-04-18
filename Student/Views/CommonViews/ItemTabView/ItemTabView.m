//
//  ItemTabView.m
//  Student
//
//  Created by 马腾 on 2021/4/14.
//

#import "ItemTabView.h"
#import "ItemModel.h"

@interface ItemTabView()
@property (nonatomic, strong) NSArray *itemList;

@end

@implementation ItemTabView

- (instancetype)initWithItemArray:(NSArray *)itemList
{
    if (self = [super init]) {
        
        self.itemList = itemList;
        
        for (NSInteger i = 0; i < itemList.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            ItemModel *model = [itemList safeObjectAtIndex:i];
            [button setTitle:model.itemName forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            if (i == 0) {
                [button setTitleColor:BWColor(44, 48, 81, 1) forState:UIControlStateNormal];
            }else{
                [button setTitleColor:BWColor(44, 48, 81, 0.4) forState:UIControlStateNormal];
            }
            [self addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.mas_equalTo(i == 0 ? 0:LAdaptation_x(100)*i);
                make.width.mas_equalTo(LAdaptation_x(100));
                make.height.equalTo(self);
            }];
        }
        
        if (self.selectBlock) {
            self.selectBlock(0);
        }
    }
    return self;
}
- (void)clickItem:(UIButton *)button
{
    for (UIView *contentView in self.subviews) {
        if ([contentView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)contentView;
            if (btn.tag == button.tag) {
                [btn setTitleColor:BWColor(44, 48, 81, 1) forState:UIControlStateNormal];

            }else{
                [btn setTitleColor:BWColor(44, 48, 81, 0.4) forState:UIControlStateNormal];
            }
        }
    }
    
    if (self.selectBlock) {
        self.selectBlock(button.tag);
    }
}

@end
