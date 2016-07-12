//
//  LJConnectorA.m
//  LJComponentManager
//
//  Created by phoenix on 16/7/5.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "LJConnectorA.h"
// 每个业务组件的connector依赖ComponentManager
#import "LJComponentManager.h"
// 每个业务组件依赖它对外开放的service协议头文件
#import "LJModuleAXXXServicePrt.h"
// 每个业务组件的connetor依赖业务组件具体实现
#import "LJModuleADetailViewController.h"
// 业务组件内部的协议模型
#import "LJModuleAXXXItem.h"

/**
 *  说明：对外开放的service协议可以不在connector中实现，可以放到其他具体的服务实现类中，只需要在连接的时候根据协议名称返回服务实现类的实例即可
 */
@interface LJConnectorA ()<LJModuleAXXXServicePrt> {
    
}

@end


@implementation LJConnectorA

#pragma mark - 注册connector

/**
 *  每个组件的实现必须自己通过load完成挂载；load只需要在挂载connector的时候完成当前connecotor的初始化，挂载量、挂载消耗、挂载所耗内存都在可控范围内
 */
+ (void)load {
    
    @autoreleasepool {
        
        [LJComponentManager registerConnector:[self getInstance]];
    }
}

/**
 *  单例
 */
+ (nonnull LJConnectorA *)getInstance {
    
    static LJConnectorA *sharedConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedConnector = [[LJConnectorA alloc] init];
    });
    
    return sharedConnector;
}


#pragma mark - LJCMConnectorPrt 中间件接入协议

/**
 *  当前业务组件可导航的URL询问判断
 *  (1)当调用方需要通过判断URL是否可导航显示界面的时候，告诉调用方该组件实现是否可导航URL；可导航，返回YES，否则返回NO
 *  (2)这个方法跟connectToOpenURL:params配套实现；如果不实现，则调用方无法判断某个URL是否可导航
 */

- (BOOL)canOpenURL:(nonnull NSURL *)URL {

    if ([URL.host isEqualToString:@"ModuleADetail"]) {
        return YES;
    }
    
    return NO;
}

/**
 *  业务模块挂接中间件，注册自己能够处理的URL，完成url的跳转；
 *  (1)通过connector向componentManager挂载可导航的URL，具体解析URL的host还是path，由connector自行决定；
 *  (2)如果URL在本业务组件可导航，则从params获取参数，实例化对应的viewController进行返回；如果参数错误，则返回一个错误提示的[UIViewController paramsError]; 如果不需要中间件进行present展示，则返回一个[UIViewController notURLController],表示当前可处理；如果无法处理，返回nil，交由其他组件处理；
 *  (3)需要在connector中对参数进行验证，不同的参数调用生成不同的ViewController实例；也可以通过参数决定是否自行展示，如果自行展示，则用户定义的展示方式无效；
 *  (4)如果挂接的url较多，这里的代码比较长，可以将处理方法分发到当前connector的category中；
 */
- (nullable UIViewController *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params {
    
    // 处理scheme://ModuleADetail的方式
    // tip: url较少的时候可以通过if-else去处理，如果url较多，可以自己维护一个url和ViewController的map，加快遍历查找，生成viewController；
    if ([self canOpenURL:URL]) {
        
        LJModuleADetailViewController *viewController = [[LJModuleADetailViewController alloc] init];
        if (params[@"key"] != nil) {
            
            viewController.valueLabel.text = params[@"key"];
        } else if(params[@"image"]) {
            
            id imageObj = params[@"image"];
            if (imageObj && [imageObj isKindOfClass:[UIImage class]]) {
                
                viewController.valueLabel.text = @"this is image";
                viewController.imageView.image = params[@"image"];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
                return [UIViewController lj_notURLController];
            } else {
                
                viewController.valueLabel.text = @"no image";
                viewController.imageView.image = [UIImage imageNamed:@"noImage"];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
                return [UIViewController lj_notURLController];
            }
        } else {
            // nothing to do
        }
        return viewController;
    }
    
    
    else {
        // nothing to to
    }
    
    return nil;
}


/**
 *  业务模块挂接中间件，注册自己提供的service，实现服务接口的调用
 *
 * （1)通过connector向BusMediator挂接可处理的Protocol，根据Protocol获取当前组件中可处理protocol的服务实例；
 *  (2)具体服务协议的实现可放到其他类实现文件中，只需要在当前connetor中引用，返回一个服务实例即可；
 *  (3)如果不能处理，返回一个nil；
 */
- (nullable id)connectToHandleProtocol:(nonnull Protocol *)servicePrt {
    
    if (servicePrt == @protocol(LJModuleAXXXServicePrt)) {
        
        // 具体服务协议的实现可放到其他类实现文件中，这边只要返回该服务的实例即可
        return [[self class] getInstance];
    }
    return nil;
}


#pragma mark - LJModuleAXXXServicePrt 对外提供的协议接口

/**
 * 下面三个接口都是组件A向外提供服务的协议实现，当前的服务接口都是同步的，如果是异步回调要注意在服务显示中对多线程进行兼容处理（主要是Block的对应）；
 */

// 服务接口1: 传入Message显示一个alert，并提供cancel和confirm的回调
- (void)showAlertWithMessage:(nonnull NSString *)message
                cancelAction:(void(^__nullable)(NSDictionary *__nonnull info))cancelAction
               confirmAction:(void(^__nullable)(NSDictionary *__nonnull info))confirmAction {
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (cancelAction) {
            
            cancelAction(@{@"alertAction":action});
        }
    }];
    
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (confirmAction) {
            
            confirmAction(@{@"alertAction":action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ModuleA的服务接口1" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAlertAction];
    [alertController addAction:confirmAlertAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

// 服务接口2: 组件A给外部组件提供一个协议化对象
- (nonnull id<LJModuleAXXXItemPrt>)getItemWithName:(nonnull NSString *)name
                                               age:(int)age {
    
    LJModuleAXXXItem * item = [[LJModuleAXXXItem alloc] initWithItemName:name itemAge:age];
    return item;
}

// 服务接口3: 外部组件给组件A传入一个协议化对象
- (void)deliveAprotocolModel:(nonnull id<LJModuleAXXXItemPrt>)item {

    NSString *showText = [item description];
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"向ModuleA传入模型对象" message:showText preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAlertAction];
    [alertController addAction:confirmAlertAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


@end
