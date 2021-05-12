//
//  BWGetDictResp.h
//  Student
//
//  Created by 马腾 on 2021/5/12.
//

#import "BWBaseResp.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWGetDictResp : BWBaseResp
- (id)initWithJSONDictionary:(NSDictionary*)jsonDic;

@end

NS_ASSUME_NONNULL_END
