//
//  BWChapterSecionReq.h
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWChapterSecionReq : BWBaseReq
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, strong) NSString *userId;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
