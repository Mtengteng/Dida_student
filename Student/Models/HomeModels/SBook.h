//
//  SBook.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SBookInfo;

@interface SBook : NSObject
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSArray<SBookInfo *> *books;

- (id)initWithDic:(NSDictionary *)dic;

@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface SBookInfo : NSObject
@property (nonatomic, strong) NSString *bId;
@property (nonatomic, assign) NSInteger answeredCount;
@property (nonatomic, assign) NSInteger bookComment;
@property (nonatomic, strong) NSString *bookHot;
@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSString *bookPic;
@property (nonatomic, strong) NSString *bookTags;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, assign) float progress;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *updateDate;

@end

NS_ASSUME_NONNULL_END

