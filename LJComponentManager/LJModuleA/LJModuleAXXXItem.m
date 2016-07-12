//
//  LJModuleAXXXItem.m
//  LJComponentManager
//
//  Created by phoenix on 16/7/5.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "LJModuleAXXXItem.h"

/**
 *  注意：协议对象中对协议中定义的property需要提供setter或getter方法；其实就是协议中定义setter和getter方法，必须在协议对象中来实现；
 */
@implementation LJModuleAXXXItem

@synthesize itemName = _itemName;
@synthesize itemAge = _itemAge;

- (nonnull instancetype)initWithItemName:(nonnull NSString *)itemName
                                 itemAge:(int)itemAge {
    self = [self init];
    if (self) {
        
        self.itemName = itemName;
        self.itemAge = itemAge;
    }
    return self;
}


- (nonnull NSString *)description {
    
    NSString *description = [NSString stringWithFormat:@"MduleA: itemName == %@, itemAge == %d", self.itemName, self.itemAge];
    return description;
}


@end
