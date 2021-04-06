//
//  BWLoginResp.h
//  teacher
//
//  Created by 马腾 on 2021/1/8.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "BWBaseResp.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWLoginResp : BWBaseResp
@property (nonatomic, strong) NSDictionary *userInfo;

- (id)initWithJSONDictionary:(NSDictionary*)jsonDic;

@end

NS_ASSUME_NONNULL_END
