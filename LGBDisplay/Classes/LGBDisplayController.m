//
//  LGBDisplayController.m
//  Pods
//
//  Created by mac_256 on 2017/8/29.
//
//

#import "LGBDisplayController.h"

@interface LGBDisplayController ()
@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, weak) UIViewController *targetController;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *snapshotView;
@end

@implementation LGBDisplayController

#pragma mark ------------------------------------------------- 生命周期 -------------------------------------------------

//- (void)dealloc
//{
//    NSLog(@"dealloc");
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------
-(void)displayView:(UIView *)view inViewController:(UIViewController *)controller
{
    if (!view) {
        return;
    }
    
    self.targetView = view;
    self.targetController = controller;
    
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.snapshotView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:view];
    
    UIImage *img = nil;
    if (self.targetController) {
        img = [self snapshotFromView:self.targetController.view];
        [self.targetController addChildViewController:self];
        [self.targetController.view addSubview:self.view];
        [self didMoveToParentViewController:self.targetController];
    }else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        img = [self snapshotFromView:window];
        [window addSubview:self.view];
    }
    
    if (self.blurValue > 0) {
        img = [self blurFromImage:img blurValue:self.blurValue];
        
    }
    
    self.snapshotView.image = img;
    
    self.backgroundView.frame = self.view.bounds;
    self.snapshotView.frame = self.backgroundView.bounds;
    self.maskView.frame = self.view.bounds;
    
    
    if (self.showBlock) {
        self.showBlock(self.snapshotView, self.maskView);
    }
}

-(void)dismiss
{
    //    NSLog(@"dismiss");
    [self.targetView removeFromSuperview];
    
    if (self.targetController) {
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }else{
        [self.view removeFromSuperview];
    }
    
}

#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------
-(void)handleTapBackground
{
    //    NSLog(@"tap background");
    if (self.backgroundTap) {
        self.backgroundTap(self.snapshotView, self.maskView);
    }
}
#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------
-(UIImage *)snapshotFromView:(UIView *)view
{

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

-(UIImage *)blurFromImage:(UIImage *)image blurValue:(CGFloat)blurValue
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    //因为在模糊的时候，边缘会变成半透明的状态，所以理想状况是可以对原图像进行适当放大，选择使用CIAffineClamp在模糊之前对图像进行处理
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    //模糊滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:extendedImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:blurValue] forKey:@"inputRadius"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //ARC不会释放CGImageRef，需要手动释放
    CGImageRelease(cgImage);
    
    return returnImage;
}
#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------
-(UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBackground)];
        _maskView.userInteractionEnabled = YES;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

-(UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [UIColor blackColor];
    }
    return _backgroundView;
}

-(UIImageView *)snapshotView
{
    if (_snapshotView == nil) {
        _snapshotView = [UIImageView new];
//        _snapshotView.backgroundColor = [UIColor blackColor];
    }
    return _snapshotView;
}
@end
