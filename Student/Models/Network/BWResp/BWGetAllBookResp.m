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
            NSDictionary *dataDic = [jsonDic safeObjectForKey:@"data"];
            NSMutableArray *hot = [[NSMutableArray alloc] init];;
            NSMutableArray *newest = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dicHot in [dataDic safeObjectForKey:@"hot"]) {
                SBook *book = [[SBook alloc] initWithDic:dicHot];
                [hot addObject:book];
            }
            for (NSDictionary *dicNew in [dataDic safeObjectForKey:@"newest"]) {
                SBook *book = [[SBook alloc] initWithDic:dicNew];
                [newest addObject:book];
            }
            self.hotBookArray = hot;
            self.newestBookArray = newest;

        }
    }
    return self;
}
@end
