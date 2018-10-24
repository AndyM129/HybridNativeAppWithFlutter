//
//  ViewController.m
//  HybridNativeAppWithFlutter
//
//  Created by 孟昕欣 on 2018/10/23.
//  Copyright © 2018年 org.andym129.ios. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HybridNativeAppWithFlutter";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 20, 40.0);
    button.center = self.view.center;
    [button addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Click to Goto Flutter Page" forState:UIControlStateNormal];
    [button setBackgroundColor:self.view.tintColor];
    [self.view addSubview:button];
}

- (void)handleButtonAction {
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] init];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}

@end
