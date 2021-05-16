//
//  BWGetDictResp.m
//  Student
//
//  Created by 马腾 on 2021/5/12.
//

#import "BWGetDictResp.h"
#import "SCDictModel.h"

@implementation BWGetDictResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            NSDictionary *dic = [jsonDic safeObjectForKey:@"data"];
            
            SCDictModel *model = [[SCDictModel alloc] init];
            model.createDate = [dic safeObjectForKey:@"createDate"];
            model.dictID = [dic safeObjectForKey:@"dictID"];
            model.dictName = [dic safeObjectForKey:@"dictName"];
            model.dictType = [dic safeObjectForKey:@"dictType"];
            
            NSMutableArray *dictValueList = [[NSMutableArray alloc] init];
            for (NSDictionary *dictInfo in [dic safeObjectForKey:@"dictValueList"]) {
                SCDictInfoModel *infoModel = [SCDictInfoModel mj_objectWithKeyValues:dictInfo];
                [dictValueList addObject:infoModel];
            }
            model.dictValueList = dictValueList;
            
            self.data = model;

        }
    }
    return self;
}
@end
