//
//  WearHacksUtility.h
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WearHacksUtility : NSObject

+ (PFQuery *)allExerciceDate;
+ (PFQuery *)allExercicesForExerciceDate:(PFObject *)injury;
+ (PFQuery *)allDataForExerciceTypeID:(NSNumber *)typeID;

+ (PFObject *)exerciceForGab;


//Facebook
+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData;

@end
