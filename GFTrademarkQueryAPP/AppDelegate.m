//
//  AppDelegate.m
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "AppDelegate.h"
#import "GFTabbarController.h"
#import "GFLeftController.h"

#pragma mark -ShareSDK的引用
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//人人SDK头文件
//#import <RennSDK/RennSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:2];  //设置启动界面时间为3秒
    //[self addAdvertisement];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor =[UIColor whiteColor];
    
    GFLeftController *leftVc =[[GFLeftController alloc]init];
    
    //_recognitionNavigation = [[UINavigationController alloc]initWithRootViewController:leftVc];
//    leftVc.viewControllers = @[w];
    //UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:leftVc]
    
    GFTabbarController *mainVc =[[GFTabbarController alloc]init];
    GFSlideController *gfSlideVc =[GFSlideController initWithLeftVC:leftVc mainVc:mainVc];
    
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:gfSlideVc];
    
    self.window.rootViewController = gfSlideVc;
    self.gfSlideVc = gfSlideVc;
    self.window.backgroundColor =[UIColor whiteColor];
    NSLog(@"加载完成！");
/*
    /**初始化ShareSDK应用
     *  @param activePlatforms          使用的分享平台集合，如:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeTencentWeibo)];
     *  @param importHandler            导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作。具体的导入方式可以参考ShareSDKConnector.framework中所提供的方法。
     *  @param configurationHandler     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeMail),
                                        @(SSDKPlatformTypeSMS),
                                        @(SSDKPlatformTypeCopy),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        //@(SSDKPlatformTypeRenren),
                                        //@(SSDKPlatformTypeFacebook),
                                        //@(SSDKPlatformTypeTwitter),
                                        //@(SSDKPlatformTypeGooglePlus)
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
//             case SSDKPlatformTypeRenren:
//                 [ShareSDKConnector connectRenren:[RennClient class]];
//                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {

         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
//             case SSDKPlatformTypeRenren:
//                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
//                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
//                                               authType:SSDKAuthTypeBoth];
//                 break;
             case SSDKPlatformTypeFacebook:
                 [appInfo SSDKSetupFacebookByApiKey:@"107704292745179"
                                          appSecret:@"38053202e1a5fe26c80c753071f0b573"
                                        displayName:@"shareSDK"
                                           authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeTwitter:
                 [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
                                         consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
                                            redirectUri:@"http://mob.com"];
                 break;
             case SSDKPlatformTypeGooglePlus:
                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                            redirectUri:@"http://localhost"];
                 break;
             default:
                 break;
         }
     }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
-(void)addAdvertisement{
    // 大背景
    //UIView *bgView = [[UIView alloc] init];
    UIView *adView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:adView];
    adView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //UIViewController *viewVC = [[UIViewController alloc]init];
    
    UIImageView  *Imageview= [[UIImageView  alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [adView addSubview:Imageview];
    //这一步是获取上次网络请求下来的图片，如果存在就展示该图片，如果不存在就展示本地保存的名为test的图片
    NSMutableData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageu"];
    if (data.length>0) {
        Imageview.image = [UIImage imageWithData:data];
    }else{
        
        Imageview.image = [UIImage imageNamed:@"雅庭国际广场.jpg"];
    }
    //下面这段代码，是调用AFN下载文件的方法，异步
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:@"http://s16.sinaimg.cn/large/005vePOgzy70Rd3a9pJdf&690"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        NSData * image = [NSData dataWithContentsOfURL:filePath];
        [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"imageu"];
    }];
    [downloadTask resume];
    
    
    //这段代码，可以实现第二张图片有3D的动画效果，动画结束后，进行同步的网络请求，请求的是广告页图片
//    [UIView animateWithDuration:6.0f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//
//        //adView.alpha = 0.0f;
//        adView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
//    } completion:^(BOOL finished) {
//
//
//        NSString * ad_imgUrl  = @"http://www.uimaker.com/uploads/allimg/121217/1_121217093327_1.jpg";
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [BBLaunchAdMonitor showAdAtPath:ad_imgUrl
//                                 onView:appDelegate.window.rootViewController.view
//                           timeInterval:5
//                       detailParameters:@{@"carId":@(12345), @"name":@"奥迪-品质生活"}];
//        [adView removeFromSuperview];
//
//    }];
}


@end
