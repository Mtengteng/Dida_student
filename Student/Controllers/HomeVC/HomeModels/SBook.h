//
//  SBook.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBook : NSObject
@property (nonatomic, strong) NSString *bId;
@property (nonatomic, assign) NSInteger bookCommentCount;
@property (nonatomic, strong) NSString *bookHot;
@property (nonatomic, strong) NSString *bookGrade;
@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSString *bookPic;
@property (nonatomic, strong) NSString *bookTags;
@property (nonatomic, strong) NSString *bookStage;
@property (nonatomic, strong) NSString *bookSubject;
@property (nonatomic, assign) NSInteger bookTotalCount;
@property (nonatomic, strong) NSString *bookType;
@property (nonatomic, strong) NSDictionary *bookVersion;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *updateDate;


@end
NS_ASSUME_NONNULL_END


