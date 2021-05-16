//
//  BWGetAllBookResp.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "BWGetAllBookResp.h"
#import "SBook.h"

@implementation BWGetAllBookResp

- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            NSMutableArray *bookArray = [[NSMutableArray alloc] init];;

            for (NSDictionary *dicHot in [jsonDic safeObjectForKey:@"data"]) {
                SBook *book = [SBook mj_objectWithKeyValues:dicHot];
                book.bId = [dicHot safeObjectForKey:@"id"];
                [bookArray addObject:book];
            }
            
            self.bookArray = bookArray;


        }
    }
    return self;
}
@end
