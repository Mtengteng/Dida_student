//
//  SANodeInfoView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SANodeInfoView.h"
#import "SANode.h"
#import "SAddImageView.h"

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
    startNode.type = NodeType_start;
    [tempArray addObject:startNode];
    
    SANode *addNode = [[SANode alloc] init];
    addNode.type = NodeType_add;
    [tempArray addObject:addNode];
    
    SANode *endNode = [[SANode alloc] init];
    endNode.type = NodeType_end;
    [tempArray addObject:endNode];
    
    self.nodeArray = tempArray;
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nodeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    for (id v in cell.contentView.subviews)
        [v removeFromSuperview];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SANode *node = [self.nodeArray safeObjectAtIndex:indexPath.row];
    
    if (node.type == NodeType_start) {
        
        [self loadCellTypeWithStartStyleByNode:node andCell:cell];
    }
    if (node.type == NodeType_add) {
        
        [self loadCellTypeWithAddStyleByNode:node andCell:cell];
    }
    if (node.type == NodeType_kw) {
        
        [self loadCellTypeWithContentStyleByNode:node andCell:cell];
    }
    if (node.type == NodeType_test) {
        [self loadCellTypeWithContentStyleByNode:node andCell:cell];

    }
    if (node.type == NodeType_end) {
        [self loadCellTypeWithEndStyleByNode:node andCell:cell];
    }

    return cell;
}
#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SANode *node = [self.nodeArray safeObjectAtIndex:indexPath.row];

    if (node.type == NodeType_start) {
        
        return LAdaptation_y(60);
    }
    if (node.type == NodeType_add) {
        return LAdaptation_y(60);

    }
    if (node.type == NodeType_kw) {
        return LAdaptation_y(120);

    }
    if (node.type == NodeType_test) {
        return LAdaptation_y(120);

    }
    if (node.type == NodeType_end) {
        return LAdaptation_y(60);
    }
    return LAdaptation_y(60);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SANode *node = [self.nodeArray safeObjectAtIndex:indexPath.row];
    if (node.type == NodeType_add) {
        
        [BWAlertCtrl alertControllerWithTitle:@"提示" buttonArray:@[@"知识节点",@"练习",@"取消"] message:@"请选择添加内容" preferredStyle:UIAlertControllerStyleAlert withVC:self.superVC clickBlock:^(NSString *buttonTitle) {
          
            if ([buttonTitle isEqualToString:@"知识节点"]) {
                
                NSMutableArray *tempArray = [self.nodeArray mutableCopy];
                [self.nodeArray enumerateObjectsUsingBlock:^(SANode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (indexPath.row == idx) {
                        
                        SANode *targetNode = [[SANode alloc] init];
                        targetNode.type = NodeType_kw;
                        [tempArray insertObject:targetNode atIndex:idx+1];
                        
                        SANode *targetAddNode = [[SANode alloc] init];
                        targetAddNode.type = NodeType_add;
                        [tempArray insertObject:targetAddNode atIndex:idx+2];
                    }
                }];
                self.nodeArray = tempArray;
                [self.tableView reloadData];
            }
            if ([buttonTitle isEqualToString:@"练习"]) {
                NSMutableArray *tempArray = [self.nodeArray mutableCopy];
                [self.nodeArray enumerateObjectsUsingBlock:^(SANode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (indexPath.row == idx) {
                        
                        SANode *targetNode = [[SANode alloc] init];
                        targetNode.type = NodeType_test;
                        [tempArray insertObject:targetNode atIndex:idx+1];
                        
                        SANode *targetAddNode = [[SANode alloc] init];
                        targetAddNode.type = NodeType_add;
                        [tempArray insertObject:targetAddNode atIndex:idx+2];
                    }
                }];
                self.nodeArray = tempArray;
                [self.tableView reloadData];
            }
        }];
       
    }
}



#pragma mark - 加载cell样式 -
- (void)loadCellTypeWithStartStyleByNode:(SANode *)node andCell:(UITableViewCell *)cell
{
    UIImageView *pointView = [[UIImageView alloc] init];
    [pointView setImage:[UIImage imageNamed:@"node_root"]];
    [cell.contentView addSubview:pointView];
    
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(LAdaptation_x(40));
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pointView);
        make.top.equalTo(pointView.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(cell.contentView.mas_bottom);
    }];
    
}
- (void)loadCellTypeWithEndStyleByNode:(SANode *)node andCell:(UITableViewCell *)cell
{
    UIImageView *pointView = [[UIImageView alloc] init];
    [pointView setImage:[UIImage imageNamed:@"node_root"]];
    [cell.contentView addSubview:pointView];
    
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(LAdaptation_x(40));
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pointView);
        make.top.equalTo(cell.contentView.mas_top);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(pointView.mas_top);
    }];
}
- (void)loadCellTypeWithAddStyleByNode:(SANode *)node andCell:(UITableViewCell *)cell
{

    UIImageView *addView = [[UIImageView alloc] init];
    [addView setImage:[UIImage imageNamed:@"node_add"]];
    [cell.contentView addSubview:addView];
    
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(LAdaptation_x(40));
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *lineView1 = [[UIImageView alloc] init];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addView);
        make.top.equalTo(cell.contentView.mas_top);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(addView.mas_top);
    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addView);
        make.top.equalTo(addView.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(cell.contentView.mas_bottom);
    }];
}
- (void)loadCellTypeWithContentStyleByNode:(SANode *)node andCell:(UITableViewCell *)cell
{

    UIImageView *addView = [[UIImageView alloc] init];
    if (node.type == NodeType_kw) {
        addView.backgroundColor = [UIColor blueColor];
    }else{
        addView.backgroundColor = [UIColor yellowColor];
    }
    [cell.contentView addSubview:addView];
    
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(LAdaptation_x(40));
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *lineView1 = [[UIImageView alloc] init];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addView);
        make.top.equalTo(cell.contentView.mas_top);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(addView.mas_top);
    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addView);
        make.top.equalTo(addView.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(cell.contentView.mas_bottom);
    }];
    
    if (node.imageList.count == 0) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = BWColor(239, 239, 239, 1.0);
        [cell.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(addView.mas_right).offset(LAdaptation_x(40));
            make.width.mas_equalTo(LAdaptation_x(100));
            make.height.mas_equalTo(LAdaptation_y(100));
        }];
                                  
        UIImageView *iconAdd = [[UIImageView alloc] init];
        [iconAdd setImage:[UIImage imageNamed:@"nodecontent_add"]];
        [bgView addSubview:iconAdd];
        
        [iconAdd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.width.mas_equalTo(LAdaptation_x(45));
            make.height.mas_equalTo(LAdaptation_y(45));
        }];
    }else{
        for (NSInteger i = 0; i < node.imageList.count; i++) {
            NSString *imageUrl = [node.imageList safeObjectAtIndex:i];
            UIImageView *contentView = [[UIImageView alloc] init];
            [contentView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            [cell.contentView addSubview:contentView];
            
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                if (i == 0) {
                    make.left.equalTo(addView.mas_right).offset(LAdaptation_x(40));
                }else{
                    make.left.equalTo(contentView.mas_right).offset(LAdaptation_x(20));
                }
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(100);
            }];
        }
    }
    

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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
