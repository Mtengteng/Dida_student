//
//  SChapter.h
//  Student
//
//  Created by 马腾 on 2021/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SChapter : NSObject
@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *accuracy;
@property (nonatomic, strong) NSString *chapterIndex;
@property (nonatomic, strong) NSString *chapterName;
@property (nonatomic, strong) NSString *chapterProcess;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *topicCount;
@property (nonatomic, strong) NSString *updateDate;

@end

NS_ASSUME_NONNULL_END
