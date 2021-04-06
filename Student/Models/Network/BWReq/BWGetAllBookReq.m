//
//  BWGetAllBookReq.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "BWGetAllBookReq.h"

@implementation BWGetAllBookReq

- (NSURL *)url
{
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,GetAllBookURL];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    return dic;
}
@end
