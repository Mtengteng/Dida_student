//
//  BWGetBookChapterReq.h
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWGetBookChapterReq : BWBaseReq
@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *userId;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
