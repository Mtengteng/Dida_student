//
//  BWKnowledgeBoxGroupReq.h
//  Student
//
//  Created by mateng on 2021/7/22.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWKnowledgeBoxGroupReq : BWBaseReq
@property (nonatomic, strong) NSString *boxId;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
