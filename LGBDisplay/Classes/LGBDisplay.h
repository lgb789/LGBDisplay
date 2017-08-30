//
//  LGBDisplay.h
//  Pods
//
//  Created by mac_256 on 2017/8/29.
//
//

#import <Foundation/Foundation.h>

@interface LGBDisplay : NSObject

+(void)displayView:(UIView *)view inViewController:(UIViewController *)controller showBlock:(void(^)(UIView *maskView))showBlock tapMaskBlock:(void(^)(UIView *maskView))maskBlock;

+(UIView *)maskForView:(UIView *)view;

+(void)dismissView:(UIView *)view;

@end
