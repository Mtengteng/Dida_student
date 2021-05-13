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
    NSString *urlStr = [NSString stringWithFormat:GetAllBookURL,self.bookSubject,self.grade];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    return dic;
}
@end
