//
//  SChapterSection.h
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SChapterSection : NSObject
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, strong) NSString *accuracy;
@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *finishedModular;
@property (nonatomic, strong) NSString *finishedQuestion;
@property (nonatomic, strong) NSString *modularCount;
@property (nonatomic, strong) NSString *secctionProcess;
@property (nonatomic, strong) NSString *sectionIndex;
@property (nonatomic, strong) NSString *sectionName;
@property (nonatomic, strong) NSString *topicCount;
@property (nonatomic, strong) NSString *updateDate;
@end

NS_ASSUME_NONNULL_END
