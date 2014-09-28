//
//  UIColor+PNPColors.m
//  pnp
//
//  Created by Philippe Blondin on 2014-06-26.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "UIColor+WearHackColors.h"
#import <UIColor-HTMLColors/UIColor+HTMLColors.h>

@implementation UIColor (WearHackColors)


// Main color

+ (UIColor *)color1 {
    return [UIColor colorWithHexString:@"#d3fbfd"];
}

+ (UIColor *)color3 {
    return [UIColor colorWithHexString:@"#85f6f5"];
}

+ (UIColor *)color2 {
    return [UIColor colorWithHexString:@"#95eefc"];
}

+ (UIColor *)color4 {
    return [UIColor colorWithHexString:@"#9fadf3"];
}

+ (UIColor *)color5 {
    return [UIColor colorWithHexString:@"#b8a0f8"];
}

+ (UIColor *)color6 {
    return [UIColor colorWithHexString:@"#9f88f3"];
}



// Random color for debug from https://gist.github.com/kylefox/1689973
+ (UIColor *)randomColor {

    CGFloat hue = (arc4random() % 256 / 256.0);              //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //  0.5 to 1.0, away from black

    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

    return color;
}

@end
