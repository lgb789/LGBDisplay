//
//  LGBDisplay.m
//  Pods
//
//  Created by mac_256 on 2017/8/29.
//
//

#import "LGBDisplay.h"
#import "LGBDisplayController.h"

static NSMutableDictionary *__displayDic;

@implementation LGBDisplay

#pragma mark ------------------------------------------------- 初始化 ---------------------------------------------------
+(void)load
{
    __displayDic = [NSMutableDictionary dictionary];
}
#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------
+(void)displayView:(UIView *)view inViewController:(UIViewController *)controller showBlock:(void(^)(UIView *maskView))showBlock tapMaskBlock:(void(^)(UIView *maskView))maskBlock
{
    if (!view) {
        return;
    }
    
    [self dismissView:view];
    
    LGBDisplayController *displayController = [LGBDisplayController new];
    displayController.backgroundTap = maskBlock;
    displayController.showBlock = showBlock;
    
    [displayController displayView:view inViewController:controller];
    
    [__displayDic setObject:displayController forKey:[NSValue valueWithNonretainedObject:view]];
    
    
}
+(UIView *)maskForView:(UIView *)view
{
    LGBDisplayController *displayController = [__displayDic objectForKey:[NSValue valueWithNonretainedObject:view]];
    if (displayController) {
        return displayController.backgroundView;
    }
    
    return nil;
}

+(void)dismissView:(UIView *)view
{
    if (!view) {
        return;
    }
    
    NSValue *key = [NSValue valueWithNonretainedObject:view];
    
    LGBDisplayController *displayController = [__displayDic objectForKey:key];
    
    if (displayController) {
        [__displayDic removeObjectForKey:key];
        [displayController dismiss];
    }
}
#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end
