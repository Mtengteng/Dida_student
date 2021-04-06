//
//  BWLoginReq.m
//  teacher
//
//  Created by 马腾 on 2021/1/8.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWLoginReq.h"

@implementation BWLoginReq
- (NSURL *)url
{
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,LoginURL];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    if (self.username) {
        [dic setObject:self.username forKey:@"username"];
    }
    if (self.password) {
        [dic setObject:self.password forKey:@"password"];
    }
    return dic;
}
@end
