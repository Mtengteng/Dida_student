//
//  BWKnowledgeBoxReq.h
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWKnowledgeBoxReq : BWBaseReq
@property (nonatomic, strong) NSString *subject;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
