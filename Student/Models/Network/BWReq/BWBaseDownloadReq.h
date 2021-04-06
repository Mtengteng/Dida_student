//
//  BWBaseDownloadReq.h
//  NStudyCenterDemo
//
//  Created by 马腾 on 2021/1/19.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWBaseDownloadReq : BWBaseReq
@property (nonatomic, strong) NSString *targetPath;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;

@end

NS_ASSUME_NONNULL_END
