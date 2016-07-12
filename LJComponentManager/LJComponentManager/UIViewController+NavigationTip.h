//
//  UIViewController+NavigationTip.h
//  LJComponentManager
//
//  Created by phoenix on 16/7/4.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @category NavigationTip
 *  中间件导航的错误提示
 */
@interface UIViewController (NavigationTip)

/**
 * URL可导航，参数错误无法生成ViewController
 */
+(nonnull UIViewController *)lj_paramsError;

/**
 * URL可导航，但是提供者并没有对URL返回一个ViewController
 */
+(nonnull UIViewController *)lj_notURLController;


/**
 * URL不可导航，提示用户无法通过LJComponentManager导航
 */
+(nonnull UIViewController *)lj_notFound;


@end

