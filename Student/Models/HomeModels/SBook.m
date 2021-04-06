//
//  SBook.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "SBook.h"


@implementation SBook
- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        NSMutableArray *bookInfoArray = [[NSMutableArray alloc] init];
        for (NSDictionary *InfoDic in [dic safeObjectForKey:@"books"]) {
            SBookInfo *bookInfo = [SBookInfo mj_objectWithKeyValues:InfoDic];
            bookInfo.bId = [InfoDic safeObjectForKey:@"id"];
            [bookInfoArray addObject:bookInfo];
        }
        
        self.stage = [dic safeObjectForKey:@"stage"];
        self.subject = [dic safeObjectForKey:@"subject"];
        self.books = bookInfoArray;
    }
    return self;
}
@end


@implementation SBookInfo



@end
