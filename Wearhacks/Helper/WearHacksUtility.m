//
//  WearHacksUtility.m
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "WearHacksUtility.h"
#import "UIImage+Resize.h"

@implementation WearHacksUtility

+ (PFQuery *)allExerciceDate {
    
    PFQuery *query = [PFQuery queryWithClassName:@"ExerciceDate"];
    [query orderByDescending:@"createdAt"];
    
    //Only fetch the one I created
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    return query;
}

+ (PFQuery *)allExercicesForExerciceDate:(PFObject *)injury {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Exercice"];
    [query whereKey:@"exerciceDate" containedIn:@[injury]];
    [query includeKey:@"type"];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

+ (PFQuery *)allDataForExerciceTypeID:(NSNumber *)typeID {
    
    PFQuery *query = [PFQuery queryWithClassName:@"ExerciceData"];
    [query whereKey:@"typeID" equalTo:typeID];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

+ (PFObject *)exerciceForGab {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Exercice"];
    PFObject * obj = [query getObjectWithId:@"tWhbidf52B"];
    return obj;
    
}

#pragma mark - Facebook

+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData {
    if (newProfilePictureData.length == 0) {
        return;
    }
    
    // The user's Facebook profile picture is cached to disk. Check if the cached profile picture data matches the incoming profile picture. If it does, avoid uploading this data to Parse.
    
    NSURL *cachesDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]; // iOS Caches directory
    
    NSURL *profilePictureCacheURL = [cachesDirectoryURL URLByAppendingPathComponent:@"FacebookProfilePicture.jpg"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[profilePictureCacheURL path]]) {
        // We have a cached Facebook profile picture
        
        NSData *oldProfilePictureData = [NSData dataWithContentsOfFile:[profilePictureCacheURL path]];
        
        if ([oldProfilePictureData isEqualToData:newProfilePictureData]) {
            return;
        }
    }
    
    UIImage *image = [UIImage imageWithData:newProfilePictureData];
    
    UIImage *mediumImage = [image thumbnailImage:280 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
    UIImage *smallRoundedImage = [image thumbnailImage:64 transparentBorder:0 cornerRadius:9 interpolationQuality:kCGInterpolationLow];
    
    NSData *mediumImageData = UIImageJPEGRepresentation(mediumImage, 0.5); // using JPEG for larger pictures
    NSData *smallRoundedImageData = UIImagePNGRepresentation(smallRoundedImage);
    
    if (mediumImageData.length > 0) {
        PFFile *fileMediumImage = [PFFile fileWithData:mediumImageData];
        [fileMediumImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"medium image profile saved");
                [[PFUser currentUser] setObject:fileMediumImage forKey:kWearHacksUserProfilePicMediumKey];
                [[PFUser currentUser] saveEventually];
            }
        }];
    }
    
    if (smallRoundedImageData.length > 0) {
        PFFile *fileSmallRoundedImage = [PFFile fileWithData:smallRoundedImageData];
        [fileSmallRoundedImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"small image profile saved");
                [[PFUser currentUser] setObject:fileSmallRoundedImage forKey:kWearHacksUserProfilePicSmallKey];
                [[PFUser currentUser] saveEventually];
            }
        }];
    }
}

@end
