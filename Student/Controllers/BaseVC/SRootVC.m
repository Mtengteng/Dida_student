//
//  SRootVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SRootVC.h"
#import "SBaseNavigationVC.h"
#import "SHomeVC.h"
#import "StudyVC.h"
#import "SPromoteVC.h"
#import "SMineVC.h"
#import "BWMyTabBar.h"
#import "SAddStudyClassVC.h"

@interface SRootVC ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSArray *viewsArray;

@end

@implementation SRootVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    [self setCustomtabbar];
    [self createTabBarItem];
}

- (void)createTabBarItem{
    
    SHomeVC *hvc = [[SHomeVC alloc] init];
    [self addChildController:hvc title:@"首页" imageName:@"home_nomal" selectedImageName:@"home_active" navVc:[SBaseNavigationVC class]];
    
    StudyVC *learnVC = [[StudyVC alloc] init];
    [self addChildController:learnVC title:@"学情" imageName:@"study_nomal" selectedImageName:@"study_active" navVc:[SBaseNavigationVC class]];
    
    SPromoteVC *correctVC = [[SPromoteVC alloc] init];
    [self addChildController:correctVC title:@"提升" imageName:@"promote_nomal" selectedImageName:@"promote_active" navVc:[SBaseNavigationVC class]];
    
    SMineVC *mineVC = [[SMineVC alloc] init];
    [self addChildController:mineVC title:@"我的" imageName:@"mine_nomal" selectedImageName:@"mine_active" navVc:[SBaseNavigationVC class]];
}
#pragma mark - 创建tabBarItem -
- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    UIImage *sizeImg_nomal = [BWTools reSizeImage:[UIImage imageNamed:imageName] toSize:CGSizeMake(30, 30)];
    UIImage *sizeImg_active = [BWTools reSizeImage:[UIImage imageNamed:selectedImageName] toSize:CGSizeMake(30, 30)];

    childController.title = title;
    childController.tabBarItem.image = [sizeImg_nomal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [sizeImg_active imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    //[childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : BWColor(24, 134, 254, 1) }forState:UIControlStateSelected];
        
    [self addChildViewController:[[navVc alloc] initWithRootViewController:childController]];

}
#pragma mark - 创建自定义
- (void)setCustomtabbar{
    
    BWMyTabBar *tabbar = [[BWMyTabBar alloc]init];
    tabbar.tintColor = BWColor(24, 134, 254, 1);
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [tabbar.plusItem addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)centerBtnClick:(UIButton *)btn{
        
    NSLog(@"click add按钮");
    if (!btn.hidden) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"createCourse" object:nil];
        
        SAddStudyClassVC *testVC = [[SAddStudyClassVC alloc] init];
        SBaseNavigationVC *nav = [[SBaseNavigationVC alloc] initWithRootViewController:testVC];
        nav.modalPresentationStyle = 0;
        [self presentViewController:nav animated:YES completion:nil];
    }
}
@end
