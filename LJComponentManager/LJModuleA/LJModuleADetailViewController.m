//
//  LJModuleADetailViewController.m
//  LJComponentManager
//
//  Created by phoenix on 16/7/5.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "LJModuleADetailViewController.h"

@interface LJModuleADetailViewController ()

@property (nonatomic, strong, readwrite) UILabel *valueLabel;
@property (nonatomic, strong, readwrite) UIImageView *imageView;

@property (nonatomic, strong) UIButton *returnButton;

@end

@implementation LJModuleADetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"ModuleADetail";
    }
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.returnButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect rect = self.view.bounds;
    
    CGRect valueLabelRect = rect;
    valueLabelRect.size.height = 60;
    valueLabelRect = CGRectOffset(valueLabelRect, 0, 44 + 20 + 10);
    valueLabelRect = CGRectInset(valueLabelRect, 10, 10);
    self.valueLabel.backgroundColor = [UIColor yellowColor];
    self.valueLabel.frame = valueLabelRect;
    
    CGRect imageViewRect = valueLabelRect;
    imageViewRect.size.height = 200;
    imageViewRect = CGRectOffset(imageViewRect, 0, valueLabelRect.size.height + 20);
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.frame = imageViewRect;
    
    CGRect returnBtnRect = imageViewRect;
    returnBtnRect.size.height = 40;
    returnBtnRect = CGRectOffset(returnBtnRect, 0, imageViewRect.size.height + 20);
    //self.returnButton.backgroundColor = [UIColor blueColor];
    self.returnButton.frame = returnBtnRect;
}

#pragma mark - event response

- (void)didTappedReturnButton:(UIButton *)button {
    
    if (self.navigationController == nil) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
        if (self.parentViewController) {
            
            [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - getters and setters

- (UILabel *)valueLabel
{
    if (_valueLabel == nil) {
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont systemFontOfSize:32];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = [UIColor blackColor];
    }
    return _valueLabel;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)returnButton
{
    if (_returnButton == nil) {
        
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_returnButton setTitle:@"返回" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _returnButton;
}

@end
