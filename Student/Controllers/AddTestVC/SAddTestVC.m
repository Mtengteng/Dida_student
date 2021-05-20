//
//  SAddTestVC.m
//  Student
//
//  Created by 马腾 on 2021/5/18.
//

#import "SAddTestVC.h"
#import "SAddImageView.h"


@interface SAddTestVC ()


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
    
    SAddImageView *imageView = [[SAddImageView alloc] initWithFrame:CGRectMake(0, LAdaptation_y(60), SCREEN_WIDTH, LAdaptation_y(100)) withSuperVC:self];
    [self.view addSubview:imageView];
}



@end
