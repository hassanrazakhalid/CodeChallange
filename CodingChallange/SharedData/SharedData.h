//
//  SharedData.h
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface SharedData : NSObject

{

}

@property (nonatomic, retain)User *currentUser;

+ (SharedData *)sharedInstance;
- (void) getTweetsInfo:(NSString *)text callback:(FetchTweets)callback;
- (void)loginTwiiterUser;



@end
