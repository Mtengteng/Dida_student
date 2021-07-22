//
//  BWKnowledgeBoxReq.m
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import "BWKnowledgeBoxReq.h"

@implementation BWKnowledgeBoxReq
- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:knowledgeBox,self.subject];
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
