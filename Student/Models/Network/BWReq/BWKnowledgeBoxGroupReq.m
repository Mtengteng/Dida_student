//
//  BWKnowledgeBoxGroupReq.m
//  Student
//
//  Created by mateng on 2021/7/22.
//

#import "BWKnowledgeBoxGroupReq.h"

@implementation BWKnowledgeBoxGroupReq
- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:knowledgeBoxGroup,self.boxId];
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
