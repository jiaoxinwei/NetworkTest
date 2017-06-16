//
//  NetWorkManager.h
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  该类 是网络请求的工具类
 */

@interface NetWorkManager : NSObject
/**
 *   建立单例类
 */

+ (id)shareNetWorkManager;
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
    failure:(void (^)( id responseObject, NSError * error))failure;


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
     failure:(void (^)( id responseObject, NSError * error))failure;
/**
 *  PUT请求
 */

- (void)PUT:(NSString *)URLString
 parameters:(id)parameters  responseDtoClassType:(Class)classType
    success:(void (^)(id responseObject))success
    failure:(void (^)( id responseObject, NSError * error))failure;
@end
