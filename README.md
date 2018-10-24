# 如何在现有的iOS工程中接入Flutter（详见[原文](https://www.jianshu.com/p/af085d4420fd)）

> 1. 本文是参考 **[官方文档](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#ios)**，加上自己的爬坑经验，总结出的，供大家参考~
> 2. 关于Flutter的[环境安装](https://flutterchina.club/get-started/install/)、[IDE配置](https://flutterchina.club/get-started/editor/)，请参看[**Flutter中文网**](https://flutterchina.club)

## 开发环境

### Flutter
- Dart：v2.0.0
- Flutter：Flutter Release Preview 2
  engine.version = 38a646e14cc25f5a56a989c6a5787bf74e0ea386
- IDE：Android Studio

### iOS
- Objective-C/Swift：Objective-C
- Xcode：Version 9.4.1 (9F2000)

## 一、[创建Flutter模块](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#create-a-flutter-module-1)

假设你有一个iOS工程，路径为 `~/Work/Projects/HybridNativeAppWithFlutter`（如下图）

![图片](http://upload-images.jianshu.io/upload_images/294630-9c974b3a704ffaa4?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在该工程路径下，创建Flutter模块:
```
cd ~/Work/Projects
flutter create -t module flutter_module
```

> **注1：** Flutter模块的创建路径 **务必** 在 `xxx.xcodeproj`工程文件的上一级目录
> 例：当前工程文件路径为`~/Work/Projects/HybridNativeAppWithFlutter/HybridNativeAppWithFlutter.xcodeproj`，
> 则Flutter模块的创建路径必须是`~/Work/Projects/HybridNativeAppWithFlutter`
> <br/>
>  **注2：** 当前笔者是通过 Android Studio 开发Flutter，无法直接创建iOS的Flutter模块（如下图，后续可能会支持），所以建议用官方的方式，通过如上命令来创建
> ![图片](http://upload-images.jianshu.io/upload_images/294630-d0bc35e3d9f16ab1?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 二、[创建依赖](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#make-the-host-app-depend-on-the-flutter-module-1)

等待片刻后，终端会输出图左内容，工程目录下会变成图右样子：

![图片](http://upload-images.jianshu.io/upload_images/294630-c6ef459cdad76691?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 1. [在Podfile文件中添加Flutter app](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#add-your-flutter-app-to-your-podfile)

`Flutter framework` 需要通过CocoaPods来管理依赖，假设当前项目已经使用了CocoaPods，则直接在 iOS 工程的`Podfile`文件中加上如下两句话：

```
flutter_application_path = '../flutter_module'
eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
```

> **注1：**如果当前项目没有使用CocoaPods，请先参考[CocoaPods官网](https://cocoapods.org/) 或 [《CocoaPods安装方法》](https://www.jianshu.com/p/f43b5964f582)进行安装；
> <br/>
> **注2：**完整的Podfile文件如下：
>
> ```ruby
> source 'https://github.com/CocoaPods/Specs.git'
> platform :ios, '9.0'
> inhibit_all_warnings!
> 
> target 'HybridNativeAppWithFlutter' do
> end
> 
> flutter_application_path = '../flutter_module'
> eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
> 
> ```

然后：
```
pod install
```


### 2.[在Xcode工程中添加Dart代码的build phase](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#add-a-build-phase-for-building-the-dart-code)

如下图，在Xcode工程中，选择`TARGET -> Build Phases -> +号 -> New Run Script Phase`，然后将如下命令粘贴到文本框中，最后通过快捷键`⌘B`编译：

```
$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
```

![图片](http://upload-images.jianshu.io/upload_images/294630-f9505ad19a54a512?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> **注：**务必保证`Run  Script`在`Target Dependencies phase`后面

## 三、[在iOS项目中，通过`FlutterViewController`跳转至Flutter页面](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#write-code-to-use-flutterviewcontroller-from-your-host-app)

参考如下代码，修改你的工程文件：

### AppDelegate.h/m

- AppDelegate.h
  ```
  #import <UIKit/UIKit.h>
  #import <Flutter/Flutter.h>
  
  @interface AppDelegate : FlutterAppDelegate
  
  @end
  ```

- AppDelegate.m

  ```
  #import "AppDelegate.h"
  #import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h> // Only if you have Flutter Plugins
  
  @interface AppDelegate () @end
  
  @implementation AppDelegate
  
  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      [GeneratedPluginRegistrant registerWithRegistry:self];
      return [super application:application didFinishLaunchingWithOptions:launchOptions];
  }
  
  @end
  ```

### ViewController.h/m

- ViewController.h
  ```
  #import <UIKit/UIKit.h>
  
  @interface ViewController : UIViewController
  
  @end
  
  ```

- ViewController.m

  ```
  #import "ViewController.h"
  #import <Flutter/Flutter.h>
  
  @interface ViewController ()
  
  @end
  
  @implementation ViewController
  
  - (void)viewDidLoad {
      [super viewDidLoad];
      self.view.backgroundColor = [UIColor lightGrayColor];
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button addTarget:self action:@selector(handleButtonAction)
       forControlEvents:UIControlEventTouchUpInside];
      [button setTitle:@"Press me" forState:UIControlStateNormal];
      [button setBackgroundColor:[UIColor blueColor]];
      button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
      [self.view addSubview:button];
  }
  
  - (void)handleButtonAction {
      FlutterViewController *flutterViewController = [[FlutterViewController alloc] init];
      flutterViewController.view.backgroundColor = [UIColor cyanColor];
      [flutterViewController setInitialRoute:@"route1"];
      [self presentViewController:flutterViewController animated:YES completion:nil];
  }
  
  @end
  ```

此时，如果直接运行、点击按钮后，会看到控制台的报错，并且页面也没有任何内容显示：
![图片](http://upload-images.jianshu.io/upload_images/294630-e9be328073a53f1c?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中，重要的两行提示：
```
2018-10-23 22:48:48.990075+0800 HybridNativeAppWithFlutter[37728:5932375] Failed to find assets path for "flutter_assets"
2018-10-23 22:48:49.057530+0800 HybridNativeAppWithFlutter[37728:5932574] [VERBOSE-2:engine.cc(114)] Engine run configuration was invalid.

```

所以，我们要把`flutter_assets`和`Flutter.framework`给加入项目中：
![图片](http://upload-images.jianshu.io/upload_images/294630-1bd34d5df8aaa3cd?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 注意：`flutter_assets`不能使用 `Create groups` 的方式添加，只能使用 `Creat folder references` 的方式添加进Xcode项目内，否则跳转flutter会页面渲染失败（页面空白）
![图片](http://upload-images.jianshu.io/upload_images/294630-1a900ef3af35b9fc?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


至此，就已经完成了 **在现有的iOS工程中接入Flutter** 的所有流程~~
|运行后的画面 | 点击按钮，跳转至Flutter页面 | 
|:---:|:---:|
| ![图片](http://upload-images.jianshu.io/upload_images/294630-ff6c21b9e0db4e02?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) | ![图片](http://upload-images.jianshu.io/upload_images/294630-b291f9ec820e6012?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) | 


## 四、[热启动/热加载 与 Dart代码调试](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#hot-restartreload-and-debugging-dart-code-1)

连接真机或是启动模拟器，可以通过如下命令连通Flutter&iOS项目，实现 **热启动/热加载**：

```
cd ~/Work/Projects/flutter_module 
flutter attach
```

此时输入`r`可热加载，`q`退出，执行效果如下图：
![图片](http://upload-images.jianshu.io/upload_images/294630-6a13832d8b1392cf?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


----

参考文档：

- 官网 Add Flutter to existing apps：https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps
- iOS Native混编Flutter交互实践：https://www.jianshu.com/p/5f4aaa72d509

## 下载代码

该示例工程下载地址：https://github.com/AndyM129/HybridNativeAppWithFlutter

> **【友情提示】** 
> ![图片](http://upload-images.jianshu.io/upload_images/294630-cbd4f85ccf7e994d?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> 在拉取代码后，若直接运行iOS工程，可能会报如上错误。
> <br/>
> 
> **原因：**`~/Work/HybridNativeAppWithFlutterDemo/flutter_module/.ios/Flutter/Generated.xcconfig`路径下的相关配置中 路径错了（如下图）
> ![图片](http://upload-images.jianshu.io/upload_images/294630-630d284b08d8f4de?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>
> **解决方法是：**先运行下 Flutter项目，然后就可以了

## 后话

本文原文地址（建议浏览，会及时更新）：[https://www.jianshu.com/p/af085d4420fd](https://www.jianshu.com/p/af085d4420fd)


如果你有好的 idea 或 疑问，请随时提 issue 或 request。

如果你在开发过程中遇到什么问题，或对iOS开发有着自己独到的见解，再或是你与我一样同为菜鸟，都可以关注或私信我的微博。

- 微信：Andy_129
- 微博：[@Developer_Andy](http://weibo.com/u/5271489088)
- 简书：[Andy__M](http://www.jianshu.com/users/28d89b68984b)

>“Stay hungry. Stay foolish.”

共勉~
