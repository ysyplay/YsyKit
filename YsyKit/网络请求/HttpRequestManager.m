//
//  HttpRequestTools.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/19.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "HttpRequestManager.h"
static AFHTTPSessionManager *_sessionManager;

@implementation HttpRequestManager
static HttpRequestManager *_instance;


+ (id)allocWithZone:(struct _NSZone *)zone
{
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HttpRequestManager alloc] init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = 7.f;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    //设置头
    [_sessionManager.requestSerializer setValue:@"value" forHTTPHeaderField:@"field"];
    // 此处可添加对应的等待效果
}

- (void)getHttpRequest:(NSString *)url parameters:(NSDictionary *)parameters withGetString:(NSString *)str  success:(void (^)(id responseObject))successful
            failure:(void (^) (NSError *error,ParamtersJudgeCode  judgeCode))failure
{
    NSError *error = nil;
    //判断接口是否是空值
    if (url.length == 0 || [url isEqualToString:@""]) {
        failure(error,RequestUrlNil);
        return;
    }
    if (str)
    {
        url = [url stringByAppendingString:str];
    }
    //开始请求内容
    [_sessionManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //如果需要填充进度内容，可以直接进行内容添加
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger errorCode = [self showResponseCode:task.response];
        NSLog(@"%@",error);
        failure(error,errorCode);
    }];
}

- (void)postHttpRequest:(NSString *)url withAppendString:(NSString *)str Parameters:(NSDictionary *)parameters
                success:(void (^)(id responseObject))successful
                failure:(void (^) (NSError *error,ParamtersJudgeCode  judgeCode))failure
{
    NSError *error = nil;
    //判断接口是否是空值
    if (url.length == 0 || [url isEqualToString:@""]) {
        failure(error,RequestUrlNil);
        return;
    }
    if (str)
    {
        url = [url stringByAppendingString:str];
    }
    //开始请求内容
    [_sessionManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //如果需要填充进度内容，可以直接进行内容添加
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger errorCode = [self showResponseCode:task.response];
        NSLog(@"%@",error);
        failure(error,errorCode);
    }];
}

/**
  图片上传接口(上传音频与图片是一致的，需要更改的只是 mimeType类型，根据要求设置对应的格式即可)
 @param url 请求接口
 @param parameters 请求参数
 @param Datas 图片数据
 @param Keys key数组
 @param mimeType 文件类型
 @param suffix 后缀名
 @param progress 进度回调
 @param successful 成功回调
 @param failure 失败回调
 */
- (void)UploadHttpRequest:(NSString *)url parameters:(NSDictionary *)parameters
            Datas:(NSArray<NSData *> *)Datas
            Keys :(NSArray<NSString *> *)Keys
            mimeType :(NSString *)mimeType
            suffix :(NSString *)suffix
               progress:(HttpProgress)progress
                success:(void (^) (id responseObject))successful
                failure:(void (^) (NSError *error,ParamtersJudgeCode  judgeCode))failure
{
    NSError *error = nil;
    //接口URL为空
    if (url.length == 0 || [url isEqualToString:@""] ) {
        failure(error,RequestUrlNil);
        return;
    }
    //传入上传图片数据为空(NSData)
    if (Datas.count != Keys.count)
    {
        NSLog(@"数据不一致");
        failure(error,UploadDataError);
        return;
    }
    //如果有数据上传
    if (Datas.count>0)
    {
        if (!mimeType)
        {
            //默认上传图片
            mimeType = @"image/jpeg";
        }
        if (!suffix)
        {
            //默认上传图片
            suffix = @"jpg";
        }
        
        [_sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //对上传完文件的配置
            //获取当前时间（int 时间戳转换）
            
            //参数介绍
            //fileData : 图片资源  name : 预定key   fileName  : 文件名  mimeType    : 资源类型(根据后台进行对应配置)
            for (int i =0; i<Datas.count; i++)
            {
                int nowDate = [[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]intValue];
                NSString *fileName = [NSString stringWithFormat:@"%d%d.%@",nowDate,i,suffix];
                [formData appendPartWithFileData:Datas[i] name:Keys[i] fileName:fileName mimeType:mimeType];
            }
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //上传进度
            dispatch_sync(dispatch_get_main_queue(), ^{
                progress ? progress(uploadProgress) : nil;
            });
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successful(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //可以将http响应码返回，以便于判断错误
            NSInteger errorCode = [self showResponseCode:task.response];
            NSLog(@"%@",error);
            failure(error,errorCode);
        }];
    }
    //如果没有数据上传，走正常的post请求
    else
    {
        [_sessionManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            //如果需要填充进度内容，可以直接进行内容添加
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successful(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSInteger errorCode = [self showResponseCode:task.response];
            NSLog(@"%@",error);
            failure(error,errorCode);
        }];
    }
}
/**
 下载文件接口
 
 @param url 请求接口
 @param progress 下载进度
 @param downloadFilePath 文件保存路径
 @param successful  返回路径内容
 @param failure 失败返回
 */
- (void)downloadHttpRequest:(NSString *)url
           progress:(HttpProgress)progress
   downloadFilePath:(NSString *)downloadFilePath
            success:(void (^) (id responseObject))successful
            failure:(void (^) (NSError *error, ParamtersJudgeCode  judgeCode))failure
{
    //下载地址
    NSURL *downloadURL = [NSURL URLWithString:url];
    //设置请求
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    //下载操作
    [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadFilePath ? downloadFilePath : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadPath stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSInteger responseCode = [self showResponseCode:response];
        if (responseCode != 200) {
            successful ? successful(filePath.absoluteString): nil;
        }else {
            failure(error, UploadFailed);
        }
    }];
}
/**
 输出http响应的状态码
 
 @param response 响应数据
 */
- (NSUInteger)showResponseCode:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    return responseStatusCode;
}


#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(RequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer == RequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(ResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer == ResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}





//+(void)showAlert
//{
//    [SVProgressHUD dismiss];
//    NSLog(@"网络暂时无法连接");
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络暂时无法连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////    [alert show];
//}
////401处理
//+(void)forbiddenToken
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [SVProgressHUD showImage:nil status:@"账号异常，请重新登录"];
//        [YsyTools gotoLoginVC];
//    });
//}
@end
