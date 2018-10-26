//
//  FlutterViewController+Singleton.m
//  HybridNativeAppWithFlutter
//
//  Created by 孟昕欣 on 2018/10/25.
//  Copyright © 2018年 org.andym129.ios. All rights reserved.
//

#import "FlutterViewController+Singleton.h"

@implementation FlutterViewController (Singleton)

+ (FlutterViewController *)sharedInstance {
    static FlutterViewController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[FlutterViewController alloc] init];
    });
    return _sharedInstance;
}

@end
