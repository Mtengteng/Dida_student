//
//  BWGetGroupNodeResp.m
//  Student
//
//  Created by mateng on 2021/7/26.
//

#import "BWGetGroupNodeResp.h"
#import "SBoxNode.h"

@implementation BWGetGroupNodeResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            
            NSArray *array = [jsonDic safeObjectForKey:@"data"];
            
            for (NSDictionary *dic in array) {
                SBoxNode *node = [SBoxNode mj_objectWithKeyValues:dic];
                node.nId = [dic safeObjectForKey:@"id"];
                [tempArray addObject:node];
            }
            self.data = tempArray;

        }
    }
    return self;
}
@end
