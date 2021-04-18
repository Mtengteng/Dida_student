//
//  SBookImageView.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "SBookImageView.h"

@implementation SBookImageView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.layer.shadowOffset = CGSizeMake(5,5);
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 4;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

@end
