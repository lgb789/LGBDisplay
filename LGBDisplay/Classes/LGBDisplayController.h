//
//  LGBDisplayController.h
//  Pods
//
//  Created by mac_256 on 2017/8/29.
//
//

#import <UIKit/UIKit.h>

typedef void(^DisplayTapBackgroundBlock)(UIView *backgroundView);
typedef void(^DisplayShowBlock)(UIView *backgroundView);

@interface LGBDisplayController : UIViewController

@property (nonatomic, copy) DisplayTapBackgroundBlock backgroundTap;
@property (nonatomic, copy) DisplayShowBlock showBlock;

-(void)displayView:(UIView *)view inViewController:(UIViewController *)controller;

-(void)dismiss;

@end
