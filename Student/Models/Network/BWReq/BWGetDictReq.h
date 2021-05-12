//
//  BWGetDictReq.h
//  Student
//
//  Created by 马腾 on 2021/5/12.
//

#import "BWBaseReq.h"

NS_ASSUME_NONNULL_BEGIN

/*
 年级字典   GRADE
 学科字典   SUBJECT
 学段字典   PERIOD
 例子：
 年级：高一、高二
 学科：数学、英语
 学段：高中、初中、大学
 */

@interface BWGetDictReq : BWBaseReq
@property (nonatomic, strong) NSString *dictType;

- (NSURL *)url;

- (NSMutableDictionary *)getRequestParametersDictionary;
@end

NS_ASSUME_NONNULL_END
