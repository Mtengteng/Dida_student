//
//  SAddImageView.m
//  Student
//
//  Created by 马腾 on 2021/5/18.
//

#import "SAddImageView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "SContentImageView.h"

@interface SAddImageView()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIViewController *superVC;


@end

@implementation SAddImageView

- (instancetype)initWithFrame:(CGRect)frame withSuperVC:(nonnull UIViewController *)superVC
{
    if (self = [super initWithFrame:frame]) {
        
        self.superVC = superVC;
        
        [self.scrollView setFrame:CGRectMake(0, 0, LAdaptation_x(100), LAdaptation_y(100))];
        [self addSubview:self.scrollView];
        
        self.addImageView.userInteractionEnabled = YES;
        [self.addImageView setFrame:CGRectMake(0, 0, LAdaptation_x(50), LAdaptation_y(50))];
        [self addSubview:self.addImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAction:)];
        [self.addImageView addGestureRecognizer:tap];
        
        
    }
    return self;
}
- (void)reloadData
{
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[SContentImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    
    for (NSInteger i = 0; i<self.imgList.count; i++) {
        UIImage *img = [self.imgList safeObjectAtIndex:i];
        SContentImageView *contentView = [[SContentImageView alloc] initWithFrame:CGRectMake(i*LAdaptation_x(110), 0, LAdaptation_x(100), LAdaptation_y(100)) withTag:i];
        [contentView setImage:img];
        [self.scrollView addSubview:contentView];
        
        DefineWeakSelf;
        contentView.deleteBlock = ^(NSInteger tag) {
            [weakSelf.imgList removeObjectAtIndex:tag];
            [weakSelf reloadData];
        };
    }
    CGFloat maxWidth = self.imgList.count * LAdaptation_x(110);
    if (maxWidth > (self.bounds.size.width - LAdaptation_x(20) - LAdaptation_x(100))) {
        
        [self.addImageView setFrame:CGRectMake((self.bounds.size.width - LAdaptation_x(20) - LAdaptation_x(100)), self.bounds.size.height/2 - LAdaptation_y(50)/2, LAdaptation_x(50), LAdaptation_y(50))];
        
        [self.scrollView setFrame:CGRectMake(0, 0, (self.bounds.size.width - LAdaptation_x(20) - LAdaptation_x(100)), LAdaptation_y(100))];
        self.scrollView.contentSize = CGSizeMake(maxWidth, LAdaptation_y(100));

    }else{
        [self.addImageView setFrame:CGRectMake(maxWidth, self.bounds.size.height/2 - LAdaptation_y(50)/2, LAdaptation_x(50), LAdaptation_y(50))];
        
        [self.scrollView setFrame:CGRectMake(0, 0, maxWidth, LAdaptation_y(100))];
        self.scrollView.contentSize = CGSizeMake(maxWidth, LAdaptation_y(100));
    }


}

- (void)addAction:(UITapGestureRecognizer *)tap 
{
    if (self.addBlock) {
        self.addBlock();
    }
    [self tapAvatar];
}

- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self; //delegate遵循了两个代理
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

- (void)tapAvatar {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
 
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self checkCameraPermission];//检查相机权限
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self checkAlbumPermission];//检查相册权限
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [self.superVC dismissViewControllerAnimated:YES completion:nil];
    }];
 
    [alert addAction:camera];
    [alert addAction:album];
    [alert addAction:cancel];
 
    alert.popoverPresentationController.sourceView = self;
    alert.popoverPresentationController.sourceRect = CGRectMake(0,0,1.0,1.0);
    [self.superVC presentViewController:alert animated:YES completion:nil];
}
#pragma mark - Camera
- (void)checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self takePhoto];
            }
        }];
    } else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
//        [self alertCamear];
    } else {
        [self takePhoto];
    }
}
 
- (void)takePhoto {
    //判断相机是否可用，防止模拟器点击【相机】导致崩溃
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:self.imagePickerController animated:YES completion:^{
 
        }];
    } else {
        NSLog(@"不能使用模拟器进行拍照");
    }
}
 

#pragma mark - Album
- (void)checkAlbumPermission {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    [self selectAlbum];
                }
            });
        }];
    } else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self alertAlbum];
    } else {
        [self selectAlbum];
    }
}
 
- (void)selectAlbum {
    //判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:self.imagePickerController animated:YES completion:^{
 
        }];
    }
}
 
- (void)alertAlbum {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置中打开相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.superVC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self.superVC presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [self.imgList addObject:image];
    
    [self reloadData];
}

#pragma mark - LazyLoad -
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIImageView *)addImageView
{
    if (!_addImageView) {
        _addImageView = [[UIImageView alloc] init];
        [_addImageView setImage:[UIImage imageNamed:@"addTest"]];
    }
    return _addImageView;
}
- (NSMutableArray *)imgList
{
    if (!_imgList) {
        _imgList = [[NSMutableArray alloc] init];
    }
    return _imgList;
}
@end
