//
//  UIImageView+Border.m
//  TestLayer
//
//  Created by FrancoisJulien ALCARAZ on 2014-05-04.
//  Copyright (c) 2014 Merchlar. All rights reserved.
//

#import "UIImageView+Border.h"

@implementation UIImageView (Border)

- (void)generateBorders {
    
    
    
    self.clipsToBounds = YES;
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.borderColor = [UIColor whiteColor].CGColor;
    rightBorder.borderWidth = 5;
    rightBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [self.layer addSublayer:rightBorder];
    
    
    CALayer *greyBorder = [CALayer layer];
    greyBorder.borderColor = [UIColor lightGrayColor].CGColor;
    greyBorder.borderWidth = 1;
    greyBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [self.layer addSublayer:greyBorder];
}

- (void)roundedImageView {
    
    self.clipsToBounds = YES;

    self.layer.cornerRadius = self.frame.size.width / 2;
    
//    CALayer *cornerLayer = [CALayer layer];
//    cornerLayer.cornerRadius = 30.0;
////    greyBorder.borderWidth = 1;
////    greyBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//    
//    [self.layer addSublayer:cornerLayer];
    
}

@end
