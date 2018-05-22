//
//  HttpRequestTools.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/19.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NetworkMacro.h"
@interface HttpRequestManager : NSObject
/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^HttpProgress)(NSProgress *progress);

+ (HttpRequestManager *)shareManager;


//get请求
- (void)getHttpRequest:(NSString *)url parameters:(NSDictionary *)parameters withGetString:(NSString *)str  success:(void (^)(id responseObject))successful
               failure:(void (^) (NSError *error,ParamtersJudgeCode  judgeCode))failure;
//post请求
- (void)postHttpRequest:(NSString *)url withAppendString:(NSString *)str Parameters:(NSDictionary *)parameters
                success:(void (^)(id responseObject))successful
                failure:(void (^) (NSError *error,ParamtersJudgeCode  judgeCode))failure;
//上传数据
- (void)UploadHttpRequest:(NSString *)url parameters:(NSDictionary *)parameters
                    Datas:(NSArray<NSData *> *)Datas
                    Keys :(NSArray<NSString *> *)Keys
                mimeType :(NSString *)mimeType
                  suffix :(NSString *)suffix
                 progress:(HttpProgress)progress
                  success:(void (^) (id responseObject))successful
                  failure:(void (^) (NSError *error,ParamtersJudgeCode  judgeCode))failure;
//下载数据
- (void)downloadHttpRequest:(NSString *)url
                   progress:(HttpProgress)progress
           downloadFilePath:(NSString *)downloadFilePath
                    success:(void (^) (id responseObject))successful
                    failure:(void (^) (NSError *error, ParamtersJudgeCode  judgeCode))failure;



#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(RequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(ResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为7S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/// 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
 一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;
@end
