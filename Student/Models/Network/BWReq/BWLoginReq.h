//
//  BWLoginReq.h
//  teacher
//
//  Created by 马腾 on 2021/1/8.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWLoginReq : BWBaseReq
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
