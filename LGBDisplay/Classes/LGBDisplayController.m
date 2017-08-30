//
//  LGBDisplayController.m
//  Pods
//
//  Created by mac_256 on 2017/8/29.
//
//

#import "LGBDisplayController.h"

@interface LGBDisplayController ()
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIViewController *targetController;
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
    
    [self.view addSubview:view];
    
    if (controller) {
        [controller addChildViewController:self];
        [controller.view addSubview:self.view];
        [self didMoveToParentViewController:controller];
    }else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.view];
    }
    
    if (self.showBlock) {
        self.showBlock(self.backgroundView);
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
        self.backgroundTap(self.backgroundView);
    }
}
#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------
-(void)updateViewsFrame
{
    
}
#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------
-(UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [UIView new];
        _backgroundView.frame = self.view.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBackground)];
        _backgroundView.userInteractionEnabled = YES;
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}
@end
