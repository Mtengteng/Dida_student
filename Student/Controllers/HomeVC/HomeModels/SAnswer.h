//
//  SAnswer.h
//  Student
//
//  Created by 马腾 on 2021/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAnswer : NSObject
@property (nonatomic, strong) NSString *answerId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
