//
//  BaseNetworkServer.h
//  NetworkTest
//
//  Created by 茭白 on 2017/6/14.
//  Copyright © 2017年 茭白. All rights reserved.
//

#import <Foundation/Foundation.h>
/***
 * 该类--网络接口请求类的基类
 **/
typedef void(^successBlock) (id responseObject);
typedef void(^faileBlock) (id responseObject,NSError *error);
@interface BaseNetworkServer : NSObject

@end
