//
//  SAPublishView.h
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^publishBlock)(NSString *name,NSArray *nodeArray,NSString *backup);

@interface SAPublishView : UIView
@property (nonatomic, copy) publishBlock publish;

- (void)setDataWith:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
