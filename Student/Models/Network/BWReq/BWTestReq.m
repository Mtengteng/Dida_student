//
//  BWTestReq.m
//  teacher
//
//  Created by 马腾 on 2021/1/8.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWTestReq.h"

@implementation BWTestReq
- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:boxURL,self.object,self.uid,self.level];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    return dic;
}
@end
