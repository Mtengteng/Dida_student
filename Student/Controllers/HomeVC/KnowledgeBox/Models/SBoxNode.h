//
//  SBoxNode.h
//  Student
//
//  Created by mateng on 2021/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBoxNode : NSObject
@property (nonatomic, strong) NSString *boxId;
@property (nonatomic, strong) NSString *cardsGroupId;
@property (nonatomic, strong) NSString *nId;
@property (nonatomic, strong) NSString *nodeName;
@property (nonatomic, strong) NSString *totalCardsCount;
@property (nonatomic, strong) NSString *type;


@end

NS_ASSUME_NONNULL_END
