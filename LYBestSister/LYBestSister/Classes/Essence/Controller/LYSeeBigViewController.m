//
//  LYSeeBigViewController.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/5.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYSeeBigViewController.h"
#import "LYTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h> // 从iOS8开始使用

@interface LYSeeBigViewController ()<UIScrollViewDelegate>

/** 图片控件 */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LYSeeBigViewController

/** 创建该应用相册名 */
static NSString * const LYCollectionName = @"百思不得姐";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 0.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    // 代理
    scrollView.delegate = self;
    // 插入到view中
    [self.view insertSubview:scrollView atIndex:0];
    
    // 1.添加imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    // 为imageView赋值
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.width = scrollView.width;
    imageView.height = self.topic.height *imageView.width / self.topic.width;
    imageView.x = 0;
    if (imageView.height >= scrollView.height) { // 大于屏幕高度
        imageView.y = 0;
    } else {
        imageView.centerY = scrollView.height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 滚动范围
    scrollView.contentSize = CGSizeMake(0, imageView.height);
    
    // 缩放比例
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
    }
}

#pragma mark - 返回
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 保存
- (IBAction)saveClick:(id)sender {
    // 保存图片到【相机胶卷】法1
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    // 0.判断保存相册状态【图片库状态】
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前用户访问相册
        LYLog(@"用户拒绝当前用户访问相册--提醒用户打开访问开关");
    } else if (status == PHAuthorizationStatusRestricted) { // 家长控制--受限
        LYLog(@"家长控制--受限");
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        LYLog(@"用户还没有做出选择");
        
        [self saveImage];
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
        LYLog(@"用户允许当前应用访问相册");
        
        [self saveImage];
    }
    
}

#pragma mark -- 保存图片方法
/* // 方法一
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
*/
/** 返回相册 */
- (PHAssetCollection *)collection {
    // 2.1 获得之前创建的相 【PHAssetCollectionTypeAlbum】-- 相册类型
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 根据相册名称判断 相册是否存在
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:LYCollectionName]) {
            return collection;
        }
    }
    
    // 2.2如果之前没有相册，就创建新的
    __block NSString *collectionId = nil;
    // 相册创建完毕返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建一个PHAssetCollectionChangeRequest对象，创建新相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:LYCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}

/** 保存图片 */
- (void)saveImage {
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件, 比如一张图片
     
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    __block NSString *assetId = nil; // 图片的字符串标示
    // 1.存储图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        // 新建一个PHAssetChangeRequest对象，保存图片到【相机胶卷】
        // 返回【PHAsset】图片的字符串标示
        assetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (error) {
            LYLog(@"保存图片到相机胶卷失败");
            return;
        }
        
        LYLog(@"保存图片到相机胶卷成功");
        
        // 2.获取相册对象
        PHAssetCollection *collection = [self collection];
        
        // 3.将【相机胶卷】中的图片添加到【新相册】
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 相册
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            //  根据图片标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            
            // 添加图片到相册
            [request addAssets:@[asset]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (error) {
                LYLog(@"添加图片到相册失败");
                return;
            }
            
            LYLog(@"添加图片到相册成功");
            
            // 在主队列中刷新UI
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }];
        }];
    }];
    
}


#pragma mark - UIScrollViewDelegate
/** 返回scrollView内部子控件缩放 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
