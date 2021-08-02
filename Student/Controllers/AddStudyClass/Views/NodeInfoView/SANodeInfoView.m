//
//  SANodeInfoView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SANodeInfoView.h"
#import "SANode.h"

@interface SANodeInfoView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nodeArray;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SANodeInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.titleLabel setFrame:CGRectMake(0, LAdaptation_y(20), self.bounds.size.width, LAdaptation_y(20))];
        [self addSubview:self.titleLabel];
        
        [self.tableView setFrame:CGRectMake(0, LAdaptation_y(20), self.bounds.size.width, self.bounds.size.height - LAdaptation_y(20))];
        [self addSubview:self.tableView];
        
        [self initData];
    }
    return self;
}
- (void)initData
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    SANode *startNode = [[SANode alloc] init];
    startNode.nId = [NSString stringWithFormat:@"%d",0];
    startNode.type = NodeType_start;
    [tempArray addObject:startNode];
    
    SANode *addNode = [[SANode alloc] init];
    addNode.nId = [NSString stringWithFormat:@"%d",1];
    addNode.type = NodeType_add;
    [tempArray addObject:addNode];
    
    SANode *endNode = [[SANode alloc] init];
    endNode.nId = [NSString stringWithFormat:@"%d",2];
    endNode.type = NodeType_end;
    [tempArray addObject:endNode];
    
    self.nodeArray = tempArray;
}


#pragma mark - LazyLoad -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    }
    return _titleLabel;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
