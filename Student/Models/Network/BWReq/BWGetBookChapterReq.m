//
//  BWGetBookChapterReq.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "BWGetBookChapterReq.h"

@implementation BWGetBookChapterReq

- (NSURL *)url
{
    NSString *urlStr = [NSString stringWithFormat:GetBookChapterURL,self.bookId,self.userId];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    return [NSURL URLWithString:str];
}

- (NSMutableDictionary *)getRequestParametersDictionary
{
    NSMutableDictionary *dic = [super getRequestParametersDictionary];
    
    return dic;
}

@end
