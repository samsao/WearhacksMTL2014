//
//  UIStoryboard+WearHacks.m
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "UIStoryboard+WearHacks.h"

@implementation UIStoryboard (WearHacks)

+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

+ (UIStoryboard *)scheduleStoryboard {
    return [UIStoryboard storyboardWithName:@"Schedule" bundle:nil];
}

+ (UIStoryboard *)rehabStoryboard {
    return [UIStoryboard storyboardWithName:@"Rehab" bundle:nil];
}

@end

