//
//  StudyVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "StudyVC.h"
#import "STabMenuView.h"
#import "SAssistantVC.h"
#import "SExamVC.h"

@interface StudyVC ()
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) STabMenuView *navMenuView;
@property (nonatomic, strong) SAssistantVC *assistantVC;
@property (nonatomic, strong) SExamVC *examVC;
@end

@implementation StudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.currentVC = self.assistantVC;
    
    DefineWeakSelf;
    self.navMenuView.selectBlock = ^(NSString * _Nonnull titleName) {
        
        if ((self.currentVC == weakSelf.assistantVC && [titleName isEqualToString:@"答题集"])||(self.currentVC == weakSelf.examVC && [titleName isEqualToString:@"学习集"])) {
            return;
        }
        
        if ([titleName isEqualToString:@"学习集"]) {
            
            [weakSelf replaceController:weakSelf.currentVC newController:weakSelf.examVC];
        
        }else{
            
            [weakSelf replaceController:weakSelf.currentVC newController:weakSelf.assistantVC];

        }
    };
    
}
- (void)createUI
{
    [self.navigationController.navigationBar addSubview:self.navMenuView];
    [self.navMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.navigationBar);
    }];
    
    [self addChildViewController:self.assistantVC];
    
    self.assistantVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.assistantVC.view];
    


}
//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}
#pragma mark - LazyLoad -
- (STabMenuView *)navMenuView
{
    if (!_navMenuView) {
        _navMenuView = [[STabMenuView alloc] initWithTitle:@[@"答题集",@"学习集"]];
    }
    return _navMenuView;
}
- (SAssistantVC *)assistantVC
{
    if (!_assistantVC) {
        _assistantVC = [[SAssistantVC alloc] init];
    }
    return _assistantVC;
}
- (SExamVC *)examVC
{
    if (!_examVC) {
        _examVC = [[SExamVC alloc] init];
    }
    return _examVC;
}
@end
