//
//  LJCMTipViewController.h
//  LJComponentManager
//
//  Created by phoenix on 16/7/4.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJCMTipViewController : UIViewController

@property (nonatomic, readonly) BOOL isparamsError;
@property (nonatomic, readonly) BOOL isNotURLSupport;
@property (nonatomic, readonly) BOOL isNotFound;

+ (nonnull UIViewController *)paramsErrorTipController;

+ (nonnull UIViewController *)notURLTipController;

+ (nonnull UIViewController *)notFoundTipConctroller;

- (void)showDebugTipController:(nonnull NSURL *)URL
               withParameters:(nullable NSDictionary *)parameters;

@end
