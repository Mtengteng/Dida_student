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

@interface SRootVC ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSArray *viewsArray;

@end

@implementation SRootVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    [self createTabBarItem];
}

- (void)createTabBarItem{
    
    SHomeVC *hvc = [[SHomeVC alloc] init];
    [self addChildController:hvc title:@"首页" imageName:@"homeOff.png" selectedImageName:@"homeOn.png" navVc:[SBaseNavigationVC class]];
    
    StudyVC *learnVC = [[StudyVC alloc] init];
    [self addChildController:learnVC title:@"学情" imageName:@"perOff.png" selectedImageName:@"perOn.png" navVc:[SBaseNavigationVC class]];
    
    SPromoteVC *correctVC = [[SPromoteVC alloc] init];
    [self addChildController:correctVC title:@"批改" imageName:@"netOff.png" selectedImageName:@"netOn.png" navVc:[SBaseNavigationVC class]];
    
    SMineVC *mineVC = [[SMineVC alloc] init];
    [self addChildController:mineVC title:@"我的" imageName:@"netOff.png" selectedImageName:@"netOn.png" navVc:[SBaseNavigationVC class]];
}
#pragma mark - 创建tabBarItem -
- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    //[childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : BWColor(24, 134, 254, 1) }forState:UIControlStateSelected];
        
    [self addChildViewController:[[navVc alloc] initWithRootViewController:childController]];

}

@end
