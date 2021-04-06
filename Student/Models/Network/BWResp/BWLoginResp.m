//
//  BWLoginResp.m
//  teacher
//
//  Created by 马腾 on 2021/1/8.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWLoginResp.h"

@implementation BWLoginResp
- (id)initWithJSONDictionary:(NSDictionary *)jsonDic
{
    
    if (self = [super initWithJSONDictionary:jsonDic]) {
        if (self.errorCode == ResponseCode_Success)
        {
            NSDictionary *data = [jsonDic safeObjectForKey:@"data"];
            self.userInfo = [data safeObjectForKey:@"userInfo"];
            
            NSString *token = [data safeObjectForKey:@"token"];
            if (token) {
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_token];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            

        }
    }
    return self;
}
@end
