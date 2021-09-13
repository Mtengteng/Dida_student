//
//  StudyVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "StudyVC.h"
#import "SelectSubView.h"
#import "SCDictModel.h"


@interface StudyVC ()
@property (nonatomic, strong) SelectSubView *subView;

@end

@implementation StudyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    
    
}

#pragma mark - LazyLoad -
- (SelectSubView *)subView
{
    if (!_subView) {
        
        NSArray *array = @[@"我的动态",@"我的数据",@"我的内容"];
        NSMutableArray *infoArray = [[NSMutableArray alloc] init];
       
        for (NSInteger i = 0; i < array.count; i++) {
            SCDictInfoModel *model = [[SCDictInfoModel alloc] init];
            model.dictValue = [array safeObjectAtIndex:i];
            [infoArray addObject:model];
        }
        
        _subView = [[SelectSubView alloc] initWithItemArray:infoArray];
    }
    return _subView;
}
@end
