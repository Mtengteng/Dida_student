//
//  BWChapterSecionResp.m
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import "BWChapterSecionResp.h"
#import "SChapterSection.h"

@implementation BWChapterSecionResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in [jsonDic safeObjectForKey:@"data"]) {
                
                SChapterSection *section = [SChapterSection mj_objectWithKeyValues:dic];
                section.sectionId = [dic safeObjectForKey:@"id"];
                [dataArray addObject:section];
            }
            self.data = dataArray;

        }
    }
    return self;
}
@end
