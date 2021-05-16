//
//  BWGetAllBookReq.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWGetAllBookReq : BWBaseReq
@property (nonatomic, strong) NSString *bookSubject;
@property (nonatomic, strong) NSString *grade;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
