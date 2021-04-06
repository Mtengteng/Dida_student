//
//  BWGetAllBookResp.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "BWBaseResp.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWGetAllBookResp : BWBaseResp
@property (nonatomic, strong) NSMutableArray *hotBookArray;
@property (nonatomic, strong) NSMutableArray *newestBookArray;

@end

NS_ASSUME_NONNULL_END
