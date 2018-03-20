//
//  LGBDisplay.h
//  Pods
//
//  Created by mac_256 on 2017/8/29.
//
//

#import <Foundation/Foundation.h>

@interface LGBDisplay : NSObject

/**
 在viewcontorller中显示view

 @param view 要显示的view
 @param controller viewcontorller，当为nil是，view在当前window显示
 @param blurValue 模糊值，当大于0是有模糊效果，值越大越模糊
 @param showBlock 当显示view时会执行此block
 @param maskBlock 当点击mask时，会执行此block
 */
+(void)displayView:(UIView *)view inViewController:(UIViewController *)controller backgroundBlurValue:(CGFloat)blurValue showBlock:(void(^)(UIView *backgroundView, UIView *maskView))showBlock tapMaskBlock:(void(^)(UIView *backgroundView, UIView *maskView))maskBlock;

+(UIView *)maskForView:(UIView *)view;

/**
 不显示view

 @param view 已经显示的view
 */
+(void)dismissView:(UIView *)view;

@end
