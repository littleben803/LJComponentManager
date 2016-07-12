//
//  LJNavigator.h
//  LJComponentManager
//
//  Created by phoenix on 16/7/4.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ELJNavigationMode) {
    
    ELJNavigationModeNone = 0,
    ELJNavigationModePush,     //push a viewController in NavigationController
    ELJNavigationModePresent,  //present a viewController in NavigationController
    ELJNavigationModeShare     //pop to the viewController already in NavigationController or tabBarController
};


/**
 *  @class LJNavigator
 *  ComponentManager内在支持的的导航器
 */
@interface LJNavigator : NSObject

/**
 * 单例
 */
+ (nonnull LJNavigator *)getInstance;

/**
 * 设置通用的拦截跳转方式；
 */
- (void)setHookRouteBlock:(BOOL (^__nullable)(UIViewController *__nonnull controller, UIViewController *__nullable baseViewController, ELJNavigationMode routeMode))routeBlock;

/**
 * 在BaseViewController下展示URL对应的Controller
 *  @param controller   当前需要present的Controller
 *  @param baseViewController 展示的BaseViewController
 *  @param routeMode  展示的方式
 */
- (void)showURLController:(nonnull UIViewController *)controller
       baseViewController:(nullable UIViewController *)baseViewController
                routeMode:(ELJNavigationMode)routeMode;

@end



/**
 * 外部不能调用该类别中的方法，仅供Busmediator中调用
 */
@interface LJNavigator (HookRouteBlock)

- (void)hookShowURLController:(nonnull UIViewController *)controller
           baseViewController:(nullable UIViewController *)baseViewController
                    routeMode:(ELJNavigationMode)routeMode;

@end
