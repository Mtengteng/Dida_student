//
//  BWGetGroupNodeReq.m
//  Student
//
//  Created by mateng on 2021/7/26.
//

#import "BWGetGroupNodeReq.h"

@implementation BWGetGroupNodeReq
- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:knowledgeBoxNodeURL,self.groupId];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    NSString *logStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    return [NSURL URLWithString:logStr];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    return dic;
}
@end
