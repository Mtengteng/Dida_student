//
//  BWBaseReq.m
//  bwclassgoverment
//
//  Created by 马腾 on 2018/1/11.
//  Copyright © 2018年 beiwaionline. All rights reserved.
//

#import "BWBaseReq.h"

@implementation BWBaseReq

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}
- (NSURL *)url
{
    return nil;
}
- (httpMethod)methodType
{
    return _methodType;
}
- (NSTimeInterval)timeOut
{
    return _timeOut == 0 ? 45 : _timeOut;
}
- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *JSONDict = [NSMutableDictionary dictionary];
    
//    [JSONDict setObject:@"2" forKey:@"deviceType"];
    
    return JSONDict;
}
- (BOOL)isSecurityPolicy
{
    return NO;
}
-(BOOL)isCancel
{
    return NO;
}

@end
