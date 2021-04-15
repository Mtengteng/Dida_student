//
//  SBaseVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SBaseVC.h"
typedef void(^backBlock)(void);

@interface SBaseVC ()
@property (nonatomic, copy) backBlock back;

@end

@implementation SBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - 创建UI -
- (void)createUI
{
    
}
#pragma mark - 返回按钮 -
- (void)createLeftBackBtn:(void(^)(void))backBlock{
    
    UIImage *image = [UIImage imageNamed:@"arrow_left.png"];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 34, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    UIView *leftView = [[UIView alloc]initWithFrame:leftBtn.bounds];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.back = backBlock;
}
- (void)back:(UIButton *)sender{
    
    if (self.back) {
        self.back();
    }
}
@end
