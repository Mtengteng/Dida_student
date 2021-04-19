//
//  BWChapterSecionReq.m
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import "BWChapterSecionReq.h"

@implementation BWChapterSecionReq

- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:GetBookChapterSectionURL,self.sectionId,self.userId];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    return dic;
}
@end
