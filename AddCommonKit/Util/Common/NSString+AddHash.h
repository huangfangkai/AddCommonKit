//
//  NSString+AddHash.h
//  111
//
//  Created by hfk on 2020/6/24.
//  Copyright © 2020 hfk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AddHash)

@property (nonatomic, copy, readonly) NSString *md5String;
@property (nonatomic, copy, readonly) NSString *sha1String;
@property (nonatomic, copy, readonly) NSString *sha256String;
@property (nonatomic, copy, readonly) NSString *sha512String;

- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/// AES128加密
/// @param key 加密Key
- (NSString *)AES128EncryptWithKey:(NSString *)key;
/// AES128解密
/// @param key 解密Key
- (NSString *)AES128DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
