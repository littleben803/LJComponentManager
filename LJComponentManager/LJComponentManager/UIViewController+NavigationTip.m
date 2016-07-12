//
//  UIViewController+NavigationTip.m
//  LJComponentManager
//
//  Created by phoenix on 16/7/4.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "UIViewController+NavigationTip.h"
#import "LJCMTipViewController.h"

@implementation UIViewController (NavigationTip)

+(nonnull UIViewController *)lj_paramsError {
    
    return [LJCMTipViewController paramsErrorTipController];
}

+(nonnull UIViewController *)lj_notURLController {
    
    return [LJCMTipViewController notURLTipController];
}

+(nonnull UIViewController *)lj_notFound {
    
    return [LJCMTipViewController notFoundTipConctroller];
}

@end
