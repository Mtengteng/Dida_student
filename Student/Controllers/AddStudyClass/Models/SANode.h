//
//  SANode.h
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum _NodeType
{
    NodeType_start = 0,
    NodeType_add = 1,
    NodeType_kw = 2,
    NodeType_test = 3,
    NodeType_end = 4
}NodeType;

@interface SANode : NSObject
@property (nonatomic, strong) NSString *nId;
@property (nonatomic, assign) NodeType type;
@property (nonatomic, strong) NSArray *imageList;
@end

NS_ASSUME_NONNULL_END
