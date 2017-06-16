//
//  NetWorkManager.m
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFHTTPSessionManager.h"

#define kTIMEOUT 15  //超时

@implementation NetWorkManager
+ (id)shareNetWorkManager {
    
    static NetWorkManager *shareNetWorkManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetWorkManager =[[self alloc]init];
    });
    return shareNetWorkManager;
    
}
// 默认初始化方法,放些默认设置，同时如果有特殊参数，比如agent等需要设置部分，做特殊设置
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        return self;
    }
    return self;
}
#pragma mark--设置返回格式
-(AFJSONResponseSerializer *)setResponseSerializer{
    /*
     AFHTTPRequestSerializer            二进制格式
     AFJSONRequestSerializer            JSON
     AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
     
     AFHTTPResponseSerializer           二进制格式
     AFJSONResponseSerializer           JSON
     AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
     AFXMLDocumentResponseSerializer (Mac OS X)
     AFPropertyListResponseSerializer   PList
     AFImageResponseSerializer          Image
     AFCompoundResponseSerializer       组合
     */
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    //AFXMLParserResponseSerializer *responseSerializer = [AFXMLParserResponseSerializer serializer];
    //AFPropertyListResponseSerializer
    //responseSerializer.removesKeysWithNullValues = YES;
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/xml", nil];
    
    return responseSerializer;
}
#pragma mark--设置请求头的方法
-(void)setHttpHeader:(AFHTTPSessionManager*) manger
{

    //NSString *deviceType = [UIDevice hardwareDescription];
    NSString *deviceSystemName = [UIDevice currentDevice].systemName;
    NSString *deviceSystemVersion = [UIDevice currentDevice].systemVersion;
    
    //[[manger requestSerializer] setValue:deviceType forHTTPHeaderField:@"Device-Model"];
    [[manger requestSerializer] setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    [[manger requestSerializer] setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"versionCode"] forHTTPHeaderField:@"versionCode"];
    [[manger requestSerializer] setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  forHTTPHeaderField:@"App-Version"];
    [[manger requestSerializer] setValue:[NSString  stringWithFormat:@"%@%@",deviceSystemName,deviceSystemVersion] forHTTPHeaderField:@"Client-OS"];
    // 设置超时时间
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 30.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
}

/**
 *  GET请求
 *
 *  @param URLString  URL 全拼
 *  @param parameters 参数全拼
 *  @param classType  用model去解析 数据
 *  @param success    成功
 *  @param failure    失败
 */

- (void)GET:(NSString *)URLString
 parameters:(id)parameters  responseDtoClassType:(Class)classType
    success:(void (^)(id responseObject))success
    failure:(void (^)( id responseObject, NSError * error))failure{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [self setHttpHeader:manager];
    manager.responseSerializer = [self setResponseSerializer];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"%@",error);
    }];
    
    
}


/**
 *  POST请求
 *
 *  @param URLString  URL 全拼
 *  @param parameters 参数全拼
 *  @param classType  用model去解析 数据
 *  @param success    成功
 *  @param failure    失败
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters responseDtoClassType:(Class)classType
     success:(void (^)( id responseObject))success
     failure:(void (^)( id responseObject, NSError * error))failure{
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    //AFXMLParserResponseSerializer *responseSerializer = [AFXMLParserResponseSerializer serializer];
    //AFPropertyListResponseSerializer
    //responseSerializer.removesKeysWithNullValues = YES;
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/xml", nil];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


/**
 *  PUT请求
 */
- (void)PUT:(NSString *)URLString
 parameters:(id)parameters  responseDtoClassType:(Class)classType
    success:(void (^)(id responseObject))success
    failure:(void (^)( id responseObject, NSError * error))failure{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    //AFXMLParserResponseSerializer *responseSerializer = [AFXMLParserResponseSerializer serializer];
    //AFPropertyListResponseSerializer
    //responseSerializer.removesKeysWithNullValues = YES;
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/xml", nil];
    manager.responseSerializer = responseSerializer;
    [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

@end
