//
//  BWGetDictReq.m
//  Student
//
//  Created by 马腾 on 2021/5/12.
//

#import "BWGetDictReq.h"

@implementation BWGetDictReq
- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:GetDictTypeURL,self.dictType,self.param];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    return dic;
}
@end
