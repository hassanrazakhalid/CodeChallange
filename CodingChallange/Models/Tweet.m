//
//  Tweet.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize imageStatus;

+ (Tweet *)insertTweet:(NSDictionary *)info{
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication]delegate] managedObjectContext];
    Tweet *tweet = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:context];
    [tweet reloadData:info];
    return tweet;
}

- (void)reloadData:(NSDictionary *)info{
    
    if(info[@"user"][@"name"])
        self.name = info[@"user"][@"name"];
    if(info[@"id_str"])
        self.tweetId = info[@"id_str"];
    if(info[@"user"][@"location"])
        self.location = info[@"user"][@"location"];
    if(info[@"created_at"])
        self.createdDate = info[@"created_at"];
    if(info[@"user"][@"profile_image_url_https"])
        self.imageURL = info[@"user"][@"profile_image_url_https"];
    
}

//If image is not downloaded it will automatically download the image and save into coredata
- (void)getImage:(ImageCallback)callBack{
    
    UIImage *userImage = [self image];
    
    // means image is already downloaded so just return
    if(userImage)
        callBack(self);
    else // download the image
    {
        
        if(self.imageStatus == ImageStatusNone) // check so that request for single image isn't send multiple times
        {
            callBack(self);// called before so a dummy image is show temperoryly. we are showing empty for now
            self.imageStatus = ImageStatusInProgress;
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSString *urlString = self.imageURL;
            NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                UIImage *image = nil;
                if(!error)
                {
                    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    [self setImage:image];
                    
                }
                
                self.imageStatus = ImageStatusDone;
                
                dispatch_async(dispatch_get_main_queue(), ^{

                        callBack(self);
                });

            }];
            [downloadTask resume];
        }
        
    }
}

@end
