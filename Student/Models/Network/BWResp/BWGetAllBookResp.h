//
//  BWGetAllBookResp.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "BWBaseResp.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWGetAllBookResp : BWBaseResp
@property (nonatomic, strong) NSMutableArray *bookArray;

- (id)initWithJSONDictionary:(NSDictionary*)jsonDic;

@end

NS_ASSUME_NONNULL_END
