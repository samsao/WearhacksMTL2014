//
//  MyoManager.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "MyoManager.h"

@implementation MyoManager

static MyoManager *instance = nil;

+ (MyoManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[MyoManager alloc] init]; });

    return instance;
}


@end
