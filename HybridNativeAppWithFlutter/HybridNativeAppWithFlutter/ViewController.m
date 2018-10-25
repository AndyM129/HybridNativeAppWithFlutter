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
    __weak __typeof(self) weakSelf = self;

    FlutterViewController *flutterViewController = [[FlutterViewController alloc] init];
    
    
    // 要与main.dart中一致
    NSString *channelName = @"com.pages.your/native_get";
    
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@",call.method,call.arguments);
        
        if ([call.method isEqualToString:@"toNativeSomething"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter回调" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
            // 回调给flutter
            if (result) {
                result(@1000);
            }
        } else if ([call.method isEqualToString:@"isHybrid"]) {
            result==nil ?: result(@YES);
        } else if ([call.method isEqualToString:@"toNativePush"]) {
            UIViewController *testViewController = [[UIViewController alloc] init];
            testViewController.view.backgroundColor = [UIColor orangeColor];
            [weakSelf.navigationController pushViewController:testViewController animated:YES];
        } else if ([call.method isEqualToString:@"toNativePop"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    // 指定前往的flutter页面，不指定则为flutter main.dart中的指定的首页页面
    [flutterViewController setInitialRoute:@"/Home"];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];
    //[self presentViewController:flutterViewController animated:YES completion:nil];
}

@end
