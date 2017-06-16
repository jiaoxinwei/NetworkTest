//
//  AppConfig.h
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
/**
 * 该类用于切换本地库
 */

typedef NS_ENUM(NSInteger, WorkEnvironment)
{
    WorkInRelease    = 0,//正式
    WorkInDevelop    = 1,//开发
    WorkInTest       = 2,//测试
    WorkInPreRelease = 3,//预发
    WorkInDeploy     = 4,//部署（另一个测试库）
    WorkInDevOptimize     = 5,//技改测试
    WorkInPreReleaseOptimize     = 6,//技改预发
    
    
};

@interface EnvironmentModel : JSONModel
//名称
@property (nonatomic,copy) NSString * name;
//域名
@property (nonatomic,copy) NSString * content;

@end

@interface AppConfig : NSObject
//获取当前运行的库
+ (WorkEnvironment)currentEnvir;

//获取URLs 模型数组
+ (NSMutableArray<EnvironmentModel*> *)httpURLs;

//保存当前选择的库
+ (void)saveEnvirWithIndex:(WorkEnvironment)index;
@end
