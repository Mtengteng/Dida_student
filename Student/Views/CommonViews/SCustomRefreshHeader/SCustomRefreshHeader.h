//
//  SCustomRefreshHeader.h
//  smartCourse
//
//  Created by 马腾 on 2021/3/4.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
#import <Lottie/Lottie.h>


NS_ASSUME_NONNULL_BEGIN

@interface SCustomRefreshHeader : MJRefreshHeader
@property (nonatomic, strong) LOTAnimationView *imageView;

@end

NS_ASSUME_NONNULL_END
