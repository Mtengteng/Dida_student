//
//  BWGetBookChapterResp.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "BWGetBookChapterResp.h"
#import "SChapter.h"

@implementation BWGetBookChapterResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in [jsonDic safeObjectForKey:@"data"]) {
                
                SChapter *chapter = [SChapter mj_objectWithKeyValues:dic];
                chapter.chapterId = [dic safeObjectForKey:@"id"];
                [dataArray addObject:chapter];
            }
            self.data = dataArray;

        }
    }
    return self;
}


@end
