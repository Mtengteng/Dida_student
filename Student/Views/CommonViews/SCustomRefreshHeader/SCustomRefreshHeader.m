//
//  SCustomRefreshHeader.m
//  smartCourse
//
//  Created by 马腾 on 2021/3/4.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import "SCustomRefreshHeader.h"

@implementation SCustomRefreshHeader

- (void)prepare
{
    [super prepare];

    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(80);
    }];
}
- (void)placeSubviews{
    [super placeSubviews];
    
    [self.imageView playWithCompletion:^(BOOL animationFinished) {
        if (animationFinished) {
            [self.imageView stop];
        }
    }];
}

- (LOTAnimationView *)imageView
{
    if (!_imageView) {
        _imageView = [LOTAnimationView animationNamed:@"loadiing_paperplane.json"];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.loopAnimation = YES;
        [_imageView setAnimationSpeed:1.0];
    }
    return _imageView;
}
@end
