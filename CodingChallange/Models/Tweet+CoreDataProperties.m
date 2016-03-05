//
//  Tweet+CoreDataProperties.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tweet+CoreDataProperties.h"
#import "ImageTransformer.h"

@implementation Tweet (CoreDataProperties)

@dynamic tweetId;
@dynamic createdDate;
@dynamic name;
@dynamic location;
@dynamic imageURL;
@dynamic image;

+ (void)initialize {
    
    if (self == [Tweet class]) {
        ImageTransformer *transformer = [[ImageTransformer alloc] init];
        [NSValueTransformer setValueTransformer:transformer forName:@"ImageTransformer"];
    }
}


@end
