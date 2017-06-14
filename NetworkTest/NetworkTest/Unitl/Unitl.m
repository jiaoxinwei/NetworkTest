//
//  Unitl.m
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import "Unitl.h"
#import "MainViewController.h"
#import "MeViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import "AppDelegate.h"
@implementation Unitl
+(void)initTabBarView
{
    
    UIImage *image=[UIImage imageNamed:@"tabbar_seedoct"];
    UIImage *selectedImage=[UIImage imageNamed:@"tabbar_seedoctHighed"];
    selectedImage=[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //主页面
    MainViewController *mainVC=[[MainViewController alloc]init];
    BaseNavigationController *mianNav=[[BaseNavigationController alloc]initWithRootViewController:mainVC];
    //mianNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"主页" image:image tag:0];
    mianNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"主页" image:image selectedImage:selectedImage];
    //信息页面
    MeViewController *messageVC=[[MeViewController alloc]init];
    messageVC.tabBarItem.title=@"主页";
    BaseNavigationController *messageNav=[[BaseNavigationController alloc]initWithRootViewController:messageVC];
    //messageNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"消息" image:image tag:1];
    messageNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"信息" image:image selectedImage:selectedImage];
    
    BaseTabBarController *tabBarVC=[[BaseTabBarController alloc]init];
    
    [tabBarVC setViewControllers:[NSMutableArray arrayWithObjects:mianNav,messageNav, nil] animated:YES];
    
    
    
    UIWindow *appdelegate=[[UIApplication sharedApplication].delegate window] ;
    appdelegate.rootViewController=tabBarVC;
    
    //[self setViewControllers:[NSMutableArray arrayWithObjects:mianNav,messageNav,myNav, nil] animated:YES];
    
}

@end
