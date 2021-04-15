//
//  SChapterCell.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "SChapterCell.h"

@interface SChapterCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SChapterCell



#pragma mark - LazyLoad -
- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
    }
    return _titleView;
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
