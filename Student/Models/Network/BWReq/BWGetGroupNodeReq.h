//
//  BWGetGroupNodeReq.h
//  Student
//
//  Created by mateng on 2021/7/26.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWGetGroupNodeReq : BWBaseReq
@property (nonatomic, strong) NSString *groupId;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
