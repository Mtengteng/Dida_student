//
//  BWKnowledgeBoxGroupResp.m
//  Student
//
//  Created by mateng on 2021/7/22.
//

#import "BWKnowledgeBoxGroupResp.h"
#import "SBoxGroup.h"

@implementation BWKnowledgeBoxGroupResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            
            NSArray *array = [jsonDic safeObjectForKey:@"data"];
            
            for (NSDictionary *dic in array) {
                SBoxGroup *group = [SBoxGroup mj_objectWithKeyValues:dic];
                group.bId = [dic safeObjectForKey:@"id"];
                [tempArray addObject:group];
            }
            self.data = tempArray;

        }
    }
    return self;
}
@end
