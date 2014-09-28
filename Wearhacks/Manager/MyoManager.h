//
//  MyoManager.h
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MyoKit/MyoKit.h>

@interface MyoManager : NSObject

@property(strong, nonatomic) TLMMyo *myo;

/**
 *  Singeleton methods
 *
 *  @return the singleton
 */
+ (instancetype)sharedInstance;

@end
