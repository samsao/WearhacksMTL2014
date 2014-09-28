//
//  UIButtonRounded.m
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "UIButtonRounded.h"

@implementation UIButtonRounded

- (void)awakeFromNib {
  
    // set corner radius
    [self.layer setCornerRadius:7.5f];
    [self.layer setMasksToBounds:YES];
    
}

@end
