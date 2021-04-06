//
//  BWTestResp.m
//  teacher
//
//  Created by 马腾 on 2021/1/8.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWTestResp.h"

@implementation BWTestResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            NSArray *data = [jsonDic safeObjectForKey:@"data"];
            
            self.data = data;
            

        }
    }
    return self;
}
@end
