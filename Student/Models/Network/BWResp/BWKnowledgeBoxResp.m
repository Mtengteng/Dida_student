//
//  BWKnowledgeBoxResp.m
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import "BWKnowledgeBoxResp.h"
#import "SBox.h"

@implementation BWKnowledgeBoxResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            
            NSArray *array = [jsonDic safeObjectForKey:@"data"];
            
            for (NSDictionary *dic in array) {
                SBox *box = [SBox mj_objectWithKeyValues:dic];
                box.bId = [dic safeObjectForKey:@"id"];
                [tempArray addObject:box];
            }
            self.data = tempArray;

        }
    }
    return self;
}
@end
