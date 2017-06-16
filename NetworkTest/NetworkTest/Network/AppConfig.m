//
//  AppConfig.m
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import "AppConfig.h"
static NSString * const HTTP_URL_SET = @"HTTP_URL_SET";//数组
static NSString * const HTTP_URL_TYPE = @"HTTP_URL_TYPE";//本地存储标识和plist读取标识

@implementation EnvironmentModel

@end


@implementation AppConfig
+ (NSDictionary *)getConfigDic
{
    //从本地 获取plist文件
    NSString * configPath = [[NSBundle mainBundle] pathForResource:@"ConstantConfig"
                                                            ofType:@"plist"];
    
    NSDictionary * configDic = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
    return configDic;
}
//获取当前运行的库
+ (WorkEnvironment)currentEnvir
{
    
    NSNumber * productionType = [AppConfig getConfigDic][HTTP_URL_TYPE];
    
    if (productionType.integerValue==0) {
        //强制使用正式环境配置
        return WorkInRelease;
    }else{
        
        //注意事项，若库的数量有增减，可能会影响测试环境的标志，还有可能会闪退，不过不会影响正式环境
        
        NSInteger  localType = [[NSUserDefaults standardUserDefaults] integerForKey:HTTP_URL_TYPE];
        
        if (localType==0) {//没存过数据
            
            
            [AppConfig saveEnvirWithIndex:productionType.integerValue];
            
            return productionType.integerValue;
        }
        return localType;
    }
    
}
+ (void)saveEnvirWithIndex:(WorkEnvironment)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:HTTP_URL_TYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSMutableArray<EnvironmentModel*> *)httpURLs
{
    
    NSDictionary * configDic = [AppConfig getConfigDic];
    
    NSMutableArray<EnvironmentModel *> * httpURLSet = [EnvironmentModel arrayOfModelsFromDictionaries:configDic[HTTP_URL_SET] error:nil];
    NSParameterAssert(httpURLSet);
    
    return httpURLSet;
}


@end
