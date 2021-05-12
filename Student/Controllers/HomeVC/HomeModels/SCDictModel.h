//
//  SCDictModel.h
//  Student
//
//  Created by 马腾 on 2021/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCDictModel : NSObject
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *dictID;
@property (nonatomic, strong) NSString *dictName;
@property (nonatomic, strong) NSString *dictType;
@property (nonatomic, strong) NSArray *dictValueList;

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface SCDictInfoModel : NSObject
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *dictKey;
@property (nonatomic, strong) NSString *dictNote;
@property (nonatomic, strong) NSString *dictValue;
@property (nonatomic, strong) NSArray *dictValueId;
@property (nonatomic, strong) NSArray *updateDate;
@property (nonatomic, strong) NSArray *valueIndex;

@end

NS_ASSUME_NONNULL_END
