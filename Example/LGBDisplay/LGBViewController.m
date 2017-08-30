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
    
    UIView *v2 = [UIView new];
    v2.backgroundColor = [UIColor greenColor];
    v2.frame = CGRectMake(200, 200, 100, 100);
    [self.view addSubview:v2];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleTapRightBarButton)];
}

-(void)handleTapRightBarButton
{
    UIView *v1 = [UIView new];
    v1.backgroundColor = [UIColor redColor];
//    v1.frame = CGRectMake(100, 100, 100, 100);
    v1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetHeight(self.view.bounds), 100, 100);
    self.v1 = v1;
    [LGBDisplay displayView:v1 inViewController:self.navigationController showBlock:^(UIView *maskView) {
        maskView.alpha = 0;
//        maskView.backgroundColor = [UIColor clearColor];
        v1.alpha = 0;
        
//        v1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetHeight(self.view.bounds), 100, 100);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            maskView.alpha = 1;
            v1.alpha = 1;
            v1.transform = CGAffineTransformMakeTranslation(0, -100);
//            v1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetHeight(self.view.bounds) - 100, 100, 100);
        } completion:^(BOOL finished) {
            
        }];
    } tapMaskBlock:^(UIView *maskView) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            maskView.alpha = 0;
            v1.alpha = 0;
            v1.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [LGBDisplay dismissView:v1];
        }];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
