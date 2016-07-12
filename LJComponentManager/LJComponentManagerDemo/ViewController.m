//
//  ViewController.m
//  LJComponentManager
//
//  Created by phoenix on 16/7/1.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "ViewController.h"
#import "LJComponentManager.h"
#import "LJModuleAXXXServicePrt.h"
#import "LJModuleAXXXItem.h"

/**
 * 用于满足配置到TabController的URL-Controller的直接share跳转
 * 任何URL-Controller均可以配置到TabController中
 * 业务端routeURL跳转时，如果URL对应的controller在tabController中，直接跳转到对应Tab
 * tip: 注意配置到tabController中的Controller所属Class不能重复
 */
static NSMutableDictionary *rootTabClassesDic = nil;

NSString * const kCellIdentifier = @"kCellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"消息";
        self.tabBarItem.title = @"消息";
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_mainframe"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect rect = self.view.bounds;
    self.tableView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //LDBusMediator Call
    if (indexPath.row == 0) {
        
        //presentViewController
        [LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail"] withParameters:@{kLJRouteModeKey: @(ELJNavigationModePresent)}];
    }
    
    if (indexPath.row == 1) {
        
        [[LJNavigator getInstance] setHookRouteBlock:nil];
        //[LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail"]];
        [LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail"] withParameters:@{@"key": @"王小虎你好"}];
    }
    
    if (indexPath.row == 2) {
        
        [LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail"] withParameters:@{@"image": [UIImage imageNamed:@"image"]}];
    }
    
    if (indexPath.row == 3) {
        
        [LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail"] withParameters:@{@"image": @""}];
    }
    
    if (indexPath.row == 4) {
        
        [[LJComponentManager serviceForProtocol:@protocol(LJModuleAXXXServicePrt)] showAlertWithMessage:@"王小虎最帅" cancelAction:nil confirmAction:^(NSDictionary *info) {
            
            NSLog(@"%@", info);
        }];
    }
    
    if(indexPath.row == 5) {
        
        id<LJModuleAXXXItemPrt> item = [[LJComponentManager serviceForProtocol:@protocol(LJModuleAXXXServicePrt)] getItemWithName:@"王小虎" age:33];
        [[LJComponentManager serviceForProtocol:@protocol(LJModuleAXXXServicePrt)] showAlertWithMessage:[item description] cancelAction:nil confirmAction:nil];
    }
    
    if (indexPath.row == 6) {
        
        LJModuleAXXXItem *item = [[LJModuleAXXXItem alloc] init];
        item.itemName = @"王小虎";
        item.itemAge = 33;
        [[LJComponentManager serviceForProtocol:@protocol(LJModuleAXXXServicePrt)] deliveAprotocolModel:item];
    }
    
    if (indexPath.row == 7) {
        
        // 测试notURLController
        UIViewController *controller = [LJComponentManager viewControllerForURL:[NSURL URLWithString:@"productScheme://ModuleADetail"] withParameters:@{@"image": @""}];
        
        if (controller) {
            
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
    // 测试hookURLRouteBlock
    if (indexPath.row == 8) {
        
        [self setURLHookRouteBlock];
        [LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail"]];
    }
    
    // 测试无法找到url的tip提示
    if (indexPath.row == 9) {
        
        [LJComponentManager routeURL:[NSURL URLWithString:@"productScheme://ModuleADetail1111"]];
    }
}

#pragma mark - getters and setters

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = @[@"present detail view controller", @"push detail view controller", @"present image", @"present image when error", @"service: show alert", @"service:get protcol model", @"service: set protocol model", @"get url controller", @"route url with hook", @"route url not found"];
    }
    return _dataSource;
}

#pragma mark - test hook route URL

- (void)setURLHookRouteBlock {
    
    [[LJNavigator getInstance] setHookRouteBlock:^BOOL(UIViewController * _Nonnull controller, UIViewController * _Nullable baseViewController, ELJNavigationMode routeMode) {
        
        UIViewController *tabController = [self isViewControllerInTabContainer:controller];
        if (tabController) {
            
            [[LJNavigator getInstance] showURLController:tabController baseViewController:baseViewController routeMode:ELJNavigationModeShare];
            return YES;
        } else {
            
            return NO;
        }
    }];
}

- (UIViewController *)isViewControllerInTabContainer:(UIViewController *)controller {
    if (rootTabClassesDic == nil) {
        
        rootTabClassesDic = [[NSMutableDictionary alloc] initWithCapacity:2];
        UIViewController *rootViewContoller = [UIApplication sharedApplication].delegate.window.rootViewController;
        if (rootViewContoller && [rootViewContoller isKindOfClass:[UITabBarController class]]) {
            
            NSArray *tabControllers = ((UITabBarController *)rootViewContoller).viewControllers;
            [tabControllers enumerateObjectsUsingBlock:^(UIViewController *_Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([viewController isKindOfClass:[UINavigationController class]]) {
                    
                    viewController = [((UINavigationController *)viewController).viewControllers objectAtIndex:0];
                }
                
                [rootTabClassesDic setObject:viewController forKey:NSStringFromClass([viewController class])];
            }];
        }
    }
    
    if (rootTabClassesDic && rootTabClassesDic.count > 0) {
        
        NSString *controllerKey = NSStringFromClass([controller class]);
        if (controllerKey) {
            
            return [rootTabClassesDic objectForKey:controllerKey];
        } else {
            
            return nil;
        }
    } else {
        
        return nil;
    }
}

@end
