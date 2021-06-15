//
//  UIImagePickerControllerVC.m
//  AllInCode
//
//  Created by hd on 2021/6/3.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "UIImagePickerControllerVC.h"
#import "UIView+GestureCallback.h"
#import <AVFoundation/AVFoundation.h>
#import <TZImagePickerController.h>

/// 一次最多选取的图片数
static const NSInteger maxPhotoCount = 9;

@interface UIImagePickerControllerVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<UIImage *> *selectedImages;
/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<PHAsset *> *selectedAccest;

///
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

///
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation UIImagePickerControllerVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        make.height.mas_equalTo(300);
    }];
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"UIImagePickerController" subTitle:@"选择相册-照相" itemOperation:^(NSIndexPath *indexPath) {
        // 弹出选择图片-拍照界面
        [UIAlertController mj_showActionSheetWithTitle:nil message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionDefaultTitle(@"选择相册");
            alertMaker.addActionDefaultTitle(@"相册多选");
            // 判断是否支持相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                alertMaker.addActionDefaultTitle(@"照相");
            }
            alertMaker.addActionCancelTitle(@"取消");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                [self choosePhoto];
            }else if (buttonIndex == 1) {
                [self chooseMultiplePhoto];
            }else if (buttonIndex == 2) {
                [self takePhoto];
            }
        }];
    }]);
}

/// 选择相册，如果没有获取相册权限，系统默认会弹窗提示用户授权，UIImagePickerController只能单选
- (void)choosePhoto {
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.imagePickerController animated:YES completion:^{
            NSLog(@"%s", __func__);
    }];
}

/// 多选图片
- (void)chooseMultiplePhoto {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxPhotoCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    if (maxPhotoCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = self.selectedAccest; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.lmj_width - 2 * left;
    NSInteger top = (self.view.lmj_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
//    imagePickerVc.isStatusBarDefault = NO;
#pragma mark - 到这里为止
    LMJWeak(self);
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        weakself.selectedImages = [NSMutableArray arrayWithArray:photos];
        weakself.selectedAccest = [NSMutableArray arrayWithArray:assets];

//        [weakself.collectionView reloadData];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

/// 拍照，默认左上角可以设置闪光灯
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSLog(@"%s, authStatus: %ld", __func__, (long)authStatus);
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        // 无相机权限 做一个友好的提示
        [UIAlertController mj_showAlertWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionDestructiveTitle(@"取消").addActionDefaultTitle(@"确认");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }
        }];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
    } else {  // 已获取权限
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;  // 相机
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;  // 后置摄像头
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* editedImage =(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];  // 取出编辑过的照片
    UIImage* originalImage =(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];  // 取出原生照片，即编辑前的图片
    UIImage* imageToSave = nil;
    if(editedImage){
        imageToSave = editedImage;
    } else {
        imageToSave = originalImage;
    }
    //将新图像（原始图像或已编辑）保存到相机胶卷
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);

    self.imageView.image = imageToSave;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Getters & Setters
- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        
        // 选取图片后，跳转到截取固定方框大小的图片，图片可以缩放。不设置则直接返回
        //使用内置编辑控件时，图像选择器控制器会强制执行某些选项。对于照片，强制执行方形裁剪以及最大像素尺寸。对于视频，选择器强制执行最大电影长度和分辨率。如果要让用户指定自定义裁剪，则必须提供自己的编辑UI。
        _imagePickerController.allowsEditing = YES;

        //是否显示相机控制按钮
        //_imagePickerController.showsCameraControls = NO;
         //自定义相机控制页面
        //_imagePickerController.cameraOverlayView = self.cameraOverLayView;
        //如果不需要自定义控制页面可以省略上面两行
        
        //设置闪光灯模式
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
    }
    return _imagePickerController;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_addPicture_BgImage"]];
    }
    return _imageView;
}
@end
