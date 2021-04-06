//
//  BWNetManager.m
//  bwclassgoverment
//
//  Created by 马腾 on 2018/1/11.
//  Copyright © 2018年 beiwaionline. All rights reserved.
//

#import "BWNetManager.h"
#import "AFNetworking.h"
#import "BWBaseReq.h"
#import "BWBaseResp.h"
#import "BWBaseDownloadReq.h"

@interface BWNetManager()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) AFURLSessionManager *fileManager;
@property (nonatomic, assign) NSInteger netState;

-(NSString *)replaceClassName:(id)reqClass;

- (void)sucessedWithRequest:(BWBaseReq *)request
             responseObject:(id)responseObj
                  withBlock:(void (^)(BWBaseReq *, BWBaseResp *))success
                    failure:(void (^)(BWBaseReq *, NSError *))failure;

- (void)failedWithRequest:(BWBaseReq *)request
                    error:(NSError *)error
                withBlock:(void (^)(BWBaseReq *, NSError *))failure;

@end

@implementation BWNetManager

+ (BWNetManager *)sharedInstances
{
    static BWNetManager *netManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netManager = [[BWNetManager alloc] init];
    });
    return netManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        //监听网络状态
        [self.manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"%ld",(long)status);
            
            self->_netState = status;
        }];
        [self.manager.reachabilityManager startMonitoring];
    }
    return self;
}

- (void)sendRequest:(BWBaseReq *)request
       withSucessed:(void (^)(BWBaseReq *, BWBaseResp *))success
            failure:(void (^)(BWBaseReq *, NSError *))failure
{
    //网络请求安全策略
    if (request.isSecurityPolicy) {
        AFSecurityPolicy *securityPolicy;
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        securityPolicy.allowInvalidCertificates = false;
        securityPolicy.validatesDomainName = YES;
        self.manager.securityPolicy = securityPolicy;
    } else {
        self.manager.securityPolicy.allowInvalidCertificates = true;
        self.manager.securityPolicy.validatesDomainName = false;
    }
    
    self.manager.requestSerializer.timeoutInterval = request.timeOut;

    NSLog(@"%f",request.timeOut);
    __weak __typeof(self) weakSelf = self;
    
    NSLog(@"\nRequest url : %@\nRequest body : %@",[request.url absoluteString],request.getRequestParametersDictionary);

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_token];
    
    
    NSURLSessionDataTask *task = [self.manager dataTaskWithHTTPMethod:[self httpMethodWithType:request.methodType]
                               URLString:request.url.absoluteString
                              parameters:[request getRequestParametersDictionary]
                                 headers:@{@"token":token == nil ? @"":token}
                          uploadProgress:nil
                        downloadProgress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                                        if (request.isCancel) {
                                            [task suspend];
                                            return;
                                        }
        
                                    [weakSelf sucessedWithRequest:request
                                                   responseObject:responseObject
                                                        withBlock:success failure:failure];
                                        }
                                 
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [weakSelf failedWithRequest:request
                                                      error:error
                                                  withBlock:failure];
                                        }];

    [task resume];

}

- (void)downloadWithUrl:(NSString *)downloadUrl
               savePath:(NSString *)savePath
               progress:(void (^)(float, NSString *))progressBlock
      completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionBlock
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
    
   __block NSURLSessionDownloadTask *downloadTask = [self.fileManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progressBlock(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount,[NSString stringWithFormat:@"%ld",downloadTask.taskIdentifier]);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
//        if (error == nil) {
            completionBlock(response,filePath,error);
//        }else{//下载失败的时候，只列举判断了两种错误状态码
//            NSString * message = nil;
//            if (error.code == - 1005) {
//                message = @"网络异常";
//            }else if (error.code == -1001){
//                message = @"请求超时";
//            }else{
//                message = @"未知错误";
//            }
//            completion(NO,message,nil);
//        }
        

    }];
    [downloadTask resume];
}


#pragma mark - PrivacyMethod -
- (NSString *)httpMethodWithType:(httpMethod)type
{
    switch (type) {
        case 0:
            return @"GET";
            break;
            
        default:
            return @"POST";
            break;
    }
    return nil;
}
-(NSString *)replaceClassName:(id)reqClass
{
    NSString * reqStr = NSStringFromClass([reqClass class]);
    NSString * string1 = reqStr;
    NSString * string2 = @"Req";
    NSRange range = [string1 rangeOfString:string2];
    NSString *respStr = nil;
    if (range.location != NSNotFound) {
        NSString *str = [string1 substringToIndex:range.location];
        respStr = [NSString stringWithFormat:@"%@Resp",str];
    }
    return respStr;
    
}
- (void)sucessedWithRequest:(BWBaseReq *)request responseObject:(id)responseObj withBlock:(void (^)(BWBaseReq *, BWBaseResp *))success failure:(void (^)(BWBaseReq *, NSError *))failure
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObj options:NSJSONReadingMutableLeaves error:nil];
    
    BWBaseResp *response = [[NSClassFromString([self replaceClassName:request]) alloc] initWithJSONDictionary:json];
    
    if (ResponseCode_Success == response.errorCode) {
        
        NSLog(@"\nRequestURL : %@\nResponseCode : %d\nResponseMsg : %@\nResponseBody : %@",request.url.absoluteString,response.errorCode,response.errorMessage,json);
        
        success(request,response);
        
    }else{
        
        NSLog(@"ERROR!!\n  \nRequestURL : %@\nResponseCode : %d\nResponseMsg : %@\nResponseBody : %@",request.url.absoluteString,response.errorCode,response.errorMessage,json);

        if (response.errorMessage != nil) {
            NSError * error = [NSError errorWithDomain:response.errorMessage code:response.errorCode userInfo:nil];
            
            
            failure(request,error);
        }
        
        
    }
}
- (void)failedWithRequest:(BWBaseReq *)request error:(NSError *)error withBlock:(void (^)(BWBaseReq *, NSError *))failure
{
    if (_netState == -1 || _netState == 0) {
        NSError * netError = [NSError errorWithDomain:@"当前网络不可用，请检查后再试" code:-1 userInfo:nil];
        failure(request,netError);
        
    }else{
        NSError * netError = [NSError errorWithDomain:@"服务器连接失败，请检查后再试" code:-1 userInfo:nil];
        
        failure(request,netError);
        
    }
}

#pragma mark - LazyLoad -
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _manager;
}
- (AFURLSessionManager *)fileManager
{
    if (!_fileManager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _fileManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        _fileManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _fileManager;
}
@end
