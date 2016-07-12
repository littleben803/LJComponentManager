//
//  LJModuleAXXXItemPrt.h
//  LJComponentManager
//
//  Created by phoenix on 16/7/5.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @protocol LJModuleAXXXItemPrt (model协议)
 *  ModuleA对外开放的xxxItem，将数据向外传递，或者将数据通过参数传入调用服务
 */
@protocol LJModuleAXXXItemPrt <NSObject>

@required

@property(nonatomic, readwrite) NSString *__nonnull itemName;
@property(nonatomic, readwrite) int itemAge;

- (nonnull NSString *)description;

@optional
- (nonnull instancetype)initWithItemName:(nonnull NSString *)itemName
                                 itemAge:(int)itemAge;


@end
