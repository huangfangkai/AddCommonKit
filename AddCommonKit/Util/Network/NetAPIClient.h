//
//  NetAPIClient.h
//  DreamWeaver
//
//  Created by hfk on 2018/4/22.
//  Copyright © 2018年 hfk. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface NetAPIClient : AFHTTPSessionManager

+ (id)sharedJsonClient;
+ (id)changeJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
         autoShowSuccessMessage:(BOOL)autoShowSuccessMessage
                       andBlock:(void (^)(id data, NSError *error))block;


- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
         autoShowSuccessMessage:(BOOL)autoShowSuccessMessage
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;


- (void)requestJsonDataWithPath:(NSString *)aPath
                         images:(NSArray *)images
                     withParams:(NSDictionary*)params
                          names:(NSArray *)imageNames
                           type:(NSString *)type
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;


- (void)uploadImage:(UIImage *)image
               path:(NSString *)aPath
               name:(NSString *)name
         withParams:(NSDictionary*)params
       successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress;

- (void)uploadAssets:(NSArray *)assets
                path:(NSString *)aPath
                name:(NSString *)name
              params:(NSDictionary *)params
        successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
       progerssBlock:(void (^)(CGFloat progressValue))progress;

- (void)uploadVoice:(NSString *)file
           withPath:(NSString *)aPath
         withParams:(NSDictionary*)params
           andBlock:(void (^)(id data, NSError *error))block;



@end
