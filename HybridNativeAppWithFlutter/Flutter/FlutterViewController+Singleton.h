//
//  FlutterViewController+Singleton.h
//  HybridNativeAppWithFlutter
//
//  Created by 孟昕欣 on 2018/10/25.
//  Copyright © 2018年 org.andym129.ios. All rights reserved.
//

#import <Flutter/Flutter.h>

/** 单例扩展 */
@interface FlutterViewController (Singleton)
@property(nonatomic, strong, readonly, class) FlutterViewController *sharedInstance;
@end
