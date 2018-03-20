//
//  LGBViewController.m
//  LGBDisplay
//
//  Created by lgb789@126.com on 08/29/2017.
//  Copyright (c) 2017 lgb789@126.com. All rights reserved.
//

#import "LGBViewController.h"

@interface LGBViewController ()
@property (nonatomic, strong) UIView *v1;
@end

@implementation LGBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *v2 = [UIView new];
    v2.backgroundColor = [UIColor greenColor];
    v2.frame = CGRectMake(200, 200, 100, 100);
    [self.view addSubview:v2];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleTapRightBarButton)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleTapLeftBarButton)];
    
}

-(void)handleTapRightBarButton
{
    UIView *v1 = [UIView new];
    v1.backgroundColor = [UIColor redColor];
//    v1.frame = CGRectMake(100, 100, 100, 100);
    v1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetHeight(self.view.bounds), 100, 100);
//    self.v1 = v1;
    [LGBDisplay displayView:v1 inViewController:self.navigationController backgroundBlurValue:5 showBlock:^(UIView *backgroundView, UIView *maskView) {
        
        maskView.alpha = 0;
//        maskView.backgroundColor = [UIColor clearColor];
//        maskView.superview insertSubview:<#(nonnull UIView *)#> aboveSubview:<#(nonnull UIView *)#>
        v1.alpha = 0;
        
//        v1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetHeight(self.view.bounds), 100, 100);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            maskView.alpha = 1;
            v1.alpha = 1;
            backgroundView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            v1.transform = CGAffineTransformMakeTranslation(0, -100);
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//            v1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetHeight(self.view.bounds) - 100, 100, 100);
        } completion:^(BOOL finished) {
            
        }];
    } tapMaskBlock:^(UIView *backgroundView, UIView *maskView) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            maskView.alpha = 0;
            v1.alpha = 0;
            v1.transform = CGAffineTransformIdentity;
            backgroundView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [LGBDisplay dismissView:v1];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }];
        
    }];
}

-(void)handleTapLeftBarButton
{

}

-(UIImage *)snapshotFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
