//
//  SANodeInfoView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SANodeInfoView.h"
#import "SANode.h"
#import "SAddImageView.h"

typedef void(^addBlock)(NSString *imageUrl);

@interface SANodeInfoView()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nodeArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImagePickerController *pickerView;
@property (nonatomic, copy) addBlock addActionBlock;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) MBProgressHUD *hud;


@end

@implementation SANodeInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.text = @"函数";
        [self.titleLabel setFrame:CGRectMake(0, 0, self.bounds.size.width, LAdaptation_y(40))];
        [self addSubview:self.titleLabel];
        
        [self.tableView setFrame:CGRectMake(0, LAdaptation_y(40), self.bounds.size.width, self.bounds.size.height - LAdaptation_y(130))];
        [self addSubview:self.tableView];
        
        [self.nextBtn setFrame:CGRectMake(self.bounds.size.width/2 - LAdaptation_x(120)/2, self.bounds.size.height - LAdaptation_y(80), LAdaptation_x(120), LAdaptation_y(44))];
        [self addSubview:self.nextBtn];
        
        
        _hud = [[MBProgressHUD alloc] initWithView:self];
        _hud.mode = MBProgressHUDModeAnnularDeterminate;
        _hud.label.text = NSLocalizedString(@"上传中", @"HUD loading title");
        [self addSubview:_hud];
        
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

- (void)nextAction:(id)sender
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self.nodeArray enumerateObjectsUsingBlock:^(SANode  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type != NodeType_add) {
            [array addObject:obj];
        }
    }];
    
    if (self.next) {
        self.next(array);
    }
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (self.nodeArray.count <= 3) {
            [MBProgressHUD showMessag:@"不能删除" toView:self hudModel:MBProgressHUDModeText hide:YES];
            return;
        }
        //删除数据源
        SANode *node = self.nodeArray[indexPath.row];
        SANode *nodeAdd = self.nodeArray[indexPath.row+1];

        NSMutableArray *tempArray = [self.nodeArray mutableCopy];
        [tempArray removeObject:node];
        [tempArray removeObject:nodeAdd];
        self.nodeArray = tempArray;
        [self.tableView reloadData];

    }
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
                        targetAddNode.type =  NodeType_add;
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
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addContentAction:)];
        [bgView addGestureRecognizer:tap];
        
    }else{
        NSInteger myCount = 0;
        if (node.imageList.count >3) {
            myCount = 4;
        }else{
            myCount = node.imageList.count+1;
        }

        for (NSInteger i = 0; i < myCount; i++) {
            
            if (i == myCount - 1) {
                UIView *bgView = [[UIView alloc] init];
                bgView.backgroundColor = BWColor(239, 239, 239, 1.0);
                bgView.userInteractionEnabled = YES;
                [cell.contentView addSubview:bgView];

                [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView);
                    make.left.mas_equalTo(LAdaptation_x(120)+i*LAdaptation_x(140));
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
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addContentAction:)];
                [bgView addGestureRecognizer:tap];
                
            }else{
                
                NSString *imageUrl = [node.imageList safeObjectAtIndex:i];
                UIImageView *contentView = [[UIImageView alloc] init];
                [contentView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//                [contentView setImage:img];
                [cell.contentView addSubview:contentView];
                
                [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView);
                    make.left.mas_equalTo(LAdaptation_x(120)+i*LAdaptation_x(140));
                    make.width.mas_equalTo(LAdaptation_x(120));
                    make.height.mas_equalTo(LAdaptation_y(100));
                }];
            }
        }
    }
    
}
- (void)addContentAction:(UITapGestureRecognizer *)tap
{
    CGPoint currentPoint = [tap locationInView:self.tableView];
      
    NSIndexPath *currentPath = [self.tableView indexPathForRowAtPoint:currentPoint];
    
    SANode *node = [self.nodeArray safeObjectAtIndex:currentPath.row];
    
    DefineWeakSelf;
    __block NSMutableArray *imgArray = [[NSMutableArray alloc] init];
    [imgArray addObjectsFromArray:node.imageList];
    
    self.addActionBlock = ^(NSString *imageUrl) {
        [imgArray addObject:imageUrl];
        node.imageList = imgArray;
        [weakSelf.tableView reloadData];
    };
    
    [BWAlertCtrl alertControllerWithTitle:@"提示" buttonArray:@[@"图片文件",@"收藏卡片",@"取消"] message:@"请选择来源" preferredStyle:UIAlertControllerStyleAlert withVC:self.superVC clickBlock:^(NSString *buttonTitle) {

        if ([buttonTitle isEqualToString:@"图片文件"]) {

            [self.superVC presentViewController:self.pickerView animated:YES completion:nil];

        }
        if ([buttonTitle isEqualToString:@"收藏卡片"]) {
            
        }
            
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    UIImage *img = [info safeObjectForKey:@"UIImagePickerControllerOriginalImage"];
   
    [self uploadImg:img];

    [self.pickerView dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)uploadImg:(UIImage *)image
{
    DefineWeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.hud showAnimated:YES];
    });
    
    NSString *upStr = [NSString stringWithFormat:@"%@/file",BaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"charset/UTF-8",
                                                         @"audio/x-wav",
                                                         @"text/plain",
                                                         nil];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_token];
    
    [manager POST:upStr parameters:@{} headers:@{@"token":token == nil ? @"":token} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        
        [formData appendPartWithFileData:data

                                    name:@"file"

                                fileName:@"file.jpeg"

                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        [uploadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf.hud hideAnimated:YES];

        
        NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableLeaves error:nil];

        NSLog(@"%@",respDic);
        
        NSInteger code = [[respDic safeObjectForKey:@"code"] integerValue];
        if (code == 1000) {
            NSString *fileURL = [respDic safeObjectForKey:@"data"];
            NSString *msd = [respDic safeObjectForKey:@"msg"];
            NSLog(@"%@",msd);
            if (weakSelf.addActionBlock) {
                weakSelf.addActionBlock(fileURL);
            }
        }else{
            [weakSelf.hud hideAnimated:YES];
            NSError *error = [NSError errorWithDomain:@"上传失败" code:-1 userInfo:nil];
            NSLog(@"%@",error.domain);

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        [weakSelf.hud hideAnimated:YES];
        
    }];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            // Do something useful in the background and update the HUD periodically.
            NSProgress *progress = (NSProgress *)object;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Instead we could have also passed a reference to the HUD
                // to the HUD to myProgressTask as a method parameter.
                self->_hud.progress = progress.fractionCompleted;
            });
            
        });
        
    }
    
}
#pragma mark - LazyLoad -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
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
- (UIImagePickerController *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIImagePickerController alloc] init];
        _pickerView.allowsEditing = YES;
        _pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:[UIColor blueColor]];
    }
    return _nextBtn;
}
@end
