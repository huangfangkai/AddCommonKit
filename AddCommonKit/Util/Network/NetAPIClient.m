//
//  NetAPIClient.m
//  DreamWeaver
//
//  Created by hfk on 2018/4/22.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import "NetAPIClient.h"
#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]
//服务器编码
#define encodingType CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)

@implementation NetAPIClient

static NetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+(NetAPIClient *)sharedJsonClient{
    dispatch_once(&onceToken, ^{
        _sharedClient=[[NetAPIClient alloc]initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    });
    return _sharedClient;
}
+ (id)changeJsonClient{
    _sharedClient = [[NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    //    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"multipart/form-data", nil];
    self.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // 客户端是否信任非法证书
    self.securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    [self.securityPolicy setValidatesDomainName:NO];
    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.requestSerializer.timeoutInterval = 20.0f;
    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES autoShowSuccessMessage:NO andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:autoShowError autoShowSuccessMessage:NO andBlock:block];

}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
         autoShowSuccessMessage:(BOOL)autoShowSuccessMessage
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES autoShowSuccessMessage:autoShowSuccessMessage andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                autoShowSuccessMessage:(BOOL)autoShowSuccessMessage
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //CSRF - 跨站请求伪造
    NSHTTPCookie *_CSRF = nil;
    for (NSHTTPCookie *tempC in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([tempC.name isEqualToString:@"XSRF-TOKEN"]) {
            _CSRF = tempC;
        }
    }
    if (_CSRF) {
        [self.requestSerializer setValue:_CSRF.value forHTTPHeaderField:@"X-XSRF-TOKEN"];
    }
    
    NSString *token = [UserData sharedManager].token;
    if ([UserData sharedManager].token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"User_Cookie"]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"User_Cookie"]];
        for (NSHTTPCookie *cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
    //log请求数据  kNetworkMethodName[method]//打印请求方法
    DebugLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], aPath, params);
    
    //签名
    params = [params addAppSign];
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    发起请求
    switch (method) {
        case Get:{
            //所有 Get 请求，增加缓存机制
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject apath:aPath autoShowError:autoShowError autoShowSuccessMessage:autoShowSuccessMessage];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
                
            }];
            break;}
        case Post:{
            [self POST:aPath parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject apath:aPath autoShowError:autoShowError autoShowSuccessMessage:autoShowSuccessMessage];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
            break;
        }
        case Put:{
            [self PUT:aPath parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject apath:aPath autoShowError:autoShowError autoShowSuccessMessage:autoShowSuccessMessage];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
            break;}
        case Delete:{
            [self DELETE:aPath parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject apath:aPath autoShowError:autoShowError autoShowSuccessMessage:autoShowSuccessMessage];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
            break;}
        default:
            break;
    }
    
}

-(void)requestJsonDataWithPath:(NSString *)aPath file:(NSDictionary *)file withParams:(NSDictionary *)params withMethodType:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    
    //签名
    params = [params addAppSign];
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // Data
    NSData *data;
    NSString *name, *fileName;
    
    if (file) {
        UIImage *image = file[@"image"];
        // 压缩
        data = [image dataForCodingUpload];
        name = file[@"name"];
        fileName = file[@"fileName"];
    }
    switch (method) {
        case Post:{
            [self POST:aPath parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                if (file) {
                    [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject apath:aPath];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
                [NSObject showError:error];
                block(nil, error);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)requestJsonDataWithPath:(NSString *)aPath images:(NSArray *)images withParams:(NSDictionary *)params names:(NSArray *)imageNames type:(NSString *)type withMethodType:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    
    //签名
    params = [params addAppSign];
    
    switch (method) {
        case Post:{
            [self POST:aPath parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSInteger cnt=0;
                for (NSData *image in images) {
                    [formData appendPartWithFileData:image name:[NSString stringWithFormat:@"%ld",cnt] fileName:imageNames[cnt] mimeType:type];
                    cnt++;
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject apath:aPath];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
                [NSObject showError:error];
                block(nil, error);
            }];
            break;
        }
        default:
            break;
    }
}
- (void)uploadImage:(UIImage *)image
               path:(NSString *)aPath
               name:(NSString *)name
         withParams:(NSDictionary*)params
       successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress{
    
    NSData *data = [image dataForCodingUpload];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    DebugLog(@"\nuploadImageSize\n%@ : %.0f", fileName, (float)data.length/1024);
    
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    
    //签名
    params = [params addAppSign];
    
    [self POST:aPath parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progressValue = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        if (progress) {
            progress(progressValue);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DebugLog(@"Success: ***** %@", responseObject);
        id error = [self handleResponse:responseObject apath:aPath];
        if (error && failure) {
            failure(task, error);
        }else{
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"Error: %@ ***** %@", error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey], error);
        if (failure) {
            failure(task, error);
        }
    }];
    
    
}

- (void)uploadAssets:(NSArray *)assets
                path:(NSString *)aPath
                name:(NSString *)name
              params:(NSDictionary *)params
        successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
       progerssBlock:(void (^)(CGFloat progressValue))progress{
    
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    //签名
    params = [params addAppSign];
    
    [self POST:aPath parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (PHAsset *asset in assets) {
            NSString *fileName = asset.fileName;;
            NSData *data = [asset.loadImage dataForCodingUpload];
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progressValue = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        if (progress) {
            progress(progressValue);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DebugLog(@"Success: %@ ***** %@", aPath, responseObject);
        id error = [self handleResponse:responseObject apath:aPath];
        if (error && failure) {
            failure(task, error);
        }else{
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"Error: %@ ***** %@", aPath, error);
        if (failure) {
            failure(task, error);
        }
    }];
}


- (void)uploadVoice:(NSString *)file
           withPath:(NSString *)aPath
         withParams:(NSDictionary*)params
           andBlock:(void (^)(id data, NSError *error))block {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:file]) {
        return;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSString *fileName = [file lastPathComponent];
    
    DebugLog(@"\nuploadVoiceSize\n%@ : %.0f", fileName, (float)data.length/1024);
    //签名
    params = [params addAppSign];
    
    [self POST:aPath parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"audio/amr"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
        id error = [self handleResponse:responseObject apath:aPath];
        if (error) {
            block(nil, error);
        }else{
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]);
        [NSObject showError:error];
        block(nil, error);
    }];
}

@end
