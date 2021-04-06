//
//  BWBaseResp.m
//  bwclassgoverment
//
//  Created by 马腾 on 2018/1/11.
//  Copyright © 2018年 beiwaionline. All rights reserved.
//

#import "BWBaseResp.h"

@implementation BWBaseResp
@synthesize errorCode = _errorCode, errorMessage = _errorMessage;

- (id)initWithJSONDictionary: (NSDictionary*)jsonDic
{
    if (self = [super init])
    {
        _errorCode = [[jsonDic safeObjectForKey:@"code"] intValue];
        _data = [jsonDic safeObjectForKey:@"data"];
        _errorMessage = [jsonDic safeObjectForKey:@"msg"];

    }
    return self;
}
@end
